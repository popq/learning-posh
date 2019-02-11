# Script to show all firewall rules from powershell
Function Get-FireWallRule
	{Param ($Name, $Direction, $Enabled, $Protocol, $profile, $action, $grouping)
	$Rules=(New-object –comObject HNetCfg.FwPolicy2).rules
	If ($name)      {$rules= $rules | where-object {$_.name     –like $name}}
	If ($direction) {$rules= $rules | where-object {$_.direction  –eq $direction}}
	If ($Enabled)   {$rules= $rules | where-object {$_.Enabled    –eq $Enabled}}
	If ($protocol)  {$rules= $rules | where-object {$_.protocol  -eq $protocol}}
	If ($profile)   {$rules= $rules | where-object {$_.Profiles -bAND $profile}}
	If ($Action)    {$rules= $rules | where-object {$_.Action     -eq $Action}}
	If ($Grouping)  {$rules= $rules | where-object {$_.Grouping -Like $Grouping}}
	$rules}
  
Get-firewallRule -enabled $true | sort direction,applicationName,name | format-table -wrap -autosize -property Name, @{Label=”Action”; expression={$Fwaction[$_.action]}}, 
@{label="Direction";expression={ $fwdirection[$_.direction]}},@{Label=”Protocol”; expression={$FwProtootocols[$_.pr]}} , localPorts,remotePorts,applicationname, LocalAddresses, RemoteAddresses
  
# For export to csv, use
#Get-firewallRule -enabled $true | sort direction,applicationName,name | Select-Object -property Name, @{Label=”Action”; expression={$Fwaction[$_.action]}},
#@{label="Direction";expression={ $fwdirection[$_.direction]}},@{Label=”Protocol”; expression={$FwProtootocols[$_.pr]}} , localPorts,remotePorts,applicationname, LocalAddresses, RemoteAddresses| export-csv e:\file.csv
