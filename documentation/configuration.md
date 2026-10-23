# Infrastructure Configuration

## 1. Lab Environment

The project uses Oracle VirtualBox to simulate a small enterprise Windows infrastructure.

| Component | Configuration |
|---|---|
| Server | Windows Server 2025 |
| Workstation | Windows 11 Pro |
| Domain | corp.test |
| Domain Controller | DC01 |
| Internal Network | 192.168.10.0/24 |
| DC LAN Address | 192.168.10.10 |
| DNS Server | 192.168.10.10 |
| DHCP Pool | 192.168.10.100–192.168.10.200 |

## 2. Active Directory

Installed Active Directory Domain Services and promoted DC01 to a Domain Controller.

Created departmental Organizational Units and security groups:

- IT — GG_IT
- HR — GG_HR
- Sales — GG_Sales

Joined CLIENT02 to the corp.test domain and verified domain connectivity.

## 3. DNS and DHCP

Configured internal DNS services to support Active Directory authentication and domain controller discovery.

Configured a DHCP scope to automatically assign IPv4 addresses to domain clients.

## 4. Group Policy

Implemented departmental policies, including:

- HR Control Panel restrictions
- Automatic network drive mapping using Group Policy Preferences
- Security group-based item-level targeting

Drive mappings:

| Department | Drive | Share |
|---|---|---|
| HR | H: | \\dc01.corp.test\HR |
| IT | I: | \\dc01.corp.test\IT |
| Sales | S: | \\dc01.corp.test\Sales |

## 5. File Server

Created departmental directories under `C:\CompanyShares`.

Configured NTFS and SMB permissions using departmental security groups.

Validated access using accounts from different departments.

## 6. Backup

Installed Windows Server Backup and configured a dedicated virtual backup disk.

Configured backup procedures for company files and explored System State recovery.

## 7. PowerShell Automation

Created PowerShell scripts for:

- CSV-based user provisioning
- Active Directory group membership
- Account activation and recovery
- Infrastructure health checks

These scripts are available in the repository's `scripts` directory.
