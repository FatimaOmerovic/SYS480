# Page 1

* Add a new function (e.g. called New-Network) that creates a Virtual Switch and Portgroup
* Add a new function (e.g. called Get-IP) to get the IP, and MAC address from the first interface of a named VM.
* Create a utility function within 480-utils.ps1 that will start a VM or VMs with by name
* Add a function (e.g. Called Set-Network)  that lets you set the network on the different interfaces on a VM
* Install ansible and show your first ansible ping.  Here's a sample ([demo](https://drive.google.com/file/d/1dI0I1PW9H_WdrSJV3v7wPZmCcrGzMsYX/view?usp=sharing))
* **Replicate the deployment of the vyos base configuration from the (**[**demo**](https://drive.google.com/file/d/14vVMIAGvewJROaTGh6xgG-c7wBc7-h8F/view?usp=sharing)**).  Your demo should show**
  * **The results of getIP before you run the the vyos ansible playbook**
  * **The successful run of the vyos ansible playbook**
  * **The results of getIP after you run the ansible playbook.**



Switch/PortGroup

{% embed url="https://vdc-download.vmware.com/vmwb-repository/dcr-public/85a74cac-7b7b-45b0-b850-00ca08d1f238/ae65ebd9-158b-4f31-aa9c-4bbdc724cc38/doc/Remove-VirtualSwitch.html" %}

ansible ping command: ansible vyos -m ping -i inventories/fw-blue1-vars.txt --user vyos --ask-pass
