<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml='http://www.omg.org/spec/UML/20131001'>
	<!-- <xsl:strip-space elements="xmi:XMI"/>-->
	<xsl:output method="xml" indent="yes"/>
	<xsl:include href="tags.xsl"/>
	<!-- options file path -->
	<xsl:param name="optionsFile"/>
	<!-- options from options file -->
	<xsl:variable name="OPTIONS" select="document($optionsFile)/options"/>

<xsl:variable name="MODULES" select="$OPTIONS/modules/module"/>
	<!-- Packages by ID getter 
	<xsl:key name="PackageByID" match="packagedElement[@xmi:type='uml:Package']" use="@xmi:id"/>-->
	<!-- Any element by ID 
	<xsl:key name="ElementByID" match="*" use="@xmi:id"/>-->
	<!-- transformation starting point -->
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="xmi:XMI | @*"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xmi:XMI">
		<xsl:element name="xmi:XMI">
			<xsl:for-each select="uml:Package">
				<xsl:call-template name="RecursiveCopy"/>
			</xsl:for-each>
			<xsl:call-template name="Tags"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="RecursiveCopy">
		<xsl:if test="not(name()='xmi:Extension')">
            <xsl:element name="{name()}">
                <xsl:apply-templates select="@*"/>
                <xsl:for-each select="*">
                    <xsl:call-template name="RecursiveCopy"/>
                </xsl:for-each>
                <xsl:if test="string-length(normalize-space(text()))>0">
                    <xsl:value-of select="text()"/>
                </xsl:if>
            </xsl:element>
		</xsl:if>
	</xsl:template>
	
<xsl:template match="@href">
		<xsl:variable name="href" select="current()"/>
		<xsl:variable name="umlNsUri" select="'http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#'"/>
		<xsl:choose>
			<xsl:when test="starts-with($href, $umlNsUri)">
				<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
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






<!--Copy all attributes -->
	<xsl:template match="@*">
		<xsl:copy/>
	</xsl:template>
	<!-- Skip all elements 
	<xsl:template match="*">
		<xsl:copy/>
	</xsl:template>-->
</xsl:stylesheet>
