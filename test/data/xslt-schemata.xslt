<xsl:transform version="1.0" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform
                        http://www.w3.org/1999/XSL/Transform.xsd
                        http://www.w3.org/1999/xhtml
                        http://www.w3.org/1999/xhtml.xsd">
	<xsl:output method="text" encoding="utf-8" media-type=" text/plain" />
	<xsl:template match="li">
		<xsl:value-of select="concat('- ',text(),'&#xD;&#xA;')"/>
	</xsl:template>
</xsl:transform>
