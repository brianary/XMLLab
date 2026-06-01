<#
.SYNOPSIS
Tests serializing complex content into XML elements.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
	$NL = [Environment]::NewLine
}
Describe 'ConvertTo-XmlElements' -Tag ConvertTo-XmlElements -Skip:$skip {
	Context 'Serializes complex content into XML elements' -Tag Convert,ConvertTo,ConvertToXmlElements,XML {
		It "Convert '<InputObject>' to '<Result>'" -TestCases @(
			@{ InputObject = $null; SkipRoot = $true; Result = '<null />' }
			@{ InputObject = $null; SkipRoot = $false; Result = '<null />' }
			@{ InputObject = [DBNull]::Value; SkipRoot = $true; Result = '<DBNull />' }
			@{ InputObject = [DBNull]::Value; SkipRoot = $false; Result = '<DBNull />' }
			@{ InputObject = 0; SkipRoot = $true; Result = '0' }
			@{ InputObject = 0; SkipRoot = $false; Result = '<Int32>0</Int32>' }
			@{ InputObject = 1UY; SkipRoot = $false; Result = '<Byte>1</Byte>' }
			@{ InputObject = 2L; SkipRoot = $false; Result = '<Int64>2</Int64>' }
			@{ InputObject = 15E3ULPB; SkipRoot = $false; Result = '<UInt64>16888498602639360000</UInt64>' }
			@{ InputObject = "Don't Panic!"; SkipRoot = $false; Result = '<String>Don&apos;t Panic!</String>' }
			@{ InputObject = 1,2,3; SkipRoot = $false
				Result = "<ObjectArray>$NL<Item>1</Item>$NL<Item>2</Item>$NL<Item>3</Item>$NL</ObjectArray>" }
			@{ InputObject = @{html=@{body=@{p='Some text.'}}}
				SkipRoot = $true
				Result = "<html>$NL<body>$NL<p>Some text.</p>$NL</body>$NL</html>" }
			@{ InputObject = [pscustomobject]@{UserName='username';Computer='COMPUTERNAME'}
				SkipRoot = $false
				Result = "<PSCustomObject>$NL<UserName>username</UserName>$NL" +
					"<Computer>COMPUTERNAME</Computer>$NL</PSCustomObject>" }
			@{ InputObject = '{"item": {"name": "Test", "id": 1 } }' |ConvertFrom-Json
				SkipRoot = $true
				Result = "<item>$NL<name>Test</name>$NL<id>1</id>$NL</item>" }
		) {
			Param([object] $InputObject, [bool] $SkipRoot, [psobject] $Result)
			ConvertTo-XmlElements $InputObject -SkipRoot:$SkipRoot |
				Should -BeExactly $Result -Because 'parameter should work'
			,$InputObject |ConvertTo-XmlElements -SkipRoot:$SkipRoot |
				Should -BeExactly $Result -Because 'pipeline should work'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
