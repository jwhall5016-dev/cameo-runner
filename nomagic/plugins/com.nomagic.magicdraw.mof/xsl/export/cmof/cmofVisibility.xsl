<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- export CMOF Visibility -->
	<xsl:template name="cmofVisibility">
        <xsl:param name="setVisibilityToPublic" select="false()"/>
		<xsl:variable name="visibility" select="@visibility"/>
        <xsl:if test="$setVisibilityToPublic=true() and (string-length($visibility) = 0 or  not ($visibility = 'private' or $visibility = 'public'))">
            <xsl:attribute name="visibility">public</xsl:attribute>
        </xsl:if>
		<xsl:if test="string-length($visibility) &gt; 0 and ($visibility = 'private' or $visibility = 'public')">
			<xsl:attribute name="visibility"><xsl:value-of select="$visibility"/></xsl:attribute>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
