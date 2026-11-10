<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF StructuralFeature attributes -->
	<xsl:template name="cmof_StructuralFeature_attributes">
		<xsl:apply-templates select="@isReadOnly"/>
	</xsl:template>
</xsl:stylesheet>
