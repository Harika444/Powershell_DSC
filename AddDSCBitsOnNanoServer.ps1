$Credentials = Get-Credential -Username "aharika" -Message "Enter password for azure login"
$session = New-PSSession -ComputerName "" -Credential $Credentials

Invoke-Command -ScriptBlock {
Install-PackageProvider -Name NanoServerPackage -Force
Import-PackageProvider NanoServerPackage

Install-NanoServerPackage -Name Microsoft-NanoServer-DSC-Package -Culture en-us -Force
} -Session $session

Remove-PSSession -Session $session

<#

$Credentials = Get-Credential -Username "aharika" -Message "Enter password for azure login"
$session = New-PSSession -ComputerName "" -Credential $Credentials

#>