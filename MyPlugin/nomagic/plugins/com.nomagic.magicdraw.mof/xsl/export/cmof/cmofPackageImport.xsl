<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF PackageImport -->
	<xsl:template name="cmof_PackageImport">
		<xsl:call-template name="XmiID"/>
		<xsl:apply-templates select="@importedPackage"/>
		<xsl:call-template name="cmofVisibility"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="importedPackage"/>
		</xsl:call-template>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
