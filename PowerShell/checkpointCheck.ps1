# Script to identify Checkpoints in Hyper-V
# Adds Events to the Application log
# if they are X days old based on the
# variable $Days
# The entry will be of the source "Hyper-V-Snapshots
# Created by Charles Jacks

$Days = 3 #change this value to determine the number of days to rotate.
New-EventLog -Source "Hyper-V-Snapshots" -LogName "Application" -ErrorAction SilentlyContinue


$VMs = Get-VM | Select -ExpandProperty name
foreach($VM in $VMs){

    $Snapshots = Get-VMSnapshot $VM
    foreach($Snapshot in $Snapshots){

        if ($snapshot.CreationTime.AddDays($Days) -lt (get-date)){
	    $createTime = $snapshot.CreationTime
	    Write-EventLog -LogName "Application" -Source "Hyper-V-Snapshots" -EventID 60192 -EntryType Warning -Message "$VM Has an old snapshot that was created $createTime!"  
        } 
    }
}