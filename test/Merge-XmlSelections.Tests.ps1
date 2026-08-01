<#
.SYNOPSIS
Tests building an object using the named XPath selections as properties.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$datadir = Join-Path $PSScriptRoot 'data'
}
Describe 'Merge-XmlSelections' -Tag Merge-XmlSelections,Merge,XmlSelections {
	Context 'Builds an object using the named XPath selections as properties.' {
		It "Performs multiple selections and returns them as properties" {
			$result = Merge-XmlSelections @{
				Version = '/*/@version'
				Format  = '/xsl:transform/xsl:output/@method'
			} "$datadir/xslt-test.xslt" -Namespace @{xsl='http://www.w3.org/1999/XSL/Transform'}
			$result.Path |Should -BeLike '*xslt-test.xslt'
			$result.Version |Should -Be '1.0'
			$result.Format |Should -Be 'text'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
