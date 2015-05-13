
#region definitions

$NodeName    = 'Webserver-1' 
$OutputPath  = 'C:\TechEd-NA-2014\Demo\CompiledConfigurations'

#endregion definitions

#region Compile configuration

# Create the MOF file using configuration parameters
Remove-Item -Force -Recurse $OutputPath

WebserverMetaconfig -NodeName $NodeName -OutputPath $OutputPath

#endregion Compile configuration

#region deploy configuration

Set-DscLocalConfigurationManager -Path $OutputPath -ComputerName $NodeName -Verbose

#endregion deploy configuration

#region AutoCorrect
function Invoke-AutoCorrect
{
    param()
    Invoke-CimMethod -ClassName MSFT_DscLocalConfigurationManager -Namespace "root/Microsoft/Windows/DesiredStateConfiguration" -ComputerName $NodeName -MethodName PerformRequiredConfigurationChecks -Arguments @{Flags=[uint32]1} -Verbose
}

Invoke-AutoCorrect -verbose
#endregion AutoCorrect