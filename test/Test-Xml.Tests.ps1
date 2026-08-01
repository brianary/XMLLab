<#
.SYNOPSIS
Tests Try parsing text as XML, and validating it if a schema is provided.
#>

return #TODO: finish tests
if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Test-Xml' -Tag Test-Xml,Test,Xml {
	Context 'Try parsing text as XML, and validating it if a schema is provided.' -Tag Example {
		It "EXAMPLE 1" -Skip {
			Test-Xml -Xml '</>' |Should -BeExactly @"
False
"@
		}
	}
	Context 'Path' -Tag Path {
		It "test" -Skip {
			1 |Should -Be 1
		}
	}
	Context 'Xml' -Tag Xml {
		It "test" -Skip {
			1 |Should -Be 1
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
