<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Enumeration attributes -->
	<xsl:template name="Enumeration_attributes">
		<xsl:call-template name="cmof_Classifier_attributes"/>
	</xsl:template>
	<!-- export CMOF Enumeration nodes -->
	<xsl:template name="Enumeration_nodes">
		<xsl:call-template name="cmof_Classifier_nodes"/>
		<xsl:call-template name="cmof_Namespace_nodes"/>
		<xsl:call-template name="cmof_DataType_nodes">
			<xsl:with-param name="exportFeatures" select="false()"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
