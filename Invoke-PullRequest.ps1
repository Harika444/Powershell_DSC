$paramHash = @{
ComputerName = 'localhost'
Namespace = 'root/microsoft/windows/desiredstateconfiguration'
Class = 'MSFT_DscLocalConfigurationManager'
MethodName = 'PerformRequiredCOnfigurationChecks'
Arguments= @{Flags=[uint32] 1}
}
Invoke-CimMethod @paramHash
 