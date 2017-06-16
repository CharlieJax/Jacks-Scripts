'Version 2.0
'Charles Jacks
'14 June 2017
strComputer = "."

SET objWMIDateTime = CREATEOBJECT ("WbemScripting.SWbemDateTime")
SET objWMI = GETOBJECT("winmgmts:\\localhost\root\cimv2")
SET colOS = objWMI.InstancesOf("Win32_OperatingSystem")

FOR EACH objOS in colOS
	objWMIDateTime.Value = objOS.LastBootUpTime
NEXT

upTime = TimeSpan(objWMIDateTime.GetVarDate,NOW)
'upTime = 215  'Used to test UpTime

currentTime = hour(now)
'result=Msgbox("Current Uptime in Hours: " & upTime,vbOKOnly+vbInformation+vbSystemModal, "Post Holdings Reboot Notificiation")

IF ((upTime >= 168 and upTime <= 191) and (currentTime = 16)) THEN
result=Msgbox("Your PC has been on for more than seven days.  Please reboot!",vbOKOnly+vbInformation+vbSystemModal, "Post Holdings Reboot Notificiation")
End IF

IF ((upTime >= 192 and upTime <= 215) and (currentTime = 10 or currentTime = 16)) THEN
result=Msgbox("Your PC has been on for more than seven days.  Please reboot!",vbOKOnly+vbInformation+vbSystemModal, "Post Holdings Reboot Notificiation")
End IF

IF (upTime >= 216) THEN
result=Msgbox("Your PC has been on for more than seven days.  Please reboot!",vbOKOnly+vbInformation+vbSystemModal, "Post Holdings Reboot Notificiation")
End IF


FUNCTION TimeSpan(dt1, dt2)
If (ISDATE(dt1) AND ISDATE(dt2)) = FALSE THEN 
	TimeSpan = "00"
EXIT FUNCTION
END IF

seconds = ABS(DATEDIFF("S", dt1, dt2))
minutes = seconds \ 60
hours = minutes \ 60
minutes = minutes MOD 60
seconds = seconds MOD 60

IF LEN(hours) = 1 THEN hours = "0" & hours

TimeSpan = hours
END FUNCTION