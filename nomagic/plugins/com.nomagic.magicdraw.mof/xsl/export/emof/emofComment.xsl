<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF Comment -->
	<xsl:template name="emof_Comment">
		<xsl:call-template name="XmiID"/>
		<xsl:apply-templates select="@body | @annotatedElement"/>
		<xsl:if test="body">
			<xsl:element name="body">
				<xsl:value-of select="body"/>
			</xsl:element>
		</xsl:if>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="annotatedElement"/>
		</xsl:call-template>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
