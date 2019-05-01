param(
[Parameter(Mandatory)]
[String] $ConfigurationserverUrl,

[Parameter(Mandatory)]
[string] $ConfigurationServerKey
)

[DSCLocalConfigurationManager()]
configuration PullClientConfiguration
{
node localhost
{
settings
{
AllowModuleOverwrite = $True;
ConfigurationMode = 'ApplyAndAutoCorrect';
ConfigurationModeFrequencyMins=60;
RefreshMode = 'Pull';
RefreshFrequencyMins = 30;
RebootNodeIfNeeded = $True;
}

#specifies an HTTP pull server for configurations
ConfigurationRepositoryWeb DSCConfigurtionServer
{
ServerURL = $Node.ConfigServer;
RegistrationKey = $Node.ConfigServerKey;
AllowunsecureConnection = $true;
ConfigurationNames = @("DemoConfig","ChocoConfig")
}

#specifies an HTTP server for modules
ResourceRepositoryWeb DSCModuleServer
{
ServerURL = $Node.ConfigServer;
RegistrationKey = $Node.ConfigServerKey;
AllowUnsecureConnection = $True;
}

PartialConfiguration DemoConfig
{
Description = "DemoConfig"
ConfigurationSource = @("[ConfigurationRepositoryWeb]DSCConfigurationServer")
}
PartialConfiguration ChocoConfig
{
Description = "ChocoConfig"
ConfigurationSource = @("[ConfigurationRepositoryWeb]DSCConfigurationServer")
DependsOn = '[PartialConfiguration]DemoConfig'
}
}
}

$configParams = @{
AllNodes = @(
@{
NodeName = 'localhost'
ConfigServer = $ConfigurationserverUrl
ConfigServerKey= $ConfigurationServerKey
}
)
}
PullClientConfiguration -configurationData $configParams