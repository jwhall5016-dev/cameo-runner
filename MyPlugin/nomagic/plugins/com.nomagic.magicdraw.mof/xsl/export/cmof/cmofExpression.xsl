<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- export CMOF Expression -->
	<xsl:template name="cmof_Expression">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="cmof_NamedElement_attributes"/>
		<xsl:call-template name="emof_TypedElement_attributes"/>
		<xsl:apply-templates select="@symbol"/>
		<xsl:for-each select="symbol">
			<xsl:element name="symbol">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="operand">
			<xsl:choose>
				<xsl:when test="@xmi:type = 'uml:OpaqueExpression'">
					<xsl:element name="operand">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_OpaqueExpression"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type = 'uml:Expression'">
					<xsl:element name="operand">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_Expression"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:call-template name="emof_TypedElement_nodes"/>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
