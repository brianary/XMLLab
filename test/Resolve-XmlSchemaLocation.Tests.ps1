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
			Resolve-XmlSchemaLocation (Join-Path $datadir test.xhtml) |
				ForEach-Object {$schemata[$_.Alias] = $_}
			$schemata['xml'].Path |Split-Path -Leaf |Should -BeExactly test.xhtml
			$schemata['xml'].Alias |Should -BeExactly xml
			$schemata['xml'].Urn |Should -BeExactly http://www.w3.org/XML/1998/namespace
			$schemata['xml'].Url |Should -BeNullOrEmpty
			$schemata['xml'].Node.Name |Should -BeExactly div
			$schemata['xsi'].Path |Split-Path -Leaf |Should -BeExactly test.xhtml
			$schemata['xsi'].Alias |Should -BeExactly xsi
			$schemata['xsi'].Urn |Should -BeExactly http://www.w3.org/2001/XMLSchema-instance
			$schemata['xsi'].Url |Should -BeNullOrEmpty
			$schemata['xsi'].Node.Name |Should -BeExactly div
			$schemata[''].Path |Split-Path -Leaf |Should -BeExactly test.xhtml
			$schemata[''].Alias |Should -BeNullOrEmpty
			$schemata[''].Urn |Should -BeExactly http://www.w3.org/1999/xhtml
			$schemata[''].Url |Should -BeExactly http://www.w3.org/1999/xhtml.xsd
			$schemata[''].Node.Name |Should -BeExactly div
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
