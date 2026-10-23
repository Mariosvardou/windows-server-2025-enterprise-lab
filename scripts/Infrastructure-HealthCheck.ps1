Write-Host "=== SERVER HEALTH CHECK ==="

Write-Host "`nSERVICES"
Get-Service NTDS,DNS,DHCPServer | Select-Object Name,Status

Write-Host "`nDOMAIN"
Get-ADDomain | Select-Object DNSRoot,NetBIOSName

Write-Host "`nDNS"
Resolve-DnsName dc01.corp.test -Server 192.168.10.10

Write-Host "`nDHCP"
Get-DhcpServerv4Scope | Select-Object ScopeId,State

Write-Host "`nSHARES"
Get-SmbShare -Name IT,HR,Sales | Select-Object Name,Path

Write-Host "`nDISK"
Get-PSDrive C | Select-Object Name,Used,Free

Write-Host "`nCHECK COMPLETED"
