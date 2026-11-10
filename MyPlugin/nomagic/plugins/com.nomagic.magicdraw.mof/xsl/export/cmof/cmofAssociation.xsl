<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Association -->
	<xsl:template name="cmof_Association">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="cmof_NamedElement_attributes"/>
		<xsl:call-template name="cmof_Classifier_attributes"/>
		<xsl:for-each select="ownedEnd">
			<xsl:element name="ownedEnd">
				<xsl:call-template name="Property"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="memberEnd"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="navigableOwnedEnd"/>
		</xsl:call-template>
		<xsl:call-template name="cmof_Classifier_nodes"/>
		<xsl:call-template name="cmof_Namespace_nodes"/>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
