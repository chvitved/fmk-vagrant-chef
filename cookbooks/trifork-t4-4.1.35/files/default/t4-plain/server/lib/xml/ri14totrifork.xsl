<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
<!DOCTYPE trifork-app-conf PUBLIC '-//Trifork Technologies//DTD Trifork System Descriptor1.0//EN' 'http://trifork.com/j2ee/dtds/trifork-app-conf_1_0.dtd'>
-->

<xsl:param name="archive-uri"/>

<xsl:template match="sun-application">
<trifork-app-conf>
<xsl:apply-templates select="security-role-mapping"/>
<xsl:apply-templates select="web"/>
</trifork-app-conf>
</xsl:template>

<xsl:template match="sun-ejb-jar">
<trifork-app-conf>
<xsl:apply-templates select="enterprise-beans"/>
</trifork-app-conf>
</xsl:template>

<xsl:template match="sun-cmp-mappings">
<trifork-app-conf>
<xsl:apply-templates select="sun-cmp-mapping"/>
</trifork-app-conf>
</xsl:template>

<xsl:template match="sun-application-client">
<trifork-app-conf>
<application-client>
<xsl:apply-templates/>
</application-client>
</trifork-app-conf>
</xsl:template>

<xsl:template match="sun-web-app">
<trifork-app-conf>
<web-app>
<xsl:apply-templates select="context-root"/>
<xsl:apply-templates select="env-entry"/>
<xsl:apply-templates select="ejb-ref"/>
<xsl:apply-templates select="resource-ref"/>
<xsl:apply-templates select="resource-env-ref"/>
<xsl:apply-templates select="service-ref"/>
<xsl:apply-templates select="message-destination"/>
<xsl:apply-templates select="webservice-description"/>
</web-app>
</trifork-app-conf>
</xsl:template>

<xsl:template match="sun-connector">
<trifork-app-conf>
<connector>
<jndi-names>
<xsl:for-each select="resource-adapter/@jndi-name">
<jndi-name><xsl:value-of select="name()"/></jndi-name>
</xsl:for-each>
</jndi-names>
</connector>
</trifork-app-conf>
</xsl:template>

<xsl:template match="message-destination">
<message-destination>
<message-destination-name><xsl:value-of select="message-destination-name"/></message-destination-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
</message-destination>
</xsl:template>


<xsl:template match="mdb-resource-adapter">
<activation-config>
  <resource-adapter-name><xsl:value-of select="resource-adapter-mid"/></resource-adapter-name>
  <xsl:for-each select="activation-config/activation-config-property">
  <activation-config-property>
    <activation-config-property-name><xsl:value-of select="activation-config-property-name"/></activation-config-property-name>
    <activation-config-property-value><xsl:value-of select="activation-config-property-value"/></activation-config-property-value>
  </activation-config-property>
  </xsl:for-each>
</activation-config>
</xsl:template>




<xsl:template match="sun-cmp-mapping">
<cmp-mapping>
<xsl:apply-templates select="entity-mapping"/>
</cmp-mapping>
</xsl:template>

<xsl:template match="entity-mapping">
<ejb>
<ejb-name><xsl:value-of select="concat($archive-uri, ejb-name)"/></ejb-name>
<cmp>
<table-name><xsl:value-of select="table-name"/></table-name>
<xsl:apply-templates select="cmp-field-mapping"/>
<create-table-deploy>true</create-table-deploy>
<delete-table-undeploy>true</delete-table-undeploy>
</cmp>
</ejb>
</xsl:template>

<xsl:template match="cmp-field-mapping">
<cmp-field>
<field-name><xsl:value-of select="field-name"/></field-name>
<db-field-name><xsl:value-of select="column-name"/></db-field-name>
</cmp-field>
</xsl:template>


<xsl:template match="enterprise-beans">
<enterprise-beans>
<xsl:apply-templates select="ejb"/>
<xsl:apply-templates select="cmp-resource"/>
<xsl:apply-templates select="message-destination"/>
<xsl:apply-templates select="webservice-description"/>
</enterprise-beans>
</xsl:template>

<xsl:template match="ejb">
<ejb>
<ejb-name><xsl:value-of select="concat($archive-uri, ejb-name)"/></ejb-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
<xsl:apply-templates select="cmp"/>
<xsl:apply-templates select="jms-durable-subscription-name"/>
<xsl:apply-templates select="mdb-connection-factory"/>
<xsl:apply-templates select="ior-security-config"/>
<xsl:apply-templates select="bean-pool"/>
<xsl:apply-templates select="ejb-ref"/>
<xsl:apply-templates select="resource-ref"/>
<xsl:apply-templates select="resource-env-ref"/>
<xsl:apply-templates select="service-ref"/>
<xsl:apply-templates select="webservice-endpoint"/>
<xsl:apply-templates select="mdb-resource-adapter"/>
</ejb>
</xsl:template>

<xsl:template match="cmp-resource">
<cmp-resource>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
<xsl:apply-templates select="default-resource-principal"/>
</cmp-resource>
</xsl:template>

<xsl:template match="default-resource-principal">
<resource-principal>
<principal><xsl:value-of select="name"/></principal>
<password><xsl:value-of select="password"/></password>
</resource-principal>
</xsl:template>

<xsl:template match="resource-env-ref">
<resource-env-ref>
<resource-env-ref-name><xsl:value-of select="resource-env-ref-name"/></resource-env-ref-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
</resource-env-ref>
</xsl:template>

<xsl:template match="resource-ref">
<resource-ref>
<res-ref-name><xsl:value-of select="res-ref-name"/></res-ref-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
<xsl:apply-templates select="default-resource-principal"/>
</resource-ref>
</xsl:template>

<xsl:template match="service-ref">
<service-ref>
<service-ref-name><xsl:value-of select="service-ref-name"/></service-ref-name>
<xsl:copy-of select="port-info"/>
<wsdl-override><xsl:value-of select="wsdl-override"/></wsdl-override>
</service-ref>
</xsl:template>

<xsl:template match="webservice-description">
<webservice-description>
<webservice-description-name><xsl:value-of select="webservice-description-name"/></webservice-description-name>
<wsdl-publish-location><xsl:value-of select="wsdl-publish-location"/></wsdl-publish-location>
</webservice-description>
</xsl:template>

<xsl:template match="webservice-endpoint">
<webservice-endpoint>
<port-component-name><xsl:value-of select="port-component-name"/></port-component-name>
<endpoint-address-uri><xsl:value-of select="endpoint-address-uri"/></endpoint-address-uri>
<xsl:copy-of select="login-config"/>
<transport-guarantee><xsl:value-of select="transport-guarantee"/></transport-guarantee>
</webservice-endpoint>
</xsl:template>


<xsl:template match="ejb-ref">
<ejb-ref>
<ejb-ref-name><xsl:value-of select="ejb-ref-name"/></ejb-ref-name>
<jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
</ejb-ref>
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

<xsl:template match="mdb-connection-factory">
<mdb-connection-factory>
  <jndi-name><xsl:value-of select="jndi-name"/></jndi-name>
</mdb-connection-factory>
</xsl:template>

<xsl:template match="jms-durable-subscription-name">
<mdb-durable-subscription-name><xsl:value-of select="."/></mdb-durable-subscription-name>
</xsl:template>

<xsl:template match="bean-pool">
<xsl:apply-templates select="max-pool-size"/>
<xsl:apply-templates select="steady-pool-size"/>
<xsl:apply-templates select="pool-idle-timeout-in-seconds"/>
</xsl:template>

<xsl:template match="max-pool-size">
<max-pool-size><xsl:value-of select="."/></max-pool-size>
</xsl:template>

<xsl:template match="steady-pool-size">
<default-pool-size><xsl:value-of select="."/></default-pool-size>
</xsl:template>

<xsl:template match="pool-idle-timeout-in-seconds">
<pool-timeout><xsl:value-of select="."/></pool-timeout>
</xsl:template>

<xsl:template match="security-role-mapping">
<role-mapping>
<role>
<xsl:attribute name="name">
<xsl:value-of select="role-name"/>
</xsl:attribute>
<principals>
<xsl:apply-templates select="principal-name"/>
</principals>
</role>
</role-mapping>
</xsl:template>

<xsl:template match="principal-name">
<principal>
<xsl:value-of select="."/>
</principal>
</xsl:template>

<!--
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
-->

<xsl:template match="cmp">
<cmp>
<xsl:apply-templates select="one-one-finders"/>
</cmp>
</xsl:template>

<xsl:template match="one-one-finders">
<xsl:apply-templates select="finder"/>
</xsl:template>

<xsl:template match="finder">
<sql-statement>
<method>
<xsl:apply-templates select="method-name"/>
<xsl:apply-templates select="query-params"/>
</method>
<xsl:apply-templates select="query-filter"/>
<xsl:apply-templates select="query-variables"/>
</sql-statement>
</xsl:template>

<xsl:template match="query-params">
<method-signature>
<xsl:value-of select="."/>
</method-signature>
</xsl:template>

<xsl:template match="query-filter">
<sql>
<xsl:value-of select="."/>
</sql>
</xsl:template>

<xsl:template match="query-variables">
</xsl:template>

<xsl:template match="web">
<web-app>
<uri><xsl:value-of select="web-uri"/></uri>
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
