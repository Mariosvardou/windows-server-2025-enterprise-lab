# Network Architecture

## Overview

The Windows Server 2025 Enterprise Lab simulates a small corporate network using Oracle VirtualBox.

The environment consists of one Windows Server 2025 Domain Controller and one Windows 11 Pro domain-joined workstation.

## Network Topology

```text
                  Internet
                     |
               VirtualBox NAT
                 /       \
                /         \
             DC01        CLIENT02
        Windows Server   Windows 11 Pro
             2025
                \         /
                 \       /
             Internal Network
                 corp-lan
               192.168.10.0/24
```

## Network Configuration

| Device | Interface | IP Address | Purpose |
|---|---|---|---|
| DC01 | Internal LAN | 192.168.10.10 | AD DS, DNS, DHCP |
| DC01 | NAT | 10.0.2.15 | Internet connectivity |
| CLIENT02 | Internal LAN | DHCP-assigned | Domain connectivity |
| CLIENT02 | NAT | DHCP-assigned | Internet connectivity |

## Active Directory

- Domain: `corp.test`
- Domain Controller: `DC01`
- Internal DNS Server: `192.168.10.10`
- Organizational Units: IT, HR, Sales
- Security Groups: GG_IT, GG_HR, GG_Sales

## DHCP Configuration

- Network: `192.168.10.0/24`
- DHCP Range: `192.168.10.100–192.168.10.200`
- DNS Server: `192.168.10.10`
- DNS Domain: `corp.test`

## Network Services

The domain controller provides:

- Active Directory authentication
- Internal DNS resolution
- DHCP address assignment
- Group Policy management
- SMB file sharing

## Security Considerations

This is an isolated educational lab environment.

In a production deployment, file services would typically run on a separate member server rather than directly on the Domain Controller.

The lab uses VirtualBox NAT for external connectivity and an internal network for domain communication.
