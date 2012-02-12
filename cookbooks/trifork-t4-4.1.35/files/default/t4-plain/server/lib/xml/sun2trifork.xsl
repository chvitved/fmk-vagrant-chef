<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
<!DOCTYPE trifork-app-conf PUBLIC '-//Trifork Technologies//DTD Trifork System Descriptor1.0//EN' 'http://trifork.com/j2ee/dtds/trifork-app-conf_1_0.dtd'>
-->

<xsl:template match="j2ee-ri-specific-information">
<trifork-app-conf>
<system-name></system-name>
<xsl:apply-templates/>
</trifork-app-conf>
</xsl:template>

<xsl:template match="app-client">
<application-client>
<xsl:apply-templates/>
</application-client>
</xsl:template>

<xsl:template match="ejb">
<ejb>
<ejb-name>
<xsl:if test="../module-name"><xsl:value-of select="../module-name"/>#</xsl:if>
<xsl:value-of select="ejb-name"/>
</ejb-name>
<xsl:apply-templates select="jndi-name"/>
<xsl:apply-templates select="cmp"/>
<xsl:apply-templates select="ejb20-cmp"/>
<xsl:apply-templates select="principal"/>
<xsl:apply-templates select="mdb-connection-factory"/>
<xsl:apply-templates select="ior-security-config"/>
<xsl:apply-templates select="env-entry"/>
<xsl:apply-templates select="ejb-ref"/>
<xsl:apply-templates select="resource-ref"/>
<xsl:apply-templates select="resource-env-ref"/>
<xsl:apply-templates select="jms-durable-subscription-name"/>
</ejb>
</xsl:template>

<xsl:template match="cmp">
<cmp>
<xsl:if test="table-name">
<table-name><xsl:value-of select="table-name"/></table-name>
</xsl:if>

<xsl:apply-templates select="sql-statement"/>

<create-table-deploy>
<xsl:value-of select="create-table-deploy"/>
</create-table-deploy>

<delete-table-undeploy>
<xsl:value-of select="delete-table-undeploy"/>
</delete-table-undeploy>

</cmp>
</xsl:template>

<xsl:template match="cmpresource">
<cmp-resource>
<jndi-name><xsl:value-of select="ds-jndi-name"/></jndi-name>
<xsl:apply-templates select="default-resource-principal"/>
</cmp-resource>
</xsl:template>

<xsl:template match="default-resource-principal">
<resource-principal>
<principal><xsl:value-of select="name"/></principal>
<password><xsl:value-of select="password"/></password>
</resource-principal>
</xsl:template>

<xsl:template match="ejb-ref">
<ejb-ref>
<ejb-ref-name><xsl:value-of select="ejb-ref-name"/></ejb-ref-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
</ejb-ref>
</xsl:template>

<xsl:template match="ejb20-cmp">
<cmp>
<xsl:if test="table-name">
<table-name><xsl:value-of select="table-name"/></table-name>
</xsl:if>

<xsl:apply-templates select="sql-statement"/>
<create-table-deploy>
<xsl:value-of select="create-table-deploy"/>
</create-table-deploy>
<delete-table-undeploy>
<xsl:value-of select="delete-table-undeploy"/>
</delete-table-undeploy>
</cmp>
</xsl:template>

<xsl:template match="enterprise-beans">
<enterprise-beans>
<xsl:apply-templates select="ejb"/>

<xsl:for-each select="ejb/cmp/ds-jndi-name">
    <cmp-resource>
        <jndi-name><xsl:value-of select="."/></jndi-name>
    </cmp-resource>
</xsl:for-each>

<xsl:apply-templates select="cmpresource"/>

</enterprise-beans>
</xsl:template>

<xsl:template match="name"/>
<xsl:template match="unique-id"/>
<xsl:template match="ds-jndi-name"/>
<xsl:template match="use-ssl"/>
<xsl:template match="field"/>
<xsl:template match="group"/>
<xsl:template match="groups"/>
<xsl:template match="ior-security-config"/>
<xsl:template match="transport-config"/>
<xsl:template match="integrity"/>
<xsl:template match="confidentiality"/>
<xsl:template match="establish-trust-in-target"/>
<xsl:template match="establish-trust-in-client"/>
<xsl:template match="as-context"/>
<xsl:template match="auth-method"/>
<xsl:template match="realm"/>
<xsl:template match="required"/>
<xsl:template match="sas-context"/>
<xsl:template match="mail-from"/>
<xsl:template match="mail-to"/>
<xsl:template match="remote-entity"/>
<xsl:template match="res-ref-name"/>
<xsl:template match="display-name"/>
<xsl:template match="module-name"/>

<xsl:template match="mail-configuration">
<mail-resource-conf>
<name><xsl:value-of select="name"/></name>
<mail-from><xsl:value-of select="mail-from"/></mail-from>
<mail-host><xsl:value-of select="mail-host"/></mail-host>
</mail-resource-conf>
</xsl:template>

<xsl:template match="principal">
<principal><xsl:value-of select="name"/></principal>
</xsl:template>

<xsl:template match="principals">
<principals>
<xsl:apply-templates select="principal"/>
</principals>
</xsl:template>

<xsl:template match="resource-env-ref">
<resource-env-ref>
<resource-env-ref-name>
<xsl:value-of select="resource-env-ref-name"/>
</resource-env-ref-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
</resource-env-ref>
</xsl:template>

<xsl:template match="resource-ref">
<resource-ref>
  <res-ref-name><xsl:value-of select="res-ref-name"/></res-ref-name>
  <!-- <jndi-name><xsl:value-of select="jndi-name"/></jndi-name> -->
  <xsl:apply-templates/>
</resource-ref>
</xsl:template>

<xsl:template match="mdb-connection-factory">
<mdb-connection-factory>
  <jndi-name><xsl:value-of select="."/></jndi-name>
</mdb-connection-factory>
</xsl:template>

<xsl:template match="jms-durable-subscription-name">
<mdb-durable-subscription-name><xsl:value-of select="."/></mdb-durable-subscription-name>
</xsl:template>

<xsl:template match="ior-security-config">
<ior-security-config>
  <xsl:apply-templates select="transport-config"/>
  <xsl:apply-templates select="as-context"/>
  <xsl:apply-templates select="sas-context"/>
</ior-security-config>
</xsl:template>

<xsl:template match="transport-config">
<transport-config>
  <integrity><xsl:value-of select="integrity"/></integrity>
  <confidentiality><xsl:value-of select="confidentiality"/></confidentiality>
  <establish-trust-in-target><xsl:value-of select="establish-trust-in-target"/></establish-trust-in-target>
  <establish-trust-in-client><xsl:value-of select="establish-trust-in-client"/></establish-trust-in-client>
</transport-config>
</xsl:template>

<xsl:template match="as-context">
<as-context>
  <auth-method><xsl:value-of select="auth-method"/></auth-method>
  <realm><xsl:value-of select="realm"/></realm>
  <required><xsl:value-of select="required"/></required>
</as-context>
</xsl:template>

<xsl:template match="sas-context">
<sas-context>
  <caller-propagation><xsl:value-of select="caller-propagation"/></caller-propagation>
</sas-context>
</xsl:template>

<xsl:template match="rolemapping">
<role-mapping>
<xsl:apply-templates/>
</role-mapping>
</xsl:template>

<xsl:template match="role">
<role>
<xsl:attribute name="name">
<xsl:value-of select="@name"/>
</xsl:attribute>
<xsl:apply-templates select="principals"/>
<xsl:apply-templates select="groups"/>
</role>
</xsl:template>

<xsl:template match="sql-statement">
<xsl:if test="method">
<sql-statement>
<xsl:apply-templates select="method"/>
<xsl:apply-templates select="sql"/>
</sql-statement>
</xsl:if>
</xsl:template>

<xsl:template match="sql">
<xsl:copy>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>


<xsl:template match="web">
<web-app>
<display-name><xsl:value-of select="display-name"/></display-name>
<xsl:apply-templates select="context-root"/>

<xsl:apply-templates select="env-entry"/>
<xsl:apply-templates select="ejb-ref"/>
<xsl:apply-templates select="resource-ref"/>
<xsl:apply-templates select="resource-env-ref"/>


</web-app>
</xsl:template>

<xsl:template match="context-root">
<context-root>
<xsl:value-of select="."/>
</context-root>
</xsl:template>

<xsl:template match="method">
<method>
<xsl:apply-templates select="method-intf"/>
<xsl:apply-templates select="method-name"/>
<xsl:apply-templates select="method-params"/>
</method>
</xsl:template>

<xsl:template match="ejb-name">
<ejb-name><xsl:value-of select="."/></ejb-name>
</xsl:template>

<xsl:template match="jndi-name">
<jndi-name><xsl:value-of select="."/></jndi-name>
</xsl:template>

<xsl:template match="method-params">
<xsl:copy>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

<xsl:template match="method-intf">
<xsl:copy>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

<xsl:template match="method-name">
<xsl:copy>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

<xsl:template match="method-param">
<xsl:copy>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

</xsl:stylesheet>
