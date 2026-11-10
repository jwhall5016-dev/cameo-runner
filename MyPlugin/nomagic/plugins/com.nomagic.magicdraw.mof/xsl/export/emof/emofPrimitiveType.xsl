<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF PrimitiveType -->
	<xsl:template name="emof_PrimitiveType">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="emof_NamedElement_attributes"/>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
