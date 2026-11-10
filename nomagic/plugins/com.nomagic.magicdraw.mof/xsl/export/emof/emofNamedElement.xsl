<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF NamedElement attributes -->
	<xsl:template name="emof_NamedElement_attributes">
		<xsl:apply-templates select="@name"/>
	</xsl:template>
</xsl:stylesheet>
