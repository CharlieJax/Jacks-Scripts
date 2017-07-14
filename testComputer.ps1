# Script will test connectivity to the named server $computer
# If the connection fails, it will create an event log entry
# In the application log, with the name "Event Name"
# The event ID is 60193
# Created by: Charles Jacks, 12 July 2017

$computer = "server name"
New-EventLog -Source "Event Name" -LogName "Application" -ErrorAction SilentlyContinue

if (Test-Connection $computer -Quiet -Count 1)
{
	#Do Nothing.
} else {
	Write-EventLog -LogName "Application" -Source "Event Name" -EventID 60193 -EntryType Warning -Message "Unable to ping!!!"  

}