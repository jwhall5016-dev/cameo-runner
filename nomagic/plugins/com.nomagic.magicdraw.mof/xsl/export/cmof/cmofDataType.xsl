<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF DataType -->
	<xsl:template name="cmof_DataType">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="cmof_NamedElement_attributes"/>
		<xsl:call-template name="cmof_Classifier_attributes"/>
		<xsl:call-template name="cmof_Classifier_nodes"/>
		<xsl:call-template name="emof_Element_nodes"/>
		<xsl:call-template name="cmof_Namespace_nodes"/>
		<xsl:call-template name="cmof_DataType_nodes"/>
	</xsl:template>
	<xsl:template name="cmof_DataType_nodes">
		<xsl:param name="exportFeatures" select="true()"/>
		<xsl:if test="$exportFeatures">
			<xsl:for-each select="ownedAttribute">
				<xsl:element name="ownedAttribute">
					<xsl:call-template name="Property"/>
				</xsl:element>
			</xsl:for-each>
			<xsl:for-each select="ownedOperation">
				<xsl:element name="ownedOperation">
					<xsl:call-template name="Operation"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
