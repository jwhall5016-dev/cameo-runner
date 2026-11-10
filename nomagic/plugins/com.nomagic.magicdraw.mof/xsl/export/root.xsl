<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml='http://www.omg.org/spec/UML/20131001'>
	<!-- <xsl:strip-space elements="xmi:XMI"/>-->
	<xsl:output method="xml" indent="yes"/>
	<xsl:include href="class.xsl"/>
	<xsl:include href="defaultValue.xsl"/>
	<xsl:include href="enumeration.xsl"/>
	<xsl:include href="enumerationLiteral.xsl"/>
	<xsl:include href="generalization.xsl"/>
	<xsl:include href="operation.xsl"/>
	<xsl:include href="package.xsl"/>
	<xsl:include href="parameter.xsl"/>
	<xsl:include href="raisedExceptions.xsl"/>
	<xsl:include href="property.xsl"/>
	<xsl:include href="tags.xsl"/>
	<xsl:include href="valueSpecificationToString.xsl"/>
	<xsl:include href="xmiID.xsl"/>
	<xsl:include href="xmiRef.xsl"/>
	<xsl:include href="xmiType.xsl"/>
	<!-- options file path -->
	<xsl:param name="optionsFile"/>
	<!-- options from options file -->
	<xsl:variable name="OPTIONS" select="document($optionsFile)/options"/>
	<!-- Packages by ID getter -->
	<xsl:key name="PackageByID" match="packagedElement[@xmi:type='uml:Package']" use="@xmi:id"/>
	<!-- Any element by ID -->
	<xsl:key name="ElementByID" match="*" use="@xmi:id"/>
	<!-- transformation starting point -->
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="xmi:XMI | @*"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xmi:XMI">
		<xsl:element name="xmi:XMI" namespace="http://schema.omg.org/spec/XMI/2.1">
			<xsl:choose>
				<xsl:when test="@xmi:version">
					<xsl:apply-templates select="@xmi:version"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="xmi:version" namespace="http://schema.omg.org/spec/XMI/2.1">2.1</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each select="uml:Model">
				<xsl:call-template name="RootPackage"/>
			</xsl:for-each>
			<xsl:for-each select="uml:Package">
				<xsl:call-template name="RootPackage"/>
			</xsl:for-each>
			<xsl:call-template name="Tags"/>
		</xsl:element>
	</xsl:template>
	<!-- Copy all attributes -->
	<xsl:template match="@*">
		<xsl:variable name="LocalName" select="local-name()"/>
		<xsl:choose>
			<xsl:when test="starts-with(name(),'xmi:')">
				<xsl:attribute name="{$LocalName}" namespace="http://schema.omg.org/spec/XMI/2.1"><xsl:value-of select="."/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Skip all elements -->
	<xsl:template match="*"/>
</xsl:stylesheet>
