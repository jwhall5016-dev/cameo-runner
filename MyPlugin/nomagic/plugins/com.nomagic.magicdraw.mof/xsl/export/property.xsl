<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:Metamodeling="http://www.magicdraw.com/schemas/Metamodeling.xmi">
	<!-- MOFProperty stereotype application getter by stereotyped element ID -->
	<xsl:key name="MOFProperty" match="Metamodeling:MOFProperty" use="@base_Property"/>
	<!-- export Property -->
	<xsl:template name="Property">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="NamedElement_attributes"/>
		<xsl:call-template name="emof_TypedElement_attributes"/>
		<xsl:call-template name="emof_MultiplicityElement_attributes"/>
		<xsl:apply-templates select="@isDerived"/>
		<xsl:if test="@aggregation='composite'">
			<xsl:attribute name="isComposite"><xsl:value-of select="string('true')"/></xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select="@isID"/>
		<xsl:call-template name="defaultValue"/>
		<xsl:call-template name="Property_attributes"/>
		<xsl:call-template name="Property_nodes"/>
		<xsl:call-template name="emof_Element_nodes"/>
		<xsl:call-template name="emof_TypedElement_nodes"/>
	</xsl:template>
</xsl:stylesheet>
