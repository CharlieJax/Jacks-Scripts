Import-Module ActiveDirectory

$When = ((Get-Date).AddDays(-1)).Date

$UserList = Get-ADUser -Filter {whenCreated -ge $When} -Properties whenCreated | select DistinguishedName, whenCreated

if($UserList.count -gt 0) {
  # Get-ADUser -Filter {whenCreated -ge $When} -Properties whenCreated | select DistinguishedName, whenCreated
  $reportpath = ".\UserCreationLog-$(get-date -f yyyy-MM-dd).txt"
  if((test-path $reportpath) -like $false) { new-item $reportpath -type file } 
  $report = $reportpath


  add-content $report "Users created on $(get-date -f yyyy-MM-dd)"
  add-content $report "------------------------------------------"

  foreach ($name in $UserList){
    add-Content $report "$($name.DistinguishedName)"
    add-Content $report "$($name.whenCreated)"
    add-Content $report " "
  }
}