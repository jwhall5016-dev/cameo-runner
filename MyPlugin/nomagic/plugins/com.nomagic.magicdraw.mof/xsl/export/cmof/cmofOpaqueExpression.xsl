<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF OpaqueExpression -->
	<xsl:template name="cmof_OpaqueExpression">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="cmof_NamedElement_attributes"/>
		<xsl:call-template name="emof_TypedElement_attributes"/>
		<xsl:apply-templates select="@body | @language"/>
		<xsl:for-each select="body">
			<xsl:element name="body">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="language">
			<xsl:element name="language">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="emof_TypedElement_nodes"/>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
