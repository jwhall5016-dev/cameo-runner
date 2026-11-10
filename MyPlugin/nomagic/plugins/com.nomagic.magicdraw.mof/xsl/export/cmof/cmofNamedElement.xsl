<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF NamedElement attributes -->
	<xsl:template name="cmof_NamedElement_attributes">
		<xsl:call-template name="emof_NamedElement_attributes"/>
		<xsl:call-template name="cmofVisibility">
            <xsl:with-param name="setVisibilityToPublic" select="true()"/>
        </xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
