<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
    <xsl:template name="XmiType">
        <xsl:choose>
            <xsl:when test="@xmi:type">
                <xsl:apply-templates select="@xmi:type"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="descendant::*[@referentType][1]">
                    <xsl:variable name="type" select="descendant::*[@referentType]"/>
                    <xsl:attribute name="xmi:type" namespace="http://schema.omg.org/spec/XMI/2.1">
                        <xsl:value-of select="concat($MOF,':' ,@referentType)"/>
                    </xsl:attribute>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Change uml type to mof type -->
    <xsl:template match="@xmi:type">
        <xsl:variable name="convertedType">
            <xsl:choose>
                <xsl:when test=". = 'uml:Model'">
                    <xsl:value-of select="'uml:Package'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="type" select="normalize-space($convertedType)"/>
        <xsl:attribute name="xmi:type" namespace="http://schema.omg.org/spec/XMI/2.1"><xsl:choose><xsl:when test="starts-with($type, 'uml:')"><xsl:value-of select="concat($MOF, substring($type, 4))"/></xsl:when><xsl:otherwise><xsl:value-of select="$type"/></xsl:otherwise></xsl:choose></xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
