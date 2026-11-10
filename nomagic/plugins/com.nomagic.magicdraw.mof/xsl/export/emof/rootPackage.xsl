<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:emof='http://schema.omg.org/spec/MOF/2.0/emof.xml' xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- export EMOF root Package -->
	<xsl:template name="RootPackage">
		<xsl:element name="emof:Package">
			<xsl:call-template name="Package"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
