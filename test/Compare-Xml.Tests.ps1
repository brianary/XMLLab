<#
.SYNOPSIS
Tests Compares two XML documents and returns the differences.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Compare-Xml' -Tag Compare-Xml {
	Context 'Compares two XML documents and returns the differences as XSLT' -Tag CompareXml,Compare,Xml {
		It 'Should return a diff that updates an attribute value' {
			(Compare-Xml '<a b="z"/>' '<a b="y"/>' |Format-Xml) -replace '\r' |Should -BeExactly (@"
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/a/@b">
    <xsl:attribute name="b"><![CDATA[y]]></xsl:attribute>
  </xsl:template>
</xsl:transform>
"@ -replace '\r')
		}
		It 'Should return a diff that changes attributes' {
			(Compare-Xml '<a b="z"/>' '<a c="y"/>' |Format-Xml) -replace '\r' |Should -BeExactly (@"
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/a/@b" />
  <xsl:template match="/a">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="c"><![CDATA[y]]></xsl:attribute>
    </xsl:copy>
  </xsl:template>
</xsl:transform>
"@ -replace '\r')
		}
		It 'Should return a diff that changes child nodes' {
			(Compare-Xml '<a><b/><c/><!-- d --></a>' '<a><c/><b/></a>' |Format-Xml) -replace '\r' |Should -BeExactly (@"
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/a">
    <xsl:copy>
      <xsl:apply-templates select="c" />
      <b />
    </xsl:copy>
  </xsl:template>
</xsl:transform>
"@ -replace '\r')
		}
		It 'Should return a diff that adds child nodes' {
			(Compare-Xml '<a/>' '<a><!-- annotation --><new/><?node details?></a>' |Format-Xml) -replace '\r' |Should -BeExactly (@"
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/a">
    <xsl:copy>
      <xsl:comment><![CDATA[ annotation ]]></xsl:comment>
      <new />
      <xsl:processing-instruction name="node"><![CDATA[details]]></xsl:processing-instruction>
    </xsl:copy>
  </xsl:template>
</xsl:transform>
"@ -replace '\r')
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
