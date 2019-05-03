Configuration ConfigDataDemo
{
Node $AllNodes.NodeName
{
File TempLogDirectory
{
DestinationPath = $Node.TempLogLocation
Type = "Directory"
Ensure = "Present"
}
}
}

$configurationData = @{
AllNodes = @(
@{
NodeName = "localhost"
TemoLogLocation = "C:\Temp"
},

@{
NodeName = "TestVM01"
TemoLogLocation = "C:\Temp"
},
@{
NodeName = "ProdVM01"
TemoLogLocation = "C:\Logs"
}
)
}
ConfigDataDemo -ConfigurationData $configurationData