<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi='http://schema.omg.org/spec/XMI/2.1' xmlns:uml='http://www.omg.org/spec/UML/20090901' xmlns:cmof="http://schema.omg.org/spec/MOF/2.0/cmof.xml" xmlns:emof_Profile="http://www.magicdraw.com/schemas/emof_Profile.xmi" xmlns:cmof_Profile="http://www.magicdraw.com/schemas/cmof_Profile.xmi">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Some variables for if conditions. -->
	<xsl:variable name="mofTags" select="//cmof:Tag"/>
	<xsl:template name="mofPackageId">
		<xsl:value-of select="//cmof:Package/@xmi:id"/>
	</xsl:template>
	<xsl:template name="mofPackage">
		<xsl:value-of select="cmof:Package"/>
	</xsl:template>
	<!-- Creates uml  model from cmof:package.-->
	<xsl:template name="Model">
		<xsl:for-each select="//cmof:Package">
			<xsl:call-template name="UmlModel"/>
		</xsl:for-each>
	</xsl:template>
	<!-- Convert Named element atributes -->
	<xsl:template name="NamedElement">
		<xsl:apply-templates select="@name"/>
		<xsl:apply-templates select="@visibility"/>
		<xsl:call-template name="XmiID"/>
	</xsl:template>
	<!-- Checks all unique tag names and create stereotypes attributes .-->
	<xsl:template name="CreateTags">
		<xsl:for-each select="//cmof:Tag">
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="not(preceding::cmof:Tag[@name = $name])">
				<xsl:call-template name="StereotypesAttributes"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Share all pckages in model package.-->
	<xsl:template name="ShareTable">
		<xsl:for-each select="//xmi:XMI/cmof:Package/ownedMember[@xmi:type='cmof:Package']">
			<xsl:element name="share">
				<xsl:attribute name="sharedPackage"><xsl:value-of select="@xmi:id"/></xsl:attribute>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- Imports tags. If tag for same element with same name is used only one time - creates tag for element with its names attribute or names elements, elsewhere creates value elements for all same tag names for same element. -->
	<xsl:template name="Tags">
		<xsl:for-each select="//cmof:Tag">
			<xsl:variable name="element" select="@element"/>
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="not((preceding::cmof:Tag[@element=$element]) and (preceding::cmof:Tag[@name=$name]))">
				<xsl:element name="{concat($mofProfile,':',$mofStereotype)}">
					<xsl:attribute name="xmi:id"><xsl:value-of select="@xmi:id"/></xsl:attribute>
					<xsl:attribute name="base_Element"><xsl:value-of select="@element"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="not((following::cmof:Tag[@element=$element]) and (following::cmof:Tag[@name=$name]))">
							<xsl:call-template name="TagValue2"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="TagValue1"/>
							<xsl:for-each select="following::cmof:Tag[@element=$element]">
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
	<!-- Check all package nodes and converts them depending on type of it.-->
	<xsl:template name="PackageNodes">
		<xsl:call-template name="Namespace"/>
		<xsl:for-each select="ownedMember">
			<xsl:choose>
				<xsl:when test="@xmi:type='cmof:Package'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Package"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:Class'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Class"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:Enumeration'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Enumeration"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:DataType'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="DataType"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:PrimitiveType'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="PrimitiveType"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:Association'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Association"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:Constraint'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Constraint"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:OpaqueExpression'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="OpaqueExpression"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type='cmof:Expression'">
					<xsl:element name="packagedElement">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Expression"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="packageMerge">
			<xsl:element name="packageMerge">
				<xsl:call-template name="PackageMerge"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!--Convert primityve type. -->
	<xsl:template name="PrimitiveType">
		<xsl:call-template name="DataType"/>
	</xsl:template>
	<!--Convert datatype type. -->
	<xsl:template name="DataType">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Classifier_attributes"/>
		<xsl:call-template name="Classifier_nodes">
			<xsl:with-param name="generalName">general</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="Element_nodes"/>
		<xsl:call-template name="Namespace"/>
		<xsl:call-template name="DataType_nodes"/>
	</xsl:template>
	<!-- Convert  datatype nodes: all properties and operations.-->
	<xsl:template name="DataType_nodes">
		<xsl:for-each select="ownedAttribute">
			<xsl:element name="ownedAttribute">
				<xsl:call-template name="Property"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="ownedOperation">
			<xsl:element name="ownedOperation">
				<xsl:call-template name="Operation"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- Convert property atributes -->
	<xsl:template name="Property_attributes">
		<xsl:apply-templates select="@isDerivedUnion | @association | @redefinedProperty| @subsettedProperty| @isDerived"/>
	</xsl:template>
	<!-- Convert property nodes directly. -->
	<xsl:template name="Property_nodes">
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="association"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="redefinedProperty"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="subsettedProperty"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Convert  operation attributes -->
	<xsl:template name="Operation_attributes">
		<xsl:apply-templates select="@bodyCondition | @isQuery"/>
	</xsl:template>
	<!-- There is no additional operation nodes.-->
	<xsl:template name="Operation_nodes">
		<xsl:call-template name="Namespace"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="precondition"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="postcondition"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="redefinedOperation"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Convert additional  enumeration attributes for cmof -->
	<xsl:template name="Enumeration_attributes">
		<xsl:call-template name="Classifier_attributes"/>
	</xsl:template>
	<!-- Convert additional  enumeration nodes for cmof -->
	<xsl:template name="Enumeration_nodes">
		<xsl:call-template name="Classifier_nodes">
			<xsl:with-param name="generalName">general</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="Namespace"/>
		<xsl:call-template name="DataType_nodes"/>
	</xsl:template>
	<!-- Convert  namespace elements to uml. -->
	<xsl:template name="Namespace">
		<xsl:for-each select="ownedRule">
			<xsl:element name="ownedRule">
				<xsl:call-template name="Constraint"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="elementImport">
			<xsl:element name="elementImport">
				<xsl:call-template name="ElementImport"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="packageImport">
			<xsl:element name="packageImport">
				<xsl:call-template name="PackageImport"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- Convert ElementImport -->
	<xsl:template name="ElementImport">
		<xsl:call-template name="NamedElement"/>
		<xsl:apply-templates select="@alias | @importedElement"/>
		<xsl:if test="alias">
			<xsl:element name="alias">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="importedElement"/>
		</xsl:call-template>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convert PackageImport -->
	<xsl:template name="PackageImport">
		<xsl:call-template name="NamedElement"/>
		<xsl:apply-templates select="@importedPackage"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="importedPackage"/>
		</xsl:call-template>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convert PckageMerge -->
	<xsl:template name="PackageMerge">
		<xsl:call-template name="XmiID"/>
		<xsl:apply-templates select="@mergedPackage"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="mergedPackage"/>
		</xsl:call-template>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convert constraint and all its specificiation elements.-->
	<xsl:template name="Constraint">
		<xsl:call-template name="NamedElement"/>
		<xsl:apply-templates select="@constrainedElement"/>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="constrainedElement"/>
		</xsl:call-template>
		<xsl:for-each select="specification">
			<xsl:choose>
				<xsl:when test="@xmi:type = 'cmof:Expression'">
					<xsl:element name="specification">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Expression"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type = 'cmof:OpaqueExpression'">
					<xsl:element name="specification">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="OpaqueExpression"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Converts OpaqueExpression and all body and language attributes and nodes. -->
	<xsl:template name="OpaqueExpression">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="TypedElement"/>
		<xsl:apply-templates select="@body | @language"/>
		<xsl:for-each select="body">
			<xsl:element name="body">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="language">
			<xsl:element name="language">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="TypedElement_nodes"/>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convert expresion element and all symbol and operand elements in it.-->
	<xsl:template name="Expression">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="TypedElement"/>
		<xsl:apply-templates select="@symbol"/>
		<xsl:for-each select="symbol">
			<xsl:element name="symbol">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="operand">
			<xsl:choose>
				<xsl:when test="@xmi:type = 'cmof:OpaqueExpression'">
					<xsl:element name="operand">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="OpaqueExpression"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@xmi:type = 'cmof:Expression'">
					<xsl:element name="operand">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Expression"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:call-template name="TypedElement_nodes"/>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convert association element. -->
	<xsl:template name="Association">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Classifier_attributes"/>
		<xsl:for-each select="ownedEnd">
			<xsl:element name="ownedEnd">
				<xsl:call-template name="Property"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="memberEnd"/>
		</xsl:call-template>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="navigableOwnedEnd"/>
		</xsl:call-template>
        <xsl:call-template name="Classifier_nodes">
            <xsl:with-param name="generalName">general</xsl:with-param>
        </xsl:call-template>
		<xsl:call-template name="Namespace"/>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
</xsl:stylesheet>
