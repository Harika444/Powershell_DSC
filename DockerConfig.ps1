$MOFfiles = "C:\Temp\DockerConfig"
Configuartion DockerConfig {

Import-DscResource -ModuleName PSDesiredStateConfiguration
Import-DscResource -ModuleName xPSDesiredStateConfiguration


Node $AllNodeName {
WindowsFeature InstallContainersFeature
{
Ensure = "Present"
Name = "Containers"
}

xRemoteFile DownloadDockerZipFile
{
DestinationPath = $configurationData.NonNodeData.DockerDownloadPath
Uri = $configurationData.NonNodeData.DockerEngineUrl
MatchSource = $False
DependsOn = "[WindowsFeature]InstallContainersFeature"
}
Archive ExtractDockerZipContents
{
Destination = $env:ProgramFiles
Path = $ConfigurationData.NonNodeData.DockerDownloadPath
Ensure = 'Present'
Validate = $false
Force = $true
DependsOn = '[xRemoteFile]DownloadDockerZipFile'
}
xEnviornment DockerPath
{
Ensure = 'Present'
Name = 'Path'
Value = $ConfigurationData.NonNodeData.DockerInstallPath
Path = $True
DependsOn = '[Archive]ExtractDockerZipContents'
}

Script RegisterDockerService
{
SetScript = {
$DockerDPath = (Join-Path $($UsingConfigurationData.NonNodeData.DockerInstallPath)"docker.exe")
& $DockerDPath @('--register-service')
}

GetScript = {
return @{
'Service' = (Get-Service -Name Docker).Name
 }
 }
 TestScript = {
 if (Get-Service -Name Docker -ErrorAction SilentlyContinue)
 {
 return $true
 }
 return $false
 }
DependsOn = '[xEnviornment]DockerPath'
}
xService StartDockerService
{
Ensure = 'Present'
Name = 'Docker'
StartupType = 'Automatic'
State = 'Running'
DependsOn = '[Script]RegisterDockerService'
}
LocalConfigurationManager {
ActionAfterReboot = 'ContinueConfiguration'
ConfigurationMode = 'ApplyOnly'
RebootNodeIfNeeded = $true
}
}
}

$ConfigData = @{
AllNodes = @(
@{
NodeName = $env:COMPUTERNAME
}

)

NonNodeData = @{
DockerEngineUrl = "https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe"
DockerInstallPath = (Join-Path -Path $ENV:ProgramFiles "Docker")
DockerDownloadPath = (Join-Path "C:\Window\Temp" "docker-17.06.2ee-5.zip")
}
}

DockerConfig -Outpath $MOFfiles -ConfigurationData $ConfigData
Set-DscLocalConfigurationManager -Path $MOFfiles -Verbose
Start-DscConfiguration -Path $MOFfiles -Wait -Verbose -Force