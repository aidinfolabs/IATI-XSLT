<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="utf8"/>
<xsl:strip-space elements="*"/>

<xsl:template name="add">
  <xsl:param name="value" select="''"/>
  <xsl:param name="quote"><xsl:text>"</xsl:text></xsl:param>
  <xsl:param name="separator"><xsl:text>,</xsl:text></xsl:param>
  <xsl:variable name="doublequote">"</xsl:variable>
  <xsl:value-of select="$quote"/>
  <xsl:value-of select="translate($value,$doublequote,'')"/>
  <xsl:value-of select="$quote"/>
  <xsl:value-of select="$separator"/>
</xsl:template>

<xsl:template name="join" >
  <xsl:param name="values" select="''"/>
  <xsl:param name="quote"><xsl:text>"</xsl:text></xsl:param>
  <xsl:param name="separator"><xsl:text>,</xsl:text></xsl:param>
  <xsl:variable name="doublequote">"</xsl:variable>

  <xsl:value-of select="$quote"/>
  <xsl:for-each select="$values">
    <xsl:choose>
      <xsl:when test="position() = 1">
        <xsl:value-of select="translate(.,$doublequote,'')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate(concat(';',.),$doublequote,'')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
  <xsl:value-of select="$quote"/>
  <xsl:value-of select="$separator"/>
</xsl:template>

<xsl:template match="/">
  <xsl:text>iati-identifier,hierarchy,title,transaction-values-sum,default-currency,transaction-values,transaction-type,transaction-date-text,transaction-date,transaction-value-dates,reporting-org-refs,reporting-orgs,participating-org-refs-funding,participating-orgs-funding,participating-org-refs-extending,participating-orgs-extending,participating-org-refs-accountable,participating-orgs-accountable,participating-org-refs-implementing,participating-orgs-implementing,description,start-planned,start-actual,end-planned,end-actual,activity-status-code,activity-status,policy-markers,policy-marker-vocabulary,policy-marker-significance,policy-marker-codes,contact-organisation,contact-telephone,contact-email,contact-mailing-address,default-tied-status-code,default-tied-status,related-activity-ref,related-activity-type,related-activity
</xsl:text>
  <xsl:for-each select="/iati-activities/iati-activity">

    <!-- iati-identifier -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="iati-identifier"/> </xsl:call-template>

    <!-- hierarchy -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="@hierarchy"/> </xsl:call-template>

    <!-- title -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="title"/> </xsl:call-template>

    <!-- transaction-values-sum -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="sum(transaction/value)"/> <xsl:with-param name="quote"></xsl:with-param> </xsl:call-template>

    <!-- default-currency -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="@default-currency"/> </xsl:call-template>

    <!-- transaction-values -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="transaction/value"/> </xsl:call-template>

    <!-- transaction-type -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="transaction/transaction-type"/> </xsl:call-template>

    <!-- transaction-date-text -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="transaction/transaction-date"/> </xsl:call-template>

    <!-- transaction-date -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="transaction/transaction-date/@iso-date"/> </xsl:call-template>

    <!-- transaction-value-dates -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="transaction/value/@value-date"/> </xsl:call-template>



    <!-- reporting-org-refs -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="reporting-org/@ref"/> </xsl:call-template>

    <!-- reporting-orgs -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="reporting-org"/> </xsl:call-template>

    <!-- Funding: The country or institution which provides the funds. -->
    <!-- http://iatistandard.org/codelists/organisation_role -->
    <!-- participating-org-refs-funding -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Funding']/@ref"/> </xsl:call-template>

    <!-- participating-orgs-funding -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Funding']"/> </xsl:call-template>

    <!-- Extending: The government entity (central, state or local government agency or department), or agency within an institution, financing the activity from its own budget -->
    <!-- http://iatistandard.org/codelists/organisation_role -->
    <!-- participating-org-refs-extending -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Extending']/@ref"/> </xsl:call-template>

    <!-- participating-orgs-extending -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Extending']"/> </xsl:call-template>

    <!-- Accountable: The government agency, civil society or private sector institution which is accountable for the implementation of the activity. -->
    <!-- http://iatistandard.org/codelists/organisation_role -->
    <!-- participating-org-refs-accountable -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Accountable']/@ref"/> </xsl:call-template>

    <!-- participating-orgs-accountable -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Accountable']"/> </xsl:call-template>

    <!-- Implementing: The intermediary between the extending agency and the ultimate beneficiary. Also known as executing agency or channel of delivery. They can be public sector, non-governmental agencies (NGOs), Public-Private partnerships, or multilateral institutions -->
    <!-- http://iatistandard.org/codelists/organisation_role -->
    <!-- participating-org-refs-implementing -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Implementing']/@ref"/> </xsl:call-template>

    <!-- participating-orgs-implementing -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="participating-org[@role='Implementing']"/> </xsl:call-template>

    <!-- description -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="description"/> </xsl:call-template>

    <!-- start-planned -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="activity-date[@type='start-planned']"/> </xsl:call-template>

    <!-- start-actual -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="activity-date[@type='start-actual']"/> </xsl:call-template>

    <!-- end-planned -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="activity-date[@type='end-planned']"/> </xsl:call-template>

    <!-- end-actual -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="activity-date[@type='end-actual']"/> </xsl:call-template>

    <!-- activity-status-code -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="activity-status/@code"/> </xsl:call-template>

    <!-- activity-status -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="activity-status"/> </xsl:call-template>


    <!-- policy-markers -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="policy-marker"/> </xsl:call-template>

    <!-- policy-marker-vocabulary -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="policy-marker/@vocabulary"/> </xsl:call-template>

    <!-- policy-marker-significance -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="policy-marker/@significance"/> </xsl:call-template>

    <!-- policy-marker-codes -->
    <xsl:call-template name="join"> <xsl:with-param name="values" select="policy-marker/@code"/> </xsl:call-template>


    <!-- contact-organisation -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="contact-info/organisation"/> </xsl:call-template>

    <!-- contact-telephone -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="contact-info/telephone"/> </xsl:call-template>

    <!-- contact-email -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="contact-info/email"/> </xsl:call-template>

    <!-- contact-mailing-address -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="contact-info/mailing-address"/> </xsl:call-template>

    <!-- default-tied-status-code -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="default-tied-status/@code"/> </xsl:call-template>

    <!-- default-tied-status -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="default-tied-status"/> </xsl:call-template>

    <!-- related-activity-ref -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="related-activity/@ref"/> </xsl:call-template>

    <!-- related-activity-type -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="related-activity/@type"/> </xsl:call-template>

    <!-- related-activity -->
    <xsl:call-template name="add"> <xsl:with-param name="value" select="related-activity"/> <xsl:with-param name="separator"><xsl:text>,</xsl:text></xsl:with-param> </xsl:call-template>
    <xsl:text>
</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
