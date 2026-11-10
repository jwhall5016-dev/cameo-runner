<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:mofext='http://www.omg.org/spec/MOF/20131001'>
	<!-- Stereotypes application by ID getter -->
	<xsl:key name="StereotypeApplicationByID" match="/xmi:XMI/*" use="@xmi:id"/>
	<!-- Create MOF tags -->
	<xsl:template name="Tags">
		<xsl:variable name="selectedStereotypes" select="$OPTIONS/stereotypes/stereotype"/>
		<xsl:variable name="stereotypes" select="key('StereotypeApplicationByID', $selectedStereotypes/@id)"/>
		<xsl:for-each select="$stereotypes">
			<!-- ignore metamodeling profile -->
			<xsl:if test="not(starts-with(name(), 'Metamodeling:'))">
				<xsl:variable name="id" select="@xmi:id"/>
				<xsl:variable name="elementAttributeName" select="$selectedStereotypes[@id = $id]/@element"/>
				<xsl:variable name="element" select="@*[local-name() = $elementAttributeName]"/>
				<!-- Tags from attributes - single value -->
				<xsl:for-each select="@*">
					<xsl:variable name="tagName" select="name()"/>
					<xsl:if test="$tagName != 'xmi:id' and $tagName != $elementAttributeName">
						<xsl:element name="{concat('mofext', ':Tag')}">
							<xsl:call-template name="TagAttributes">
								<xsl:with-param name="id" select="$id"/>
								<xsl:with-param name="tagName" select="name()"/>
								<xsl:with-param name="element" select="$element"/>
							</xsl:call-template>
							<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
				<!-- Tags from elements - multiple value -->
				<xsl:for-each select="node()[1]">
					<xsl:call-template name="TagMultiValue">
						<xsl:with-param name="id" select="$id"/>
						<xsl:with-param name="element" select="$element"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Create tags from multivalued UML tags -->
	<xsl:template name="TagMultiValue">
		<xsl:param name="id"/>
		<xsl:param name="element"/>
		<xsl:variable name="tagName" select="name()"/>
		<xsl:variable name="previousTags" select="preceding-sibling::*[name() = $tagName]"/>
		<xsl:if test="not($previousTags)">
			<xsl:variable name="tags" select="../*[name() = $tagName]"/>
			<xsl:if test="$tags">
				<xsl:element name="{concat('mofext', ':Tag')}">
					<xsl:call-template name="TagAttributes">
						<xsl:with-param name="id" select="$id"/>
						<xsl:with-param name="tagName" select="$tagName"/>
						<xsl:with-param name="element" select="$element"/>
					</xsl:call-template>
					<xsl:for-each select="$tags">
						<xsl:element name="value">
							<xsl:value-of select="text()"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
		</xsl:if>
		<xsl:variable name="nextTag" select="following-sibling::*[name() != $tagName]"/>
		<xsl:for-each select="$nextTag[1]">
			<xsl:call-template name="TagMultiValue">
				<xsl:with-param name="id" select="$id"/>
				<xsl:with-param name="element" select="$element"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!-- Create Tag element attributes -->
	<xsl:template name="TagAttributes">
		<xsl:param name="id"/>
		<xsl:param name="tagName"/>
		<xsl:param name="element"/>
		<xsl:attribute name="xmi:type"><xsl:value-of select="concat('mofext', ':Tag')"/></xsl:attribute>
		<xsl:attribute name="xmi:id"><xsl:value-of select="concat($id, '_', $tagName)"/></xsl:attribute>
		<xsl:attribute name="name"><xsl:value-of select="$tagName"/></xsl:attribute>
		<xsl:attribute name="element"><xsl:value-of select="$element"/></xsl:attribute>
		
	</xsl:template>
</xsl:stylesheet>
