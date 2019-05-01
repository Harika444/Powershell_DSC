param
(
[Parameter(Mandatory)]
[string] $Path
)

Configuration DemoConfig
{
node DemoConfig
{
File TestFile
{
Ensure = 'Present'
Type = 'File'
DestinationPath = "$env:windir\Temp\DSCPullTest_ConfigName.txt"
Contents = "the demo works if you see this"
}

}

}

DemoConfig -OutputPath $Path
