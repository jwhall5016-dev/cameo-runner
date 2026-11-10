<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF Class attributes -->
	<xsl:template name="Class_attributes">
		<xsl:apply-templates select="@isAbstract"/>
	</xsl:template>
	<!-- export EMOF Class nodes -->
	<xsl:template name="Class_nodes">
		<xsl:call-template name="generalization_nodes">
			<xsl:with-param name="generalName" select="string('superClass')"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
