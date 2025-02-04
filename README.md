---
description: Lab 1
---

# Hypervisor Setup

IPMI - Intelligent Platform Management Interface:&#x20;

Installing EXSi

* Get assigned IP, plug flashdrive containing ESXi into server, access server from assigned IP.

<figure><img src=".gitbook/assets/image (3).png" alt=""><figcaption><p>IPv4 Configuration</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (1) (1).png" alt=""><figcaption><p>DNS Config</p></figcaption></figure>

Navigated to Super14 IP via web

<figure><img src=".gitbook/assets/image (2) (1).png" alt=""><figcaption><p>192.168.3.214</p></figcaption></figure>



Clicked Storage > database1-super14 > create directory > named "ISOs" > Upload > naviagated to ISO folder and selected VMs

<figure><img src=".gitbook/assets/image (3) (1).png" alt=""><figcaption><p>The VM's loaded into database1-super14</p></figcaption></figure>

Navigated to Networking > Add standard virtual switch > NO uplink

<figure><img src=".gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

Clicked Networking > Port Groups > Add port group&#x20;

<figure><img src=".gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

Creating VM

<figure><img src=".gitbook/assets/image (7).png" alt=""><figcaption><p>Named 480-fw, selected compatibility, and OS family and version</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (8).png" alt=""><figcaption><p>Changed memory and HDD sizes and thin provisioned VM</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (9).png" alt=""><figcaption><p>Selected VYOS Rolling ISO</p></figcaption></figure>

Click Finish > Power On VM > Open Console

Installing image

```
install image
```

Accept defaults >> vyos / Ch@mpl@1n!22



```
config
show interfaces
delete interfaces ethernet eth0 hw-id
delete interfaces ethernet eth1 hw-id
commit
save
show interfaces
set interfaces ethernet eth0 address dhcp
set service ssh listen-address 0.0.0.0
commit
save
exit
poweroff [Y]
```

480-fw VM >> Right Click edit settings > CD/DVD Drive 1 > Host device

<figure><img src=".gitbook/assets/image (10).png" alt=""><figcaption><p>Changed adapter to VM Network for Base</p></figcaption></figure>

Right Click 480-fw > Snapshots > Take Snapshot

<figure><img src=".gitbook/assets/image (11).png" alt=""><figcaption><p>Named snapshot "Base"</p></figcaption></figure>

Power on and change 2nd network adapter to 480-WAN

How to change vyos password

```
set system login user vyos authentication plaintext-password XXXXXXX
```



Setting interfaces:

```
del interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 address 192.168.3.24/24
commit
save
```

Set default gateway

```
set protocols static route 0.0.0.0/0 next-hop 192.168.3.250
-----
set interface ethernet eth0 description CYBERLAB
set interface ethernet eth1 description 480-WAN
set interface ethernet eth1 address 10.0.17.2/24
set system name-server 192.168.4.4
set system name-server 192.168.4.5
set service dns forwarding listen-address 10.0.17.2
set service dns forwarding allow-from 10.0.17.0/24
set service dns forwarding system
```

Creating NAT rule

```
set nat source rule 10 source address 10.0.17.0/24
set nat source rule 10 outbound-interface eth0 
set nat source rule 10 translation address masquerade
```

Setting hostname

```
set system host-name 480-fw
```

Creating xubuntu-wan vm

Click Virtual Machines tab > Create / Register VM >&#x20;

<figure><img src=".gitbook/assets/image (12).png" alt=""><figcaption><p>Named, selected compatibility, OS family and version</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (13).png" alt=""><figcaption><p>Changed CPU, Memory, and HDD sides. Thin Provisioned VM. </p></figcaption></figure>

<figure><img src=".gitbook/assets/image (14).png" alt=""><figcaption><p>Added the xubuntu ISO to CD/DVD Drive 1</p></figcaption></figure>

Powered on xubuntu-wan vm > Install xubuntu > Minimal installation > Restarted computer when installation finished



Opened terminal

```
sudo -i 
wget https://raw.githubusercontent.com/gmcyber/RangeControl/main/src/scripts/base-vms/ubuntu-desktop.sh
chmod +x ubuntu-desktop.sh
./ubuntu-desktop.sh
ls
rm *.deb ubuntu-desktop.sh
ls
shutdown -h now
```

Edit settings > Change CD/DVD Drive to Host Device > Take Snapshot named Base > Edit settings of xubuntu-wan > Change network adapter 1 to 480-WAN > Turn VM on.&#x20;



Add new sudo user, log out and log in as new user

```
sudo adduser fatima (f129.)
sudo usermod -aG sudo fatima
userdel -r champuser
sudo hostnamectl set-hostname xubuntu-wan
```

Network Configurations:&#x20;

<figure><img src=".gitbook/assets/image (15).png" alt=""><figcaption></figcaption></figure>

Deliverables:

1: from xubuntu-wan tracepath to champlain.edu with 4 hops, print out the IP address as well (see switches in video)

2: Named xubuntu-wan administrative user

3: Your IP is 10.0.17.100

4: browse to or curl champlain.edu

<figure><img src=".gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>
