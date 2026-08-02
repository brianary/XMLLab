<#
.SYNOPSIS
Tests getting the namespaces and their URIs and URLs from a document.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$datadir = Join-Path $PSScriptRoot 'data'
}
Describe 'Resolve-XmlSchemaLocation' -Tag Resolve-XmlSchemaLocation,Resolve,XmlSchemaLocation {
	Context 'Gets the namespaces and their URIs and URLs from a document.' {
		It "Finds the schemata within the given XML document namespaces" {
			$schemata = @{}
			Resolve-XmlSchemaLocation (Join-Path $datadir xslt-schemata.xslt) |
				ForEach-Object {$schemata[$_.Alias] = $_}
			$schemata['xml'].Path |Split-Path -Leaf |Should -BeExactly xslt-schemata.xslt
			$schemata['xml'].Alias |Should -BeExactly xml
			$schemata['xml'].Urn |Should -BeExactly http://www.w3.org/XML/1998/namespace
			$schemata['xml'].Url |Should -BeNullOrEmpty
			$schemata['xsi'].Path |Split-Path -Leaf |Should -BeExactly xslt-schemata.xslt
			$schemata['xsi'].Alias |Should -BeExactly xsi
			$schemata['xsi'].Urn |Should -BeExactly http://www.w3.org/2001/XMLSchema-instance
			$schemata['xsi'].Url |Should -BeNullOrEmpty
			$schemata['fn'].Path |Split-Path -Leaf |Should -BeExactly xslt-schemata.xslt
			$schemata['fn'].Alias |Should -BeExactly fn
			$schemata['fn'].Urn |Should -BeExactly http://www.w3.org/2005/xpath-functions
			$schemata['fn'].Url |Should -BeNullOrEmpty
			$schemata['xsl'].Path |Split-Path -Leaf |Should -BeExactly xslt-schemata.xslt
			$schemata['xsl'].Alias |Should -BeExactly xsl
			$schemata['xsl'].Urn |Should -BeExactly http://www.w3.org/1999/XSL/Transform
			$schemata['xsl'].Url |Should -BeExactly http://www.w3.org/1999/XSL/Transform.xsd
			$schemata[''].Path |Split-Path -Leaf |Should -BeExactly xslt-schemata.xslt
			$schemata[''].Alias |Should -BeNullOrEmpty
			$schemata[''].Urn |Should -BeExactly http://www.w3.org/1999/xhtml
			$schemata[''].Url |Should -BeExactly http://www.w3.org/1999/xhtml.xsd
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
