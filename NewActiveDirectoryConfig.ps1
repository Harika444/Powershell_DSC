Configuration NewActiveDirectoryConfig {
param (
[Parameter(Mandatory)]
[PSCredential]$DomainCredential,
[Parameter(Mandatory)]
[PSCredential]$SafeModeAdminPassword
)
Import-DscResource -ModuleName xActiveDirectory
Node $ComputerName {
WindowsFeature ActiveDirectory {
Ensure = 'Present'
Name = 'AD-Domain-services'
}

WindowsFeature ADDSTools
{
ENsure = "Present"
Name = "RSAT-ADDS"
DependsOn = "[WindowsFeature]ActiveDirectory"
}

WindowsFeature ActiveDirectoryTools {
Ensure = 'Present'
Name = 'RSAT-AD-Tools'
DependsOn = "[WindowsFeature]ActiveDirectory"
}

WindowsFeature ActiveDirectoryTools {
Ensure = 'Present'
Name = 'RSAT-AD-Tools'
DependsOn = "[WindowsFeature]ADDSTools"
}

WindowsFeature DNSServerTools{
Ensure = 'Present'
Name = 'RSAT-DNS-Server'
DependsOn="[WindowsFeature]ActiveDirectoryTools"
}

WindowsFeature ActiveDirectoryPowershell {
Ensure ="Present"
Name = "RSAT-AD-Powershell"
DependsOn = "[WindowsFeature]DNSServerTools"
}

XADDomain RootDomain {
Domainname = $DomainName
SafemodeAdministratorPassword = $SafeModeAdminPassword
DomainAdministratorCredential = $DomainCredential
DependsOn = "[WindowsFeature]ActiveDirectory", "[WindowsFeature]ActiveDirectoryPowershell"
}
}
}
$configurationData = @{
AllNodes = @(
@{
NodeName = $ComputerName
PSDscAllowPlainTextPassword = $true
DomainName = $DomainName
}
)
}
NewActiveDirectoryConfig -SafeModeAdminPassword $SafeModeAdminPassword -DomainCredential $DomainCredential

Start-DscConfiguration -Path $MOFfiles -Verbose -CimSession $CimSession -Wait -Force


