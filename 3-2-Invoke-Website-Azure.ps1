
#region definitions

$ServiceName = 'fourthcoffee81'
$OutputPath  = 'C:\TechEd-NA-2014\Demo\CompiledConfigurations'
$SourcePath  = 'C:\Content\'
Get-AzureWinRMUri -ServiceName $ServiceName -OutVariable WinRMUri

$ScriptPath  = 'C:\TechEd-NA-2014\Demo'
$ConfigData  = (& "$ScriptPath\3-1-TestData.ps1")

#endregion definitions

#region Compile configuration

# Create the MOF file using configuration parameters
Remove-Item -Force -Recurse $OutputPath

FourthCoffeeWebSite -ConfigurationData $ConfigData `
                    -WebSiteName       'FourthCoffee' `
                    -SourcePath        $SourcePath  `
                    -DestinationPath   'C:\inetpub\FourthCoffee' `
                    -OutputPath        $OutputPath

#endregion Compile configuration

#region setup cimsession for Azure V
$Options = New-CimSessionOption -SkipCACheck -UseSsl 

$s = New-CimSession -ComputerName $WinRMUri.Host -Port $WinRMUri.Port -SessionOption $Options -Credential localadmin -Verbose

#endregion setup cimsession for Azure VM

#region deploy configuration

Start-DscConfiguration -CimSession $s -Wait -Path $OutputPath -Verbose

#endregion deploy configuration