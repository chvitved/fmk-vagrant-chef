<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
<!DOCTYPE trifork-app-conf PUBLIC '-//Trifork Technologies//DTD Trifork System Descriptor1.0//EN' 'http://trifork.com/j2ee/dtds/trifork-app-conf_1_0.dtd'>
-->

<xsl:template match="trifork-system-conf">
<trifork-app-conf>
<xsl:apply-templates/>
</trifork-app-conf>
</xsl:template>

<xsl:template match="http">
<!-- It would be nice to be able to output the comment below, but unfortunately it doesn't work -->
<!-- <xsl:text disable-output-escaping="yes"> -->
<!-- &lt;!- - NOTE: Converted trifork 3.1 descriptor contained the http tag - -&gt; -->
<!-- </xsl:text> -->
</xsl:template>

<xsl:template match="https"/>
<xsl:template match="ajpv13"/>
<xsl:template match="default-host"/>
<xsl:template match="server-name"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
