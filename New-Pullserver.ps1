$ErrorActionPreference = 'Stop'
if((Get-ExecutionPolicy) -eq 'Restricted')
{
throw 'Execution policy should be set atlease to RemoteSigned..'
}
if(-not(Test-WSMan -ErrorAction SilentlyContinue))
{
Set-WSManQuickConfig -Force
}
if(-not(Get-Module -Name PackageManagement -ListAvailable))
{
throw 'PackageManagement module should be installed to proceed'
}
if(-not(Get-Module -Name xPSDesiredStateConfiguration -ListAvailable))
{
Install-Module -Name xPSDesiredStateConfiguration -Confirm:$false -verbose
}

#Use [Guid]::NewGuid() | select -ExpandProperty Guid to generate a new the key here
$registrationKey = 'c944ce11-0ffe-467b-bb22-fd1cd2fd7691'

.\Documents\DSCPullServer.ps1 -NodeName 'localhost' -key $registrationKey

Set-DscLocalConfigurationManager -Path .\PullServerConfiguration -Verbose -Force
Start-DscConfiguration .\PullServerConfiguration -Verbose -Force
