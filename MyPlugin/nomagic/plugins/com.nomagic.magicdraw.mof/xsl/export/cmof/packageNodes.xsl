<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmi="http://www.omg.org/spec/XMI/20131001" xmlns:uml='http://www.omg.org/spec/UML/20131001'>
	<xsl:variable name="selectedPackages" select="$OPTIONS/packages/package"/>
	<xsl:key name="selectedPackagesKeys" match="*" use="$OPTIONS/packages/package/@id"/>
	<!-- It can be used to filter out packages by options file. It is not user because model will be made inconsistence after exprot. -->
	<xsl:template name="PackageNodes2">
		<xsl:for-each select="ownedRule">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="elementImport">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="packageImport">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="packagedElement">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="uml:Package">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="uml:Model">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="uml:Profile">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
		<xsl:for-each select="packageMerge">
			<xsl:call-template name="PackageNodes3"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="PackageNodes3">
		<xsl:variable name="ids" select="ancestor-or-self::packagedElement[@xmi:id]"/>
		<xsl:variable name="ids2" select="ancestor-or-self::uml:Package[@xmi:id]"/>
		<xsl:variable name="ids3" select="ancestor-or-self::uml:Model[@xmi:id]"/>
		<xsl:variable name="ids4" select="ancestor-or-self::uml:Profile[@xmi:id]"/>
		<xsl:choose>
			<xsl:when test="count($selectedPackages)=0">
				<xsl:call-template name="PackageNodes"/>
			</xsl:when>
			<xsl:when test="key('selectedPackagesKeys', $ids/@xmi:id)">
				<xsl:call-template name="PackageNodes"/>
			</xsl:when>
			<xsl:when test="key('selectedPackagesKeys', $ids2/@xmi:id)">
				<xsl:call-template name="PackageNodes"/>
			</xsl:when>
			<xsl:when test="key('selectedPackagesKeys', $ids3/@xmi:id)">
				<xsl:call-template name="PackageNodes"/>
			</xsl:when>
			<xsl:when test="key('selectedPackagesKeys', $ids4/@xmi:id)">
				<xsl:call-template name="PackageNodes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="PackageNodes2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!-- export CMOF Package nodes -->
	<xsl:template name="PackageNodes">
		<xsl:call-template name="cmof_Namespace_nodes"/>
		<xsl:for-each select="packagedElement">
			<xsl:variable name="type" select="@xmi:type"/>
			<xsl:choose>
				<xsl:when test="($type='uml:Package' or $type='uml:Model') and @xmi:id">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Package"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:Class'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Class"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:Enumeration'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="Enumeration"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:DataType'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_DataType"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:PrimitiveType'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_PrimitiveType"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:Association'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_Association"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:Constraint'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_Constraint"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:OpaqueExpression'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_OpaqueExpression"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="$type='uml:Expression'">
					<xsl:element name="ownedMember">
						<xsl:call-template name="XmiType"/>
						<xsl:call-template name="cmof_Expression"/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="packageMerge">
			<xsl:element name="packageMerge">
				<xsl:call-template name="cmof_PackageMerge"/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
