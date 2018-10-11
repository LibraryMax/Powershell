<# (Get-HotFix | sort installedon)[-1]  sd  #>
(New-Object adsisearcher([adsi]"LDAP://OU=Test,DC=testing,DC=com","(objectCategory=computer)")).FindAll() | foreach-object {
	$PingRequest = Test-Connection -ComputerName $_.properties.dnshostname -Count 1 -Quiet
	if($PingRequest -eq $true){
		(Get-HotFix -Computername $_.properties.dnshostname | sort installedon)[-1] | Out-File -filepath C:\test\latest.txt -Append
	} Elseif($PingRequest -eq $false){
		$_.properties.dnshostname | Out-File -filepath C:\test\noresponse.txt -Append
	}
}