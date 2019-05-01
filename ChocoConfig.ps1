param
(
[Parameter(Mandatory)]
[string] $Path
)

configuration chocoConfig
{
Import-DscResource -Module CChoco

Node ChocoConfig
{
cChocoInstaller InstallChocolatey
{
InstallDir = "C:\ProgramData\chocolatey"
}
cChocoPackageInstaller 7Zip
{
Name = '7zip.install'
DependsOn="[cChocoInstaller]InstallChocolatey"
}
}
}

ChocoConfig -OutputPath $Path
