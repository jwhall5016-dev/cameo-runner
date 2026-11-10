<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Class attributes -->
	<xsl:template name="Class_attributes">
		<xsl:call-template name="cmof_Classifier_attributes"/>
	</xsl:template>
	<!-- export CMOF Class nodes -->
	<xsl:template name="Class_nodes">
		<xsl:call-template name="cmof_Classifier_nodes">
			<xsl:with-param name="generalName" select="string('superClass')"/>
		</xsl:call-template>
		<xsl:call-template name="cmof_Namespace_nodes"/>
	</xsl:template>
</xsl:stylesheet>
