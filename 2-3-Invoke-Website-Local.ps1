
#region definitions

$OutputPath  = 'C:\TechEd-NA-2014\Demo\CompiledConfigurations'
$SourcePath  = 'C:\Content\TechEd-NA-2014\content\BakeryWebsite'
$ScriptPath  = 'C:\TechEd-NA-2014\Demo'
$ConfigData  = (& "$ScriptPath\2-2-DevData.ps1")

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

#region deploy configuration

Start-DscConfiguration -Path $OutputPath -Wait -Verbose

#endregion deploy configuration