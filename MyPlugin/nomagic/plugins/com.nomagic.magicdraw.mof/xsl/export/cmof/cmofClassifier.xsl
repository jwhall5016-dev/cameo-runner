<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Classifier attributes -->
	<xsl:template name="cmof_Classifier_attributes">
		<xsl:apply-templates select="@isAbstract"/>
	</xsl:template>
	<!-- export CMOF Classifier nodes -->
	<xsl:template name="cmof_Classifier_nodes">
		<xsl:param name="generalName" select="string('general')"/>
		<xsl:call-template name="generalization_nodes">
			<xsl:with-param name="generalName" select="$generalName"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
