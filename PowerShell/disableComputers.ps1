ForEach ($system in Get-Content "systems.txt")
{
Write-Host $system
Set-ADComputer -Identity $system -Enabled $false
}