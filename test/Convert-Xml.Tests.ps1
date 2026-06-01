<#
.SYNOPSIS
Tests transforming XML using an XSLT template.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$datadir = Join-Path $PSScriptRoot 'data'
	#TODO: Figure out SelectXmlExtensions dependency.
}
Describe 'Convert-Xml' -Tag Convert-Xml -Skip:$skip {
	Context 'Transform XML using an XSLT template' -Tag ConvertXml,Convert,Xml,Xslt {
		It "Should perform a trivial transform to pipeline data" {
			Convert-Xml '<a xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>' '<z/>' |
				Format-Xml |
				Should -BeExactly '<a />'
		}
		It "Should perform a simple transform to pipeline data" {
			Convert-Xml `
				-TransformXslt @"
<a xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
href="{/link/@href}"><xsl:value-of select="/link/@title"/></a>
"@ `
				-Xml '<link title="Example" href="https://example.com/" />' |
				Format-Xml |
				Should -BeExactly '<a href="https://example.com/">Example</a>'
		}
		It "Should perform a text transform to a file" {
			$outfile = Join-Path ([io.path]::GetTempPath()) temp.txt
			Convert-Xml `
				-TransformFile (Join-Path $datadir xslt-test.xslt) `
				-Path (Join-Path $datadir xslt-test.xml) `
				-OutFile $outfile
			$outfile |Should -Exist
			$outfile |Should -FileContentMatchMultilineExactly (Get-Content (Join-Path $datadir xslt-test.txt) -Raw)
			Remove-Item $outfile -Force
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
