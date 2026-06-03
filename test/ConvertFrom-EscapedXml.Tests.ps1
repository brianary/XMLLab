<#
.SYNOPSIS
Tests parsing escaped XML into XML and serialization.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'ConvertFrom-EscapedXml' -Tag ConvertFrom-EscapedXml {
	Context 'Parse escaped XML into XML and serialize it' -Tag ConvertFromEscapedXml,Convert,ConvertFrom,EscapedXml,Xml {
		It "Should convert '<Value>' into '<Result>'" -TestCases @(
			@{ Value = '&lt;x /&gt;'; Result = '<x />' }
			@{ Value = '&lt;a href=&quot;http://example.org&quot;&gt;link&lt;/a&gt;'
				Result = '<a href="http://example.org">link</a>' }
		) {
			Param([string]$Value,[string]$Result)
			ConvertFrom-EscapedXml $Value |Should -BeExactly $Result -Because 'input parameter should work'
			$Value |ConvertFrom-EscapedXml |Should -BeExactly $Result -Because 'input pipeline should work'
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
