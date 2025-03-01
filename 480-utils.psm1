function 480Banner()
{
    Write-Host "Hello SYS480"
}

Function 480Connect([string] $server)
{
    $conn = $global:DefaultVIServer
    # Is it already connected?
    if ($conn){
        $msg = "Already connected to: {0}" -f $conn

        Write-Host -ForegroundColor Green $msg
    }else
    {
        $conn = Connect-VIServer -Server $server
    }
}

Function Get-480Config([string] $config_path)
{
    Write-Host "Reading " $config_path
    $conf=$null
    if(Test-Path $config_path)
    {
        $conf = (Get-Content -Raw -Path $config_path | ConvertFrom-Json)
        $msg = "Using Configuration at {0}" -f $config_path
        Write-Host -ForegroundColor "Green" $msg
    } else
    {
        Write-host -ForegroundColor "Yellow" "No Configuration"

    }
    return $conf
}

Function Select-VM([string] $folder)
{
    $selected_vm=$null
    try
    {
        $vms = Get-VM -Location $folder
        $index = 1
        foreach($vm in $vms)
        {
            Write-Host [$index] $vm.name
            $index+=1
        }
        $pick_index = Read-Host "Which index number [x] do you wish to pick?"
        # Created an exception for dealing with invalid index
        if($selected_vm = $vms[$pick_index -1])
        {
        Write-Host "You picked " $selected_vm.name
        return $selected_vm
        } else
        {
        (-not $selected_vm)
        Write-Host "Invalid, Try Again"
        }
}
    catch
    {
        Write-Host "Invalid Folder: $folder" -ForegroundColor "Red"
    }
}

Function Select-Datastore([string] $folder)
{
    $selected_ds=$null
    $datastores=Get-Datastore
    $index=1

    foreach ($ds in $datastores) {
        Write-Host "[$index] $($ds.Name)"
        $index += 1
        } 
        $pick_index = Read-Host "Which index number [x] do you wish to pick?"
        # ChatGPT helped
        # -gt 0 = checking if value enter is greather than 0
        # -le = checking if value entered is less than or equal to total # of datastores
        # "Cannot Index into a null array"
            if ($pick_index -gt 0 -and $pick_index -le $datastores.Count) {
                $selected_ds = $datastores[$pick_index - 1]
                Write-Host "You picked $($selected_ds.Name)"
                return $selected_ds
            }
        
            Write-Host "Invalid!" -ForegroundColor "Red"

        }
Function LinkedClone{
    $vm = Select-VM "Base"
    $vm_host = "192.168.3.214"
    $datastores = Select-Datastore
    $snapshot = Get-Snapshot -VM $vm -Name "Base"
    Write-Host "Creating Linked Clone from '$($vm.name)'.."
    Write-Host "VM: $vm"
    Write-Host "Snapshot: $snapshot"
    Write-Host "Datastore: $datastores"
    Write-Host "VMHost: $vm_host"
    $linkedClone = "{0}.linked" -f $vm.Name
    try {
        $linkedvm = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vm_host -Datastore $datastores
        Write-Host "Successfully Created!" -ForegroundColor "Green"
    }
    catch {
    
    Write-Host "ERROR!! ABORT" -ForegroundColor "Red"
    }
}

Function FullClone{
        $vm = Select-VM "Base"
        $vm_host = "192.168.3.214"
        $datastores = Select-Datastore
        $snapshot = Get-Snapshot -VM $vm -Name "Base"
        Write-Host "Creating Linked Clone from '$($vm.name)'.."
        Write-Host "VM: $vm"
        Write-Host "Snapshot: $snapshot"
        Write-Host "Datastore: $datastores"
        Write-Host "VMHost: $vm_host"
        $linkedClone = "{0}.linked" -f $vm.Name
        $fullClone = "{0}.full" -f $vm.Name
        try {
            $fullvm = New-VM -Name $fullClone -VM $linkedClone -VMHost $vm_host -Datastore $datastores
            Write-Host "Created Successfully!" -ForegroundColor "Green"
        }
        catch {
        
        Write-Host "ERROR!! ABORT" -ForegroundColor "Red"
        }
    }

    Function whatuwant {
        $question = Read-Host "Enter 1 to create a Full Clone or 2 for a Linked Clone"
        if ($question -eq '1') {
            FullClone
        }
            else {
            ($question -eq '2')
                LinkedClone
            }
        }
