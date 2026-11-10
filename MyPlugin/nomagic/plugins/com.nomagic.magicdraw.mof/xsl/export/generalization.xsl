<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- export superClassifier attribute -->
	<xsl:template name="generalization_nodes">
		<xsl:param name="generalName" select="string('general')"/>
		<xsl:for-each select="generalization">
			<xsl:element name="{$generalName}">
				<xsl:if test="string-length(@general) &gt; 0">
					<xsl:attribute name="xmi:idref" namespace="http://schema.omg.org/spec/XMI/2.1"><xsl:value-of select="@general"/></xsl:attribute>
				</xsl:if>
				<xsl:for-each select="general">
					<xsl:apply-templates select="@xmi:idref | @href"/>
				</xsl:for-each>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
