<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- Export paramter/property defaultValue (ValueSpecification) as default (String) -->
	<xsl:template name="defaultValue">
		<xsl:for-each select="defaultValue | xmi:Extension/modelExtension/defaultValue">
			<xsl:variable name="default">
				<xsl:call-template name="valueSpecificationToString"/>
			</xsl:variable>
			<xsl:if test="string-length($default) &gt; 0">
				<xsl:attribute name="default"><xsl:value-of select="$default"/></xsl:attribute>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
