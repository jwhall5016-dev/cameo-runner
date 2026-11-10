<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi='http://schema.omg.org/spec/XMI/2.1' xmlns:uml='http://www.omg.org/spec/UML/20090901' xmlns:cmof="http://schema.omg.org/spec/MOF/2.0/cmof.xml" xmlns:emof="http://schema.omg.org/spec/MOF/2.0/emof.xml" xmlns:emof_Profile="http://www.magicdraw.com/schemas/emof_Profile.xmi" xmlns:cmof_Profile="http://www.magicdraw.com/schemas/cmof_Profile.xmi">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Mof profile and stereotype constants -->
	<xsl:variable name="mofProfile" select="concat($MOF,'_Profile')"/>
	<xsl:variable name="mofStereotype" select="concat($MOF,'_Stereotype')"/>
	<!-- Everything starts here -->
	<xsl:template match="/">
		<xsl:element name="xmi:XMI">
			<xsl:apply-templates select="@xmi:version"/>
			<xsl:namespace name="UML_Standard_Profile">http://www.magicdraw.com/schemas/UML_Standard_Profile.xmi</xsl:namespace>
			<xsl:namespace name="MagicDraw_Profile">http://www.magicdraw.com/schemas/MagicDraw_Profile.xmi</xsl:namespace>
			<xsl:namespace name="{$mofProfile}">
				<xsl:value-of select="concat('http://www.magicdraw.com/schemas/', $mofProfile,'.xmi')"/>
			</xsl:namespace>
			<xsl:call-template name="Exporter"/>
			<xsl:call-template name="MountTable"/>
			<xsl:call-template name="Model"/>
		</xsl:element>
	</xsl:template>
	<!-- Creates xmi:XMI element with uml namespaces. Calls templates for creating mount table and model.-->
	<xsl:template match="xmi:XMI">
		
	</xsl:template>
	<!--Exporter for md extensions-->
	<xsl:template name="Exporter">
		<xsl:element name="xmi:Documentation">
			<xsl:attribute name="exporter">MagicDraw UML</xsl:attribute>
			<xsl:attribute name="exporterVersion">16.8</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<!--Creates mount table. This template goes throught all elments with href attribute. If this href is using module, add it to mount table. If module is used before - it will be sciped. Also add Metamodeling profile, if in model is used any element from it.-->
	<xsl:template name="MountTableNodes">
		<xsl:for-each select="//*[@href]">
			<xsl:variable name="hr" select="@href"/>
			<xsl:variable name="subhr" select="substring-before($hr,'#')"/>
			<!--<xsl:variable name="subhrWithoutEnding" select="substring-before($subhr,concat('.',$MOF))"/>-->
			<xsl:variable name="subhrWithoutEnding" select="substring-before($subhr,'.')"/>
			<xsl:if test="string-length($subhrWithoutEnding) > 0 and string($subhrWithoutEnding)!='UML_Standard_Profile' and string($subhrWithoutEnding)!='Metamodeling' ">
				<xsl:if test="not(preceding::*[substring-before(@href,'#') = $subhr]) and not(ancestor::*[substring-before(@href,'#') = $subhr])">
					<xsl:variable name="pId">
						<xsl:call-template name="mofPackageId"/>
					</xsl:variable>
					<xsl:variable name="pattern" select="concat('.',$MOF,'#')"/>
					<xsl:variable name="pattern5" select="concat('http://schema.omg.org/spec/MOF/2.0/', $MOF, '.xml#')"/>
					<xsl:if test="not(contains($hr,$pattern5))">
					
					<xsl:variable name="loadType">
						<xsl:choose>
							<xsl:when test="contains($hr, $pattern)">
								<xsl:value-of select="'ALWAYS_LOAD'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'MANUAL_LOAD'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					
					<xsl:variable name="resource">
						<xsl:choose>
							<xsl:when test="contains($hr, $pattern)">
								<xsl:value-of select="concat('file:/',$subhrWithoutEnding,'.mdxml')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('file:/',$subhr)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					
					
					<xsl:call-template name="Module">
						<xsl:with-param name="loadType"><xsl:value-of select='$loadType'/></xsl:with-param>
						<xsl:with-param name="resource">
							<xsl:value-of select='$resource'/>
						</xsl:with-param>
						<xsl:with-param name="mountPoint">
							<xsl:value-of select="concat($pId,$subhrWithoutEnding)"/>
						</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="Module">
				<xsl:with-param name="loadType">ALWAYS_LOAD</xsl:with-param>
				<xsl:with-param name="resource">file:/UML_Standard_Profile.xml</xsl:with-param>
				<xsl:with-param name="mountPoint">magicdraw_uml_standard_profile_v_0001</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	<!-- Creates actual one module. -->
	<xsl:template name="Module">
		<xsl:param name="loadType">MANUAL_LOAD</xsl:param>
		<xsl:param name="resource"/>
		<xsl:param name="mountPoint"/>
		<xsl:element name="module">
			<xsl:attribute name="resource"><xsl:value-of select="$resource"/></xsl:attribute>
			<xsl:attribute name="autoloadType"><xsl:value-of select="$loadType"/></xsl:attribute>
			<xsl:attribute name="readOnly">true</xsl:attribute>
			<xsl:attribute name="loadIndex">true</xsl:attribute>
			<xsl:attribute name="requiredVersion">-1</xsl:attribute>
			<!--	<xsl:element name="mount">
				<xsl:attribute name="mountPoint"><xsl:value-of select="$mountPoint"/></xsl:attribute>
				<xsl:attribute name="mountedOn"><xsl:call-template name="mofPackageId"/></xsl:attribute>
			</xsl:element>-->
		</xsl:element>
	</xsl:template>
	<!-- Creates extension elements for mount and share tables. Calls share and mount table templates. -->
	<xsl:template name="MountTable">
		<xsl:element name="xmi:Extension">
			<xsl:attribute name="extender">MagicDraw UML</xsl:attribute>
			<xsl:attribute name="extenderID">MagicDraw UML</xsl:attribute>
			<xsl:element name="shareTable">
				<xsl:call-template name="ShareTable"/>
			</xsl:element>
			<xsl:element name="mountTable">
				<xsl:call-template name="MountTableNodes"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Create proxy. This template goes throught all elments with href attribute. If this href  have a link to modules alement, add this element to proxy. If proxy is created for same element before - it will be sciped. All proxies elements will be class type, because it is imposible to get linked elements type.  -->
	<xsl:template name="Proxy">
		<xsl:element name="xmi:Extension">
			<xsl:attribute name="extender">MagicDraw UML</xsl:attribute>
			<xsl:element name="privateProxies">
				<xsl:for-each select="//*[@href]">
					<xsl:variable name="hr" select="@href"/>
					<xsl:variable name="subhr" select="substring-before($hr,'#')"/>
					<xsl:variable name="subhrAfter" select="substring-after($hr,'#')"/>
					<!--<xsl:variable name="subhrWithoutEnding" select="substring-before($subhr,concat('.',$MOF))"/>-->
					<xsl:variable name="subhrWithoutEnding" select="substring-before($subhr,'.')"/>
					<xsl:if test="string-length($subhrWithoutEnding) > 0 and string($subhrWithoutEnding)!='UML_Standard_Profile' and string($subhrWithoutEnding)!='Metamodeling' ">
						<xsl:if test="not(preceding::*[substring-after(@href,'#') = $subhrAfter]) and not(ancestor::*[substring-after(@href,'#') = $subhrAfter])">
							<xsl:variable name="pattern5" select="concat('http://schema.omg.org/spec/MOF/2.0/', $MOF, '.xml#')"/>
							<xsl:if test="not(contains($hr,$pattern5))">
							<xsl:element name="proxy">
								<xsl:variable name="pattern" select="concat($MOF,':')"/>
								<xsl:attribute name="xmi:type">uml:Class</xsl:attribute> 
								<xsl:if test="@xmi:type">
									<xsl:attribute name="xmi:type"><xsl:value-of select="concat('uml:',substring-after(@xmi:type, $pattern))"/></xsl:attribute>
									<!--	<xsl:attribute name="xmi:type"><xsl:value-of select="@xmi:type"/></xsl:attribute>-->
								</xsl:if>
								<xsl:attribute name="xmi:id"><xsl:value-of select="substring-after($hr,'#')"/></xsl:attribute>
								<xsl:attribute name="name">unloaded</xsl:attribute>
							</xsl:element>
							</xsl:if>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
			<xsl:element name="options">
		</xsl:element>
		</xsl:element>
	</xsl:template>
	<!--Change xmi type -->
	<xsl:template name="XmiType">
		<xsl:apply-templates select="@xmi:type"/>
	</xsl:template>
	<!-- Change mof type to uml type by replacing emof or cmof to uml keyword. -->
	<xsl:template match="@xmi:type">
		<xsl:variable name="convertedType">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:variable name="type" select="normalize-space($convertedType)"/>
		<xsl:attribute name="xmi:type"><xsl:choose><xsl:when test="starts-with($type, $MOF)"><xsl:value-of select="concat('uml', substring($type, 5))"/></xsl:when><xsl:otherwise><xsl:value-of select="$type"/></xsl:otherwise></xsl:choose></xsl:attribute>
	</xsl:template>
	<!-- Creates  uml model. call templates for element name, package for metamodeling profile, profile for steretype with is needed for tags. When model is created is calls templates for creating metamodeling tags, other tags and proxies. -->
	<xsl:template name="UmlModel">
		<xsl:element name="uml:Model">
			<xsl:apply-templates select="@uri"/>
			<xsl:apply-templates select="@URI"/>
			<xsl:call-template name="NamedElement"/>
			<xsl:call-template name="Element_nodes"/>
			<xsl:call-template name="AditionalTagsStereotype"/>
			<xsl:call-template name="PackageNodes"/>
		</xsl:element>
		<xsl:call-template name="Proxy"/>
		<xsl:call-template name="Tags"/>
	</xsl:template>
	<!-- If there are any tag in mof profile, creates profile and adds stereotype. Call template for creating all propertie for steretype, witch is used in tags.-->
	<xsl:template name="AditionalTagsStereotype">
		<xsl:if test="$mofTags">
			<xsl:element name="packagedElement">
				<xsl:attribute name="xmi:type">uml:Profile</xsl:attribute>
				<xsl:attribute name="xmi:id">magicdraw_mof_profile_0001</xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="$mofProfile"/></xsl:attribute>
				<xsl:element name="packagedElement">
					<xsl:attribute name="xmi:type">uml:Stereotype</xsl:attribute>
					<xsl:attribute name="xmi:id">magicdraw_mof_tags_0001</xsl:attribute>
					<xsl:attribute name="name"><xsl:value-of select="$mofStereotype"/></xsl:attribute>
					<xsl:call-template name="CreateTags"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- Create atributes for stereotype-->
	<xsl:template name="StereotypesAttributes">
		<xsl:element name="ownedAttribute">
			<xsl:attribute name="xmi:type">uml:Property</xsl:attribute>
			<xsl:attribute name="xmi:id"><xsl:value-of select="concat(@xmi:id,'_tag')"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
			<xsl:element name="type">
				<xsl:attribute name="xmi:type">uml:PrimitiveType</xsl:attribute>
				<xsl:attribute name="href">http://www.omg.org/spec/UML/20090901/uml.xml#String</xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Creates tags values depending of value is attribute or set of elements.-->
	<xsl:template name="TagValue2">
		<xsl:choose>
			<xsl:when test="@value">
				<xsl:attribute name="{@name}"><xsl:value-of select="@value"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="name" select="@name"/>
				<xsl:for-each select="value">
					<xsl:element name="{$name}">
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Creates tags values all as elements.-->
	<xsl:template name="TagValue1">
		<xsl:variable name="name" select="@name"/>
		<xsl:choose>
			<xsl:when test="@value">
				<xsl:element name="{$name}">
					<xsl:value-of select="@value"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="value">
					<xsl:element name="{$name}">
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--Package element-->
	<xsl:template name="Package">
		<xsl:apply-templates select="@uri"/>
		<xsl:apply-templates select="@URI"/>
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Element_nodes"/>
		<xsl:call-template name="PackageNodes"/>
	</xsl:template>
	<!--Classifier nodes. Converts generalizations for elements.-->
	<xsl:template name="Classifier_nodes">
		<xsl:param name="generalName" select="string('superClass')"/>
		<xsl:choose>
			<xsl:when test="$generalName = string('superClass')">
				<xsl:if test="@superClass">
					<xsl:call-template name="GeneralizationElement2">
						<xsl:with-param name="general">
							<xsl:value-of select="@superClass"/>
						</xsl:with-param>
						<xsl:with-param name="xmiid">
							<xsl:value-of select="@xmi:id"/>
						</xsl:with-param>
						<xsl:with-param name="primeInt" select="number('0')"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:for-each select="superClass">
					<xsl:call-template name="GeneralizationElement"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="@general">
					<xsl:call-template name="GeneralizationElement2">
						<xsl:with-param name="general">
							<xsl:value-of select="@general"/>
						</xsl:with-param>
						<xsl:with-param name="xmiid">
							<xsl:value-of select="@xmi:id"/>
						</xsl:with-param>
						<xsl:with-param name="primeInt" select="number('0')"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:for-each select="general">
					<xsl:call-template name="GeneralizationElement"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Creates actual generalization element -->
	<xsl:template name="GeneralizationElement">
		<xsl:element name="generalization">
			<xsl:attribute name="xmi:type">uml:Generalization</xsl:attribute>
			<xsl:attribute name="xmi:id"><xsl:value-of select="parent::*/@xmi:id"/>_generalization_<xsl:number count="//*"/></xsl:attribute>
			<xsl:if test="@xmi:idref">
				<xsl:attribute name="general"><xsl:value-of select="@xmi:idref"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@href">
				<xsl:element name="general">
				<xsl:apply-templates select="@xmi:idref | @href"/>
				</xsl:element>
			</xsl:if>
			
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="GeneralizationElement2">
		<xsl:param name="general"/>
		<xsl:param name="xmiid"/>
		<xsl:param name="primeInt"/>
		<xsl:variable name="int" select="$primeInt + 1"/>
		<xsl:variable name="newgeneral" select="concat(normalize-space($general), ' ')" />
		<xsl:variable name="first" select="substring-before($newgeneral, ' ')" />
		<xsl:variable name="remaining" select="substring-after($newgeneral, ' ')" />
		<xsl:element name="generalization">
			<xsl:attribute name="xmi:type">uml:Generalization</xsl:attribute>
			<xsl:attribute name="general"><xsl:value-of select="$first"/></xsl:attribute>
			<xsl:attribute name="xmi:id"><xsl:value-of select="$xmiid"/>_generalization_<xsl:value-of select="$int"/></xsl:attribute>
		</xsl:element>
		<xsl:if test="$remaining">
        <xsl:call-template name="GeneralizationElement2">
            <xsl:with-param name="general" select="$remaining" />
            <xsl:with-param name="xmiid" select="$xmiid"/>
             <xsl:with-param name="primeInt" select="$int"/>
        </xsl:call-template>
    </xsl:if>
	</xsl:template>
	<!-- Converts class elements with their all atributes and namespace, property, operation, classifier elements. -->
	<xsl:template name="Class">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Classifier_attributes"/>
		<xsl:call-template name="Classifier_nodes"/>
		<xsl:call-template name="Namespace"/>
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
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Classifier atribute -->
	<xsl:template name="Classifier_attributes">
		<xsl:apply-templates select="@isAbstract"/>
	</xsl:template>
	<!--Converts property element-->
	<xsl:template name="Property">
		<xsl:attribute name="xmi:type">uml:Property</xsl:attribute>
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="TypedElement"/>
		<xsl:apply-templates select="@isDerived"/>
		<xsl:apply-templates select="@isReadOnly"/>
		<xsl:apply-templates select="@isID"/>
		<xsl:if test="@isComposite='true'">
			<xsl:attribute name="aggregation">composite</xsl:attribute>
		</xsl:if>
		<xsl:call-template name="Property_attributes"/>
		<xsl:call-template name="MultiplicityElement"/>
		<xsl:call-template name="DefaultValue"/>
		<xsl:call-template name="Property_nodes"/>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Create default value element from default atribute. -->
	<xsl:template name="DefaultValue">
		<xsl:if test="@default">
			<xsl:element name="defaultValue">
				<xsl:attribute name="xmi:type">uml:LiteralString</xsl:attribute>
				<xsl:attribute name="xmi:id"><xsl:value-of select="concat(@xmi:id,'_defaultValue')"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="@default"/></xsl:attribute>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!--Converts mof multiplicity attributes to uml multiplicity elements. Converts upper and lower attribute in sequence.-->
	<xsl:template name="MultiplicityElement">
        <xsl:apply-templates select="@isOrdered | @isUnique"/>
		<xsl:call-template name="multiplicityValue">
			<xsl:with-param name="id" select="@xmi:id"/>
			<xsl:with-param name="multiplicityValue" select="@upper"/>
			<xsl:with-param name="attributeName" select="string('upperValue')"/>
		</xsl:call-template>
		<xsl:call-template name="multiplicityValue">
			<xsl:with-param name="id" select="@xmi:id"/>
			<xsl:with-param name="multiplicityValue" select="@lower"/>
			<xsl:with-param name="attributeName" select="string('lowerValue')"/>
		</xsl:call-template>
		<xsl:call-template name="TypedElement_nodes"/>
	</xsl:template>
	<!--Convert multiplicity lower or upper atribute to uml multipicity end element-->
	<xsl:template name="multiplicityValue">
		<xsl:param name="multiplicityValue"/>
		<xsl:param name="attributeName"/>
		<xsl:param name="id"/>
		<xsl:if test="$multiplicityValue">
			<xsl:element name="{$attributeName}">
				<xsl:attribute name="xmi:id"><xsl:value-of select="$id"/><xsl:value-of select="$attributeName"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="$multiplicityValue = '*'">
						<xsl:attribute name="xmi:type">uml:LiteralUnlimitedNatural</xsl:attribute>
						<xsl:attribute name="value">-1</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="xmi:type">uml:LiteralInteger</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="$multiplicityValue"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!--Converts enumeration literal.-->
	<xsl:template name="EnumerationLiteral">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!--Converts enumeration element with all enumeration literal elements.-->
	<xsl:template name="Enumeration">
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Enumeration_attributes"/>
		<xsl:call-template name="Enumeration_nodes"/>
		<xsl:for-each select="ownedLiteral">
			<xsl:element name="ownedLiteral">
				<xsl:attribute name="xmi:type">uml:EnumerationLiteral</xsl:attribute>
				<xsl:call-template name="EnumerationLiteral"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Convetrts operation elements with all parameters. In emof parameter for return is created from operation element atributes and type element. -->
	<xsl:template name="Operation">
		<xsl:attribute name="xmi:type">uml:Operation</xsl:attribute>
		<xsl:call-template name="NamedElement"/>
		<xsl:call-template name="Operation_attributes"/>
		<xsl:call-template name="Operation_nodes"/>
		<xsl:for-each select="ownedParameter">
			<xsl:choose>
				<xsl:when test="@direction">
					<xsl:call-template name="Parameter">
						<xsl:with-param name="direction">
							<xsl:value-of select="@direction"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="Parameter">
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="raisedException"/>
		</xsl:call-template>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!--Converts parameter elements with given direction, type and multiplicities.-->
	<xsl:template name="Parameter">
		<xsl:param name="direction">in</xsl:param>
		<xsl:element name="ownedParameter">
			<xsl:attribute name="xmi:type">uml:Parameter</xsl:attribute>
			<xsl:if test="$direction">
				<xsl:attribute name="direction"><xsl:value-of select="$direction"/></xsl:attribute>
			</xsl:if>
			<xsl:call-template name="TypedElement"/>
			<xsl:call-template name="MultiplicityElement"/>
            <xsl:if test="$direction">
                <xsl:call-template name="DefaultValue"/>
            </xsl:if>
            <xsl:call-template name="Element_nodes"/>
		</xsl:element>
	</xsl:template>
	<!--Convert typed elements atributes.-->
	<xsl:template name="TypedElement">
		<xsl:call-template name="NamedElement"/>
		<xsl:if test="@type">
			<xsl:apply-templates select="@type"/>
		</xsl:if>
	</xsl:template>
	<!--Convert typed elemens with their href;s and idrefs.-->
	<xsl:template name="TypedElement_nodes">
		<xsl:for-each select="type">
			<xsl:element name="type">
				<xsl:attribute name="xmi:type">uml:PrimitiveType</xsl:attribute>
				<xsl:apply-templates select="@xmi:idref | @href"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!--Convert comment elementss-->
	<xsl:template name="Element_nodes">
		<xsl:for-each select="ownedComment">
			<xsl:element name="ownedComment">
				<xsl:call-template name="Comment"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!--Create comment element atributes and anotated elements for it.-->
	<xsl:template name="Comment">
		<xsl:attribute name="xmi:type">uml:Comment</xsl:attribute>
		<xsl:call-template name="XmiID"/>
		<xsl:apply-templates select="@body | @annotatedElement"/>
		<xsl:if test="body">
			<xsl:element name="body">
				<xsl:value-of select="body"/>
			</xsl:element>
		</xsl:if>
		<xsl:call-template name="XmiRef">
			<xsl:with-param name="node" select="annotatedElement"/>
		</xsl:call-template>
		<xsl:call-template name="Element_nodes"/>
	</xsl:template>
	<!-- Converts different references -->
	<xsl:template name="XmiRef">
		<xsl:param name="node"/>
		<xsl:for-each select="$node">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@xmi:idref | @href"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!--Convert href by replacing profile extension from cmof or emof to mdxml.-->
	<xsl:template match="@href">
		<xsl:variable name="href" select="current()"/>
		<xsl:variable name="umlNsUri" select="concat('http://schema.omg.org/spec/MOF/2.0/', $MOF, '.xml#')"/>
		<xsl:choose>
			<xsl:when test="starts-with($href, $umlNsUri)">
				<xsl:attribute name="href"><xsl:value-of select="concat('http://www.omg.org/spec/UML/20090901/uml.xml' , '#', substring-after($href, $umlNsUri))"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="pattern" select="concat('.',$MOF,'#')"/>
				<xsl:choose>
					<xsl:when test="contains(., $pattern)">
						<xsl:attribute name="href"><xsl:value-of select="concat(substring-before(current(), $pattern), '.mdxml#', substring-after(current(), $pattern))"/></xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Change uri to URI-->
	<xsl:template match="@uri">
		<xsl:attribute name="URI"><xsl:value-of select="current()"/></xsl:attribute>
	</xsl:template>
	<!-- Copy xmi:id-->
	<xsl:template name="XmiID">
		<xsl:apply-templates select="@xmi:id"/>
	</xsl:template>
	<!-- Copy all attributes -->
	<xsl:template match="@*">
		<xsl:copy/>
	</xsl:template>
	<!-- Skip all elements -->
	<xsl:template match="*"/>
</xsl:stylesheet>
