<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- modules data from options file -->
	<xsl:variable name="MODULES" select="$OPTIONS/modules/module"/>
	<!-- Create idref of href attributes -->
	<xsl:template name="XmiRef">
		<xsl:param name="node"/>
		<xsl:for-each select="$node">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@xmi:idref | @href"/>
				<xsl:if test="string-length(@href) &gt; 0">
                    <xsl:call-template name="XmiType" />
				</xsl:if>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- Change the module URI to module name in href-->
	<xsl:template match="@href">
		<xsl:variable name="href" select="current()"/>
		<xsl:variable name="umlNsUri" select="'http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#'"/>
		<xsl:choose>
			<xsl:when test="starts-with($href, $umlNsUri)">
				<xsl:attribute name="href"><xsl:value-of select="concat('http://schema.omg.org/spec/MOF/2.0/', $MOF, '.xml' , '#', substring-after($href, $umlNsUri))"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="converted">
					<xsl:for-each select="$MODULES">
						<xsl:variable name="pattern" select="@uri"/>
						<xsl:if test="contains($href, $pattern) and contains($href, '#')">
						<!--  	<xsl:value-of select="substring-before($href, $pattern)"/>-->
							<xsl:value-of select="@name"/>
							<xsl:value-of select="concat('.', $MOF, '#', substring-after($href, '#'))"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="string-length($converted) &gt; 0">
						<xsl:attribute name="href"><xsl:value-of select="$converted"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
