<#
.SYNOPSIS
Tests criating an object to lookup XML namespace prefixes.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'New-NamespaceManager' -Tag New-NamespaceManager,New,NamespaceManager {
	Context 'Creates an object to lookup XML namespace prefixes.' {
		It "Returns a new XmlNamespaceManager" {
			$n = New-NamespaceManager @{xsl='http://www.w3.org/1999/XSL/Transform'}
			,$n |Should -BeOfType System.Xml.XmlNamespaceManager -Because 'The correct type should be returned'
			$n.LookupNamespace('xsl') |Should -BeExactly http://www.w3.org/1999/XSL/Transform `
				-Because 'The namespace URL should be returned given the prefix'
			$n.LookupPrefix('http://www.w3.org/1999/XSL/Transform') |Should -BeExactly xsl `
				-Because 'The prefix should be returned given the namespace URL'
			$n.LookupNamespace('x') |Should -BeNullOrEmpty -Because 'The prefix is not defined'
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
