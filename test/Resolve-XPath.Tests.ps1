<#
.SYNOPSIS
Tests Returns the XPath of the location of an XML node.
#>

return #TODO: finish tests
if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Resolve-XPath' -Tag Resolve-XPath,Resolve,XPath {
	Context 'Returns the XPath of the location of an XML node.' -Tag Example {
		It "EXAMPLE 1" -Skip {
			'<a><b c="value"/></a>' |Select-Xml //@c |Resolve-XPath |Should -BeExactly @"
/a/b/@c
"@
		}
		It "EXAMPLE 2" -Skip {
			'<a>one<!-- two -->three</a>' |Select-Xml '//text()' |Resolve-XPath |Should -BeExactly @"
/a/text()[1]
/a/text()[2]
"@
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
