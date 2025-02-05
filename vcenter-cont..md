# vCenter Cont.

Sign into your vCenter management interface with root port 5480 > Head to update, find newest update > stage & update



Licenses&#x20;

Added vSphere and vCenter licenses and also assigned new licenses via the assets tab

<figure><img src=".gitbook/assets/image.png" alt=""><figcaption><p>vCenter</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (1).png" alt=""><figcaption><p>vSphere</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (2).png" alt=""><figcaption><p>Showing version</p></figcaption></figure>

* Add the your.name.local SSO provider as default
* In vCenter, go to: Administration->Single Sign On->Configuration
* To join your domain in vCenter, you’ll enter creds for your domain admin!

<figure><img src=".gitbook/assets/image (4).png" alt=""><figcaption><p>Joining AD</p></figcaption></figure>

<figure><img src=".gitbook/assets/image (5).png" alt=""><figcaption><p>Proof of AD joined</p></figcaption></figure>

Add Identity Source - fatima.local - and then go to "Users and Groups" under "Single Sign On" and click "Groups" click "Administrators" edit and click dropdown to select fatima.local and add "Domain Admins".&#x20;

<figure><img src=".gitbook/assets/image (6).png" alt=""><figcaption><p>Domain Admins added to Fatima.local Administrators group</p></figcaption></figure>

Successful login using -adm creds @fatima.local

<figure><img src=".gitbook/assets/image (23).png" alt=""><figcaption></figcaption></figure>
