<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF MultiplicityElement attributes -->
	<xsl:template name="emof_MultiplicityElement_attributes">
		<xsl:apply-templates select="@isOrdered | @isUnique"/>
		<xsl:call-template name="multiplicityValue">
			<xsl:with-param name="multiplicityValue" select="lowerValue"/>
			<xsl:with-param name="attributeName" select="string('lower')"/>
		</xsl:call-template>
		<xsl:call-template name="multiplicityValue">
			<xsl:with-param name="multiplicityValue" select="upperValue"/>
			<xsl:with-param name="attributeName" select="string('upper')"/>
		</xsl:call-template>
	</xsl:template>
	<!-- convert lowerValue/upperValue (ValueSpecification) to lower/upper (String) -->
	<xsl:template name="multiplicityValue">
		<xsl:param name="multiplicityValue"/>
		<xsl:param name="attributeName"/>
		<xsl:if test="$multiplicityValue">
			<xsl:variable name="value" select="$multiplicityValue/@value"/>
			<xsl:attribute name="{$attributeName}"><xsl:choose><xsl:when test="$value"><xsl:choose><xsl:when test="$value = -1"><xsl:value-of select="string('*')"/></xsl:when><xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:value-of select="string('0')"/></xsl:otherwise></xsl:choose></xsl:attribute>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
