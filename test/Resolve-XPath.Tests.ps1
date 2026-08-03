<#
.SYNOPSIS
Tests returning the XPath of the location of an XML node.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$datadir = Join-Path $PSScriptRoot 'data'
}
Describe 'Resolve-XPath' -Tag Resolve-XPath,Resolve,XPath {
	Context 'Returns the XPath of the location of an XML node.' {
		It "Should return a simple XPath" {
			$xpath = '<a><b c="value"/></a>' |Select-Xml //@c |Resolve-XPath
			$xpath.XPath |Should -BeExactly '/a/b/@c'
			$xpath.Namespace.Count |Should -BeExactly 0
		}
		It "Should return multiple XPaths with a namspace" {
			$xpaths = Select-Xml '/xhtml:*/text()' -Path (Join-Path $datadir test.xhtml) `
				-Namespace @{'xhtml'='http://www.w3.org/1999/xhtml'} |Resolve-XPath
			$xpaths[0].XPath |Should -BeExactly '/xhtml:div/text()[1]'
			$xpaths[0].Namespace.Count |Should -BeExactly 1
			$xpaths[0].Namespace['xhtml'] |Should -BeExactly http://www.w3.org/1999/xhtml
			$xpaths[1].XPath |Should -BeExactly '/xhtml:div/text()[2]'
			$xpaths[1].Namespace.Count |Should -BeExactly 1
			$xpaths[1].Namespace['xhtml'] |Should -BeExactly http://www.w3.org/1999/xhtml
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
