
# Active Directory User Provisioning
# Windows Server 2025 - Enterprise Infrastructure Lab

#Requires -Modules ActiveDirectory

param(
    [switch]$Apply
)

$ErrorActionPreference = "Stop"

$csvPath = "C:\AD-Automation\employees.csv"

$departmentGroups = @{
    "IT"    = "GG_IT"
    "HR"    = "GG_HR"
    "Sales" = "GG_Sales"
}

Write-Host "`n=== ACTIVE DIRECTORY USER PROVISIONING ===" -ForegroundColor Cyan

if (-not (Test-Path $csvPath)) {
    Write-Host "[ERROR] CSV file not found: $csvPath" -ForegroundColor Red
    return
}

$users = @(Import-Csv $csvPath)

if ($users.Count -eq 0) {
    Write-Host "[ERROR] CSV file is empty." -ForegroundColor Red
    return
}

# Validate CSV records before processing
$requiredColumns = @("FirstName", "LastName", "Username", "Department")

foreach ($column in $requiredColumns) {
    if ($column -notin $users[0].PSObject.Properties.Name) {
        Write-Host "[ERROR] Missing CSV column: $column" -ForegroundColor Red
        return
    }
}

$invalidUsers = @($users | Where-Object {
    [string]::IsNullOrWhiteSpace($_.FirstName) -or
    [string]::IsNullOrWhiteSpace($_.LastName) -or
    [string]::IsNullOrWhiteSpace($_.Username) -or
    $_.Department -notin @("IT", "HR", "Sales")
})

if ($invalidUsers.Count -gt 0) {
    Write-Host "[ERROR] CSV contains invalid records." -ForegroundColor Red
    return
}

$duplicates = @($users | Group-Object Username | Where-Object Count -gt 1)

if ($duplicates.Count -gt 0) {
    Write-Host "[ERROR] Duplicate usernames found." -ForegroundColor Red
    $duplicates | Select-Object Name, Count
    return
}

# Resolve departmental OUs and groups
$departmentOUs = @{}

foreach ($department in $departmentGroups.Keys) {
    $ou = @(Get-ADOrganizationalUnit -Filter * |
        Where-Object { $_.Name -eq $department })

    if ($ou.Count -ne 1) {
        Write-Host "[ERROR] Expected one OU named $department; found $($ou.Count)." -ForegroundColor Red
        return
    }

    $departmentOUs[$department] = $ou[0].DistinguishedName

    Get-ADGroup -Identity $departmentGroups[$department] | Out-Null
}

Write-Host "`nMODE: $(if ($Apply) { 'APPLY' } else { 'PREVIEW' })"

# Request password only when applying changes
if ($Apply) {
    $password = Read-Host "Enter temporary password for NEW users" -AsSecureString
}

foreach ($user in $users) {
    $username = $user.Username.Trim()
    $department = $user.Department.Trim()
    $group = $departmentGroups[$department]

    $existing = Get-ADUser -Filter {
        SamAccountName -eq $username
    }

    if ($existing) {
        Write-Host "[SKIP] $username already exists." -ForegroundColor Yellow
        continue
    }

    if (-not $Apply) {
        Write-Host "[PREVIEW] Create $username in $department; add to $group"
        continue
    }

    try {
        $newUserParams = @{
            Name                  = "$($user.FirstName) $($user.LastName)"
            GivenName             = $user.FirstName
            Surname               = $user.LastName
            SamAccountName        = $username
            UserPrincipalName     = "$username@corp.test"
            Path                  = $departmentOUs[$department]
            AccountPassword       = $password
            Enabled               = $true
            ChangePasswordAtLogon = $true
            ErrorAction           = "Stop"
        }

        New-ADUser @newUserParams

        Add-ADGroupMember -Identity $group -Members $username -ErrorAction Stop

        Write-Host "[SUCCESS] Created $username and added to $group" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERROR] Failed to provision ${username}: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n=== PROVISIONING COMPLETED ==="



