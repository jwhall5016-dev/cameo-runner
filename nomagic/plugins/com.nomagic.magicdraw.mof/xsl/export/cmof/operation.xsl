<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Operation attributes -->
	<xsl:template name="Operation_attributes">
		<xsl:apply-templates select="@bodyCondition | @isQuery"/>
	</xsl:template>
	<!-- export CMOF Operation nodes -->
	<xsl:template name="Operation_nodes">
		<xsl:call-template name="cmof_BehavioralFeature_nodes"/>
		<xsl:call-template name="cmof_Namespace_nodes"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="precondition"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="postcondition"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="redefinedOperation"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
