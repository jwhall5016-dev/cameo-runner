<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export EMOF Element nodes -->
	<xsl:template name="emof_Element_nodes">
		<xsl:for-each select="ownedComment">
			<xsl:element name="ownedComment">
				<xsl:call-template name="emof_Comment"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
