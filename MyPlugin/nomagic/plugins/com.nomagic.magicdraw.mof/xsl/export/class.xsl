<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- export Class -->
	<xsl:template name="Class">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="NamedElement_attributes"/>
		<xsl:call-template name="Class_attributes"/>
		<xsl:call-template name="Class_nodes"/>
		<xsl:for-each select="ownedAttribute[@xmi:type='uml:Property']">
			<xsl:element name="ownedAttribute">
				<xsl:call-template name="Property"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="ownedOperation">
			<xsl:element name="ownedOperation">
				<xsl:call-template name="Operation"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
