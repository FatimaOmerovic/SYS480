---
description: install chrome rdp on xubuntu
---

# Page

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
</strong></code></pre>

