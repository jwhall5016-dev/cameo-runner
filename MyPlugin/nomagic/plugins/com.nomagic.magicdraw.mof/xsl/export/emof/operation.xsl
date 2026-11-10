<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- export EMOF Operation attributes -->
	<xsl:template name="Operation_attributes">
		<xsl:for-each select="ownedParameter[@direction='return']">
			<xsl:call-template name="emof_MultiplicityElement_attributes"/>
			<xsl:call-template name="emof_TypedElement_attributes"/>
		</xsl:for-each>
	</xsl:template>
	<!-- export EMOF Operation nodes -->
	<xsl:template name="Operation_nodes">
		<xsl:for-each select="ownedParameter[@direction='return']">
			<xsl:call-template name="emof_TypedElement_nodes"/>
		</xsl:for-each>
		<xsl:for-each select="ownedParameter[not(@direction) or @direction!='return']">
			<xsl:element name="ownedParameter">
				<xsl:call-template name="Parameter"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="raisedExceptions"/>
	</xsl:template>
</xsl:stylesheet>
