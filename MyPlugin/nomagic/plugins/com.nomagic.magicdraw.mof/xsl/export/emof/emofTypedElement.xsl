<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF TypedElement attributes -->
	<xsl:template name="emof_TypedElement_attributes">
		<xsl:apply-templates select="@type"/>
	</xsl:template>
	<!-- export EMOF TypedElement nodes -->
	<xsl:template name="emof_TypedElement_nodes">
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="type"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
