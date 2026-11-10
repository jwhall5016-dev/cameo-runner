<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF ElementImport -->
	<xsl:template name="cmof_ElementImport">
		<xsl:call-template name="XmiID"/>
		<xsl:apply-templates select="@alias | @importedElement"/>
		<xsl:call-template name="cmofVisibility"/>
		<xsl:if test="alias">
			<xsl:element name="alias">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="importedElement"/>
		</xsl:call-template>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
