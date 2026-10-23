# Infrastructure Test Results

## Test Environment

- Domain: `corp.test`
- Server: `DC01` — Windows Server 2025
- Client: `CLIENT02` — Windows 11 Pro
- Network: `192.168.10.0/24`

## Functional Validation

| Test | Expected Result | Status |
|---|---|---|
| Domain Join | CLIENT02 joins corp.test | Passed |
| DNS Resolution | Client resolves DC01 | Passed |
| DHCP | Client receives an address from the configured scope | Passed |
| Active Directory | Domain users and groups are accessible | Passed |
| HR Group Policy | HR restrictions are applied | Passed |
| Drive Mapping | Departmental drives appear for authorized users | Passed |
| SMB Permissions | Authorized access succeeds; unauthorized access is denied | Passed |
| PowerShell Health Check | Script executes without parser errors | Passed |
| Bulk AD User Provisioning | New users are enabled and assigned to the correct groups | Pending final verification |
| File Restore | Backup file is recovered and verified | Pending final verification |
| System State Backup | A successful System State backup is confirmed | Pending final verification |

## Diagnostic Commands

### Domain Controller

```powershell
dcdiag /test:Advertising
dcdiag /test:Services
```

### DNS

```powershell
Resolve-DnsName dc01.corp.test -Server 192.168.10.10
```

### DHCP

```powershell
Get-DhcpServerv4Scope
```

### File Shares

```powershell
Get-SmbShare -Name IT,HR,Sales
```

### User Provisioning

```powershell
Get-ADUser -Identity nioannou -Properties Enabled
```

### Backup

```powershell
wbadmin get versions -backupTarget:E:
```

## Notes

Test results reflect the educational lab environment.

Pending items should be marked as Passed only after their results have been verified.

Screenshots are available in the `screenshots` directory.
