Configuration ConfigDataEnvDemo
{
Node $AllNodes.Where{ $_.Env -eq "Dev"}.NodeName
{
File IISLogs
{
DestinationPath = $Node.IISLogFile
Type = "File"
Ensure = "Present"
}
}
Node $AllNodes.Where{ $_.Env -eq "Test"}.NodeNAme
{
File IISLogs
{
DestinationPath = $Node.IISLogFile
Type = "File"
Ensure = "Present"
} 
}
}

$configurationData = @{
AllNodes = @(
@{
NodeName = "locthost"
IISLogFile = "C:\Temp\IISLogs\Logs.txt"
Env="Dev"
},

@{
NodeName = "DEVVM-01"
IISLogFile = "C:\Temp\IISLogs\Logs.txt"
Env="Dev"
},

@{
NodeName = "VM-Test01"
IISLogFile = "C:\Temp\IISLogs\Logs.txt"
Env="Test"
},


@{
NodeName = "VM-Test02"
IISLogFile = "C:\Temp\IISLogs\Logs.txt"
Env="Test"
}
@{
NodeName = "VM-Test03"
IISLogFile = "C:\Temp\IISLogs\Logs.txt"
Env="Test"
}
)
}

ConfigDataEnvDemo -ConfigurationData $configurationData 

