<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- Converts valua specifications to string -->
	<xsl:template name="valueSpecificationToString">
		<xsl:variable name="type" select="@xmi:type"/>
		<xsl:choose>
			<xsl:when test="$type = 'uml:LiteralBoolean' or $type = 'uml:LiteralInteger' or $type = 'uml:LiteralString' or $type = 'uml:LiteralUnlimitedNatural'">
				<xsl:value-of select="@value"/>
				<xsl:for-each select="value">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$type = 'uml:LiteralNull'">
				<xsl:value-of select="'null'"/>
			</xsl:when>
			<xsl:when test="$type = 'uml:OpaqueExpression'">
				<xsl:value-of select="@body"/>
				<xsl:for-each select="body">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$type = 'uml:Expression'">
				<xsl:value-of select="@symbol"/>
				<xsl:for-each select="symbol">
					<xsl:value-of select="."/>
				</xsl:for-each>
				<xsl:if test="operand">
					<xsl:value-of select="'('"/>
					<xsl:for-each select="operand">
						<xsl:if test="position() != 1">
							<xsl:value-of select="','"/>
						</xsl:if>
						<xsl:call-template name="valueSpecificationToString"/>
					</xsl:for-each>
					<xsl:value-of select="')'"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$type = 'uml:TimeExpression' or $type = 'uml:Duration'">
				<xsl:for-each select="expr">
					<xsl:call-template name="valueSpecificationToString"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$type = 'uml:TimeInterval' or $type = 'uml:DurationInterval'">
				<xsl:for-each select="key('ElementByID', @min)">
					<xsl:call-template name="valueSpecificationToString"/>
				</xsl:for-each>
				<xsl:variable name="max">
					<xsl:for-each select="key('ElementByID', @max)">
						<xsl:call-template name="valueSpecificationToString"/>
					</xsl:for-each>
				</xsl:variable>
				<xsl:if test="string-length($max) &gt; 0">
					<xsl:value-of select="concat('..', $max)"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$type = 'uml:InstanceValue'">
				<xsl:call-template name="elementName">
					<xsl:with-param name="elementID" select="@instance"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$type = 'uml:ElementValue'">
				<xsl:call-template name="elementName">
					<xsl:with-param name="elementID" select="@element"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="elementName">
		<xsl:param name="elementID"/>
		<xsl:if test="string-length($elementID) &gt; 0">
			<xsl:variable name="element" select="key('ElementByID', $elementID)"/>
			<xsl:if test="$element">
				<xsl:value-of select="$element/@name"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
