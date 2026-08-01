<#
.SYNOPSIS
Tests Gets the namespaces and their URIs and URLs from a document.
#>

return #TODO: finish tests
if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Resolve-XmlSchemaLocation' -Tag Resolve-XmlSchemaLocation,Resolve,XmlSchemaLocation {
	Context 'Gets the namespaces and their URIs and URLs from a document.' -Tag Example {
		It "EXAMPLE 1" -Skip {
			Resolve-XmlSchemaLocation test.xml |Should -BeExactly @"
Path  : C:\test.xml
Node  : root
Alias : xml
Urn   : http://www.w3.org/XML/1998/namespace
Url   :

Path  : C:\test.xml
Node  : root
Alias : xsi
Urn   : http://www.w3.org/2001/XMLSchema-instance
Url   :
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
