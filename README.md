
# Windows Server 2025 — Enterprise Infrastructure Lab

A hands-on IT infrastructure project designed to simulate a small enterprise environment using Windows Server 2025, Windows 11 Pro, and Oracle VirtualBox.

The project demonstrates practical skills in Active Directory administration, network services, access control, Group Policy, file sharing, troubleshooting, backup configuration, and PowerShell automation.

## Technologies Used

- Windows Server 2025
- Windows 11 Pro
- Oracle VirtualBox
- Active Directory Domain Services (AD DS)
- DNS and DHCP
- Group Policy Management
- SMB File Sharing and NTFS Permissions
- Windows Server Backup
- Windows PowerShell

## Lab Architecture

| Component | Configuration |
|---|---|
| Domain | `corp.test` |
| Domain Controller | `DC01` |
| Domain Controller LAN IP | `192.168.10.10` |
| Client | `CLIENT02` |
| Client OS | Windows 11 Pro |
| Internal Network | `192.168.10.0/24` |
| DHCP Address Pool | `192.168.10.100–192.168.10.200` |
| Virtualization | Oracle VirtualBox |

The lab uses an isolated internal network for domain services and a separate NAT adapter for internet connectivity.

## Implemented Features

### 1. Active Directory Domain Services

- Deployed a Windows Server 2025 domain controller.
- Configured the `corp.test` domain.
- Created departmental Organizational Units.
- Created domain users and security groups.
- Joined a Windows 11 Pro workstation to the domain.

### 2. DNS and DHCP

- Configured internal DNS resolution.
- Verified domain controller discovery using DNS SRV records.
- Configured a DHCP scope for client address assignment.
- Tested network connectivity and DNS troubleshooting scenarios.

### 3. Group Policy

- Configured departmental Group Policy settings.
- Implemented restrictions for HR users.
- Configured automatic network drive mapping using Group Policy Preferences and security-group targeting.

### 4. File Server and Access Control

Created departmental SMB shares:

- `\\dc01.corp.test\IT`
- `\\dc01.corp.test\HR`
- `\\dc01.corp.test\Sales`

Configured share-level and NTFS permissions using Active Directory security groups.

Tested authorized and unauthorized access using departmental user accounts.

### 5. Backup and Recovery

- Installed Windows Server Backup.
- Configured a dedicated virtual backup disk.
- Practiced file backup and recovery procedures.
- Explored System State backup and Active Directory recovery concepts.

### 6. PowerShell Automation

Developed scripts for:

- CSV-based Active Directory user provisioning.
- Departmental security group assignment.
- Recovery of partially provisioned lab accounts.
- Infrastructure health checks covering key server services and configurations.

## Troubleshooting Scenarios

The project includes practical troubleshooting involving:

- Domain connectivity and DNS resolution.
- DHCP client configuration.
- Group Policy application.
- File share access permissions.
- Active Directory account provisioning and password policies.
-
