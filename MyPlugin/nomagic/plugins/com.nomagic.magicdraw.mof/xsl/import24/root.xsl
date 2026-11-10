<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi='http://www.omg.org/spec/XMI/20131001' xmlns:uml="http://www.omg.org/spec/UML/20131001" xmlns:mof_Profile="http://www.magicdraw.com/schemas/mof_Profile.xmi" xmlns:mofext="http://www.omg.org/spec/MOF/20131001">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Mof profile and stereotype constants -->
	<xsl:variable name="mofProfile">mof_Profile</xsl:variable>
	<xsl:variable name="mofStereotype">mof_Stereotype</xsl:variable>
	<xsl:variable name="mofTags" select="//mofext:Tag"/>
	<!-- Everything starts here -->
	<xsl:template match="/">
		<xsl:element name="xmi:XMI">
			<xsl:namespace name="UML_Standard_Profile">http://www.magicdraw.com/schemas/UML_Standard_Profile.xmi</xsl:namespace>
			<xsl:namespace name="MagicDraw_Profile">http://www.magicdraw.com/schemas/MagicDraw_Profile.xmi</xsl:namespace>
			<xsl:namespace name="{$mofProfile}">
				<xsl:value-of select="concat('http://www.magicdraw.com/schemas/', $mofProfile,'.xmi')"/>
			</xsl:namespace>
			<!-- 
			<xsl:choose>
				<xsl:when test="@xmi:version">
					<xsl:apply-templates select="@xmi:version"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="xmi:version">2.1</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			-->
			<xsl:call-template name="Exporter"/>
			<xsl:call-template name="MountTable"/>
			<xsl:call-template name="UmlModel"/>
		</xsl:element>
	</xsl:template>
	<!-- Creates xmi:XMI element with uml namespaces. Calls templates for creating mount table and model.-->
	<xsl:template match="xmi:XMI">
		
	</xsl:template>
	<!--Exporter for md extensions-->
	<xsl:template name="Exporter">
		<xsl:element name="xmi:Documentation">
			<xsl:attribute name="exporter">MagicDraw UML</xsl:attribute>
			<xsl:attribute name="exporterVersion">17.0</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<!--Creates mount table. This template goes throught all elments with href attribute. If this href is using module, add it to mount table. If module is used before - it will be sciped. Also add Metamodeling profile, if in model is used any element from it.-->
	<xsl:template name="MountTableNodes">
		<xsl:for-each select="//*[@href]">
			<xsl:variable name="hr" select="@href"/>
			<xsl:variable name="subhr" select="substring-before($hr,'#')"/>
			<!--<xsl:variable name="subhrWithoutEnding" select="substring-before($subhr,concat('.',$MOF))"/>-->
			<xsl:variable name="subhrWithoutEnding" select="substring-before($subhr,'.')"/>
			<xsl:if test="string-length($subhrWithoutEnding) > 0 and string($subhrWithoutEnding)!='UML_Standard_Profile' ">
				<xsl:if test="not(preceding::*[substring-before(@href,'#') = $subhr]) and not(ancestor::*[substring-before(@href,'#') = $subhr])">
					<xsl:variable name="pattern" select="concat('.',$MOF,'#')"/>
					<xsl:variable name="pattern5">http://www.omg.org/spec/UML/201</xsl:variable>
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
							<xsl:with-param name="loadType">
								<xsl:value-of select='$loadType'/>
							</xsl:with-param>
							<xsl:with-param name="resource">
								<xsl:value-of select='$resource'/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="Module">
			<xsl:with-param name="loadType">ALWAYS_LOAD</xsl:with-param>
			<xsl:with-param name="resource">file:/UML_Standard_Profile.xml</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- Creates actual one module. -->
	<xsl:template name="Module">
		<xsl:param name="loadType">MANUAL_LOAD</xsl:param>
		<xsl:param name="resource"/>
		<xsl:element name="module">
			<xsl:attribute name="resource"><xsl:value-of select="$resource"/></xsl:attribute>
			<xsl:attribute name="autoloadType"><xsl:value-of select="$loadType"/></xsl:attribute>
			<xsl:attribute name="readOnly">true</xsl:attribute>
			<xsl:attribute name="loadIndex">true</xsl:attribute>
			<xsl:attribute name="requiredVersion">-1</xsl:attribute>
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
					<xsl:if test="string-length($subhrWithoutEnding) > 0 and string($subhrWithoutEnding)!='UML_Standard_Profile'">
						<xsl:if test="not(preceding::*[substring-after(@href,'#') = $subhrAfter]) and not(ancestor::*[substring-after(@href,'#') = $subhrAfter])">
							<xsl:variable name="pattern5">http://www.omg.org/spec/UML/201</xsl:variable>
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
	<!-- Creates  uml model. call templates for element name, package for metamodeling profile, profile for steretype with is needed for tags. When model is created is calls templates for creating metamodeling tags, other tags and proxies. -->
	<xsl:template name="UmlModel">
		<xsl:for-each select="//uml:Package">
			<xsl:element name="{'uml:Model'}">
				<xsl:apply-templates select="@*"/>
				<xsl:for-each select="*">
					<xsl:call-template name="RecursiveCopy"/>
				</xsl:for-each>
				<xsl:call-template name="AditionalTagsStereotype"/>
				<xsl:value-of select="text()"/>
			</xsl:element>
		</xsl:for-each>
		<xsl:call-template name="Proxy"/>
		<xsl:call-template name="Tags"/>
	</xsl:template>
	<xsl:template name="RecursiveCopy">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:for-each select="*">
				<xsl:call-template name="RecursiveCopy"/>
			</xsl:for-each>
			<xsl:value-of select="text()"/>
		</xsl:element>
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
	<xsl:template name="CreateTags">
		<xsl:for-each select="//mofext:Tag">
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="not(preceding::mofext:Tag[@name = $name]) and not(ancestor::mofext:Tag[@name = $name])">
				<xsl:call-template name="StereotypesAttributes"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Create atributes for stereotype-->
	<xsl:template name="StereotypesAttributes">
		<xsl:element name="ownedAttribute">
			<xsl:attribute name="xmi:type">uml:Property</xsl:attribute>
			<xsl:attribute name="xmi:id"><xsl:value-of select="concat(@xmi:id,'_tag')"/></xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
			<xsl:element name="type">
				<xsl:attribute name="xmi:type">uml:PrimitiveType</xsl:attribute>
				<xsl:attribute name="href">http://www.omg.org/spec/UML/20131001/uml.xml#String</xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Share all pckages in model package.-->
	<xsl:template name="ShareTable">
		<xsl:for-each select="//xmi:XMI/uml:Package/packagedElement">
		<xsl:variable name="xmitype" select="@xmi:type"/>
		<xsl:if test="$xmitype='uml:Package'">
			<xsl:element name="share">
				<xsl:attribute name="sharedPackage"><xsl:value-of select="@xmi:id"/></xsl:attribute>
			</xsl:element>
		</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Imports tags. If tag for same element with same name is used only one time - creates tag for element with its names attribute or names elements, elsewhere creates value elements for all same tag names for same element. -->
	<xsl:template name="Tags">
		<xsl:for-each select="//mofext:Tag">
			<xsl:variable name="element" select="@element"/>
			<xsl:variable name="name" select="@name"/>
			<xsl:element name="{concat($mofProfile,':',$mofStereotype)}">
				<xsl:attribute name="xmi:id"><xsl:value-of select="@xmi:id"/></xsl:attribute>
				<xsl:attribute name="base_Element"><xsl:value-of select="@element"/></xsl:attribute>
				<xsl:call-template name="TagValue1"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<!-- Creates tags values all as elements.-->
	<xsl:template name="TagValue1">
		<xsl:variable name="name" select="@name"/>
		<xsl:choose>
			<xsl:when test="@value">
				<xsl:attribute name="{$name}"><xsl:value-of select="@value"/></xsl:attribute>
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
	<!--Convert href by replacing profile extension from cmof or emof to mdxml.-->
	<xsl:template match="@href">
		<xsl:variable name="href" select="current()"/>
		<xsl:variable name="pattern" select="concat('.',$MOF,'#')"/>
		<xsl:choose>
			<xsl:when test="contains(., $pattern)">
				<xsl:attribute name="href"><xsl:value-of select="concat(substring-before(current(), $pattern), '.mdxml#', substring-after(current(), $pattern))"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Copy all attributes -->
	<xsl:template match="@*">
		<xsl:copy/>
	</xsl:template>
</xsl:stylesheet>
