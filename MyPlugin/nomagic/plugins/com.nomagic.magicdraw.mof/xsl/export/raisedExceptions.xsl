<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- export raised exceptions -->
	<xsl:template name="raisedExceptions">
		<xsl:for-each select="raisedException">
			<xsl:if test="(string-length(@xmi:idref) &gt; 0 and key('ElementByID', @xmi:idref)/@xmi:type = 'uml:Class') or (string-length(@href) &gt; 0 and @xmi:type = 'uml:Class')">
				<xsl:call-template name="XmiRef">
					<xsl:with-param name="node" select="current()"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
