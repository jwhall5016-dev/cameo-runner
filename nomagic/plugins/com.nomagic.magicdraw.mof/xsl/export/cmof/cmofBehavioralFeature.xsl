<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF BehavioralFeature nodes -->
	<xsl:template name="cmof_BehavioralFeature_nodes">
		<xsl:for-each select="ownedParameter">
			<xsl:element name="ownedParameter">
				<xsl:call-template name="Parameter"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="raisedExceptions"/>
	</xsl:template>
</xsl:stylesheet>
