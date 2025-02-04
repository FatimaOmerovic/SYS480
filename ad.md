---
description: install chrome rdp on xubuntu
---

# AD

3 major parts to a vCenter Deployment

vCenter Server:

* Centralized host management, configuration, scaling, etc

Platform Services Controller

* Certificate management, authentication, and licensing

Database

* ISOs, VM files, templates, snapshots, etc



AD



Setting up Windows Server 2019

Config:&#x20;

<figure><img src=".gitbook/assets/image (17).png" alt=""><figcaption></figcaption></figure>

Forgot to set ISO image:

<figure><img src=".gitbook/assets/image (19).png" alt=""><figcaption><p>make sure to select "connect on power" for ISO file<br></p></figcaption></figure>

Powered on VM > Boot Normally > CTRL SHIFT F3 > Clicked Next on Language and Country > Selected Standard Desktop Experience

<figure><img src=".gitbook/assets/image (20).png" alt=""><figcaption></figcaption></figure>

* Selected Custom Windows Install
* Prompted to put user/pass, CTRL SHIFT F3

Opened Powershell > enter ‘sconfig’ > Select 5: Change to manual windows updates > Select 9: Change timezone to Eastern > Select 6: Install updates - ALL (you will need an internet connection, or it will say ‘no applicable updates’)



Install VMware tools

Right click VM > Guest OS > Install VMware tools > Open file explorer > Right clicked drive > Install > Kept default configuration for install



wget the script for sysprep

<figure><img src=".gitbook/assets/image (21).png" alt=""><figcaption></figcaption></figure>

Editing the script:

<figure><img src=".gitbook/assets/image (22).png" alt=""><figcaption></figcaption></figure>

Shut down VM > Removed CD/ISO > Snapshot called 'Base'

Added Administrative user password

* Change the segment to 480-WAN give it an ip of 10.0.17.4/24 and a hostname of dc1, you will want DNS and Gateway pointing to vyos:10.0.17.2 initially
* Renamed to DC-fatima

Xubuntu:

`ssh administrator@10.0.17.4`

Installing AD

<pre><code>Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
<strong>Install-ADDSForest -DomainName fatima.local
</strong>Install-WindowsFeature -Name DNS
Get-WindowsFeature -Name DNS*
Add-DnsServerPrimaryZone -Name "17.0.10.in-addr.arpa" -ReplicationScope Forest
Get-DnsServerZone

# Creating A Records
Add-DnsServerResourceRecordA -ZoneName "fatima.local" -Name "vcenter" -IPv4Address "10.0.17.3"
Add-DnsServerResourceRecordA -ZoneName "fatima.local" -Name "480-fw" -IPv4Address "10.0.17.2"
Add-DnsServerResourceRecordA -ZoneName "fatima.local" -Name "xubuntu-wan" -IPv4Address "10.0.17.100"

# Creating PTR Records
Add-DnsServerResourceRecordPTR -ZoneName "17.0.10.in-addr.arpa" -Name "3" -PtrDomainName "vcenter.fatima.local"
Add-DnsServerResourceRecordPTR -ZoneName "17.0.10.in-addr.arpa" -Name "2" -PtrDomainName "480-fw.fatima.local"
Add-DnsServerResourceRecordPTR -ZoneName "17.0.10.in-addr.arpa" -Name "100" -PtrDomainName "xubuntu-wan.fatima.local"
Add-DnsServerResourceRecordPTR -ZoneName "17.0.10.in-addr.arpa" -Name "4" -PtrDomainName "dc-fatima.fatima.local"
</code></pre>



Enabling RDP via Powershell

```
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 1
```

Install DHCP

```
Install-WindowsFeature -Name DHCP -IncludeManagementTools
Add-DhcpServerInDC -DnsName "fatima.local" -IpAddress "10.0.17.4"
$scopeStart = "10.0.17.101"
$scopeEnd = "10.0.17.150"
$subnetMask = "255.255.255.0"
$router = "10.0.17.2"
$dnsServer = "10.0.17.4"
$scopeName = "DHCP"
$scopeDescription = "DHCP scope for fatima.local"

Add-DhcpServerv4Scope -Name $scopeName -StartRange $scopeStart -EndRange $scopeEnd -SubnetMask $subnetMask -Description $scopeDescription
Set-DhcpServerv4Scope -ScopeId $scopeStart -State Active
```

###

Creating Domain User

<pre><code><strong>New-ADUser -SamAccountName "fatima-adm" -UserPrincipalName "fatima-adm@fatima.local" -Name "fatima-adm" -GivenName "fatima-adm" -DisplayName "fatima-adm" -AccountPassword (ConvertTo-SecureString "PASSWORD" -AsPlainText -Force) -Enabled $True
</strong><strong>Add-AdGroupMember -Identity "Domain Admins" -Members fatima-adm
</strong></code></pre>

### Deliverable

```
# Shows Reverse Zones (PTR)
Get-DnsServerResourceRecord -ZoneName "17.0.10.in-addr.arpa"

# Shows DHCP
Get-DhcpServerv4Scope
```

