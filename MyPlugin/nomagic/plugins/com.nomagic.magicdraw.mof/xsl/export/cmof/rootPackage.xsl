<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cmof='http://schema.omg.org/spec/MOF/2.0/cmof.xml'>
	<!-- export CMOF root package -->
	<xsl:template name="RootPackage">
		<xsl:element name="cmof:Package">
			<xsl:call-template name="Package"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
