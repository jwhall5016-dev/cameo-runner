<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- Attribute getter by association ID -->
	<xsl:key name="OwnedAttributeByAssociationID" match="ownedAttribute" use="@association"/>
	<!-- export EMOF Property attributes -->
	<xsl:template name="Property_attributes">
		<xsl:apply-templates select="@isReadOnly"/>
		<xsl:if test="@association">
			<xsl:variable name="ends" select="key('OwnedAttributeByAssociationID', @association)"/>
			<xsl:variable name="thisEndID" select="@xmi:id"/>
			<xsl:variable name="otherEnd" select="$ends[@xmi:id != $thisEndID]"/>
			<xsl:if test="$otherEnd">
				<xsl:attribute name="opposite"><xsl:value-of select="$otherEnd/@xmi:id"/></xsl:attribute>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- export EMOF Property nodes -->
	<xsl:template name="Property_nodes"/>
</xsl:stylesheet>
