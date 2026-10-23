
Import-Module ActiveDirectory

Write-Host "=== WINDOWS SERVER HEALTH CHECK ==="

Write-Host "`n1. SERVICES"
Get-Service NTDS,DNS,DHCPServer | Select-Object Name,Status

Write-Host "`n2. DOMAIN"
Get-ADDomain | Select-Object DNSRoot,NetBIOSName

Write-Host "`n3. DNS"
Resolve-DnsName dc01.corp.test -Server 192.168.10.10

Write-Host "`n4. DHCP"
Get-DhcpServerv4Scope | Select-Object ScopeId,State

Write-Host "`n5. FILE SHARES"
Get-SmbShare -Name IT,HR,Sales | Select-Object Name,Path

Write-Host "`n6. AD USERS"
Get-ADUser -Filter 'SamAccountName -eq "nioannou" -or SamAccountName -eq "mkonstantinou" -or SamAccountName -eq "gdimitriou"' -Properties Enabled | Select-Object Name,Enabled

Write-Host "`n7. DISK SPACE"
Get-PSDrive C | Select-Object Name,Used,Free

Write-Host "`n=== CHECK COMPLETED ==="


