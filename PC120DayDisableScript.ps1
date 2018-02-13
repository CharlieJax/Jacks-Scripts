Import-Module activedirectory
$datecutoff = (Get-Date).AddDays(-120)
$filedate = (Get-Date).tostring("yyyyMMdd")
$filename = "c:\scripts\PCCleanup-" + $filedate + ".txt"
Get-ADComputer -Properties LastLogonDate -Filter {(enabled -eq $True) -and (LastLogonDate -lt $datecutoff)} | Sort LastLogonDate | FT Name, LastLogonDate -Autosize | Out-File $filename
Get-ADComputer -Properties LastLogonDate -Filter {(enabled -eq $True) -and (LastLogonDate -lt $datecutoff)} | Set-ADComputer -Enabled $false