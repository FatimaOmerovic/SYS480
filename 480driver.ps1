Import-Module '480-utils' -Force
# Call the Banner Function
480Banner
$conf = Get-480Config -config_path "/home/fatima/modules/480-utils/480.json"
480Connect -Server $conf.vcenter_server
whatuwant

