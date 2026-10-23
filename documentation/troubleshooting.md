# Troubleshooting Documentation

## 1. DNS and Domain Connectivity

**Scenario:** A domain client cannot locate the Domain Controller.

**Diagnostic commands:**

```powershell
ipconfig /all
nslookup dc01.corp.test
nltest /dsgetdc:corp.test
```

**Troubleshooting approach:** Verify that the client uses the internal DNS server and can communicate with the Domain Controller.

## 2. DHCP Troubleshooting

**Scenario:** A workstation cannot obtain the expected IPv4 configuration.

**Diagnostic commands:**

```powershell
ipconfig /release
ipconfig /renew
ipconfig /all
```

**Troubleshooting approach:** Check the DHCP service, scope configuration, and VirtualBox network adapter settings.

## 3. Group Policy Troubleshooting

**Scenario:** Departmental restrictions or mapped drives do not appear.

**Diagnostic commands:**

```powershell
gpupdate /force
gpresult /r
```

**Troubleshooting approach:** Verify GPO links, security filtering, item-level targeting, and the user's group membership.

## 4. SMB Permission Troubleshooting

**Scenario:** A user cannot access a departmental share.

**Diagnostic commands:**

```powershell
Get-SmbShareAccess -Name HR
icacls C:\CompanyShares\HR
```

**Troubleshooting approach:** Review both share permissions and NTFS permissions. Effective access is constrained by both permission layers.

## 5. Active Directory Provisioning Failure

**Observed issue:** PowerShell user provisioning failed because the temporary password did not satisfy domain password requirements.

**Symptoms:**

- The script reported a password policy error.
- The account object remained in Active Directory.
- A second script execution skipped the existing account.

**Resolution approach:** Updated the provisioning logic to detect disabled accounts, set a compliant temporary password, enable the account, and verify security group membership.

## 6. PowerShell Parser Error

**Observed issue:** The initial infrastructure health check script contained unexpected closing braces.

**Error:**

```text
Unexpected token '}' in expression or statement.
```

**Resolution:** Replaced the problematic script with a simpler version and successfully executed the infrastructure checks.

## Lessons Learned

- Validate account creation results rather than assuming successful provisioning.
- Verify domain password policies before bulk user creation.
- Check both NTFS and SMB permissions when troubleshooting access.
- Use simple, testable PowerShell scripts.
- Confirm functionality before publishing automation scripts.
