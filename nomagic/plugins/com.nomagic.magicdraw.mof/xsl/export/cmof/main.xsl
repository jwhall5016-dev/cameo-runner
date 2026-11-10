<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- include required stylesheets -->
	<xsl:include href="../root.xsl"/>
	<xsl:include href="../emof/emofComment.xsl"/>
	<xsl:include href="../emof/emofElement.xsl"/>
	<xsl:include href="../emof/emofMultiplicityElement.xsl"/>
	<xsl:include href="../emof/emofNamedElement.xsl"/>
	<xsl:include href="../emof/emofTypedElement.xsl"/>
	<xsl:include href="class.xsl"/>
	<xsl:include href="cmofAssociation.xsl"/>
	<xsl:include href="cmofBehavioralFeature.xsl"/>
	<xsl:include href="cmofClassifier.xsl"/>
	<xsl:include href="cmofConstraint.xsl"/>
	<xsl:include href="cmofDataType.xsl"/>
	<xsl:include href="cmofElementImport.xsl"/>
	<xsl:include href="cmofExpression.xsl"/>
	<xsl:include href="cmofNamedElement.xsl"/>
	<xsl:include href="cmofNamespace.xsl"/>
	<xsl:include href="cmofOpaqueExpression.xsl"/>
	<xsl:include href="cmofPackageImport.xsl"/>
	<xsl:include href="cmofPackageMerge.xsl"/>
	<xsl:include href="cmofPrimitiveType.xsl"/>
	<xsl:include href="cmofStructuralFeature.xsl"/>
	<xsl:include href="cmofVisibility.xsl"/>
	<xsl:include href="enumeration.xsl"/>
	<xsl:include href="namedElement.xsl"/>
	<xsl:include href="operation.xsl"/>
	<xsl:include href="packageNodes.xsl"/>
	<xsl:include href="parameter.xsl"/>
	<xsl:include href="property.xsl"/>
	<xsl:include href="rootPackage.xsl"/>
	<!-- MOF type -->
	<xsl:variable name="MOF" select="'cmof'"/>
</xsl:stylesheet>
