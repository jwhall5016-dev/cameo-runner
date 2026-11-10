<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:cmof='http://schema.omg.org/spec/MOF/2.0/cmof.xml'>
	<!-- export CMOF Constraint -->
	<xsl:template name="cmof_Constraint">
		<xsl:call-template name="XmiID"/>
		<xsl:call-template name="cmof_NamedElement_attributes"/>
		<xsl:apply-templates select="@constrainedElement"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="constrainedElement"/>
		</xsl:call-template>
		<xsl:for-each select="specification | xmi:Extension/modelExtension/specification">
			<xsl:choose>
				<xsl:when test="@xmi:type = 'uml:Expression'">
					<xsl:element name="specification">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_Expression"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type = 'uml:OpaqueExpression'">
					<xsl:element name="specification">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_OpaqueExpression"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="stringValue">
						<xsl:call-template name="valueSpecificationToString"/>
					</xsl:variable>
					<xsl:if test="string-length($stringValue) &gt; 0">
						<xsl:element name="specification">
							<xsl:attribute name="xmi:type" namespace="http://schema.omg.org/spec/XMI/2.1"><xsl:value-of select="'cmof:OpaqueExpression'"/></xsl:attribute>
							<xsl:call-template name="XmiID"/>
                            <xsl:call-template name="cmofVisibility">
                                <xsl:with-param name="setVisibilityToPublic" select="true()"/>
                            </xsl:call-template>
							<xsl:element name="body"><xsl:value-of select="$stringValue"/></xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:call-template name="emof_Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
