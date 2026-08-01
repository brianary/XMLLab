<#
.SYNOPSIS
Tests getting the namespaces from a document as a dictionary.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$datadir = Join-Path $PSScriptRoot 'data'
}
Describe 'Get-XmlNamespaces' -Tag Get-XmlNamespaces,Get,XmlNamespaces {
	Context 'Gets the namespaces from a document as a dictionary' {
		It "Can be used to provide namespaces for Select-Xml" {
			Select-Xml /xsl:transform (Join-Path $datadir xslt-test.xslt) -Namespace (Get-XmlNamespaces (Join-Path $datadir xslt-test.xslt)) |
				Should -HaveCount 1 -Because 'one element should be found'
		}
		It "Should return namespaces" {
			(Get-XmlNamespaces (Join-Path $datadir xslt-test.xslt) |ConvertTo-Json) -replace '\r' |
				Should -BeExactly (@"
{
  "xml": "http://www.w3.org/XML/1998/namespace",
  "fn": "http://www.w3.org/2005/xpath-functions",
  "xsl": "http://www.w3.org/1999/XSL/Transform",
  "": "http://www.w3.org/1999/xhtml"
}
"@ -replace '\r') -Because 'the aliases and namespaces should be returned from the XML document'
		}
	}

}
AfterAll {
	&"/home/brianary/GitHub/XMLLab/scripts/../scripts/Remove-ThisModule.ps1"
}
