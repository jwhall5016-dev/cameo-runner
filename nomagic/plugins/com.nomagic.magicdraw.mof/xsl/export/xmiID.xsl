<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- copy xmi:id attribute -->
	<xsl:template name="XmiID">
		<xsl:apply-templates select="@xmi:id"/>
	</xsl:template>
</xsl:stylesheet>
