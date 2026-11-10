<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Property attributes -->
	<xsl:template name="Property_attributes">
		<xsl:call-template name="cmof_StructuralFeature_attributes"/>
		<xsl:apply-templates select="@isDerivedUnion | @association"/>
	</xsl:template>
	<!-- export CMOF Property nodes -->
	<xsl:template name="Property_nodes">
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="association"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="redefinedProperty"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="subsettedProperty"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
