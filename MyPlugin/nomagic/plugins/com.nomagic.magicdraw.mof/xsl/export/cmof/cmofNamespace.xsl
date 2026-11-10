<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Namespace nodes -->
	<xsl:template name="cmof_Namespace_nodes">
		<xsl:for-each select="ownedRule">
			<xsl:element name="ownedRule">
				<xsl:call-template name="cmof_Constraint"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="elementImport">
			<xsl:element name="elementImport">
				<xsl:call-template name="cmof_ElementImport"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="packageImport">
			<xsl:element name="packageImport">
				<xsl:call-template name="cmof_PackageImport"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
