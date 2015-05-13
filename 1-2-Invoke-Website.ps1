
#region definitions

$NodeName    = 'Webserver-1' 
$OutputPath  = 'C:\TechEd-NA-2014\Demo\CompiledConfigurations'
$SourcePath  = 'C:\Content\TechEd-NA-2014\content\BakeryWebsite'

#endregion definitions

#region Compile configuration

# Create the MOF file using configuration parameters
Remove-Item -Force -Recurse $OutputPath

FourthCoffeeWebSite -NodeName        $NodeName `
                    -WebSiteName     'FourthCoffee' `
                    -SourcePath      $SourcePath  `
                    -DestinationPath 'C:\inetpub\FourthCoffee' `
                    -OutputPath      $OutputPath

#endregion Compile configuration

#region deploy configuration

Start-DscConfiguration -Path $OutputPath -Wait -Verbose

#endregion deploy configuration