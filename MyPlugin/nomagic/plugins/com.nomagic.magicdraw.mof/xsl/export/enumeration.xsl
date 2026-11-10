<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export Enumeration -->
	<xsl:template name="Enumeration">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="NamedElement_attributes"/>
		<xsl:call-template name="Enumeration_attributes"/>
		<xsl:call-template name="Enumeration_nodes"/>
		<xsl:for-each select="ownedLiteral">
			<xsl:element name="ownedLiteral">
				<xsl:call-template name="EnumerationLiteral"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
