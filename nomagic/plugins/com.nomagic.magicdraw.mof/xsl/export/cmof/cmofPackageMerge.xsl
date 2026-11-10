<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF PackageMerge -->
	<xsl:template name="cmof_PackageMerge">
		<xsl:call-template name="XmiID"/>
		<xsl:apply-templates select="@mergedPackage"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="mergedPackage"/>
		</xsl:call-template>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
