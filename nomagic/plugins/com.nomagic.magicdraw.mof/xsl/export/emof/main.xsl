<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- include required stylesheets -->
	<xsl:include href="../root.xsl"/>
	<xsl:include href="class.xsl"/>
	<xsl:include href="emofComment.xsl"/>
	<xsl:include href="emofElement.xsl"/>
	<xsl:include href="emofMultiplicityElement.xsl"/>
	<xsl:include href="emofNamedElement.xsl"/>
	<xsl:include href="emofPrimitiveType.xsl"/>
	<xsl:include href="emofTypedElement.xsl"/>
	<xsl:include href="enumeration.xsl"/>
	<xsl:include href="namedElement.xsl"/>
	<xsl:include href="operation.xsl"/>
	<xsl:include href="packageNodes.xsl"/>
	<xsl:include href="parameter.xsl"/>
	<xsl:include href="property.xsl"/>
	<xsl:include href="rootPackage.xsl"/>
	<!-- MOF type -->
	<xsl:variable name="MOF" select="'emof'"/>
</xsl:stylesheet>
