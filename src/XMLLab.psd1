# see https://docs.microsoft.com/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest
# and https://docs.microsoft.com/powershell/module/microsoft.powershell.core/new-modulemanifest
@{
RootModule = 'XMLLab.psm1'
ModuleVersion = '0.0.0.0' # placeholder to be overridden
CompatiblePSEditions = @('Core')
GUID = '94b85e1a-1bc8-44e3-ba09-b26eeaa88cca'
Author = 'Brian Lalonde'
CompanyName = 'Unknown'
Copyright = 'Copyright © 2026 Brian Lalonde'
Description = 'Cmdlets to query, transform, and update XML data.'
PowerShellVersion = '7.0'
# RequiredModules = ,'Microsoft.PowerShell.Utility'
FunctionsToExport = @('*') # '*'
CmdletsToExport = @() # '*'
VariablesToExport = @() # '*'
# AliasesToExport = @()
FileList = @('XMLLab.psd1','XMLLab.psm1')
PrivateData = @{
	PSData = @{
		Tags = @('XML','XSLT','XPath','xmlns','data')
		LicenseUri = 'https://github.com/brianary/XMLLab/blob/master/LICENSE'
		ProjectUri = 'https://github.com/brianary/XMLLab/'
		IconUri = 'http://webcoder.info/images/XMLLab.svg'
		# ReleaseNotes = ''
		# PS7: A list of external modules that this module is dependent upon.
		# ExternalModuleDependencies = ,'Microsoft.PowerShell.Utility'
	}
}
}
