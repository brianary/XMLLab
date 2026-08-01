<#
.SYNOPSIS
Tests Creates an object to lookup XML namespace prefixes.
#>

return #TODO: finish tests
if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'New-NamespaceManager' -Tag New-NamespaceManager,New,NamespaceManager {
	Context 'Creates an object to lookup XML namespace prefixes.' -Tag Example {
		It "EXAMPLE 1" -Skip {
			$n = New-NamespaceManager; (Select-Xml //xhtml:td dataref.xslt).Node.SelectSingleNode('xhtml:var',$n).OuterXml |Should -BeExactly @"
<var xmlns="http://www.w3.org/1999/xhtml">ANY</var>
<var xmlns="http://www.w3.org/1999/xhtml">ANY</var>
"@
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
