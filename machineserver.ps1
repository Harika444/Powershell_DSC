Configuration MachineConfig
{
Import-DscResource -ModuleName PSDesiredStateConfiguration
Node localhost
{
File TempDirectory
{
DestinationPath = "C:\Temp"
ensure = "Present"
Type = "Directory"
}

Service WindowsInstaller
{
Name = "msiserver"
State = "Running"
}
}
}
MachineConfig