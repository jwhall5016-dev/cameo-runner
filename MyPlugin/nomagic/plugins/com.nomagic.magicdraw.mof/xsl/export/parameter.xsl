<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export Parameter -->
	<xsl:template name="Parameter">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="NamedElement_attributes"/>
		<xsl:call-template name="emof_MultiplicityElement_attributes"/>
		<xsl:call-template name="emof_TypedElement_attributes"/>
		<xsl:call-template name="Parameter_attributes"/>
		<xsl:call-template name="emof_Element_nodes"/>
		<xsl:call-template name="emof_TypedElement_nodes"/>
	</xsl:template>
</xsl:stylesheet>
