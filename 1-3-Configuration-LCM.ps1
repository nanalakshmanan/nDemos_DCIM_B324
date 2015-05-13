configuration WebserverMetaconfig
{
    param
      (
          # Target nodes to apply the configuration
          [Parameter(Mandatory)]
          [ValidateNotNullOrEmpty()]
          [String[]]$NodeName
      )

      # Import the module that defines custom resources
      Import-DscResource -Module xWebAdministration

      Node $NodeName
      {
          LocalConfigurationManager
          {
              ConfigurationMode = 'ApplyAndAutoCorrect'
          }
      }
}