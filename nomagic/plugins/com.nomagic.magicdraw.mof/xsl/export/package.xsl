<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:Metamodeling="http://www.magicdraw.com/schemas/Metamodeling.xmi">
	<!-- MOFPackage stereotype application getter by stereotyped element ID -->
	<xsl:key name="MOFPackage" match="Metamodeling:MOFPackage" use="@base_Package"/>
	<!-- export Package -->
	<xsl:template name="Package">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="NamedElement_attributes"/>
		<xsl:apply-templates select="@URI"/>
		<xsl:call-template name="emof_Element_nodes"/>
		<xsl:call-template name="PackageNodes"/>
	</xsl:template>
	</xsl:stylesheet>