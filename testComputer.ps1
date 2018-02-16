# Script will test connectivity to the named server $computer
# If the connection fails, it will create an event log entry
# In the application log, with the name "Post Connectivity"
# The event ID is 60193
# Created by: Charles Jacks, 12 July 2017

$STLcomputer = "breutl01.postholdings.com"
$DEVcomputer = "rsppads1.postholdings.com"
New-EventLog -Source "Post Connectivity" -LogName "Application" -ErrorAction SilentlyContinue

if (Test-Connection $STLcomputer -Quiet -Count 1)
{
	$results = "Success @ $(Get-Date)"
    $results | Out-File c:\scripts\results.txt
} else {
	$results = "Failure @ $(Get-Date)"
    $results | Out-File c:\scripts\results.txt
	Write-EventLog -LogName "Application" -Source "Post Connectivity" -EventID 60193 -EntryType Warning -Message "Rackspace Windows team: There is no action to be taken on the server for this alert.  This alert is to ping the Post Holdings Network, which will be inaccessible from your consoles.  In the event of this alert, the monitoring system should text the individuals with access to the firewalls (the Post Holdings network team).  This is a notification to let Post know that network connectivity is down between Rackspace and St. Louis (or the server is being rebooted).  There is no need to evaluate the server this alert ran on.  The ticket, if validated by Post Holdings, should be moved to the NETSEC team for management and troubleshooting."  

}

if (Test-Connection $DEVcomputer -Quiet -Count 1)
{
	$results1 = "Success @ $(Get-Date)"
    $results, $results1 | Out-File c:\scripts\results.txt
} else {
	$results1 = "Failure @ $(Get-Date)"
    $results, $results1 | Out-File c:\scripts\results.txt
	Write-EventLog -LogName "Application" -Source "Post Connectivity" -EventID 60193 -EntryType Warning -Message "Rackspace Windows team: This alert is pinging across the VPN tunnel between the IAD and ORD datacenters.  This VPN connection is managed by Rackspace and the ticket should be moved to the NETSEC team to valdate if the VPN tunnel is down."  

}