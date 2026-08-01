<#
.SYNOPSIS
Tests Builds an object using the named XPath selections as properties.
#>

return #TODO: finish tests
if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Merge-XmlSelections' -Tag Merge-XmlSelections,Merge,XmlSelections {
	Context 'Builds an object using the named XPath selections as properties.' -Tag Example {
		It "EXAMPLE 1" -Skip {
			Merge-XmlSelections @{Version='/*/@version';Format='/xsl:output/@method'} *.xsl* -Namespace @{xsl='http://www.w3.org/1999/XSL/Transform'} |Should -BeExactly @"
Path                    Version Format
----                    ------- ------
Z:\Scripts\dataref.xslt 2.0     html
Z:\Scripts\xhtml2fo.xsl 1.0     xml
"@
		}
	}
	Context 'Xml' -Tag Xml {
		It "test" -Skip {
			1 |Should -Be 1
		}
	}
	Context 'Path' -Tag Path {
		It "test" -Skip {
			1 |Should -Be 1
		}
	}
}
AfterAll {
	&"/home/brianary/GitHub/XMLLab/scripts/../scripts/Remove-ThisModule.ps1"
}
