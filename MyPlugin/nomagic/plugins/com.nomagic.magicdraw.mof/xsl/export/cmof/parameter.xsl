<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Parameter attributes -->
	<xsl:template name="Parameter_attributes">
		<xsl:apply-templates select="@direction"/>
		<xsl:call-template name="defaultValue"/>
	</xsl:template>
</xsl:stylesheet>
