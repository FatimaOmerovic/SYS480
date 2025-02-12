# vCenter AD Integration

Install Ansible Dependencies

```
sudo apt install sshpass python3-paramiko git
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
ansible --version
```

PowerCLI Dependencies&#x20;

```
sudo snap install powershell --classic
pwsh

# PowerCLI Libraries
Install-Module VMware.PowerCLI -Scope CurrentUser
Get-Module VMware.PowerCLI -ListAvailable
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false
```

Visual Studio Code

```
sudo snap install code --classic
```

```
$vcenter="vcenter.fatima.local"
Connect-VIServer -Server $vcenter
    fatima-adm@fatima.local

Get-VM
$vm = Get-VM -Name WinServer
$vm
$snapshot = Get-Snapshot -VM $vm -Name "Base"

Get-VMHost
$vmhost=Get-VMHost -Name "192.168.3.214"
Get-DataStore
$ds = Get-DataStore -Name "datastore1-super14"

$linkedClone = "{0}.linked" -f $vm.name
$linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -DataStore $ds
$newvm = New-VM -Name "server.2019.gui.base" -VM $linkedvm -VMHost $vmhost -Datastore $ds
$newvm | New-Snapshot -Name "Base"
$linkedvm | Remove-Vm
```

Made script.ps1, created ubuntu and winserver bases, just run the script with the video&#x20;
