# List of accounts whose profiles cannot be deleted
For ($i = 0; $1 -le 100; $i++) {
$computer = Read-Host 
Invoke-Command -ComputerName DUMMYDOMAIN$computer -ScriptBlock {

$ExcludedUsers = ”Public”,"Additionl User”
$LocalProfiles = Get-WMIObject -class Win32_UserProfile | Where {(!$_.Special) -and (!$_.Loaded) -and ($_.ConvertToDateTime($_.LastUseTime) -lt (Get-Date).AddDays(-60))}

foreach ($LocalProfile in $LocalProfiles)
{

if (!($ExcludedUsers -like $LocalProfile.LocalPath.Replace(“C:\Users\”,””)))
{

$LocalProfile | Remove-WmiObject
Write-host $LocalProfile.LocalPath, “profile deleted” -ForegroundColor Magenta
}
}
}
}
