(New-Object adsisearcher([adsi]"LDAP://OU=TestComputers,DC=testing,DC=com","(objectCategory=computer)")).FindAll() | foreach-object {
	if ([System.IO.File]::Exists("C:\Program Files (x86)\Polaris\5.2\Bin\Polaris.exe") -eq $true) {
		Invoke-GPUpdate -Computer $_.properties.dnshostname -Force 
	}
}