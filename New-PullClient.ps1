$ErrorActionPreference='Stop'
if((Get-ExecutionPolicy) -eq 'Restricted')
{
throw 'Execution policy should be set atleast to RemoteSigned..'
}
if(-not(Test-WSMan -ErrorAction SilentlyContinue))
{
Set-WSManQuickConfig -Force
}

$configServerUrl = 'http://pullserver9392.cloudapp.net/PSDSCPullServer.svc/'

$configServerKey='c944ce11-0ffe-467b-bb22-fd1cd2fd7691'

.\documents\ClientConfig.ps1 -ConfigurationServerURL $configServerUrl -ConfigurationServerKey $configServerKey


 Set-DscLocalConfigurationManager -Path .\PullClientConfiguration -Verbose -Force
