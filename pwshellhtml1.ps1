#Install file in IIS
$downloadsHome =  Get-location
Add-Type -AssemblyName System.IO.Compression.FileSystem
$source = "$downloadsHome\testhtmlpage.html"; $destination = "C:\inetpub\testhtmlpage"
New-Item -ItemType directory -Path "C:\inetpub\testhtmlpage" -Force
Copy-Item $source $destination -Force

Import-Module WebAdministration
Set-Location IIS:\
$SiteFolderPath = "C:\inetpub\testhtmlpage"
$SiteAppPool = "html"
$SiteName = "html"

if(Test-Path IIS:\AppPools\$SiteAppPool)
{
"AppPool is already there"
"so removing the existing app pool and recreating the new app pool"
##$AppPoolRemoveScriptBlock="Remove-WebAppPool -Name html"
##Invoke-Command -ScriptBlock $AppPoolRemoveScriptBlock
Remove-WebAppPool -Name html
New-Item IIS:\AppPools\$SiteAppPool -force
New-Item IIS:\Sites\$SiteName -physicalPath $SiteFolderPath -bindings @{protocol="http";bindingInformation=":80:"} -force
Set-ItemProperty IIS:\Sites\$SiteName -name applicationPool -value $SiteAppPool
##return $true;
}
else
{
"AppPool is not present"
"Creating new AppPool"
New-Item IIS:\AppPools\$SiteAppPool -force
New-Item IIS:\Sites\$SiteName -physicalPath $SiteFolderPath -bindings @{protocol="http";bindingInformation=":80:"} -force
Set-ItemProperty IIS:\Sites\$SiteName -name applicationPool -value $SiteAppPool
}


#Powershell command to enable iis
#Start /w pkgmgr /iu:IIS-WebServerRole;IIS-WebServer;IIS-CommonHttpFeatures;IIS-StaticContent;IIS-DefaultDocument;IIS-DirectoryBrowsing;IIS-HttpErrors;IIS-HealthAndDiagnostics;IIS-HttpLogging;IIS-LoggingLibraries;IIS-RequestMonitor;IIS-Security;IIS-RequestFiltering;IIS-HttpCompressionStatic;IIS-WebServerManagementTools;IIS-ManagementConsole;WAS-WindowsActivationService;WAS-ProcessModel;WAS-NetFxEnvironment;WAS-ConfigurationAPI

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -online -FeatureName NetFx4Extended-ASPNET45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45

# installing extra features

Add-WindowsFeature web-server
Add-WindowsFeature web-common-http
Add-WindowsFeature web-default-doc
Add-WindowsFeature web-http-errors
Add-WindowsFeature web-static-content
Add-WindowsFeature web-http-logging
Add-WindowsFeature web-performance
Add-WindowsFeature web-stat-compression
Add-WindowsFeature web-security
Add-WindowsFeature web-filtering
Add-WindowsFeature web-mgmt-tools
Add-WindowsFeature web-custom-logging
Add-WindowsFeature web-request-monitor
Add-WindowsFeature web-http-tracing
Add-WindowsFeature web-windows-auth
Add-WindowsFeature web-app-dev
Add-WindowsFeature web-net-ext45
Add-WindowsFeature web-isapi-ext
Add-WindowsFeature web-isapi-filter
Add-WindowsFeature web-scripting-tools
Add-WindowsFeature web-mgmt-service
Add-WindowsFeature Web-Asp-Net45