param
(

[Parameter(Mandatory=$false)]
[String] $NodeName = 'localhost',

[Parameter(Mandatory)]
[String] $Key

)


Configuration PullServerConfiguration
{
Import-DscResource -ModuleName xPSDesiredStateConfiguration
Node localhost
{
LocalConfigurationManager
{
ConfigurationMode = 'ApplyAndAutoCorrect'
RefreshMode = 'Push'
RebootNodeIfNeeded = $true
}
WindowsFeature DSCServiceFeature
{
Ensure = 'Present';
Name = 'DSC-Service'
}
xDscWebService PullServer
{
Ensure = 'Present'
EndpointName = 'PullServer';
Port = 80;
PhysicalPath = "$env:SystemDrive\inetpub\PullServer";
CertificateThumbPrint = 'AllowUnencryptedTraffic';
ModulePath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules";
ConfigurationPath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
State = 'Started'
DependsOn = '[WindowsFeature]DSCServiceFeature'
UseSecurityBestPractices =$false
}
File RegistrationKeyFile
{
Ensure = 'Present'
Type ='File'
DestinationPath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\RegistrationKeys.txt"
Contents = "c944ce11-0ffe-467b-bb22-fd1cd2fd76k7"
}
}
}
PullServerConfiguration
