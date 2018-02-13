Import-Module activedirectory
$filedate = (Get-Date).tostring("yyyyMMdd")
$filename = "c:\scripts\PCCheck-" + $filedate + ".txt"
Get-ADComputer -Properties LastLogonDate -Filter {enabled -eq $True} | Sort LastLogonDate | FT Name, LastLogonDate -Autosize | Out-File $filename