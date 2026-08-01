<#
.SYNOPSIS
Tests pretty-printing XML.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Format-Xml' -Tag Format-Xml,Format,Xml {
	Context 'Pretty-prints XML' {
		It "Indents XML elements" {
			(Get-PSProvider alias |ConvertTo-Xml |Format-Xml) -replace '\\|\r' |Should -BeExactly (@"
<Objects>
  <Object Type="System.Management.Automation.ProviderInfo">
    <Property Name="ImplementingType" Type="System.RuntimeType">Microsoft.PowerShell.Commands.AliasProvider</Property>
    <Property Name="HelpFile" Type="System.String">System.Management.Automation.dll-Help.xml</Property>
    <Property Name="Name" Type="System.String">Alias</Property>
    <Property Name="PSSnapIn" Type="System.Management.Automation.PSSnapInInfo">Microsoft.PowerShell.Core</Property>
    <Property Name="ModuleName" Type="System.String">Microsoft.PowerShell.Core</Property>
    <Property Name="Module" Type="System.Management.Automation.PSModuleInfo" />
    <Property Name="Description" Type="System.String"></Property>
    <Property Name="Capabilities" Type="System.Management.Automation.Provider.ProviderCapabilities">ShouldProcess</Property>
    <Property Name="Home" Type="System.String"></Property>
    <Property Name="Drives" Type="System.Collections.ObjectModel.Collection``1[System.Management.Automation.PSDriveInfo]">
      <Property Type="System.Management.Automation.PSDriveInfo">Alias</Property>
    </Property>
    <Property Name="VolumeSeparatedByColon" Type="System.Boolean">True</Property>
    <Property Name="ItemSeparator" Type="System.Char">/</Property>
    <Property Name="AltItemSeparator" Type="System.Char">\</Property>
  </Object>
</Objects>
"@ -replace '[\\|\r]') -Because 'the output should indent the XML elements'
		}
		It "Indents XML attributes" {
			(Get-PSProvider alias |ConvertTo-Xml |Format-Xml -NewLineOnAttributes) -replace '\\|\r' |Should -BeExactly (@"
<Objects>
  <Object
    Type="System.Management.Automation.ProviderInfo">
    <Property
      Name="ImplementingType"
      Type="System.RuntimeType">Microsoft.PowerShell.Commands.AliasProvider</Property>
    <Property
      Name="HelpFile"
      Type="System.String">System.Management.Automation.dll-Help.xml</Property>
    <Property
      Name="Name"
      Type="System.String">Alias</Property>
    <Property
      Name="PSSnapIn"
      Type="System.Management.Automation.PSSnapInInfo">Microsoft.PowerShell.Core</Property>
    <Property
      Name="ModuleName"
      Type="System.String">Microsoft.PowerShell.Core</Property>
    <Property
      Name="Module"
      Type="System.Management.Automation.PSModuleInfo" />
    <Property
      Name="Description"
      Type="System.String"></Property>
    <Property
      Name="Capabilities"
      Type="System.Management.Automation.Provider.ProviderCapabilities">ShouldProcess</Property>
    <Property
      Name="Home"
      Type="System.String"></Property>
    <Property
      Name="Drives"
      Type="System.Collections.ObjectModel.Collection``1[System.Management.Automation.PSDriveInfo]">
      <Property
        Type="System.Management.Automation.PSDriveInfo">Alias</Property>
    </Property>
    <Property
      Name="VolumeSeparatedByColon"
      Type="System.Boolean">True</Property>
    <Property
      Name="ItemSeparator"
      Type="System.Char">/</Property>
    <Property
      Name="AltItemSeparator"
      Type="System.Char">\</Property>
  </Object>
</Objects>
"@ -replace '\\|\r') -Because 'the output should indent the XML attributes'
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
