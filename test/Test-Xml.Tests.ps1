<#
.SYNOPSIS
Tests trying parsing text as XML, and validating it if a schema is provided.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$datadir = Join-Path $PSScriptRoot 'data'
}
Describe 'Test-Xml' -Tag Test-Xml,Test,Xml {
	Context 'Try parsing text as XML, and validating it if a schema is provided.' {
		It "Should return '<Result>' for the string '<Xml>'" -TestCases @(
			@{ Xml = '</>'; Result = $false }
			@{ Xml = '<a/>'; Result = $true }
		) {
			Param([string] $Xml, [bool] $Result)
			Test-Xml -Xml $Xml |Should -Be $Result -Because 'the parameter should work'
			$Xml |Test-Xml |Should -Be $Result -Because 'the pipeline should work'
		}
		It "Should return '<Result>' for the file '<File>'" -TestCases @(
			@{ File = 'test.xml'; Result = $true }
			@{ File = 'xslt-test.txt'; Result = $false }
		) {
			Param([string] $File, [bool] $Result)
			$path = Join-Path $datadir $File
			Test-Xml -Path $path |Should -Be $Result -Because 'the parameter should work'
			Get-Item $path |Test-Xml |Should -Be $Result -Because 'the pipeline should work'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
