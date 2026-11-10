<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi='http://schema.omg.org/spec/XMI/2.1' xmlns:uml='http://www.omg.org/spec/UML/20090901' xmlns:cmof="http://schema.omg.org/spec/MOF/2.0/cmof.xml" xmlns:emof="http://schema.omg.org/spec/MOF/2.0/emof.xml" xmlns:emof_Profile="http://www.magicdraw.com/schemas/emof_Profile.xmi">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Some variables for if conditions. -->
	<xsl:variable name="mofTags" select="//emof:Tag"/>
	<xsl:template name="mofPackageId">
		<xsl:value-of select="//emof:Package/@xmi:id"/>
	</xsl:template>
	<!-- Namespace elements not exist in emof -->
	<xsl:template name="Namespace"/>
	<!-- Creates uml model from emof:package.-->
	<xsl:template name="Model">
		<xsl:for-each select="//emof:Package">
			<xsl:call-template name="UmlModel"/>
		</xsl:for-each>
	</xsl:template>
	<!-- Checks all unique tag names and create stereotypes attributes .-->
	<xsl:template name="CreateTags">
		<xsl:for-each select="//emof:Tag">
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="not(preceding::emof:Tag[@name = $name]) and not(ancestor::emof:Tag[@name = $name])">
				<xsl:call-template name="StereotypesAttributes"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Share all pckages in model package.-->
	<xsl:template name="ShareTable">
		<xsl:for-each select="//xmi:XMI/emof:Package/nestedPackage">
			<xsl:element name="share">
				<xsl:attribute name="sharedPackage"><xsl:value-of select="@xmi:id"/></xsl:attribute>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- Imports tags. If tag for same element with same name is used only one time - creates tag for element with its names attribute or names elements, elsewhere creates value elements for all same tag names for same element. -->
		<xsl:template name="Tags">
		<xsl:for-each select="//emof:Tag">
			<xsl:variable name="element" select="@element"/>
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="not((preceding::emof:Tag[@element=$element]) and (preceding::emof:Tag[@name=$name]))">
				<xsl:element name="{concat($mofProfile,':',$mofStereotype)}">
					<xsl:attribute name="xmi:id"><xsl:value-of select="@xmi:id"/></xsl:attribute>
					<xsl:attribute name="base_Element"><xsl:value-of select="@element"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="not((following::emof:Tag[@element=$element]) and (following::emof:Tag[@name=$name]))">
							<xsl:call-template name="TagValue2"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="TagValue1"/>
							<xsl:for-each select="following::emof:Tag[@element=$element]">
								<xsl:if test="@name=$name">
									<xsl:call-template name="TagValue1"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--Creates associacions if any ownedattribute have oposite atribute. Assosiciation will be created only once for  two opposited element directing each other.-->
	<xsl:template name="Associations">
		<xsl:for-each select="ownedType[@xmi:type='emof:Class']/ownedAttribute">
			<xsl:if test="string-length(@opposite) &gt; 0">
				<xsl:variable name="id" select="@xmi:id"/>
				<xsl:if test="not(preceding::ownedAttribute[@opposite = $id]) and not(ancestor::ownedAttribute[@opposite = $id])">
					<xsl:element name="packagedElement">
						<xsl:attribute name="xmi:type">uml:Association</xsl:attribute>
						<xsl:attribute name="xmi:id"><xsl:value-of select="concat(@xmi:id,@opposite)"/></xsl:attribute>
						<xsl:element name="end">
							<xsl:attribute name="idref"><xsl:value-of select="@xmi:id"/></xsl:attribute>
						</xsl:element>
						<xsl:element name="end">
							<xsl:attribute name="idref"><xsl:value-of select="@opposite"/></xsl:attribute>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Check all package nodes and converts them depending on type of it.-->
	<xsl:template name="PackageNodes">
		<xsl:call-template name="Associations"/>
		<xsl:for-each select="nestedPackage">
			<xsl:element name="packagedElement">
				<xsl:attribute name="xmi:type">uml:Package</xsl:attribute>
				<xsl:call-template name="Package"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="ownedType">
			<xsl:choose>
				<xsl:when test="@xmi:type='emof:Class'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Class"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='emof:Enumeration'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Enumeration"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='emof:PrimitiveType'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="PrimitiveType"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!--Convert primityve type. -->
	<xsl:template name="PrimitiveType">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convert property atributes -->
	<xsl:template name="Property_attributes">
		<xsl:if test="@opposite">
			<xsl:variable name="id" select="@xmi:id"/>
			<xsl:attribute name="association"><xsl:choose><xsl:when test="not(preceding::ownedAttribute[@opposite = $id]) and not(ancestor::ownedAttribute[@opposite = $id])"><xsl:value-of select="concat(@xmi:id,@opposite)"/></xsl:when><xsl:otherwise><xsl:value-of select="concat(@opposite,@xmi:id)"/></xsl:otherwise></xsl:choose></xsl:attribute>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Property_nodes"/>
	<!-- Convert Named element atributes -->
	<xsl:template name="NamedElement">
		<xsl:apply-templates select="@name"/>
		<xsl:call-template name="XmiID"/>
	</xsl:template>
	<!-- No additional operation atributes in emof -->
	<xsl:template name="Operation_attributes"/>
	<!-- If is crated type element in operation in uml it will be created parameted element with return type -->
	<xsl:template name="Operation_nodes">
		<xsl:if test="@type or type">
			<xsl:element name="ownedParameter">
				<xsl:attribute name="xmi:type">uml:Parameter</xsl:attribute>
				<xsl:call-template name="TypedElement"/>
				<xsl:attribute name="xmi:id"><xsl:value-of select="concat(@xmi:id,'_return')"/></xsl:attribute>
				<xsl:attribute name="direction">return</xsl:attribute>
				<xsl:call-template name="MultiplicityElement"/>
				<xsl:call-template name="Element_nodes"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- No additional emnumeration nodes and atributes for emof -->
	<xsl:template name="Enumeration_nodes"/>
	<xsl:template name="Enumeration_attributes"/>
</xsl:stylesheet>
