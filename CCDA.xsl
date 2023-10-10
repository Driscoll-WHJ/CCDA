<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n1="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc" 	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="#default" xmlns="urn:hl7-org:v3" xmlns:cda="urn:hl7-org:v3" xmlns:gsd="http://aurora.regenstrief.org/GenericXMLSchema" 	xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:xlink="http://www.w3.org/TR/WD-xlink" xmlns:mif="urn:hl7-org:v3/mif" 	>
  <xsl:output method="xml" indent="yes" version ="1.0" omit-xml-declaration="no"  encoding="UTF-8" />
  <!-- global variable title -->
  <!--<xsl:variable name="title">
 <xsl:choose>
 <xsl:when test="string-length(/n1:ClinicalDocument/n1:title) &gt;= 1">
 <xsl:value-of select="/n1:ClinicalDocument/n1:title"/>
 </xsl:when>
 <xsl:when test="/n1:ClinicalDocument/n1:code/@displayName">
 <xsl:value-of select="/n1:ClinicalDocument/n1:code/@displayName"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>Clinical Document</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:variable>-->
  <!-- Main -->
  <xsl:template match="/">
    <ClinicalDocument >
      <xsl:apply-templates select="CCDA"/>
    </ClinicalDocument>
  </xsl:template>
  <!-- produce browser rendered, human readable clinical document -->
  <xsl:template match="CCDA">
    <realmCode code="US"/>
    <typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>
    <templateId root="2.16.840.1.113883.10.20.22.1.1" extension="2015-08-01"/>
    <templateId root="2.16.840.1.113883.10.20.22.1.1"/>
    <templateId root="2.16.840.1.113883.10.20.22.1.2" extension="2015-08-01"/>
    <templateId root="2.16.840.1.113883.10.20.22.1.2"/>
    <!-- Referral Note (V2) template ID -->
    <xsl:if test="IsCCDADS4P = 'true'">
      <templateId root="2.16.840.1.113883.3.3251.1.1" assigningAuthorityName="HL7 Security" />
    </xsl:if>
    <id>
      <xsl:attribute name="root">
        <xsl:value-of select="EHRID"/>
      </xsl:attribute>
      <xsl:attribute name="extension">
        <xsl:value-of select="DocumentID"/>
      </xsl:attribute>
      <xsl:attribute name="assigningAuthorityName">
        <xsl:value-of select="EHRName"/>
      </xsl:attribute>
    </id>
    <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" code="34133-9" displayName="Summarization of episode note"/>
    <title>
      <xsl:value-of select="CCDADisplayName"/>
    </title>
    <effectiveTime>
      <xsl:attribute name="value">
        <xsl:value-of select="CCDAEffectiveTimeValue"/>
      </xsl:attribute>
    </effectiveTime>
    <confidentialityCode codeSystem="2.16.840.1.113883.5.25">
      <xsl:choose>
        <xsl:when test="boolean(IsCCDADS4P) and IsCCDADS4P!='' ">
          <xsl:attribute name="code">
            <xsl:if test="IsCCDADS4P = 'true'">
              <xsl:value-of select="PrivacyMarkingsObj/confidentialityCode"/>
            </xsl:if>
            <xsl:if test="IsCCDADS4P = 'false'">
              <xsl:text>N</xsl:text>
            </xsl:if>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="code">
            <xsl:text>N</xsl:text>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </confidentialityCode>
    <languageCode code="en-US"/>
    <recordTarget>
      <xsl:call-template name="patientRoleObj"/>
    </recordTarget>

    <author>

      <xsl:if test="IsCCDADS4P = 'true'">
        <templateId root="2.16.840.1.113883.3.3251.1.2" assigningAuthorityName="HL7 Security" />
      </xsl:if>

      <xsl:choose>
        <xsl:when test="boolean(author/givenName)">
          <time>
            <xsl:attribute name="value">
              <xsl:value-of select="author/visitDate"/>
            </xsl:attribute>
          </time>
          <assignedAuthor>

            <xsl:if test="IsCCDADS4P = 'true'">
              <templateId root="2.16.840.1.113883.3.3251.1.3" assigningAuthorityName="HL7 Security" />
            </xsl:if>
            <id>
              <xsl:attribute name="root">
                <xsl:value-of select="//EHRID"/>
              </xsl:attribute>
            </id>
            <id  root = "2.16.840.1.113883.4.6">
              <xsl:attribute name="extension">
                <xsl:value-of select="author/providerid"/>
              </xsl:attribute>
            </id>
            <code code = "163WP2201X" codeSystem = "2.16.840.1.113883.6.101" codeSystemName = "NUCC">
              <xsl:if test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                <xsl:attribute name="displayName">
                  <xsl:value-of select="//FacilityAddressObj/name"/>
                </xsl:attribute>
              </xsl:if>              
            </code>
            <addr use = "WP">
              <xsl:call-template name="facilityAddressDetails"/>
            </addr>
            <telecom use = "WP">
              <xsl:choose>
                <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                  <xsl:attribute name="value">
                    <xsl:text>tel:</xsl:text>
                    <xsl:value-of select="//FacilityAddressObj/phone"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
            </telecom>
            <assignedPerson>
              <name>
                <xsl:if test="author/suffix != ''">
                  <suffix>
                    <xsl:value-of select="author/suffix"/>
                  </suffix>
                </xsl:if>
                <xsl:if test="author/prefix != ''">
                  <prefix>
                    <xsl:value-of select="author/prefix"/>
                  </prefix>
                </xsl:if>
                <given>
                  <xsl:value-of select="author/givenName"/>
                </given>
                <family>
                  <xsl:value-of select="author/familyName"/>
                </family>
              </name>
            </assignedPerson>
            <representedOrganization>
              <id>
                <xsl:attribute name="root">
                  <xsl:value-of select="//EHRID"/>
                </xsl:attribute>
              </id>
              <xsl:choose>
                <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                  <name>
                    <xsl:value-of select="//FacilityAddressObj/name"/>
                  </name>
                </xsl:when>
                <xsl:otherwise>
                  <name nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <telecom use="WP">
                <xsl:choose>
                  <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                    <xsl:attribute name="value">
                      <xsl:text>tel:</xsl:text>
                      <xsl:value-of select="//FacilityAddressObj/phone"/>
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </telecom>
              <addr use = "WP">
                <xsl:call-template name="facilityAddressDetails"/>
              </addr>
            </representedOrganization>
          </assignedAuthor>
        </xsl:when>
        <xsl:otherwise>
          <time>
            <xsl:attribute name="value">
              <xsl:value-of select="CCDAEffectiveTimeValue"/>
            </xsl:attribute>
          </time>
          <assignedAuthor>

            <xsl:if test="IsCCDADS4P = 'true'">
              <templateId root="2.16.840.1.113883.3.3251.1.3" assigningAuthorityName="HL7 Security" />
            </xsl:if>

            <id nullFlavor="UNK"/>
            <addr nullFlavor="UNK">
              <streetAddressLine nullFlavor="UNK"/>
              <city nullFlavor="UNK"/>
              <state nullFlavor="UNK"/>
              <postalCode nullFlavor="UNK"/>
              <country nullFlavor="UNK"/>
            </addr>
            <telecom nullFlavor="UNK"/>
            <assignedPerson>
              <name nullFlavor="UNK"/>
            </assignedPerson>
          </assignedAuthor>
        </xsl:otherwise>
      </xsl:choose>
    </author>
    <xsl:if test="boolean(dataEnterer/givenName) = 'true'">
      <xsl:if test ="dataEnterer/givenName[. !='ASKU'] and dataEnterer/givenName[. !='UNK'] and dataEnterer/givenName[. !='']">
        <dataEnterer>
          <assignedEntity>
            <id  root = "2.16.840.1.113883.4.6">
              <xsl:attribute name="extension">
                <xsl:value-of select="dataEnterer/providerid"/>
              </xsl:attribute>
            </id>
            <addr use = "WP">
              <xsl:call-template name="facilityAddressDetails"/>
            </addr>
            <telecom use = "WP">
              <xsl:choose>
                <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                  <xsl:attribute name="value">
                    <xsl:text>tel:</xsl:text>
                    <xsl:value-of select="//FacilityAddressObj/phone"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
            </telecom>
            <assignedPerson>
              <name>
                <xsl:if test="dataEnterer/suffix != ''">
                  <suffix>
                    <xsl:value-of select="dataEnterer/suffix"/>
                  </suffix>
                </xsl:if>
                <xsl:if test="dataEnterer/prefix != ''">
                  <prefix>
                    <xsl:value-of select="dataEnterer/prefix"/>
                  </prefix>
                </xsl:if>
                <given>
                  <xsl:value-of select="dataEnterer/givenName"/>
                </given>
                <family>
                  <xsl:value-of select="dataEnterer/familyName"/>
                </family>
              </name>
            </assignedPerson>
          </assignedEntity>
        </dataEnterer>
      </xsl:if>
    </xsl:if>

    <!--<informant>
      <assignedEntity>
        <id root="2.16.840.1.113883.19.5">
          <xsl:attribute name="extension">
            <xsl:value-of select="dataEnterer/providerid"/>
          </xsl:attribute>
        </id>
        <addr use = "WP">
          <streetAddressLine>
            <xsl:value-of select="FacilityAddressObj/streetAddressLine"/>
          </streetAddressLine>
          <city>
            <xsl:value-of select="FacilityAddressObj/city"/>
          </city>
          <state>
            <xsl:value-of select="FacilityAddressObj/state"/>
          </state>
          <postalCode>
            <xsl:value-of select="FacilityAddressObj/postalCode"/>
          </postalCode>
          <country>
            <xsl:value-of select="FacilityAddressObj/country"/>
          </country>
        </addr>
        <telecom use = "WP">
          <xsl:attribute name="value">
            <xsl:text>tel:</xsl:text><xsl:value-of select="FacilityAddressObj/phone"/>
          </xsl:attribute>
        </telecom>
        <assignedPerson>
          <name>
            <given>
              <xsl:value-of select="dataEnterer/givenName"/>
            </given>
            <family>
              <xsl:value-of select="dataEnterer/familyName"/>
            </family>
          </name>
        </assignedPerson>
      </assignedEntity>
    </informant>-->

    <!--<xsl:if test="boolean(informant/givenName)">
      <informant>
        <relatedEntity classCode="PRS">
          -->
    <!-- classCode PRS represents a person with personal relationship with the patient. -->
    <!--
          <code codeSystem="2.16.840.1.113883.1.11.19563" codeSystemName="Personal Relationship Role Type Value Set">
            <xsl:attribute name="code">
              <xsl:value-of select="informant/RelationCode"/>
            </xsl:attribute>
            <xsl:attribute name="displayName">
              <xsl:value-of select="informant/Relation"/>
            </xsl:attribute>
          </code>
          <relatedPerson>
            <name>
              <given>
                <xsl:value-of select="informant/givenName"/>
              </given>
              <family>
                <xsl:value-of select="informant/familyName"/>
              </family>
            </name>
          </relatedPerson>
        </relatedEntity>
      </informant>
    </xsl:if>-->

    <custodian>
      <xsl:choose>
        <xsl:when test="boolean(FacilityAddressObj/name)">
          <assignedCustodian>
            <representedCustodianOrganization>
              <id>
                <xsl:attribute name="root">
                  <xsl:value-of select="//EHRID"/>
                </xsl:attribute>
              </id>

              <!--<id  root = "2.16.840.1.113883.4.6">
                <xsl:attribute name="extension">
                  <xsl:value-of select="author/providerid"/>
                </xsl:attribute>
              </id>-->
              <xsl:choose>
                <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                  <name>
                    <xsl:value-of select="//FacilityAddressObj/name"/>
                  </name>
                </xsl:when>
                <xsl:otherwise>
                  <name nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <telecom use = "WP">
                <xsl:choose>
                  <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                    <xsl:attribute name="value">
                      <xsl:text>tel:</xsl:text>
                      <xsl:value-of select="//FacilityAddressObj/phone"/>
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </telecom>
              <addr use = "WP">
                <xsl:call-template name="facilityAddressDetails"/>
              </addr>
            </representedCustodianOrganization>
          </assignedCustodian>
        </xsl:when>
        <xsl:otherwise>
          <assignedCustodian>
            <representedCustodianOrganization>
              <id nullFlavor="UNK"/>
              <name nullFlavor="UNK"/>
              <telecom nullFlavor="UNK"/>
              <addr nullFlavor="UNK">
                <streetAddressLine nullFlavor="UNK"/>
                <city nullFlavor="UNK"/>
                <state nullFlavor="UNK"/>
                <postalCode nullFlavor="UNK"/>
                <country nullFlavor="UNK"/>
              </addr>
            </representedCustodianOrganization>
          </assignedCustodian>
        </xsl:otherwise>
      </xsl:choose>
    </custodian>

    <informationRecipient>
      <intendedRecipient>
        <informationRecipient>
          <name>
            <xsl:if test="informationRecepient/suffix != ''">
              <suffix>
                <xsl:value-of select="informationRecepient/suffix"/>
              </suffix>
            </xsl:if>
            <xsl:if test="informationRecepient/prefix != ''">
              <prefix>
                <xsl:value-of select="informationRecepient/prefix"/>
              </prefix>
            </xsl:if>

            <xsl:choose>
              <xsl:when test="informationRecepient/givenName != ''">
                <given>
                  <xsl:value-of select="informationRecepient/givenName"/>
                </given>
              </xsl:when>
              <xsl:otherwise>
                <given nullFlavor="UNK"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="informationRecepient/familyName != ''">
                <family>
                  <xsl:value-of select="informationRecepient/familyName"/>
                </family>
              </xsl:when>
              <xsl:otherwise>
                <family nullFlavor="UNK"/>
              </xsl:otherwise>
            </xsl:choose>
          </name>
        </informationRecipient>
        <receivedOrganization>
          <xsl:choose>
            <xsl:when test="informationRecepient/facilityName != ''">
              <name>
                <xsl:value-of select="informationRecepient/facilityName"/>
              </name>
            </xsl:when>
            <xsl:otherwise>
              <name nullFlavor="UNK"/>
            </xsl:otherwise>
          </xsl:choose>
        </receivedOrganization>
      </intendedRecipient>
    </informationRecipient>

    <!--<legalAuthenticator>
      <time>
        <xsl:attribute name="value">
          <xsl:value-of select="author/visitDate"/>
        </xsl:attribute>
      </time>
      <signatureCode code="S"/>
      <assignedEntity>
        <id  root = "2.16.840.1.113883.4.6">
          <xsl:attribute name="extension">
            <xsl:value-of select="author/providerid"/>
          </xsl:attribute>
        </id>
        <addr use = "WP">
          <streetAddressLine>
            <xsl:value-of select="FacilityAddressObj/streetAddressLine"/>
          </streetAddressLine>
          <city>
            <xsl:value-of select="FacilityAddressObj/city"/>
          </city>
          <state>
            <xsl:value-of select="FacilityAddressObj/state"/>
          </state>
          <postalCode>
            <xsl:value-of select="FacilityAddressObj/postalCode"/>
          </postalCode>
          <country>
            <xsl:value-of select="FacilityAddressObj/country"/>
          </country>
        </addr>
        <telecom use = "WP">
          <xsl:attribute name="value">
            <xsl:text>tel:</xsl:text><xsl:value-of select="FacilityAddressObj/phone"/>
          </xsl:attribute>
        </telecom>
        <assignedPerson>
          <name>
            <xsl:if test="author/suffix != ''">
              <suffix>
                <xsl:value-of select="author/suffix"/>
              </suffix>
            </xsl:if>
            <xsl:if test="author/prefix != ''">
              <prefix>
                <xsl:value-of select="author/prefix"/>
              </prefix>
            </xsl:if>
            <given>
              <xsl:value-of select="author/givenName"/>
            </given>
            <family>
              <xsl:value-of select="author/familyName"/>
            </family>
          </name>
        </assignedPerson>
      </assignedEntity>
    </legalAuthenticator>-->

    <!--<authenticator>
      <time>
        <xsl:attribute name="value">
          <xsl:value-of select="author/visitDate"/>
        </xsl:attribute>
      </time>
      <signatureCode code="S"/>
      <assignedEntity>
        <id  root = "2.16.840.1.113883.4.6">
          <xsl:attribute name="extension">
            <xsl:value-of select="author/providerid"/>
          </xsl:attribute>
        </id>
        <addr use = "WP">
          <streetAddressLine>
            <xsl:value-of select="FacilityAddressObj/streetAddressLine"/>
          </streetAddressLine>
          <city>
            <xsl:value-of select="FacilityAddressObj/city"/>
          </city>
          <state>
            <xsl:value-of select="FacilityAddressObj/state"/>
          </state>
          <postalCode>
            <xsl:value-of select="FacilityAddressObj/postalCode"/>
          </postalCode>
          <country>
            <xsl:value-of select="FacilityAddressObj/country"/>
          </country>
        </addr>
        <telecom use = "WP">
          <xsl:attribute name="value">
            <xsl:text>tel:</xsl:text><xsl:value-of select="FacilityAddressObj/phone"/>
          </xsl:attribute>
        </telecom>
        <assignedPerson>
          <name>
            <xsl:if test="author/suffix != ''">
              <suffix>
                <xsl:value-of select="author/suffix"/>
              </suffix>
            </xsl:if>
            <xsl:if test="author/prefix != ''">
              <prefix>
                <xsl:value-of select="author/prefix"/>
              </prefix>
            </xsl:if>
            <given>
              <xsl:value-of select="author/givenName"/>
            </given>
            <family>
              <xsl:value-of select="author/familyName"/>
            </family>
          </name>
        </assignedPerson>
      </assignedEntity>
    </authenticator>-->

    <!--<xsl:for-each select="participantListObj/Participant">
      <participant typeCode="IND">
        -->
    <!-- patient's grandfather -->
    <!--
        <associatedEntity classCode="PRS">
          <code codeSystem="2.16.840.1.113883.1.11.19563" codeSystemName="Personal Relationship Role Type Value Set">
            <xsl:attribute name="code">
              <xsl:value-of select="RelationCode"/>
            </xsl:attribute>
            <xsl:attribute name="displayName">
              <xsl:value-of select="Relation"/>
            </xsl:attribute>
          </code>
          <addr use="HP">
            <streetAddressLine>
              <xsl:value-of select="//patientAddress/streetAddressLine"/>
            </streetAddressLine>
            <city>
              <xsl:value-of select="//patientAddress/city"/>
            </city>
            <state>
              <xsl:value-of select="//patientAddress/state"/>
            </state>
            <postalCode>
              <xsl:value-of select="//patientAddress/postalCode"/>
            </postalCode>
            <country>
              <xsl:value-of select="//patientAddress/country"/>
            </country>
          </addr>
          <xsl:if test="boolean(//patientAddress/phone)">
            <telecom use="HP">
              <xsl:attribute name="value">
                <xsl:value-of select="//patientAddress/phone"/>
              </xsl:attribute>
            </telecom>
          </xsl:if>
          <xsl:if test="boolean(//patientAddress/mobile)">
            <telecom use="MC">
              <xsl:attribute name="value">
                <xsl:value-of select="//patientAddress/mobile"/>
              </xsl:attribute>
            </telecom>
          </xsl:if>

          <associatedPerson>
            <name>
              <xsl:if test="suffix != ''">
                <suffix>
                  <xsl:value-of select="suffix"/>
                </suffix>
              </xsl:if>
              <xsl:if test="prefix != ''">
                <prefix>
                  <xsl:value-of select="prefix"/>
                </prefix>
              </xsl:if>
              <given>
                <xsl:value-of select="givenName"/>
              </given>
              <family>
                <xsl:value-of select="familyName"/>
              </family>
            </name>
          </associatedPerson>
        </associatedEntity>
      </participant>
    </xsl:for-each>-->

    <xsl:call-template name="documentationOf"/>
    <!--if there is only one encounter then only render this-->
    <xsl:if test="boolean(encounterListObj/Encounter)">
      <xsl:if test="count(encounterListObj/Encounter) = 1 ">
        <componentOf>
          <encompassingEncounter>
            <id>
              <xsl:attribute name="root">
                <xsl:value-of select="//EHRID"/>
              </xsl:attribute>
              <xsl:attribute name="extension">
                <xsl:value-of select="encounterListObj/Encounter/visitID"/>
              </xsl:attribute>

              <xsl:if test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                <xsl:attribute name="assigningAuthorityName">
                  <xsl:value-of select="//FacilityAddressObj/name"/>
                </xsl:attribute>
              </xsl:if>

            </id>
            <code >
              <xsl:choose>
                <xsl:when test="encounterListObj/Encounter/cptCodes != ''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="encounterListObj/Encounter/cptCodes"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>NA</xsl:text>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="encounterListObj/Encounter/text != ''">
                <xsl:attribute name="displayName">
                  <xsl:value-of select="encounterListObj/Encounter/text"/>
                </xsl:attribute>
              </xsl:if>

              <xsl:choose>
                <xsl:when test ="codeSystem != ''">
                  <xsl:attribute name="codeSystem">
                    <xsl:value-of select="codeSystem"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="codeSystem">
                    <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>

            </code>
            <effectiveTime>
              <xsl:choose>
                <xsl:when test ="encounterListObj/Encounter/effectiveTimeLow != ''">
                  <low>
                    <xsl:attribute name="value">
                      <xsl:value-of select="encounterListObj/Encounter/effectiveTimeLow"/>
                    </xsl:attribute>
                  </low>
                </xsl:when>
                <xsl:otherwise>
                  <low nullFlavor="UNK" />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test ="encounterListObj/Encounter/effectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="encounterListObj/Encounter/effectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:when >
                <xsl:otherwise>
                  <high nullFlavor="UNK" />
                </xsl:otherwise>
              </xsl:choose>
            </effectiveTime>
            <xsl:call-template name="componentof"/>
            <location>
              <healthCareFacility>
                <id>
                  <xsl:attribute name="root">
                    <xsl:value-of select="//EHRID"/>
                  </xsl:attribute>
                  <xsl:attribute name="extension">
                    <xsl:value-of select="//EHRID"/>
                  </xsl:attribute>
                  <xsl:if test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                    <xsl:attribute name="assigningAuthorityName">
                      <xsl:value-of select="//FacilityAddressObj/name"/>
                    </xsl:attribute>
                  </xsl:if>                  
                </id>
                <code code="163WP2201X" codeSystem = "2.16.840.1.113883.6.101" codeSystemName = "NUCC" displayName = "Ambulatory Care"/>
                <location>
                  <name>
                    <xsl:choose>
                      <xsl:when test="encounterListObj/Encounter/encounterlocation != ''">
                        <xsl:value-of select="encounterListObj/Encounter/encounterlocation"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="//FacilityAddressObj/name"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </name>
                  <addr>
                    <xsl:choose>
                      <xsl:when test="encounterListObj/Encounter/encounteraddress/streetAddressLine != ''">
                        <streetAddressLine>
                          <xsl:value-of select="encounterListObj/Encounter/encounteraddress/streetAddressLine"/>
                        </streetAddressLine>
                      </xsl:when>
                      <xsl:otherwise>
                        <streetAddressLine nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="encounterListObj/Encounter/encounteraddress/city != ''">
                        <city>
                          <xsl:value-of select="encounterListObj/Encounter/encounteraddress/city"/>
                        </city>
                      </xsl:when>
                      <xsl:otherwise>
                        <city nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="encounterListObj/Encounter/encounteraddress/state != ''">
                        <state>
                          <xsl:value-of select="encounterListObj/Encounter/encounteraddress/state"/>
                        </state>
                      </xsl:when>
                      <xsl:otherwise>
                        <state nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="encounterListObj/Encounter/encounteraddress/postalCode != ''">
                        <postalCode>
                          <xsl:value-of select="encounterListObj/Encounter/encounteraddress/postalCode"/>
                        </postalCode>
                      </xsl:when>
                      <xsl:otherwise>
                        <postalCode nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="encounterListObj/Encounter/encounteraddress/country != ''">
                        <country>
                          <xsl:value-of select="encounterListObj/Encounter/encounteraddress/country"/>
                        </country>
                      </xsl:when>
                      <xsl:otherwise>
                        <country nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </addr>
                </location>
              </healthCareFacility>
            </location>
          </encompassingEncounter>
        </componentOf>
      </xsl:if>
    </xsl:if>

    <component>
      <structuredBody>

        <xsl:if test="IsCCDADS4P = 'true'">
          <component>
            <section>
              <!-- Privacy Markings section template -->
              <templateId root="2.16.840.1.113883.3.3251.1.5" assigningAuthorityName="HL7 Security" />
              <code code="57017-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Privacy policy Organization" />
              <title>Security and Privacy Prohibitions</title>
              <text>
                <xsl:value-of select="PrivacyMarkingsObj/securityprivacytext"/>
              </text>

              <confidentialityCode codeSystem="2.16.840.1.113883.5.25" codeSystemName="HL7 Confidentiality" >
                <xsl:choose>
                  <xsl:when test="PrivacyMarkingsObj/confidentialityCode != ''">
                    <xsl:attribute name="code">
                      <xsl:value-of select="PrivacyMarkingsObj/confidentialityCode"/>
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>NA</xsl:text>
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </confidentialityCode>

              <author>

                <templateId root="2.16.840.1.113883.3.3251.1.2" assigningAuthorityName="HL7 Security" />

                <xsl:choose>
                  <xsl:when test="boolean(author/givenName)">
                    <time>
                      <xsl:attribute name="value">
                        <xsl:value-of select="author/visitDate"/>
                      </xsl:attribute>
                    </time>
                    <assignedAuthor>

                      <templateId root="2.16.840.1.113883.3.3251.1.3" assigningAuthorityName="HL7 Security" />

                      <id root="2.16.840.1.113883.4.6">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="author/providerid"/>
                        </xsl:attribute>
                      </id>

                      <code code="163WP2201X" codeSystem="2.16.840.1.113883.6.101" codeSystemName ="Ambulatory Care">
                      </code>

                      <addr>
                        <xsl:call-template name="facilityAddressDetails"/>
                      </addr>
                      <telecom use="WP">
                        <xsl:choose>
                          <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                            <xsl:attribute name="value">
                              <xsl:text>tel:</xsl:text>
                              <xsl:value-of select="//FacilityAddressObj/phone"/>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="nullFlavor">
                              <xsl:text>UNK</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </telecom>

                      <assignedPerson>
                        <name>
                          <xsl:if test="author/prefix != ''">
                            <prefix>
                              <xsl:value-of select="author/prefix"/>
                            </prefix>
                          </xsl:if>
                          <given>
                            <xsl:value-of select="author/givenName"/>
                          </given>
                          <family>
                            <xsl:value-of select="author/familyName"/>
                          </family>
                        </name>
                      </assignedPerson>

                      <representedOrganization>

                        <id>
                          <xsl:attribute name="root">
                            <xsl:value-of select="//EHRID"/>
                          </xsl:attribute>
                        </id>
                        <xsl:choose>
                          <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                            <name>
                              <xsl:value-of select="//FacilityAddressObj/name"/>
                            </name>
                          </xsl:when>
                          <xsl:otherwise>
                            <name nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>

                      </representedOrganization>
                    </assignedAuthor>
                  </xsl:when>
                  <xsl:otherwise>
                    <time>
                      <xsl:attribute name="value">
                        <xsl:value-of select="CCDAEffectiveTimeValue"/>
                      </xsl:attribute>
                    </time>
                    <assignedAuthor>

                      <templateId root="2.16.840.1.113883.3.3251.1.3" assigningAuthorityName="HL7 Security" />

                      <id nullFlavor="UNK"/>
                      <addr nullFlavor="UNK">
                        <streetAddressLine nullFlavor="UNK"/>
                        <city nullFlavor="UNK"/>
                        <state nullFlavor="UNK"/>
                        <postalCode nullFlavor="UNK"/>
                        <country nullFlavor="UNK"/>
                      </addr>
                      <telecom nullFlavor="UNK"/>
                      <assignedPerson>
                        <name nullFlavor="UNK"/>
                      </assignedPerson>
                    </assignedAuthor>
                  </xsl:otherwise>
                </xsl:choose>

              </author>

              <entry typeCode="COMP">
                <!-- Privacy Marking Entry to indicate the precise/computable security obligations and refrains -->
                <templateId root="2.16.840.1.113883.3.3251.1.9" assigningAuthorityName="HL7 Security" />
                <organizer classCode="CLUSTER" moodCode="EVN">
                  <!-- Privacy Annotations are organized using template "2.16.840.1.113883.3.3251.1.4" -->
                  <templateId root="2.16.840.1.113883.3.3251.1.4" assigningAuthorityName="HL7 Security" />
                  <statusCode code="active" />
                  <component typeCode="COMP">
                    <observation classCode="OBS" moodCode="EVN">
                      <!-- Security Observation -->
                      <templateId root="2.16.840.1.113883.3.445.21" assigningAuthorityName="HL7 CBCC" />
                      <!--  Confidentiality Code template -->
                      <templateId root="2.16.840.1.113883.3.445.12" assigningAuthorityName="HL7 CBCC" />
                      <!-- Confidentiality Security Observation - the only mandatory element of a Privacy Annotation -->
                      <code code="SECCLASSOBS" codeSystem="2.16.840.1.113883.1.11.20457" displayName="Security Classification" codeSystemName="HL7 SecurityObservationTypeCodeSystem" />
                      <!-- value set constrained to "2.16.840.1.113883.1.11.16926" -->
                      <value xsi:type="CE" code="R" codeSystem="2.16.840.1.113883.5.1063" codeSystemName="SecurityObservationValueCodeSystem" displayName="Restricted">
                        <originalText>Restricted Confidentiality</originalText>
                      </value>
                    </observation>
                  </component>
                  <component typeCode="COMP">
                    <observation classCode="OBS" moodCode="EVN">
                      <!-- Security Observation -->
                      <templateId root="2.16.840.1.113883.3.445.21" assigningAuthorityName="HL7 CBCC" />
                      <!--  Refrain Policy Code template -->
                      <templateId root="2.16.840.1.113883.3.445.23" assigningAuthorityName="HL7 CBCC" />
                      <code code="SECCONOBS" codeSystem="2.16.840.1.113883.1.11.20457" displayName="Security Classification" codeSystemName="HL7 SecurityObservationTypeCodeSystem" />
                      <!-- Value set constraint "2.16.840.1.113883.1.11.20446" -->
                      <value xsi:type="CE" code="NORDSLCD" codeSystem="2.16.840.1.113883.5.1063" codeSystemName="SecurityObservationValueCodeSystem" displayName="Prohibition on redisclosure without patient consent directive">
                        <originalText>
                          Prohibition on redisclosure without patient
                          consent directive
                        </originalText>
                      </value>
                    </observation>
                  </component>
                  <component typeCode="COMP">
                    <observation classCode="OBS" moodCode="EVN">
                      <!-- Security Observation -->
                      <templateId root="2.16.840.1.113883.3.445.21" assigningAuthorityName="HL7 CBCC" />
                      <!--  Purpose Of Use Code template -->
                      <templateId root="2.16.840.1.113883.3.445.22" assigningAuthorityName="HL7 CBCC" />
                      <code code="SECCONOBS" codeSystem="2.16.840.1.113883.1.11.20457" displayName="Security Classification" codeSystemName="HL7 SecurityObservationTypeCodeSystem" />
                      <!-- Value set constraint "2.16.840.1.113883.1.11.20448" -->
                      <value xsi:type="CE" code="TREAT" codeSystem="2.16.840.1.113883.5.1063" codeSystemName="SecurityObservationValueCodeSystem" displayName="Treatment">
                        <originalText>
                          Information intended for
                          treatment
                        </originalText>
                      </value>
                    </observation>
                  </component>
                </organizer>
              </entry>

            </section>
          </component>
        </xsl:if>

        <xsl:choose>
          <xsl:when test ="boolean(Chiefcomplaint) and string-length(Chiefcomplaint) > 0">
            <component>
              <section>
                <templateId root = "2.16.840.1.113883.10.20.22.2.13"/>
                <code code = "46239-0" codeSystem = "2.16.840.1.113883.6.1" codeSystemName = "LOINC" displayName = "CHIEF COMPLAINT AND REASON FOR VISIT"/>
                <title>CHIEF COMPLAINT</title>

                <text>
                  <table border = "1" width = "100%">
                    <thead>
                      <tr>
                        <th>Reason for Visit/Chief Complaint</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>
                          <list>
                            <item>
                              <xsl:value-of select="Chiefcomplaint"/>
                            </item>
                          </list>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </text>
              </section>
            </component>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="allergies"/>
        <xsl:call-template name="immunization"/>


        <xsl:call-template name="medication"/>


        <xsl:call-template name="medicationadministered"/>


        <xsl:call-template name="careplan"/>
        <xsl:call-template name="payer"/>

        <xsl:call-template name="assesment"/>
        <xsl:call-template name="healthconcern"/>
        <xsl:call-template name="goals"/>
        <xsl:call-template name="procedures"/>

        <xsl:call-template name="ClinicalNotes">
          <xsl:with-param name="notetype">
            <xsl:value-of select="effectiveTimeLow"/>
            <xsl:text>ProcedureNote</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="notetypedisplay">
            <xsl:text>Procedure Note</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="noteloinc">
            <xsl:text>28570-0</xsl:text>
          </xsl:with-param>
        </xsl:call-template>


        <xsl:call-template name="implants"/>


        <xsl:call-template name="socialhistory"/>


        <xsl:call-template name="vitalsigns"/>
        <xsl:call-template name="familyhistory"/>
        <xsl:call-template name="medicalhistory"/>        


        <xsl:call-template name="encounters"/>

        <xsl:call-template name="results"/>

        <xsl:call-template name="ClinicalNotes">
          <xsl:with-param name="notetype">
            <xsl:text>LaboratoryNarrativeNote</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="notetypedisplay">
            <xsl:text>Laboratory Narrative</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="noteloinc">
            <xsl:text>11502-2</xsl:text>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="ClinicalNotes">
          <xsl:with-param name="notetype">
            <xsl:text>DiagnosticImagingNarrativeNote</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="notetypedisplay">
            <xsl:text>Diagnostic Imaging Narrative</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="noteloinc">
            <xsl:text>18748-4</xsl:text>
          </xsl:with-param>
        </xsl:call-template>


        <xsl:call-template name="problems"/>

        <xsl:call-template name="functionalstatus"/>

        <xsl:choose>
          <xsl:when test="boolean(ReferralListObj/Referral)">
            <component>
              <section>
                <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1" extension="2014-06-09"/>
                <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1"/>
                <code code="42349-1" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="REFERRALS"/>
                <title>REFERRALS</title>
                <xsl:call-template name="referrals"/>
              </section >
            </component >
          </xsl:when>
          <xsl:otherwise>
            <component>
              <section nullFlavor="NI">
                <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1" extension="2014-06-09"/>
                <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1"/>
                <code code="42349-1" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="REFERRALS"/>
                <title>REFERRALS</title>
                <text>Data in this section may be excluded or not available.</text>              
              </section >
            </component >
          </xsl:otherwise>
        </xsl:choose>
        
        
        <xsl:call-template name="dischargeinstructions"/>


        <xsl:call-template name="ClinicalNotes">
          <xsl:with-param name="notetype">
            <xsl:text>ConsultationNote</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="notetypedisplay">
            <xsl:text>Consultation Note</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="noteloinc">
            <xsl:text>11488-4</xsl:text>
          </xsl:with-param>
        </xsl:call-template>


        <xsl:call-template name="ClinicalNotes">
          <xsl:with-param name="notetype">
            <xsl:text>ProgressNote</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="notetypedisplay">
            <xsl:text>Progress Note</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="noteloinc">
            <xsl:text>11506-3</xsl:text>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="ClinicalNotes">
          <xsl:with-param name="notetype">
            <xsl:text>HistoryAndPhysicalNarrativeNote</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="notetypedisplay">
            <xsl:text>History and Physical Note</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="noteloinc">
            <xsl:text>34117-2</xsl:text>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="careteam"/>

      </structuredBody >
    </component >
  </xsl:template>

  <xsl:template name="careteam">
    <xsl:if test ="boolean(careTeamObj/AssignedPerson)">
      <component>
        <section>
          <templateId root="2.16.840.1.113883.10.20.22.2.500" extension="2019-07-01"/>
          <code code="85847-2" codeSystem="2.16.840.1.113883.6.1"/>
          <title>Patient Care Teams</title>
          <text>
            <list>
              <item>
                <content>Care Team</content>
                <table>
                  <thead>
                    <tr>
                      <th>Member</th>
                      <th>Role on Team</th>
                      <th>Date</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="careTeamObj/AssignedPerson">
                      <tr>
                        <td>
                          <xsl:if test="prefix != ''">
                            <xsl:value-of select="prefix"/>
                          </xsl:if><xsl:text> </xsl:text><xsl:value-of select="familyName"/>. <xsl:value-of select="givenName"/> <xsl:text> </xsl:text>

                          <br></br>
                        </td>
                        <td>
                          <xsl:if test="suffix != ''">
                            <xsl:value-of select="suffix"/>
                          </xsl:if>
                        </td>
                        <td>
                          <xsl:value-of select="visitDate"/>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </item>
            </list>

          </text>
          <!--Care Team Organizer-->
          <entry>
            <organizer classCode="CLUSTER" moodCode="EVN">
              <templateId root="2.16.840.1.113883.10.20.22.4.500" extension="2019-07-01"/>
              <!--NEW Care Team Organizer Entry Template ID and extension-->
              <id root="1.1.1.1.1.1"/>
              <code code="86744-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Care Team"></code>
              <!--Care Team Status - https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.1.11.15933/expansion-->
              <statusCode code="active"/>
              <effectiveTime>
                <low>
                  <xsl:attribute name="value">
                    <xsl:value-of select="//birthTime"/>
                  </xsl:attribute>
                </low>
                <high>
                  <xsl:attribute name="value">
                    <xsl:value-of select="//CCDAEffectiveTimeValue"/>
                  </xsl:attribute>
                </high>
              </effectiveTime>
              <xsl:for-each select="careTeamObj/AssignedPerson">
                <component>
                  <act classCode="PCPR" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.500.1" extension="2019-07-01"/>
                    <id root="1.5.5.5.5.5.5"/>
                    <code code="85847-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Care Team Information"/>
                    <!--Care Team Member Status - https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.1.11.15933/expansion-->
                    <statusCode code="active"/>
                    <effectiveTime xsi:type="IVL_TS">
                      <low>
                        <xsl:attribute name="value">
                          <xsl:value-of select="//birthTime"/>
                        </xsl:attribute>
                      </low>
                      <high>
                        <xsl:attribute name="value">
                          <xsl:value-of select="//CCDAEffectiveTimeValue"/>
                        </xsl:attribute>
                      </high>
                    </effectiveTime>
                    <performer typeCode="PRF">
                      <assignedEntity>
                        <id  root = "2.16.840.1.113883.4.6">
                          <xsl:choose>
                            <xsl:when test="boolean(providerid)">
                              <xsl:attribute name="extension">
                                <xsl:value-of select="providerid"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>NA</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:if test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                            <xsl:attribute name="assigningAuthorityName">
                              <xsl:value-of select="//FacilityAddressObj/name"/>
                            </xsl:attribute>
                          </xsl:if>
                        </id>
                        <code code="163WP2201X" displayName="Ambulatory Care" codeSystemName="Provider Codes" codeSystem="2.16.840.1.113883.6.101"/>
                        <addr>
                          <xsl:call-template name="facilityAddressDetails"/>
                        </addr>
                        <telecom use="WP">
                            <xsl:choose>
                              <xsl:when test ="phone != ''">
                                <xsl:attribute name="value">
                                  <xsl:text>tel:</xsl:text>
                                  <xsl:value-of select="phone"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>

                                <xsl:choose>
                                  <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                    <xsl:attribute name="value">
                                      <xsl:text>tel:</xsl:text>
                                      <xsl:value-of select="//FacilityAddressObj/phone"/>
                                    </xsl:attribute>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:attribute name="nullFlavor">
                                      <xsl:text>UNK</xsl:text>
                                    </xsl:attribute>
                                  </xsl:otherwise>
                                </xsl:choose>
                                
                              </xsl:otherwise>
                            </xsl:choose>                          
                        </telecom>
                        <assignedPerson>
                          <name>
                            <xsl:if test="suffix != ''">
                              <suffix>
                                <xsl:value-of select="suffix"/>
                              </suffix>
                            </xsl:if>
                            <xsl:if test="prefix != ''">
                              <prefix>
                                <xsl:value-of select="prefix"/>
                              </prefix>
                            </xsl:if>
                            <given>
                              <xsl:value-of select="givenName"/>
                            </given>
                            <family>
                              <xsl:value-of select="familyName"/>
                            </family>
                          </name>
                        </assignedPerson>
                        <representedOrganization>
                          <id>
                            <xsl:attribute name="root">
                              <xsl:value-of select="//EHRID"/>
                            </xsl:attribute>
                          </id>
                          <xsl:choose>
                            <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                              <name>
                                <xsl:value-of select="//FacilityAddressObj/name"/>
                              </name>
                            </xsl:when>
                            <xsl:otherwise>
                              <name nullFlavor="UNK"/>
                            </xsl:otherwise>
                          </xsl:choose>
                          <telecom use="WP">
                            <xsl:choose>
                              <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                <xsl:attribute name="value">
                                  <xsl:text>tel:</xsl:text>
                                  <xsl:value-of select="//FacilityAddressObj/phone"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>UNK</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                          </telecom>

                          <addr>
                            <xsl:call-template name="facilityAddressDetails"/>
                          </addr>
                        </representedOrganization>
                      </assignedEntity>
                    </performer>
                  </act>
                </component>
              </xsl:for-each >
            </organizer>
          </entry>
        </section>
      </component>
    </xsl:if>
  </xsl:template>

  <xsl:template name="facilityAddressDetails">
    <xsl:choose>
      <xsl:when test="//FacilityAddressObj/streetAddressLine != ''">
        <streetAddressLine>
          <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
        </streetAddressLine>
      </xsl:when>
      <xsl:otherwise>
        <streetAddressLine nullFlavor="UNK"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="//FacilityAddressObj/city != ''">
        <city>
          <xsl:value-of select="//FacilityAddressObj/city"/>
        </city>
      </xsl:when>
      <xsl:otherwise>
        <city nullFlavor="UNK"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="//FacilityAddressObj/state != ''">
        <state>
          <xsl:value-of select="//FacilityAddressObj/state"/>
        </state>
      </xsl:when>
      <xsl:otherwise>
        <state nullFlavor="UNK"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="//FacilityAddressObj/postalCode != ''">
        <postalCode>
          <xsl:value-of select="//FacilityAddressObj/postalCode"/>
        </postalCode>
      </xsl:when>
      <xsl:otherwise>
        <postalCode nullFlavor="UNK"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="//FacilityAddressObj/country != ''">
        <country>
          <xsl:value-of select="//FacilityAddressObj/country"/>
        </country>
      </xsl:when>
      <xsl:otherwise>
        <country nullFlavor="UNK"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="patientRoleObj">
    <xsl:choose>
      <xsl:when test ="boolean(patientRoleObj/patientFirstName)">
        <xsl:for-each select="patientRoleObj">
          <patientRole>
            <!-- CONF 5268-->
            <id>
              <xsl:attribute name="root">
                <xsl:value-of select="../EHRID"/>
              </xsl:attribute>
              <xsl:if test ="mrn ='ASKU'  or mrn = 'UNK' or mrn = ''">
                <xsl:attribute name="nullFlavor">
                  <xsl:text>ASKU</xsl:text>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test ="mrn !='ASKU'  and mrn != 'UNK' and mrn != ''">
                <xsl:attribute name="extension">
                  <xsl:value-of select="mrn"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:attribute name="assigningAuthorityName">
                <xsl:value-of select="../EHRName"/>
              </xsl:attribute>
            </id>
            <addr use="HP">
              <xsl:choose>
                <xsl:when test="//patientAddress/streetAddressLine != ''">
                  <streetAddressLine>
                    <xsl:value-of select="//patientAddress/streetAddressLine"/>
                  </streetAddressLine>
                </xsl:when>
                <xsl:otherwise>
                  <streetAddressLine nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientAddress/city != ''">
                  <city>
                    <xsl:value-of select="//patientAddress/city"/>
                  </city>
                </xsl:when>
                <xsl:otherwise>
                  <city nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientAddress/state != ''">
                  <state>
                    <xsl:value-of select="//patientAddress/state"/>
                  </state>
                </xsl:when>
                <xsl:otherwise>
                  <state nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientAddress/postalCode != ''">
                  <postalCode>
                    <xsl:value-of select="//patientAddress/postalCode"/>
                  </postalCode>
                </xsl:when>
                <xsl:otherwise>
                  <postalCode nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientAddress/country != ''">
                  <country>
                    <xsl:value-of select="//patientAddress/country"/>
                  </country>
                </xsl:when>
                <xsl:otherwise>
                  <country nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
            </addr>
            <addr use="H">
              <xsl:choose>
                <xsl:when test="//patientPreviousAddress/streetAddressLine != ''">
                  <streetAddressLine>
                    <xsl:value-of select="//patientPreviousAddress/streetAddressLine"/>
                  </streetAddressLine>
                </xsl:when>
                <xsl:otherwise>
                  <streetAddressLine nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientPreviousAddress/city != ''">
                  <city>
                    <xsl:value-of select="//patientPreviousAddress/city"/>
                  </city>
                </xsl:when>
                <xsl:otherwise>
                  <city nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientPreviousAddress/state != ''">
                  <state>
                    <xsl:value-of select="//patientPreviousAddress/state"/>
                  </state>
                </xsl:when>
                <xsl:otherwise>
                  <state nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientPreviousAddress/postalCode != ''">
                  <postalCode>
                    <xsl:value-of select="//patientPreviousAddress/postalCode"/>
                  </postalCode>
                </xsl:when>
                <xsl:otherwise>
                  <postalCode nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="//patientPreviousAddress/country != ''">
                  <country>
                    <xsl:value-of select="//patientPreviousAddress/country"/>
                  </country>
                </xsl:when>
                <xsl:otherwise>
                  <country nullFlavor="UNK"/>
                </xsl:otherwise>
              </xsl:choose>
            </addr>
            <xsl:choose>
              <xsl:when test="boolean(//patientAddress/phone)">
                <telecom use="HP">
                  <xsl:attribute name="value">
                    <xsl:text>tel:+1</xsl:text>
                    <xsl:value-of select="//patientAddress/phone"/>
                  </xsl:attribute>
                </telecom>
              </xsl:when>
              <xsl:otherwise>
                <telecom use="HP" nullFlavor="UNK" ></telecom>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="boolean(//patientAddress/mobile)">
              <telecom use="MC">
                <xsl:attribute name="value">
                  <xsl:text>tel:+1</xsl:text>
                  <xsl:value-of select="//patientAddress/mobile"/>
                </xsl:attribute>
              </telecom>
            </xsl:if>
            <xsl:if test="boolean(//patientAddress/workphone)">
              <telecom use="WP">
                <xsl:attribute name="value">
                  <xsl:text>tel:</xsl:text>
                  <xsl:value-of select="//patientAddress/workphone"/>
                </xsl:attribute>
              </telecom>
            </xsl:if>
            <xsl:if test="boolean(//patientAddress/email)">
              <telecom>
                <xsl:attribute name="value">
                  <xsl:text>mailto:</xsl:text>
                  <xsl:value-of select="//patientAddress/email"/>
                </xsl:attribute>
              </telecom>
            </xsl:if>

            <patient>
              <name>
                <!--<xsl:if test="boolean(patientPrefix)">
                  <prefix>
                    <xsl:value-of select="patientPrefix"/>
                  </prefix>
                </xsl:if>-->
                <given>
                  <xsl:value-of select="patientFirstName"/>
                </given>

                <xsl:if test="boolean(patientMiddleName) and patientMiddleName!=''  ">
                  <given>
                    <xsl:value-of select="patientMiddleName"/>
                  </given>
                </xsl:if>

                <family>
                  <xsl:value-of select="patientFamilyName"/>
                </family>

                <xsl:if test="boolean(patientSuffix) and patientSuffix!='' ">
                  <suffix>
                    <xsl:value-of select="patientSuffix"/>
                  </suffix>
                </xsl:if>
              </name>

              <xsl:if test="boolean(patientPreviousName) and patientPreviousName!=''">
                <name>
                  <given  qualifier="BR">
                    <xsl:value-of select="patientPreviousName"/>
                  </given>
                  <family>
                    <xsl:value-of select="patientFamilyName"/>
                  </family>
                </name>
              </xsl:if>

              <administrativeGenderCode codeSystem="2.16.840.1.113883.5.1" >
                <xsl:if test ="administrativeGenderCode='ASKU' or administrativeGenderCode='UNK' or administrativeGenderCode=''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>OTH</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="administrativeGenderCode !='ASKU' and administrativeGenderCode !='UNK' and administrativeGenderCode!=''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="administrativeGenderCode"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="administrativeGenderDisplayName"/>
                </xsl:attribute>
              </administrativeGenderCode>
              <birthTime>
                <xsl:attribute name="value">
                  <xsl:value-of select="birthTime"/>
                </xsl:attribute>
              </birthTime>
              <!--Commented below Lines-->
              <!--          
          <maritalStatusCode codeSystem="2.16.840.1.113883.5.2" 	codeSystemName="MaritalStatusCode">
            <xsl:attribute name="code">
              <xsl:value-of select="maritalStatusCode"/>
            </xsl:attribute>
            <xsl:attribute name="displayName">
              <xsl:value-of select="maritalStatusDisplayName"/>
            </xsl:attribute>
          </maritalStatusCode>

          <religiousAffiliationCode codeSystemName="HL7 Religious Affiliation " 	codeSystem="2.16.840.1.113883.5.1076">
            <xsl:attribute name="code">
              <xsl:value-of select="religiousAffiliationCodeCode"/>
            </xsl:attribute>
            <xsl:attribute name="displayName">
              <xsl:value-of select="religiousAffiliationCodeDisplayName"/>
            </xsl:attribute>
          </religiousAffiliationCode>-->

              <raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                <xsl:if test ="boolean(raceCode) = false or raceCode='ASKU' or raceCode='UNK' or raceCode=''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>ASKU</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="raceCode !='ASKU' and raceCode !='UNK' and raceCode!=''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="raceCode"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="boolean(race) and race !=''">
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="race"/>
                  </xsl:attribute>
                </xsl:if>                
              </raceCode>

              <xsl:if test="boolean(granularRacecode) = 'true'">
                <xsl:if test ="granularRacecode !='ASKU' and granularRacecode !='UNK' and granularRacecode!=''">
                  <sdtc:raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                    <xsl:attribute name="code">
                      <xsl:value-of select="granularRacecode"/>
                    </xsl:attribute>
                    <xsl:attribute name="displayName">
                      <xsl:value-of select="granularRace"/>
                    </xsl:attribute>
                  </sdtc:raceCode>
                </xsl:if>
              </xsl:if>
              <xsl:if test="boolean(additionalraceCode) = 'true'">
                <xsl:if test ="additionalraceCode !='ASKU' and additionalraceCode !='UNK' and additionalraceCode!=''">
                  <raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity" xmlns="urn:hl7-org:sdtc" >
                    <xsl:attribute name="code">
                      <xsl:value-of select="additionalraceCode"/>
                    </xsl:attribute>
                    <xsl:attribute name="displayName">
                      <xsl:value-of select="additionalrace"/>
                    </xsl:attribute>
                  </raceCode>
                </xsl:if>
              </xsl:if>
              <xsl:if test="boolean(additionalgranularRacecode) = 'true'">
                <xsl:if test ="additionalgranularRacecode !='ASKU' and additionalgranularRacecode !='UNK' and additionalgranularRacecode!=''">
                  <sdtc:raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                    <xsl:attribute name="code">
                      <xsl:value-of select="additionalgranularRacecode"/>
                    </xsl:attribute>
                    <xsl:attribute name="displayName">
                      <xsl:value-of select="additionalgranularRace"/>
                    </xsl:attribute>
                  </sdtc:raceCode>
                </xsl:if>
              </xsl:if>



              <ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                <xsl:if test ="boolean(ethnicGroupCode) = false or ethnicGroupCode='ASKU' or ethnicGroupCode='UNK' or ethnicGroupCode=''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>ASKU</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="ethnicGroupCode !='ASKU' and ethnicGroupCode !='UNK' and ethnicGroupCode !=''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="ethnicGroupCode"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="boolean(ethnicGroupCodeDisplayName) and ethnicGroupCodeDisplayName !=''">
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="ethnicGroupCodeDisplayName"/>
                  </xsl:attribute>
                </xsl:if>                          
              </ethnicGroupCode>


              <xsl:if test="boolean(granularethnicGroupCode) = 'true'">
                <xsl:if test ="granularethnicGroupCode !='ASKU' and granularethnicGroupCode !='UNK' and granularethnicGroupCode !=''">
                  <sdtc:ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                    <xsl:attribute name="code">
                      <xsl:value-of select="granularethnicGroupCode"/>
                    </xsl:attribute>
                    <xsl:attribute name="displayName">
                      <xsl:value-of select="granularethnicGroupCodeDisplayName"/>
                    </xsl:attribute>
                  </sdtc:ethnicGroupCode>
                </xsl:if>
              </xsl:if>

              <xsl:if test="boolean(additionalethnicGroupCode) = 'true'">
                <xsl:if test ="additionalethnicGroupCode !='ASKU' and additionalethnicGroupCode !='UNK' and additionalethnicGroupCode !=''">
                  <ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity" xmlns="urn:hl7-org:sdtc">
                    <xsl:attribute name="code">
                      <xsl:value-of select="additionalethnicGroupCode"/>
                    </xsl:attribute>
                    <xsl:attribute name="displayName">
                      <xsl:value-of select="additionalethnicGroupCodeDisplayName"/>
                    </xsl:attribute>
                  </ethnicGroupCode>
                </xsl:if>
              </xsl:if>
              <xsl:if test="boolean(additionalgranularethnicGroupCode) = 'true'">
                <xsl:if test ="additionalgranularethnicGroupCode !='ASKU' and additionalgranularethnicGroupCode !='UNK' and additionalgranularethnicGroupCode !=''">
                  <sdtc:ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                    <xsl:attribute name="code">
                      <xsl:value-of select="additionalgranularethnicGroupCode"/>
                    </xsl:attribute>
                    <xsl:attribute name="displayName">
                      <xsl:value-of select="additionalgranularethnicGroupCodeDisplayName"/>
                    </xsl:attribute>
                  </sdtc:ethnicGroupCode>
                </xsl:if>
              </xsl:if>


              <!--Commented below Lines-->
              <!--<addr use="HP">
            <streetAddressLine>
              <xsl:value-of select="patientAddress/streetAddressLine"/>
            </streetAddressLine>
            <city>
              <xsl:value-of select="patientAddress/city"/>
            </city>
            <state>
              <xsl:value-of select="patientAddress/state"/>
            </state>
            <postalCode>
              <xsl:value-of select="patientAddress/postalCode"/>
            </postalCode>
            <country>
              <xsl:value-of select="patientAddress/country"/>
            </country>
          </addr>
          <telecom value="UNK" use="HP"/>-->
              <!-- FIX the Code System to be 639.2 -->
              <languageCommunication>
                <languageCode>
                  <xsl:choose>
                    <xsl:when test ="boolean(languageCommunication) = false or languageCommunication='ASKU' or languageCommunication='UNK' or languageCommunication=''">

                      <!--<xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
                      </xsl:attribute>-->

                      <xsl:attribute name="code">
                        <xsl:text>en</xsl:text>
                      </xsl:attribute>

                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="code">
                        <xsl:value-of select="languageCommunication"/>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                  <!--Commented below Lines-->
                  <!--<xsl:attribute name="displayName">
                <xsl:value-of select="languageCommunicationDisplayname"/>
              </xsl:attribute>-->
                </languageCode>
              </languageCommunication>
            </patient>
            <xsl:choose>
              <xsl:when test="boolean(../FacilityAddressObj/name)">
                <providerOrganization>
                  <id>
                    <xsl:attribute name="root">
                      <xsl:value-of select="//EHRID"/>
                    </xsl:attribute>
                  </id>

                  <xsl:choose>
                    <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                      <name>
                        <xsl:value-of select="//FacilityAddressObj/name"/>
                      </name>
                    </xsl:when>
                    <xsl:otherwise>
                      <name nullFlavor="UNK"/>
                    </xsl:otherwise>
                  </xsl:choose>
                  <telecom use = "WP">
                    <xsl:choose>
                      <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                        <xsl:attribute name="value">
                          <xsl:text>tel:</xsl:text>
                          <xsl:value-of select="//FacilityAddressObj/phone"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </telecom>
                  <addr use = "WP">
                    <xsl:call-template name="facilityAddressDetails"/>
                  </addr>
                </providerOrganization>
              </xsl:when>
              <xsl:otherwise>
                <providerOrganization>
                  <id>
                    <xsl:attribute name="root">
                      <xsl:value-of select="//EHRID"/>
                    </xsl:attribute>
                  </id>
                  <name nullFlavor="UNK"/>
                  <telecom nullFlavor="UNK"/>
                  <addr nullFlavor="UNK">
                    <streetAddressLine nullFlavor="UNK"/>
                    <city nullFlavor="UNK"/>
                    <state nullFlavor="UNK"/>
                    <postalCode nullFlavor="UNK"/>
                    <country nullFlavor="UNK"/>
                  </addr>
                </providerOrganization>
              </xsl:otherwise>
            </xsl:choose>

          </patientRole>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <patientRole>
          <!-- CONF 5268-->
          <id nullFlavor="UNK"></id>
          <addr nullFlavor="UNK">
            <streetAddressLine nullFlavor="UNK"/>
            <city nullFlavor="UNK"/>
            <state nullFlavor="UNK"/>
            <postalCode nullFlavor="UNK"/>
            <country nullFlavor="UNK"/>
          </addr>
          <telecom nullFlavor="UNK"/>
          <patient>
            <name nullFlavor="UNK">
              <given nullFlavor="UNK"/>
              <family nullFlavor="UNK"/>
            </name>
            <administrativeGenderCode codeSystem="2.16.840.1.113883.5.1" 	nullFlavor="UNK"/>
            <birthTime 	nullFlavor="UNK"/>
            <raceCode codeSystem="2.16.840.1.113883.6.238" 	nullFlavor="UNK"/>
            <ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" nullFlavor="UNK"/>
            <!-- FIX the Code System to be 639.2 -->
            <languageCommunication nullFlavor="UNK">
              <languageCode nullFlavor="UNK"/>
            </languageCommunication>
          </patient>
          <providerOrganization>
            <id nullFlavor="UNK"/>
            <name nullFlavor="UNK"></name>
            <telecom nullFlavor="UNK"/>
            <addr nullFlavor="UNK">
              <streetAddressLine nullFlavor="UNK"/>
              <city nullFlavor="UNK"/>
              <state nullFlavor="UNK"/>
              <postalCode nullFlavor="UNK"/>
              <country nullFlavor="UNK"/>
            </addr>
          </providerOrganization>
        </patientRole>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="componentof">
    <xsl:for-each select="encounterListObj/Encounter/careTeamObj/AssignedPerson">
      <encounterParticipant typeCode="ATND">
        <assignedEntity>
          <id  root = "2.16.840.1.113883.4.6">
            <xsl:choose>
              <xsl:when test="boolean(providerid)">
                <xsl:attribute name="extension">
                  <xsl:value-of select="providerid"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="nullFlavor">
                  <xsl:text>NA</xsl:text>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
              <xsl:attribute name="assigningAuthorityName">
                <xsl:value-of select="//FacilityAddressObj/name"/>
              </xsl:attribute>
            </xsl:if>
          </id>
          <telecom use="WP">
              <xsl:choose>
                <xsl:when test ="phone != ''">
                  <xsl:attribute name="value">
                    <xsl:text>tel:</xsl:text>
                  <xsl:value-of select="phone"/>
                </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                      <xsl:attribute name="value">
                        <xsl:text>tel:</xsl:text>
                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>              
          </telecom>
          <assignedPerson>
            <name>
              <xsl:if test="suffix != ''">
                <suffix>
                  <xsl:value-of select="suffix"/>
                </suffix>
              </xsl:if>
              <xsl:if test="prefix != ''">
                <prefix>
                  <xsl:value-of select="prefix"/>
                </prefix>
              </xsl:if>
              <given>
                <xsl:value-of select="givenName"/>
              </given>
              <family>
                <xsl:value-of select="familyName"/>
              </family>
            </name>
          </assignedPerson>
        </assignedEntity>
      </encounterParticipant>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="documentationOf">
    <xsl:choose>
      <xsl:when test ="boolean(careTeamObj/AssignedPerson)">
        <documentationOf typeCode="DOC">
          <serviceEvent classCode="PCPR">
            <effectiveTime>
              <low>
                <xsl:attribute name="value">
                  <xsl:value-of select="//birthTime"/>
                </xsl:attribute>
              </low>
              <high>
                <xsl:attribute name="value">
                  <xsl:value-of select="//CCDAEffectiveTimeValue"/>
                </xsl:attribute>
              </high>
            </effectiveTime>
            <xsl:for-each select="careTeamObj/AssignedPerson">
              <performer typeCode="PRF">
                <functionCode code="PCP" displayName="Primary Care Provider" codeSystemName="ParticipationFunction" codeSystem="2.16.840.1.113883.5.88">
                  <originalText>Primary Care Provider</originalText>
                </functionCode>
                <assignedEntity>
                  <id  root = "2.16.840.1.113883.4.6">
                    <xsl:choose>
                      <xsl:when test="boolean(providerid)">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="providerid"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>NA</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                      <xsl:attribute name="assigningAuthorityName">
                        <xsl:value-of select="//FacilityAddressObj/name"/>
                      </xsl:attribute>
                    </xsl:if>
                  </id>
                  <code code="163WP2201X" displayName="Ambulatory Care" codeSystemName="Provider Codes" codeSystem="2.16.840.1.113883.6.101"/>
                  <addr>
                    <xsl:call-template name="facilityAddressDetails"/>
                  </addr>
                  <telecom use="WP">
                    <xsl:choose>
                      <xsl:when test ="phone != ''">
                        <xsl:attribute name="value">
                          <xsl:text>tel:</xsl:text>
                          <xsl:value-of select="phone"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                            <xsl:attribute name="value">
                              <xsl:text>tel:</xsl:text>
                              <xsl:value-of select="//FacilityAddressObj/phone"/>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="nullFlavor">
                              <xsl:text>UNK</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                  </telecom>
                  <assignedPerson>
                    <name>
                      <xsl:if test="suffix != ''">
                        <suffix>
                          <xsl:value-of select="suffix"/>
                        </suffix>
                      </xsl:if>
                      <xsl:if test="prefix != ''">
                        <prefix>
                          <xsl:value-of select="prefix"/>
                        </prefix>
                      </xsl:if>
                      <given>
                        <xsl:value-of select="givenName"/>
                      </given>
                      <family>
                        <xsl:value-of select="familyName"/>
                      </family>
                    </name>
                  </assignedPerson>
                  <representedOrganization>
                    <id>
                      <xsl:attribute name="root">
                        <xsl:value-of select="//EHRID"/>
                      </xsl:attribute>
                    </id>
                    <xsl:choose>
                      <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                        <name>
                          <xsl:value-of select="//FacilityAddressObj/name"/>
                        </name>
                      </xsl:when>
                      <xsl:otherwise>
                        <name nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <telecom use="WP">
                      <xsl:choose>
                        <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                          <xsl:attribute name="value">
                            <xsl:text>tel:</xsl:text>
                            <xsl:value-of select="//FacilityAddressObj/phone"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>UNK</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                    </telecom>

                    <addr>
                      <xsl:call-template name="facilityAddressDetails"/>
                    </addr>
                  </representedOrganization>
                </assignedEntity>
              </performer>
            </xsl:for-each >
          </serviceEvent >
        </documentationOf>
      </xsl:when>
      <xsl:otherwise>
        <documentationOf typeCode="DOC">
          <serviceEvent classCode="PCPR">
            <code codeSystem="2.16.840.1.113883.6.12" codeSystemName="CPT4" nullFlavor="UNK" />
            <effectiveTime>
              <low nullFlavor="UNK" />
              <high nullFlavor="UNK" />
            </effectiveTime>
            <performer typeCode="PRF">
              <templateId root="2.16.840.1.113883.10.20.6.2.1"/>
              <functionCode code="PCP" displayName="Primary Care Provider" codeSystemName="ParticipationFunction" codeSystem="2.16.840.1.113883.5.88">
                <originalText>Primary Care Provider</originalText>
              </functionCode>
              <assignedEntity>
                <id nullFlavor="UNK" />
                <code nullFlavor="UNK" displayName="General Physicians" codeSystemName="Provider Codes" codeSystem="2.16.840.1.113883.6.101" />
                <addr nullFlavor="UNK">
                  <streetAddressLine nullFlavor="UNK" />
                  <city nullFlavor="UNK" />
                  <state nullFlavor="UNK" />
                  <postalCode nullFlavor="UNK" />
                  <country nullFlavor="UNK" />
                </addr>
                <telecom nullFlavor="UNK" />
                <assignedPerson>
                  <name nullFlavor="UNK" />
                </assignedPerson>
              </assignedEntity>
            </performer>
          </serviceEvent>
        </documentationOf>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="problems">
    <xsl:choose>
      <xsl:when test="boolean(problemListObj/Problem)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.5.1" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.5.1"/>
            <code code="11450-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="PROBLEM LIST"/>
            <title>PROBLEMS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Problem</th>
                    <th>Effective Dates</th>
                    <th>Problem Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="problemListObj/Problem">
                    <tr>
                      <td>
                        <xsl:value-of select="problemNameDisplayName"/> [Code: <xsl:value-of select="problemNameCode"/>]
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="topLevelEffectiveTimeLow"/>
                          </xsl:with-param>
                        </xsl:call-template >
                        -
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="topLevelEffectiveTimeHigh"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                      <td>
                        <xsl:value-of select="status"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="problemListObj/Problem">
              <entry typeCode="DRIV">
                <act classCode="ACT" moodCode="EVN">
                  <!-- Problem act template -->
                  <templateId root="2.16.840.1.113883.10.20.22.4.3" extension="2015-08-01" />
                  <templateId root="2.16.840.1.113883.10.20.22.4.3"/>
                  <id root="ec8a6ff8-ed4b-4f7e-82c3-e98e58b45de7" >
                    <xsl:attribute name="extension">
                      <xsl:value-of select="id"/>
                    </xsl:attribute>
                  </id>
                  <code code="CONC" codeSystem="2.16.840.1.113883.5.6" displayName="Concern"/>
                  <xsl:if test ="topLevelEffectiveTimeHigh = '' or boolean(topLevelEffectiveTimeHigh) = false">
                    <statusCode code="active"/>
                  </xsl:if>

                  <xsl:if test ="topLevelEffectiveTimeHigh != ''">
                    <statusCode code="completed"/>
                  </xsl:if>
                  <effectiveTime>
                    <xsl:choose>
                      <xsl:when test ="topLevelEffectiveTimeLow != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="topLevelEffectiveTimeLow"/>
                          </xsl:attribute>
                        </low>
                      </xsl:when >
                      <xsl:otherwise>
                        <low nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="topLevelEffectiveTimeHigh != ''">
                        <high>
                          <xsl:attribute name="value">
                            <xsl:value-of select="topLevelEffectiveTimeHigh"/>
                          </xsl:attribute>
                        </high>
                      </xsl:when >
                      <xsl:otherwise>
                        <high nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>
                  <!--<xsl:if test="boolean(author)">
                <author>
                  <xsl:choose>
                    <xsl:when test="boolean(author/givenName)">
                      <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                      <time>
                        <xsl:attribute name="value">
                          <xsl:value-of select="author/visitDate"/>
                        </xsl:attribute>
                      </time>
                      <assignedAuthor>
                        <id  root = "2.16.840.1.113883.4.6">
                          <xsl:attribute name="extension">
                            <xsl:value-of select="author/providerid"/>
                          </xsl:attribute>
                        </id>
                        <addr use = "WP">
                          <xsl:choose>
                            <xsl:when test="//FacilityAddressObj/streetAddressLine != ''">
                              <streetAddressLine>
                                <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
                              </streetAddressLine>
                            </xsl:when>
                            <xsl:otherwise>
                              <streetAddressLine nullFlavor="UNK"/>
                            </xsl:otherwise>
                          </xsl:choose>
                          <city>
                            <xsl:value-of select="//FacilityAddressObj/city"/>
                          </city>
                          <state>
                            <xsl:value-of select="//FacilityAddressObj/state"/>
                          </state>
                          <postalCode>
                            <xsl:value-of select="//FacilityAddressObj/postalCode"/>
                          </postalCode>
                          <country>
                            <xsl:value-of select="//FacilityAddressObj/country"/>
                          </country>
                        </addr>
                        <telecom use = "WP">
                          <xsl:attribute name="value">
                            <xsl:text>tel:</xsl:text>
                            <xsl:value-of select="//FacilityAddressObj/phone"/>
                          </xsl:attribute>
                        </telecom>
                        <assignedPerson>
                          <name>
                            <xsl:if test="author/suffix != ''">
                              <suffix>
                                <xsl:value-of select="author/suffix"/>
                              </suffix>
                            </xsl:if>
                            <xsl:if test="author/prefix != ''">
                              <prefix>
                                <xsl:value-of select="author/prefix"/>
                              </prefix>
                            </xsl:if>
                            <given>
                              <xsl:value-of select="author/givenName"/>
                            </given>
                            <family>
                              <xsl:value-of select="author/familyName"/>
                            </family>
                          </name>
                        </assignedPerson>
                        <representedOrganization>
                          <id root="2.16.840.1.113883.3.441.1.50" extension="300011" />
                          <name>
                            <xsl:value-of select="//FacilityAddressObj/name"/>
                          </name>
                          <telecom use="WP">
                            <xsl:attribute name="value">
                              <xsl:text>tel:</xsl:text>
                              <xsl:value-of select="//FacilityAddressObj/phone"/>
                            </xsl:attribute>
                          </telecom>
                          <addr use = "WP">
                            <xsl:choose>
                              <xsl:when test="//FacilityAddressObj/streetAddressLine != ''">
                                <streetAddressLine>
                                  <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
                                </streetAddressLine>
                              </xsl:when>
                              <xsl:otherwise>
                                <streetAddressLine nullFlavor="UNK"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <city>
                              <xsl:value-of select="//FacilityAddressObj/city"/>
                            </city>
                            <state>
                              <xsl:value-of select="//FacilityAddressObj/state"/>
                            </state>
                            <postalCode>
                              <xsl:value-of select="//FacilityAddressObj/postalCode"/>
                            </postalCode>
                            <country>
                              <xsl:value-of select="//FacilityAddressObj/country"/>
                            </country>
                          </addr>
                        </representedOrganization>
                      </assignedAuthor>
                    </xsl:when>
                    <xsl:otherwise>
                      <author>
                        <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                        <time nullFlavor="UNK" />
                        <assignedAuthor>
                          <id nullFlavor="UNK" />
                          <addr>
                            <streetAddressLine nullFlavor="UNK"/>
                            <city nullFlavor="UNK"/>
                          </addr>
                          <telecom nullFlavor="UNK" />
                        </assignedAuthor>
                      </author>
                    </xsl:otherwise>
                  </xsl:choose>
                </author>
              </xsl:if>-->
                  <entryRelationship typeCode="SUBJ">
                    <observation classCode="OBS" moodCode="EVN">
                      <xsl:if test="boolean(negationInd)">
                        <xsl:if test="negationInd = 'true' or negationInd = 'True' or negationInd = 'TRUE'">
                          <xsl:attribute name="negationInd">
                            <xsl:text>true</xsl:text>
                          </xsl:attribute>
                        </xsl:if>
                      </xsl:if>
                      <!-- Problem observation template -->
                      <templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.4"/>
                      <id root="ab1791b0-5c71-11db-b0de-0800200c9a66">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </id>
                      <code codeSystemName="SNOMED-CT" codeSystem="2.16.840.1.113883.6.96">
                        <!-- This code SHALL contain at least one [1..*] translation, which SHOULD be selected from ValueSet Problem Type (LOINC) -->
                        <!-- Condition seems like the best option: No EXACT requirement was given in the test data -db -->
                        <xsl:choose>
                          <xsl:when test="problemTypeSnomedCode != ''">
                            <xsl:attribute name="code">
                              <xsl:value-of select="problemTypeSnomedCode"/>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="code">
                              <xsl:text>55607006</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                          <xsl:when test="problemTypeDescription != ''">
                            <xsl:attribute name="displayName">
                              <xsl:value-of select="problemTypeDescription"/>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="displayName">
                              <xsl:text>Condition</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>


                        <translation codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" >
                          <xsl:choose>
                            <xsl:when test="problemTypeTranslationLOINCCode != ''">
                              <xsl:attribute name="code">
                                <xsl:value-of select="problemTypeTranslationLOINCCode"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="code">
                                <xsl:text>75323-6</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:choose>
                            <xsl:when test="problemTypeDescription != ''">
                              <xsl:attribute name="displayName">
                                <xsl:value-of select="problemTypeDescription"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="displayName">
                                <xsl:text>Condition</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                        </translation>

                      </code>
                      <!-- commented line below-->
                      <statusCode code="completed"/>

                      <effectiveTime>
                        <xsl:choose>
                          <xsl:when test ="topLevelEffectiveTimeLow != ''">
                            <low>
                              <xsl:attribute name="value">
                                <xsl:value-of select="topLevelEffectiveTimeLow"/>
                              </xsl:attribute>
                            </low>
                          </xsl:when >
                          <xsl:otherwise>
                            <low nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                          <xsl:when test ="topLevelEffectiveTimeHigh != ''">
                            <high>
                              <xsl:attribute name="value">
                                <xsl:value-of select="topLevelEffectiveTimeHigh"/>
                              </xsl:attribute>
                            </high>
                          </xsl:when >
                          <xsl:otherwise>
                            <high nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </effectiveTime>

                      <value xsi:type="CD">

                        <xsl:choose>
                          <xsl:when test="problemNameCode != ''">
                            <xsl:attribute name="code">
                              <xsl:value-of select="problemNameCode"/>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="nullFlavor">
                              <xsl:text>NA</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>

                        <xsl:if test="problemNameDisplayName != ''">
                          <xsl:attribute name="displayName">
                            <xsl:value-of select="problemNameDisplayName"/>
                          </xsl:attribute>
                        </xsl:if>

                        <xsl:choose>
                          <xsl:when test ="codeSystem != ''">
                            <xsl:attribute name="codeSystem">
                              <xsl:value-of select="codeSystem"/>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="codeSystem">
                              <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>

                      </value>

                      <xsl:if test="boolean(author)">
                        <author>
                          <xsl:choose>
                            <xsl:when test="boolean(author/givenName)">
                              <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                              <time>
                                <xsl:attribute name="value">
                                  <xsl:value-of select="author/visitDate"/>
                                </xsl:attribute>
                              </time>
                              <assignedAuthor>
                                <id  root = "2.16.840.1.113883.4.6">
                                  <xsl:attribute name="extension">
                                    <xsl:value-of select="author/providerid"/>
                                  </xsl:attribute>
                                </id>
                                <addr use = "WP">
                                  <xsl:call-template name="facilityAddressDetails"/>
                                </addr>
                                <telecom use = "WP">
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                      <xsl:attribute name="value">
                                        <xsl:text>tel:</xsl:text>
                                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                                      </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:attribute name="nullFlavor">
                                        <xsl:text>UNK</xsl:text>
                                      </xsl:attribute>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </telecom>
                                <assignedPerson>
                                  <name>
                                    <xsl:if test="author/suffix != ''">
                                      <suffix>
                                        <xsl:value-of select="author/suffix"/>
                                      </suffix>
                                    </xsl:if>
                                    <xsl:if test="author/prefix != ''">
                                      <prefix>
                                        <xsl:value-of select="author/prefix"/>
                                      </prefix>
                                    </xsl:if>
                                    <given>
                                      <xsl:value-of select="author/givenName"/>
                                    </given>
                                    <family>
                                      <xsl:value-of select="author/familyName"/>
                                    </family>
                                  </name>
                                </assignedPerson>
                                <representedOrganization>
                                  <id>
                                    <xsl:attribute name="root">
                                      <xsl:value-of select="//EHRID"/>
                                    </xsl:attribute>
                                  </id>
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                      <name>
                                        <xsl:value-of select="//FacilityAddressObj/name"/>
                                      </name>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <name nullFlavor="UNK"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <telecom use="WP">
                                    <xsl:choose>
                                      <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                        <xsl:attribute name="value">
                                          <xsl:text>tel:</xsl:text>
                                          <xsl:value-of select="//FacilityAddressObj/phone"/>
                                        </xsl:attribute>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:attribute name="nullFlavor">
                                          <xsl:text>UNK</xsl:text>
                                        </xsl:attribute>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </telecom>
                                  <addr use = "WP">
                                    <xsl:call-template name="facilityAddressDetails"/>
                                  </addr>
                                </representedOrganization>
                              </assignedAuthor>
                            </xsl:when>
                            <xsl:otherwise>
                              <author>
                                <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                <time nullFlavor="UNK" />
                                <assignedAuthor>
                                  <id nullFlavor="UNK" />
                                  <addr>
                                    <streetAddressLine nullFlavor="UNK"/>
                                    <city nullFlavor="UNK"/>
                                  </addr>
                                  <telecom nullFlavor="UNK" />
                                </assignedAuthor>
                              </author>
                            </xsl:otherwise>
                          </xsl:choose>
                        </author>
                      </xsl:if>
                    </observation>
                  </entryRelationship>
                </act>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section >
            <templateId root="2.16.840.1.113883.10.20.22.2.5.1" extension="2015-08-01" />
            <templateId root="2.16.840.1.113883.10.20.22.2.5.1" />
            <code code="11450-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="PROBLEM LIST" />
            <title>PROBLEMS</title>
            <text>Data in this section may be excluded or not available.</text>
            <entry>
              <act classCode="ACT" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.3" extension="2015-08-01" />
                <templateId root="2.16.840.1.113883.10.20.22.4.3" />
                <id root="2.16.840.1.113883.3.441" extension="c5df6f29978b472f9fd6359c08a65c65" />
                <code code="CONC" codeSystem="2.16.840.1.113883.5.6" />
                <statusCode code="active" />
                <effectiveTime>
                  <low nullFlavor="UNK" />
                  <high nullFlavor="UNK" />
                </effectiveTime>
                <entryRelationship typeCode="SUBJ">
                  <observation classCode="OBS" moodCode="EVN"  negationInd="true">
                    <templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01" />
                    <templateId root="2.16.840.1.113883.10.20.22.4.4" />
                    <id root="2.16.840.1.113883.3.441" extension="c5df6f29978b472f9fd6359c08a65c65" />
                    <code code="55607006" displayName="Condition" codeSystemName="SNOMED-CT" codeSystem="2.16.840.1.113883.6.96">
                      <translation code="75323-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Condition" />
                    </code>
                    <statusCode code="completed" />
                    <effectiveTime>
                      <low nullFlavor="UNK" />
                      <high nullFlavor="UNK" />
                    </effectiveTime>
                    <value xsi:type="CD" code="55607006" displayName="Disease" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" />
                  </observation>
                </entryRelationship>
              </act>
            </entry>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="medicalhistory">
    <xsl:if test="boolean(MedicalHistoryObj/MedicalHistory)">
      <component>
        <section>
          <templateId root="2.16.840.1.113883.10.20.22.2.20" />
          <templateId root="2.16.840.1.113883.10.20.22.2.20" extension="2015-08-01" />
          <id root="F542B71A-4C66-11EC-9DD0-0050568B4ECE" />
          <code code="11348-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF PAST ILLNESS" />
          <title>Resolved Problems</title>

          <text>
            <table border="1" width="100%">
              <thead>
                <tr>
                  <th>Problem</th>
                  <th>Noted Date</th>
                  <th>Resolved Date</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="MedicalHistoryObj/MedicalHistory">
                  <tr>
                    <td>
                      <xsl:value-of select="problemDisplayName"/>
                    </td>
                    <td>
                      <xsl:value-of select="effectiveTimeLow"/>
                    </td>
                    <td>
                      <xsl:value-of select="effectiveTimeHigh"/>
                    </td>                    
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </text>
          <xsl:for-each select="MedicalHistoryObj/MedicalHistory">
            <entry>
              <observation classCode="OBS" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.4" />
                <templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01" />
                <id root="1.2.840.114350.1.13.0.1.7.2.768076" extension="25917" />
                <code code="64572001" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                  <translation code="75323-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
                </code>

                <statusCode>
                  <xsl:choose>
                    <xsl:when test="boolean(status) and status != ''">
                      <xsl:attribute name="code">
                        <xsl:value-of select="status"/>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="code">
                        <xsl:text>completed</xsl:text>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                </statusCode>
                <effectiveTime>
                  <low>
                    <xsl:choose>
                      <xsl:when test="boolean(effectiveTimeLow) and effectiveTimeLow != ''">
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTimeLow"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </low>
                  <high>
                    <xsl:choose>
                      <xsl:when test="boolean(effectiveTimeHigh) and effectiveTimeHigh != ''">
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTimeHigh"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </high>
                </effectiveTime>
                <value codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" xsi:type="CD">
                  <xsl:choose>
                    <xsl:when test="boolean(problemCode) and problemCode != ''">
                      <xsl:attribute name="code">
                        <xsl:value-of select="problemCode"/>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>NA</xsl:text>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="boolean(problemDisplayName) and problemDisplayName != ''">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="problemDisplayName"/>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                  </xsl:choose>
                </value>
                <!-- <entryRelationship typeCode="REFR">
                  <observation classCode="OBS" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.6" />
                    <code code="33999-4" codeSystem="2.16.840.1.113883.6.1" displayName="Status" />
                    <statusCode code="completed" />
                    <effectiveTime>
                      <low value="20100124" />
                      <high value="20151101" />
                    </effectiveTime>
                    <value code="413322009" codeSystem="2.16.840.1.113883.6.96" displayName="Resolved" xsi:type="CD" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" />
                  </observation>
                </entryRelationship> -->
              </observation>
            </entry>
          </xsl:for-each>
        </section>
      </component>
    </xsl:if>
  </xsl:template>
  

  <xsl:template name="familyhistory">
      <xsl:if test="boolean(FamilyHistoryObj/FamilyHistory)">
        <component>
          <section>
            <!-- ** Family history section (V2) ** -->
            <templateId root="2.16.840.1.113883.10.20.22.2.15" extension="2014-06-09" />
            <code code="10157-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
            <title>FAMILY HISTORY</title>
                         
              <text>
                <table border="1" width="100%">
                  <thead>
                    <tr>
                      <th>Relative</th>
                      <th>Diagnosis</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="FamilyHistoryObj/FamilyHistory">
                    <tr>
                      <td>
                        <xsl:value-of select="relatedSubjectCodeDisplayName"/>
                      </td>
                      <td>
                        <xsl:value-of select="observationCodeDisplayName"/>
                      </td>
                    </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </text>

            <xsl:for-each select="FamilyHistoryObj/FamilyHistory">
              <entry typeCode="DRIV">
              <organizer moodCode="EVN" classCode="CLUSTER">
                <!-- * Family history organizer * -->
                <templateId root="2.16.840.1.113883.10.20.22.4.45" extension="2014-06-09" />
                <id root="d42ebf70-5c89-11db-b0de-0855200c9a66" />
                <statusCode code="completed" />
                <subject>
                  <relatedSubject classCode="PRS">
                    <!--<code displayName="aunt" codeSystemName="FamilyRelationshipRoleType" codeSystem="2.16.840.1.113883.5.111"></code>-->

                    <code codeSystem="2.16.840.1.113883.5.111">
                      <!--<xsl:if test ="codeSystem = ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="boolean(codeSystem) = false">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="codeSystem"/>
                        </xsl:attribute>
                      </xsl:if>-->

                      <xsl:choose>
                        <xsl:when test="boolean(relatedSubjectCode) and relatedSubjectCode != ''">
                          <xsl:attribute name="code">
                            <xsl:value-of select="relatedSubjectCode"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>NA</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>

                      <xsl:if test="boolean(relatedSubjectCodeDisplayName) and relatedSubjectCodeDisplayName != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="relatedSubjectCodeDisplayName"/>
                        </xsl:attribute>
                      </xsl:if>
                    </code>                    
                    
                  </relatedSubject>
                </subject>
                <component>
                  <observation classCode="OBS" moodCode="EVN">
                    <xsl:if test="boolean(negationInd)">
                      <xsl:if test="negationInd = 'true' or negationInd = 'True' or negationInd = 'TRUE'">
                        <xsl:attribute name="negationInd">
                          <xsl:text>true</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                    </xsl:if>
                    <!-- * Family history observation * -->
                    <templateId root="2.16.840.1.113883.10.20.22.4.46" extension="2014-06-09" />
                    <id root="d42ebf70-5c89-11db-b0de-0800200c9a66" />
                    <code code="29308-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Diagnosis" />
                    <statusCode code="completed" />
                    <!--<value xsi:type="CD" code="372064008" codeSystem="2.16.840.1.113883.6.96" displayName="Malignant neoplasm of female breast" sdtc:valueSet="2.16.840.1.113883.3.88.12.3221.7.4" />-->

                    <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96" >
                      <xsl:choose>
                        <xsl:when test="boolean(observationCode) and observationCode != ''">
                          <xsl:attribute name="code">
                            <xsl:value-of select="observationCode"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>NA</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>

                      <xsl:if test="boolean(observationCodeDisplayName) and observationCodeDisplayName != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="observationCodeDisplayName"/>
                        </xsl:attribute>
                      </xsl:if>
                    </value>

                  </observation>
                </component>
              </organizer>
            </entry>
            </xsl:for-each>
          </section>
        </component>        
      </xsl:if>
  </xsl:template>

  
  <xsl:template name="encounters">
    <xsl:if test ="boolean(encounterListObj/Encounter)">
      <component>
        <section>
          <templateId root="2.16.840.1.113883.10.20.22.2.22.1" extension="2015-08-01"/>
          <templateId root="2.16.840.1.113883.10.20.22.2.22.1"/>
          <!-- Encounters Section - required entries -->
          <code code="46240-8" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of encounters"/>
          <title>ENCOUNTER DIAGNOSIS</title>
          <text>
            <table border = "1" width = "100%">
              <thead>
                <tr>
                  <th>Encounter Diagnosis</th>
                  <th>Service Location</th>
                  <th>Date</th>
                  <th>Provider</th>
                  <th>Visit Type</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="encounterListObj/Encounter">
                  <tr>
                    <td>
                      <xsl:choose>
                        <xsl:when test="boolean(diagnosisName) and diagnosisName != ''">
                          <xsl:value-of select="diagnosisName"/>[Code:<xsl:value-of select="diagnosisCode"/>]
                        </xsl:when>
                        <xsl:otherwise>
                          No encounter diagnosis available
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                    <td>
                      <xsl:value-of select="encounterlocation"/>
                    </td>
                    <td>
                      <xsl:call-template name="show-time">
                        <xsl:with-param name="datetime">
                          <xsl:value-of select="effectiveTimeLow"/>
                        </xsl:with-param>
                      </xsl:call-template >
                    </td>
                    <td>
                      <xsl:for-each select="careTeamObj/AssignedPerson">
                        <xsl:if test="prefix != ''">
                          <xsl:value-of select="prefix"/>
                        </xsl:if><xsl:text> </xsl:text><xsl:value-of select="familyName"/>. <xsl:value-of select="givenName"/> <xsl:text> </xsl:text><xsl:if test="suffix != ''">
                          (<xsl:value-of select="suffix"/>)
                        </xsl:if>
                        <br></br>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:choose>
                        <xsl:when test="cptCodes != ''">
                          <xsl:value-of select="text"/> <xsl:text> </xsl:text>(<xsl:value-of select="cptCodes"/>)
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </xsl:for-each >
              </tbody>
            </table>
          </text>
          <xsl:for-each select="encounterListObj/Encounter">
            <entry typeCode="DRIV">
              <encounter classCode="ENC" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.49" extension="2015-08-01" />
                <templateId root="2.16.840.1.113883.10.20.22.4.49" />
                <!-- Encounter Activities -->
                <!-- ******** Encounter activity template ******** -->
                <id root="2a620155-9d11-439e-92b3-5d9815ff4de8">
                  <xsl:attribute name="extension">
                    <xsl:value-of select="visitID"/>
                  </xsl:attribute>
                </id>
                <code  codeSystemName="CPT" codeSystem="2.16.840.1.113883.6.12" codeSystemVersion="4">
                  <xsl:choose>
                    <xsl:when test="cptCodes != ''">
                      <xsl:attribute name="code">
                        <xsl:value-of select="cptCodes"/>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>NA</xsl:text>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                </code>
                <effectiveTime>
                  <xsl:choose>
                    <xsl:when test ="effectiveTimeLow != ''">
                      <xsl:attribute name="value">
                        <xsl:value-of select="effectiveTimeLow"/>
                      </xsl:attribute>
                    </xsl:when >
                    <xsl:otherwise>
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>
                </effectiveTime>
                <performer>
                  <assignedEntity>
                    <id  root = "2.16.840.1.113883.4.6">
                      <xsl:attribute name="extension">
                        <xsl:value-of select="careTeamObj/AssignedPerson/providerid"/>
                      </xsl:attribute>
                    </id>
                    <code code="59058001" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="General Physician"/>
                  </assignedEntity>
                </performer>
                <participant typeCode="LOC">
                  <participantRole classCode="SDLOC">
                    <templateId root="2.16.840.1.113883.10.20.22.4.32"/>
                    <!-- Service Delivery Location template -->
                    <code code="1117-1" codeSystem="2.16.840.1.113883.6.259" codeSystemName="HealthcareServiceLocation" >
                      <xsl:if test="encounterlocation != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="encounterlocation"/>
                        </xsl:attribute>
                      </xsl:if>
                    </code>

                    <addr>
                      <streetAddressLine>
                        <xsl:value-of select="encounteraddress/streetAddressLine"/>
                      </streetAddressLine>
                      <city>
                        <xsl:value-of select="encounteraddress/city"/>
                      </city>
                      <state>
                        <xsl:value-of select="encounteraddress/state"/>
                      </state>
                      <postalCode>
                        <xsl:value-of select="encounteraddress/postalCode"/>
                      </postalCode>
                      <country>
                        <xsl:value-of select="encounteraddress/country"/>
                      </country>
                    </addr>

                    <telecom use = "WP">
                      <xsl:attribute name="value">
                        <xsl:text>tel:</xsl:text>
                        <xsl:value-of select="encounteraddress/phone"/>
                      </xsl:attribute>
                    </telecom>


                    <playingEntity classCode="PLC">
                      <name>
                        <xsl:value-of select="encounterlocation"/>
                      </name>
                    </playingEntity>
                  </participantRole>
                </participant>
                <xsl:if test="diagnosisCode != ''">
                  <entryRelationship typeCode="SUBJ">
                    <!-- ** Encounter Diagnosis (V3)** -->
                    <act classCode="ACT" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.22.4.80" extension="2015-08-01"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.80"></templateId>
                      <templateId root="2.16.840.1.113883.10.20.22.4.19"/>
                      <id root="5a784260-6857-4f38-9638-80c751aff2fb"/>
                      <code xsi:type="CE"  code="29308-4" codeSystem="2.16.840.1.113883.6.1"  codeSystemName="LOINC" displayName="ENCOUNTER DIAGNOSIS"/>
                      <effectiveTime>
                        <xsl:choose>
                          <xsl:when test ="effectiveTimeLow != ''">
                            <low>
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTimeLow"/>
                              </xsl:attribute>
                            </low>
                          </xsl:when >
                          <xsl:otherwise>
                            <low nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                          <xsl:when test ="effectiveTimeHigh != ''">
                            <high>
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTimeHigh"/>
                              </xsl:attribute>
                            </high>
                          </xsl:when >
                          <xsl:otherwise>
                            <high nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </effectiveTime>
                      <entryRelationship typeCode="SUBJ" inversionInd="false">
                        <observation classCode="OBS" moodCode="EVN" negationInd="false">
                          <templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01"/>
                          <templateId root="2.16.840.1.113883.10.20.22.4.4"/>
                          <!-- Problem Observation -->
                          <id root="ab1791b0-5c71-11db-b0de-0800200c9a66" >
                            <xsl:attribute name="extension">
                              <xsl:value-of select="visitID"/>
                            </xsl:attribute>
                          </id>
                          <code code="409586006" codeSystem="2.16.840.1.113883.6.96" displayName="Complaint">
                            <translation code="75323-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Condition"/>
                          </code>
                          <statusCode code="completed"/>
                          <effectiveTime>
                            <xsl:choose>
                              <xsl:when test ="effectiveTimeLow != ''">
                                <low>
                                  <xsl:attribute name="value">
                                    <xsl:value-of select="effectiveTimeLow"/>
                                  </xsl:attribute>
                                </low>
                              </xsl:when >
                              <xsl:otherwise>
                                <low nullFlavor="UNK"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                              <xsl:when test ="effectiveTimeHigh != ''">
                                <high>
                                  <xsl:attribute name="value">
                                    <xsl:value-of select="effectiveTimeHigh"/>
                                  </xsl:attribute>
                                </high>
                              </xsl:when >
                              <xsl:otherwise>
                                <high nullFlavor="UNK"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </effectiveTime>
                          <value xsi:type="CD" >
                            <xsl:choose>
                              <xsl:when test="diagnosisCode != ''">
                                <xsl:attribute name="code">
                                  <xsl:value-of select="diagnosisCode"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>NA</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>

                            <xsl:if test="diagnosisName != ''">
                              <xsl:attribute name="displayName">
                                <xsl:value-of select="diagnosisName"/>
                              </xsl:attribute>
                            </xsl:if>

                            <xsl:choose>
                              <xsl:when test ="codeSystem != ''">
                                <xsl:attribute name="codeSystem">
                                  <xsl:value-of select="codeSystem"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="codeSystem">
                                  <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>

                          </value>
                          <xsl:if test="boolean(author)">
                            <author>
                              <xsl:choose>
                                <xsl:when test="boolean(author/givenName)">
                                  <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                  <time>
                                    <xsl:attribute name="value">
                                      <xsl:value-of select="author/visitDate"/>
                                    </xsl:attribute>
                                  </time>
                                  <assignedAuthor>
                                    <id  root = "2.16.840.1.113883.4.6">
                                      <xsl:attribute name="extension">
                                        <xsl:value-of select="author/providerid"/>
                                      </xsl:attribute>
                                    </id>
                                    <addr use = "WP">
                                      <xsl:call-template name="facilityAddressDetails"/>
                                    </addr>
                                    <telecom use = "WP">
                                      <xsl:choose>
                                        <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                          <xsl:attribute name="value">
                                            <xsl:text>tel:</xsl:text>
                                            <xsl:value-of select="//FacilityAddressObj/phone"/>
                                          </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:attribute name="nullFlavor">
                                            <xsl:text>UNK</xsl:text>
                                          </xsl:attribute>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </telecom>
                                    <assignedPerson>
                                      <name>
                                        <xsl:if test="author/suffix != ''">
                                          <suffix>
                                            <xsl:value-of select="author/suffix"/>
                                          </suffix>
                                        </xsl:if>
                                        <xsl:if test="author/prefix != ''">
                                          <prefix>
                                            <xsl:value-of select="author/prefix"/>
                                          </prefix>
                                        </xsl:if>
                                        <given>
                                          <xsl:value-of select="author/givenName"/>
                                        </given>
                                        <family>
                                          <xsl:value-of select="author/familyName"/>
                                        </family>
                                      </name>
                                    </assignedPerson>
                                    <representedOrganization>
                                      <id>
                                        <xsl:attribute name="root">
                                          <xsl:value-of select="//EHRID"/>
                                        </xsl:attribute>
                                      </id>
                                      <xsl:choose>
                                        <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                          <name>
                                            <xsl:value-of select="//FacilityAddressObj/name"/>
                                          </name>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <name nullFlavor="UNK"/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                      <telecom use="WP">
                                        <xsl:choose>
                                          <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                            <xsl:attribute name="value">
                                              <xsl:text>tel:</xsl:text>
                                              <xsl:value-of select="//FacilityAddressObj/phone"/>
                                            </xsl:attribute>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <xsl:attribute name="nullFlavor">
                                              <xsl:text>UNK</xsl:text>
                                            </xsl:attribute>
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </telecom>
                                      <addr use = "WP">
                                        <xsl:call-template name="facilityAddressDetails"/>
                                      </addr>
                                    </representedOrganization>
                                  </assignedAuthor>
                                </xsl:when>
                                <xsl:otherwise>
                                  <author>
                                    <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                    <time nullFlavor="UNK" />
                                    <assignedAuthor>
                                      <id nullFlavor="UNK" />
                                      <addr>
                                        <streetAddressLine nullFlavor="UNK"/>
                                        <city nullFlavor="UNK"/>
                                      </addr>
                                      <telecom nullFlavor="UNK" />
                                    </assignedAuthor>
                                  </author>
                                </xsl:otherwise>
                              </xsl:choose>
                            </author>
                          </xsl:if>
                        </observation>
                      </entryRelationship>
                    </act>
                  </entryRelationship>
                </xsl:if>
              </encounter>
            </entry>
          </xsl:for-each>
        </section >
      </component >
    </xsl:if>
  </xsl:template>
  <xsl:template name="allergies">
    <xsl:choose>
      <xsl:when test ="boolean(allergyListObj/Allergy)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.6.1" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.6.1"/>
            <!-- Alerts section template -->
            <code code="48765-2" codeSystem="2.16.840.1.113883.6.1"/>
            <title>ALLERGIES, ADVERSE REACTIONS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Substance</th>
                    <th>Reaction</th>
                    <th>Severity</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="allergyListObj/Allergy">
                    <!--Commented below Lines-->
                    <!-- Need iterator for algsummary_1 id -->
                    <tr>
                      <td>
                        <xsl:value-of select="participantDisplayName"/> [Code: <xsl:value-of select="participantCode"/>]
                      </td>
                      <td>
                        <xsl:value-of select="reactionValueDisplayName"/>
                      </td>
                      <td>
                        <xsl:choose>
                          <xsl:when test="boolean(severityDisplayName) and severityDisplayName != ''">
                            <xsl:value-of select="severityDisplayName"/>
                          </xsl:when>
                          <xsl:otherwise>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td>
                        <xsl:value-of select="status"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="allergyListObj/Allergy">
              <entry typeCode="DRIV">
                <act classCode="ACT" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.30"/>
                  <!-- ** Allergy problem act ** -->
                  <id root="36e3e930-7b14-11db-9fe1-0800200c9a66" >
                    <xsl:attribute name="extension">
                      <xsl:value-of select="id"/>
                    </xsl:attribute>
                  </id>
                  <code code="48765-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Allergies, adverse reactions, alerts"/>
                  <statusCode code="completed"/>
                  <effectiveTime>
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeLow != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:attribute>
                        </low>
                      </xsl:when >
                      <xsl:otherwise>
                        <low nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeHigh != ''">
                        <high>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeHigh"/>
                          </xsl:attribute>
                        </high>
                      </xsl:when >
                      <xsl:otherwise>
                        <high nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>
                  <!--<xsl:if test="boolean(author)">
                <author>
                  <xsl:choose>
                    <xsl:when test="boolean(author/givenName)">
                      <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                      <time>
                        <xsl:attribute name="value">
                          <xsl:value-of select="author/visitDate"/>
                        </xsl:attribute>
                      </time>
                      <assignedAuthor>
                        <id  root = "2.16.840.1.113883.4.6">
                          <xsl:attribute name="extension">
                            <xsl:value-of select="author/providerid"/>
                          </xsl:attribute>
                        </id>
                        <addr use = "WP">
                          <xsl:choose>
                            <xsl:when test="//FacilityAddressObj/streetAddressLine != ''">
                              <streetAddressLine>
                                <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
                              </streetAddressLine>
                            </xsl:when>
                            <xsl:otherwise>
                              <streetAddressLine nullFlavor="UNK"/>
                            </xsl:otherwise>
                          </xsl:choose>
                          <city>
                            <xsl:value-of select="//FacilityAddressObj/city"/>
                          </city>
                          <state>
                            <xsl:value-of select="//FacilityAddressObj/state"/>
                          </state>
                          <postalCode>
                            <xsl:value-of select="//FacilityAddressObj/postalCode"/>
                          </postalCode>
                          <country>
                            <xsl:value-of select="//FacilityAddressObj/country"/>
                          </country>
                        </addr>
                        <telecom use = "WP">
                          <xsl:attribute name="value">
                            <xsl:text>tel:</xsl:text>
                            <xsl:value-of select="//FacilityAddressObj/phone"/>
                          </xsl:attribute>
                        </telecom>
                        <assignedPerson>
                          <name>
                            <xsl:if test="author/suffix != ''">
                              <suffix>
                                <xsl:value-of select="author/suffix"/>
                              </suffix>
                            </xsl:if>
                            <xsl:if test="author/prefix != ''">
                              <prefix>
                                <xsl:value-of select="author/prefix"/>
                              </prefix>
                            </xsl:if>
                            <given>
                              <xsl:value-of select="author/givenName"/>
                            </given>
                            <family>
                              <xsl:value-of select="author/familyName"/>
                            </family>
                          </name>
                        </assignedPerson>
                        <representedOrganization>
                          <id root="2.16.840.1.113883.3.441.1.50" extension="300011" />
                          <name>
                            <xsl:value-of select="//FacilityAddressObj/name"/>
                          </name>
                          <telecom use="WP">
                            <xsl:attribute name="value">
                              <xsl:text>tel:</xsl:text>
                              <xsl:value-of select="//FacilityAddressObj/phone"/>
                            </xsl:attribute>
                          </telecom>
                          <addr use = "WP">
                            <xsl:choose>
                              <xsl:when test="//FacilityAddressObj/streetAddressLine != ''">
                                <streetAddressLine>
                                  <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
                                </streetAddressLine>
                              </xsl:when>
                              <xsl:otherwise>
                                <streetAddressLine nullFlavor="UNK"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <city>
                              <xsl:value-of select="//FacilityAddressObj/city"/>
                            </city>
                            <state>
                              <xsl:value-of select="//FacilityAddressObj/state"/>
                            </state>
                            <postalCode>
                              <xsl:value-of select="//FacilityAddressObj/postalCode"/>
                            </postalCode>
                            <country>
                              <xsl:value-of select="//FacilityAddressObj/country"/>
                            </country>
                          </addr>
                        </representedOrganization>
                      </assignedAuthor>
                    </xsl:when>
                    <xsl:otherwise>
                      <author>
                        <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                        <time nullFlavor="UNK" />
                        <assignedAuthor>
                          <id nullFlavor="UNK" />
                          <addr>
                            <streetAddressLine nullFlavor="UNK"/>
                            <city nullFlavor="UNK"/>
                          </addr>
                          <telecom nullFlavor="UNK" />
                        </assignedAuthor>
                      </author>
                    </xsl:otherwise>
                  </xsl:choose>
                </author>
              </xsl:if>-->
                  <entryRelationship typeCode="SUBJ">
                    <observation classCode="OBS" moodCode="EVN">
                      <xsl:if test="boolean(negationInd)">
                        <xsl:if test="negationInd = 'true' or negationInd = 'True' or negationInd = 'TRUE'">
                          <xsl:attribute name="negationInd">
                            <xsl:text>true</xsl:text>
                          </xsl:attribute>
                        </xsl:if>
                      </xsl:if>
                      <!-- allergy observation template -->
                      <templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.7"/>
                      <id root="4adc1020-7b14-11db-9fe1-0800200c9a66" >
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </id>
                      <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
                      <statusCode code="completed"/>
                      <effectiveTime>
                        <xsl:choose>
                          <xsl:when test ="effectiveTimeLow != ''">
                            <low>
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTimeLow"/>
                              </xsl:attribute>
                            </low>
                          </xsl:when >
                          <xsl:otherwise>
                            <low nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                          <xsl:when test ="effectiveTimeHigh != ''">
                            <high>
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTimeHigh"/>
                              </xsl:attribute>
                            </high>
                          </xsl:when >
                          <xsl:otherwise>
                            <high nullFlavor="UNK"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </effectiveTime>
                      <value xsi:type="CD" code="419511003" displayName="Propensity to adverse reaction to drug" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"> </value>
                      <xsl:if test="boolean(author)">
                        <author>
                          <xsl:choose>
                            <xsl:when test="boolean(author/givenName)">
                              <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                              <time>
                                <xsl:attribute name="value">
                                  <xsl:value-of select="author/visitDate"/>
                                </xsl:attribute>
                              </time>
                              <assignedAuthor>
                                <id  root = "2.16.840.1.113883.4.6">
                                  <xsl:attribute name="extension">
                                    <xsl:value-of select="author/providerid"/>
                                  </xsl:attribute>
                                </id>
                                <addr use = "WP">
                                  <xsl:call-template name="facilityAddressDetails"/>
                                </addr>
                                <telecom use = "WP">
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                      <xsl:attribute name="value">
                                        <xsl:text>tel:</xsl:text>
                                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                                      </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:attribute name="nullFlavor">
                                        <xsl:text>UNK</xsl:text>
                                      </xsl:attribute>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </telecom>
                                <assignedPerson>
                                  <name>
                                    <xsl:if test="author/suffix != ''">
                                      <suffix>
                                        <xsl:value-of select="author/suffix"/>
                                      </suffix>
                                    </xsl:if>
                                    <xsl:if test="author/prefix != ''">
                                      <prefix>
                                        <xsl:value-of select="author/prefix"/>
                                      </prefix>
                                    </xsl:if>
                                    <given>
                                      <xsl:value-of select="author/givenName"/>
                                    </given>
                                    <family>
                                      <xsl:value-of select="author/familyName"/>
                                    </family>
                                  </name>
                                </assignedPerson>
                                <representedOrganization>
                                  <id>
                                    <xsl:attribute name="root">
                                      <xsl:value-of select="//EHRID"/>
                                    </xsl:attribute>
                                  </id>
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                      <name>
                                        <xsl:value-of select="//FacilityAddressObj/name"/>
                                      </name>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <name nullFlavor="UNK"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <telecom use="WP">
                                    <xsl:choose>
                                      <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                        <xsl:attribute name="value">
                                          <xsl:text>tel:</xsl:text>
                                          <xsl:value-of select="//FacilityAddressObj/phone"/>
                                        </xsl:attribute>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:attribute name="nullFlavor">
                                          <xsl:text>UNK</xsl:text>
                                        </xsl:attribute>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </telecom>
                                  <addr use = "WP">
                                    <xsl:call-template name="facilityAddressDetails"/>
                                  </addr>
                                </representedOrganization>
                              </assignedAuthor>
                            </xsl:when>
                            <xsl:otherwise>
                              <author>
                                <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                <time nullFlavor="UNK" />
                                <assignedAuthor>
                                  <id nullFlavor="UNK" />
                                  <addr>
                                    <streetAddressLine nullFlavor="UNK"/>
                                    <city nullFlavor="UNK"/>
                                  </addr>
                                  <telecom nullFlavor="UNK" />
                                </assignedAuthor>
                              </author>
                            </xsl:otherwise>
                          </xsl:choose>
                        </author>
                      </xsl:if>
                      <participant typeCode="CSM">
                        <participantRole classCode="MANU">
                          <playingEntity classCode="MMAT">
                            <code>
                              <xsl:if test ="boolean(codeSystem) = false">
                                <xsl:attribute name="codeSystem">
                                  <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                                </xsl:attribute>
                              </xsl:if>

                              <xsl:if test ="codeSystem = ''">
                                <xsl:attribute name="codeSystem">
                                  <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                                </xsl:attribute>
                              </xsl:if>
                              <xsl:if test ="codeSystem != ''">
                                <xsl:attribute name="codeSystem">
                                  <xsl:value-of select="codeSystem"/>
                                </xsl:attribute>
                              </xsl:if>


                              <xsl:if test ="boolean(participantCode) = false">
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>NA</xsl:text>
                                </xsl:attribute>
                              </xsl:if>

                              <xsl:if test ="participantCode = ''">
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>NA</xsl:text>
                                </xsl:attribute>
                              </xsl:if>
                              <xsl:if test ="participantCode != ''">
                                <xsl:attribute name="code">
                                  <xsl:value-of select="participantCode"/>
                                </xsl:attribute>
                              </xsl:if>
                              <xsl:if test="participantDisplayName != ''">
                                <xsl:attribute name="displayName">
                                  <xsl:value-of select="participantDisplayName"/>
                                </xsl:attribute>
                              </xsl:if>
                            </code>
                          </playingEntity>
                        </participantRole>
                      </participant>

                      <entryRelationship typeCode="MFST" inversionInd="true">
                        <observation classCode="OBS" moodCode="EVN">
                          <templateId root="2.16.840.1.113883.10.20.22.4.9" extension="2017-09-15"/>
                          <templateId root="2.16.840.1.113883.10.20.22.4.9"/>
                          <!-- Reaction observation template -->
                          <id root="4adc1020-7b14-11db-9fe1-0800200c9a64"/>

                          <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
                          <text>
                            <xsl:value-of select="reactionValueDisplayName"/>
                          </text>
                          <statusCode code="completed"/>
                          <effectiveTime>
                            <xsl:choose>
                              <xsl:when test ="effectiveTimeLow != ''">
                                <low>
                                  <xsl:attribute name="value">
                                    <xsl:value-of select="effectiveTimeLow"/>
                                  </xsl:attribute>
                                </low>
                              </xsl:when >
                              <xsl:otherwise>
                                <low nullFlavor="UNK"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </effectiveTime>


                          <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96">
                            <xsl:choose>
                              <xsl:when test ="reactionValueCode != ''">
                                <xsl:attribute name="code">
                                  <xsl:value-of select="reactionValueCode"/>
                                </xsl:attribute>
                              </xsl:when >
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>UNK</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test ="reactionValueDisplayName != ''">
                              <xsl:attribute name="displayName">
                                <xsl:value-of select="reactionValueDisplayName"/>
                              </xsl:attribute>
                            </xsl:if>
                          </value>

                          <entryRelationship typeCode="SUBJ" inversionInd="true">
                            <observation classCode="OBS" moodCode="EVN">
                              <!-- ** Severity observation ** -->
                              <!-- When the Severity Observation is associated directly with an allergy it characterizes the allergy. 
														 When the Severity Observation is associated with a Reaction Observation it characterizes a Reaction. -->
                              <templateId root="2.16.840.1.113883.10.20.22.4.8" extension="2014-06-09"/>
                              <templateId root="2.16.840.1.113883.10.20.22.4.8"/>
                              <code code="SEV" xsi:type="CE" displayName="Severity Observation" codeSystem="2.16.840.1.113883.5.4" codeSystemName="ActCode"/>

                              <text>
                                <xsl:value-of select="severityDisplayName"/>
                              </text>

                              <statusCode code="completed"/>


                              <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96">

                                <xsl:choose>
                                  <xsl:when test="boolean(severityCode)">
                                    <xsl:if test ="severityCode = ''">
                                      <xsl:attribute name="nullFlavor">
                                        <xsl:text>NA</xsl:text>
                                      </xsl:attribute>
                                    </xsl:if>
                                    <xsl:if test ="severityCode != ''">
                                      <xsl:attribute name="code">
                                        <xsl:value-of select="severityCode"/>
                                      </xsl:attribute>
                                      <xsl:if test="severityDisplayName">
                                        <xsl:attribute name="displayName">
                                          <xsl:value-of select="severityDisplayName"/>
                                        </xsl:attribute>
                                      </xsl:if>
                                    </xsl:if>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:attribute name="nullFlavor">
                                      <xsl:text>NA</xsl:text>
                                    </xsl:attribute>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </value>
                            </observation>
                          </entryRelationship>
                        </observation>
                      </entryRelationship>
                      <!--<entryRelationship typeCode="SUBJ" inversionInd="true">
                    <observation classCode="OBS" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.22.4.28"/>
                      <code code="33999-4" displayName="STATUS" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
                      <text>
                          <xsl:value-of select="status"/>
                      </text>
                      <statusCode code="completed"/>
                      <xsl:if test="status = 'Inactive'">
                        <value xsi:type="CE" code="73425007" codeSystem="2.16.840.1.113883.6.96" displayName="Inactive"/>
                      </xsl:if>
                      <xsl:if test="status = 'Active'">
                        <value xsi:type="CE" code="55561003" codeSystem="2.16.840.1.113883.6.96" displayName="Active"/>
                      </xsl:if>
                    </observation>
                  </entryRelationship>
                  <entryRelationship typeCode="REFR">
                    <act classCode="ACT" moodCode="EVN">
                      <templateId root="1.3.6.1.4.1.19376.1.5.3.1.4.4.1"/>
                      <id extension="a778b36c-2a08-4f41-bc2a-3f29293c4e3c" root="2.201"/>
                      <code nullFlavor="UNK"/>
                    </act>
                  </entryRelationship>-->
                    </observation>
                  </entryRelationship>
                </act>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.6.1" extension="2015-08-01" />
            <templateId root="2.16.840.1.113883.10.20.22.2.6.1" />
            <code code="48765-2" codeSystem="2.16.840.1.113883.6.1" />
            <title>ALLERGIES, ADVERSE REACTIONS</title>
            <text>Data in this section may be excluded or not available.</text>
            <entry>
              <act classCode="ACT" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01" />
                <templateId root="2.16.840.1.113883.10.20.22.4.30" />
                <id root="2.16.840.1.113883.3.441.1.50.300011.51.26562.57" extension="1307" />
                <code code="48765-2" displayName="Allergies, adverse reactions, alerts" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
                <statusCode code="active" />
                <effectiveTime>
                  <low nullFlavor="UNK" />
                  <high nullFlavor="UNK" />
                </effectiveTime>
                <entryRelationship typeCode="SUBJ" negationInd="true">
                  <observation classCode="OBS" moodCode="EVN" negationInd="false">
                    <templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09" />
                    <templateId root="2.16.840.1.113883.10.20.22.4.7" />
                    <id root="2.16.840.1.113883.3.441" extension="03d2b31b04fd4042a24423b657750245" />
                    <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4" />
                    <statusCode code="completed" />
                    <effectiveTime>
                      <low nullFlavor="UNK" />
                      <high nullFlavor="UNK" />
                    </effectiveTime>
                    <value xsi:type="CD" code="419199007" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="Allergy to substance (disorder)" />
                    <participant typeCode="CSM">
                      <participantRole classCode="MANU">
                        <playingEntity classCode="MMAT">
                          <code nullFlavor="NA" />
                        </playingEntity>
                      </participantRole>
                    </participant>
                  </observation>
                </entryRelationship>
              </act>
            </entry>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="medication">
    <xsl:choose>
      <xsl:when test="boolean(medicationListObj/Medication)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.1.1" extension="2014-06-09"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.1.1"/>
            <code code="10160-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF MEDICATION USE"/>
            <title>MEDICATIONS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Medication</th>
                    <th>Start Date</th>
                    <th>Route/Frequency</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="medicationListObj/Medication">
                    <tr>
                      <td>
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/> [Code :<xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>]
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>

                      <td>
                        <xsl:value-of select="routeCodeDisplayName"/>
                        Instructions: <xsl:value-of select="instructions"/>
                        <!--every <xsl:value-of select="effectiveTimePeriodValue"/> <xsl:value-of select="effectiveTimePeriodUnit"/>-->
                      </td>

                      <td>
                        <xsl:text>Active</xsl:text>
                      </td>
                    </tr>
                  </xsl:for-each >
                </tbody>
              </table>
            </text>
            <xsl:for-each select="medicationListObj/Medication">
              <entry typeCode="DRIV">
                <substanceAdministration classCode="SBADM" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.16"/>
                  <!-- ** MEDICATION ACTIVITY -->
                  <id root="cdbd33f0-6cde-11db-9fe1-0800200c9a66" >
                    <!--<xsl:attribute name="extension">
                  <xsl:value-of select="id"/>
                </xsl:attribute>-->
                    <xsl:choose>
                      <xsl:when test ="(boolean(id)) and id != ''">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="extension">
                          <xsl:text>123456789</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>                    
                  </id>
                  <statusCode code="active"/>
                  <effectiveTime xsi:type="IVL_TS">
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeLow != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:attribute>
                        </low>
                      </xsl:when >
                      <xsl:otherwise>
                        <low nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeHigh != ''">
                        <high>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeHigh"/>
                          </xsl:attribute>
                        </high>
                      </xsl:when >
                      <xsl:otherwise>
                        <high nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>
                  <!--Commented below Lines-->
                  <!-- code value and display name cannot be blank-->
                  <xsl:if test ="effectiveTimePeriodValue != ''">

                  </xsl:if>

                  <xsl:if test ="routeCodeDisplayName != ''">
                    <routeCode codeSystem="2.16.840.1.113883.3.26.1.1" codeSystemName="NCI Thesaurus">
                      <xsl:if test ="routeCodeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="routeCodeCode"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test =" (boolean(routeCodeCode) = false) or routeCodeCode = ''">
                        <xsl:choose>
                          <xsl:when test="routeCodeDisplayName = 'ORAL' or routeCodeDisplayName = 'oral'">
                            <xsl:attribute name="code">
                              <xsl:text>C38288</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:when test="routeCodeDisplayName = 'inhl'">
                            <xsl:attribute name="code">
                              <xsl:text>C38216</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                        </xsl:choose>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>NA</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test="routeCodeDisplayName != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="routeCodeDisplayName"/>
                        </xsl:attribute>
                      </xsl:if>
                      <originalText>
                        <xsl:value-of select="routeCodeDisplayName"/>
                      </originalText>
                    </routeCode>
                  </xsl:if>

                  <!--Commented below Lines-->
                  <!-- code value and display name cannot be blank-->

                  <xsl:choose>
                    <xsl:when test ="(boolean(doseQuantityValue)) and doseQuantityValue != ''">
                      <doseQuantity>
                        <xsl:attribute name="value">
                          <xsl:value-of select="doseQuantityValue"/>
                        </xsl:attribute>
                        <!--<xsl:attribute name="unit">
                      <xsl:value-of select="doseQuantityUnit"/>
                    </xsl:attribute>-->
                      </doseQuantity>
                    </xsl:when>
                    <xsl:otherwise>
                      <doseQuantity nullFlavor="UNK"></doseQuantity>
                    </xsl:otherwise>
                  </xsl:choose>

                  <!--Commented below Lines-->
                  <!-- code value and display name cannot be blank-->
                  <xsl:if test =" (boolean(rateQuantityValue)) and rateQuantityValue != ''">
                    <rateQuantity>
                      <xsl:attribute name="value">
                        <xsl:value-of select="rateQuantityValue"/>
                      </xsl:attribute>
                      <xsl:attribute name="unit">
                        <xsl:value-of select="rateQuantityUnit"/>
                      </xsl:attribute>
                    </rateQuantity>
                  </xsl:if>
                  <consumable>
                    <manufacturedProduct classCode="MANU">
                      <templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.23"/>
                      <id root="2a620155-9d11-439e-92b3-5d9815ff4ee8">
                        <!--<xsl:attribute name="extension">
							<xsl:value-of select="id"/>
						</xsl:attribute>-->
                      </id>
                      <manufacturedMaterial>
                        <code>
                          <xsl:choose>
                            <xsl:when test ="manufacturedMaterialObj/codeSystem != ''">
                              <xsl:attribute name="codeSystem">
                                <xsl:value-of select="manufacturedMaterialObj/codeSystem"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="codeSystem">
                                <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:choose>
                            <xsl:when test ="manufacturedMaterialObj/manufacturedMaterialCode != ''">
                              <xsl:attribute name="code">
                                <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>UNK</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:if test ="manufacturedMaterialObj/manufacturedMaterialDisplayName != ''">
                            <xsl:attribute name="displayName">
                              <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/>
                            </xsl:attribute>
                          </xsl:if>
                        </code>
                      </manufacturedMaterial>
                      <manufacturerOrganization>
                        <name>Medication Factory Inc.</name>
                      </manufacturerOrganization>
                    </manufacturedProduct>
                  </consumable>

                  <xsl:if test="boolean(author)">
                    <author>
                      <xsl:choose>
                        <xsl:when test="boolean(author/givenName)">
                          <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                          <time>
                            <xsl:attribute name="value">
                              <xsl:value-of select="author/visitDate"/>
                            </xsl:attribute>
                          </time>
                          <assignedAuthor>
                            <id  root = "2.16.840.1.113883.4.6">
                              <xsl:attribute name="extension">
                                <xsl:value-of select="author/providerid"/>
                              </xsl:attribute>
                            </id>
                            <addr use = "WP">
                              <xsl:call-template name="facilityAddressDetails"/>
                            </addr>
                            <telecom use = "WP">
                              <xsl:choose>
                                <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                  <xsl:attribute name="value">
                                    <xsl:text>tel:</xsl:text>
                                    <xsl:value-of select="//FacilityAddressObj/phone"/>
                                  </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:attribute name="nullFlavor">
                                    <xsl:text>UNK</xsl:text>
                                  </xsl:attribute>
                                </xsl:otherwise>
                              </xsl:choose>
                            </telecom>
                            <assignedPerson>
                              <name>
                                <xsl:if test="author/suffix != ''">
                                  <suffix>
                                    <xsl:value-of select="author/suffix"/>
                                  </suffix>
                                </xsl:if>
                                <xsl:if test="author/prefix != ''">
                                  <prefix>
                                    <xsl:value-of select="author/prefix"/>
                                  </prefix>
                                </xsl:if>
                                <given>
                                  <xsl:value-of select="author/givenName"/>
                                </given>
                                <family>
                                  <xsl:value-of select="author/familyName"/>
                                </family>
                              </name>
                            </assignedPerson>
                            <representedOrganization>
                              <id>
                                <xsl:attribute name="root">
                                  <xsl:value-of select="//EHRID"/>
                                </xsl:attribute>
                              </id>
                              <xsl:choose>
                                <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                  <name>
                                    <xsl:value-of select="//FacilityAddressObj/name"/>
                                  </name>
                                </xsl:when>
                                <xsl:otherwise>
                                  <name nullFlavor="UNK"/>
                                </xsl:otherwise>
                              </xsl:choose>
                              <telecom use="WP">
                                <xsl:choose>
                                  <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                    <xsl:attribute name="value">
                                      <xsl:text>tel:</xsl:text>
                                      <xsl:value-of select="//FacilityAddressObj/phone"/>
                                    </xsl:attribute>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:attribute name="nullFlavor">
                                      <xsl:text>UNK</xsl:text>
                                    </xsl:attribute>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </telecom>
                              <addr use = "WP">
                                <xsl:call-template name="facilityAddressDetails"/>
                              </addr>
                            </representedOrganization>
                          </assignedAuthor>
                        </xsl:when>
                        <xsl:otherwise>
                          <author>
                            <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                            <time nullFlavor="UNK" />
                            <assignedAuthor>
                              <id nullFlavor="UNK" />
                              <addr>
                                <streetAddressLine nullFlavor="UNK"/>
                                <city nullFlavor="UNK"/>
                              </addr>
                              <telecom nullFlavor="UNK" />
                            </assignedAuthor>
                          </author>
                        </xsl:otherwise>
                      </xsl:choose>
                    </author>
                  </xsl:if>

                  <!--<performer>
            <assignedEntity>
              <id nullFlavor="NI"/>
              <addr nullFlavor="UNK"/>
              <telecom nullFlavor="UNK"/>
              <representedOrganization>
                <id root="2.16.840.1.113883.19.5.9999.1393" extension="1016"/>
                <name>Get Well Clinic</name>
                <telecom nullFlavor="UNK"/>
                <addr nullFlavor="UNK"/>
              </representedOrganization>
            </assignedEntity>
          </performer>
          <participant typeCode="CSM">
            <participantRole classCode="MANU">
              <templateId root="2.16.840.1.113883.10.20.22.4.24"/>
              <code code="412307009" displayName="drug vehicle" codeSystem="2.16.840.1.113883.6.96"/>
              <playingEntity classCode="MMAT">

                -->
                  <!--Commented below Lines-->
                  <!--
                -->
                  <!-- Add code and displayName value -->
                  <!--
                <code codeSystem="2.16.840.1.113883.6.88" codeSystemName="RxNorm">
                  <xsl:attribute name="code">
                    <xsl:value-of select="participantPlayingEntityCode"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="participantPlayingEntityDisplayName"/>
                  </xsl:attribute>

                </code>
                <name>
                  <xsl:value-of select="participantPlayingEntityDisplayName"/>
                </name>
              </playingEntity>
            </participantRole>
          </participant>
          <entryRelationship typeCode="RSON">
            <observation classCode="OBS" moodCode="EVN">
              <templateId root="2.16.840.1.113883.10.20.22.4.19"/>
              <id root="db734647-fc99-424c-a864-7e3cda82e703" extension="1017"/>
              <code code="404684003" displayName="Finding" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/>
              <statusCode>
                -->
                  <!--Commented below Lines-->
                  <!--
                -->
                  <!-- Add prope code value -->
                  <!--
                <xsl:attribute name="code">
                  <xsl:value-of select="findingCode"/>
                </xsl:attribute>
              </statusCode>
              <effectiveTime>
                <low nullFlavor="UNK"/>

                <xsl:if test ="findingEffectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="findingEffectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:if >
              </effectiveTime>
              <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96">
                <xsl:attribute name="code">
                  <xsl:value-of select="findingCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="findingDisplayName"/>
                </xsl:attribute>
              </value>
            </observation>
          </entryRelationship>-->
                  <entryRelationship typeCode="REFR">
                    <!--To Identify Status-->
                    <observation classCode="OBS" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.1.47"/>
                      <code code="33999-4" displayName="Status"
                        codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
                      <value xsi:type="CE" code="55561003" displayName="Active"
                        codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                      </value>
                    </observation>
                  </entryRelationship>
                  <entryRelationship typeCode='SUBJ' inversionInd='true'>
                    <act classCode='ACT' moodCode='INT'>
                      <templateId root="2.16.840.1.113883.10.20.22.4.20" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
                      <code code="422037009" displayName="Provider medication administration instructions" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/>
                      <text>
                        <xsl:value-of select="instructions"/>
                      </text>
                      <statusCode code="completed" />
                    </act>
                  </entryRelationship>
                </substanceAdministration>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.1.1" extension="2014-06-09" />
            <templateId root="2.16.840.1.113883.10.20.22.2.1.1" />
            <code code="10160-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF MEDICATION USE" />
            <title>MEDICATIONS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="medicationadministered">
    <xsl:choose>
      <xsl:when test="boolean(medicationAdministedListObj/Medication)">
        <component>
          <section>
            <templateId root = "2.16.840.1.113883.10.20.22.2.38"/>
            <code code = "29549-3" codeSystem = "2.16.840.1.113883.6.1" codeSystemName = "LOINC" displayName = "MEDICATIONS ADMINISTERED"/>
            <title>MEDICATIONS ADMINISTERED DURING VISIT</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Medication</th>
                    <th>Start Date</th>

                    <th>Route/Frequency</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="medicationAdministedListObj/Medication">
                    <tr>
                      <td>
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/>, [Code: <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>]
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>

                      <td>
                        <xsl:value-of select="routeCodeDisplayName"/>
                        Instructions: <xsl:value-of select="instructions"/>
                        <!--every <xsl:value-of select="effectiveTimePeriodValue"/> <xsl:value-of select="effectiveTimePeriodUnit"/>-->
                      </td>

                      <td>
                        <xsl:text>Active</xsl:text>
                      </td>
                    </tr>
                  </xsl:for-each >
                </tbody>
              </table>
            </text>
            <xsl:for-each select="medicationAdministedListObj/Medication">
              <entry typeCode="DRIV">
                <substanceAdministration classCode="SBADM" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.16"/>

                  <!-- ** MEDICATION ACTIVITY -->
                  <id root="cdbd33f0-6cde-11db-9fe1-0800200c9a66" >
                    <!--<xsl:attribute name="extension">
                  <xsl:value-of select="id"/>
                </xsl:attribute>-->
                    <xsl:choose>
                      <xsl:when test ="(boolean(id)) and id != ''">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="extension">
                          <xsl:text>123456789</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </id>
                  <text>
                    <xsl:value-of select="instructions"/>
                  </text>
                  <statusCode code="active"/>
                  <effectiveTime xsi:type="IVL_TS">
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeLow != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:attribute>
                        </low>
                      </xsl:when >
                      <xsl:otherwise>
                        <low nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeHigh != ''">
                        <high>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeHigh"/>
                          </xsl:attribute>
                        </high>
                      </xsl:when >
                      <xsl:otherwise>
                        <high nullFlavor="UNK"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>
                  <!--Commented below Lines-->
                  <!-- code value and display name cannot be blank-->
                  <xsl:if test ="effectiveTimePeriodValue != ''">
                    <effectiveTime xsi:type="PIVL_TS" institutionSpecified="true" operator="A">
                      <period>
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTimePeriodValue"/>
                        </xsl:attribute>
                        <xsl:attribute name="unit">
                          <xsl:value-of select="effectiveTimePeriodUnit"/>
                        </xsl:attribute>
                      </period>
                    </effectiveTime>
                  </xsl:if>
                  <xsl:if test ="routeCodeDisplayName != ''">
                    <routeCode codeSystem="2.16.840.1.113883.3.26.1.1" codeSystemName="NCI Thesaurus">
                      <xsl:if test ="routeCodeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="routeCodeCode"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test =" (boolean(routeCodeCode) = false) or routeCodeCode = ''">
                        <xsl:choose>
                          <xsl:when test="routeCodeDisplayName = 'ORAL' or routeCodeDisplayName = 'oral'">
                            <xsl:attribute name="code">
                              <xsl:text>C38288</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:when test="routeCodeDisplayName = 'inhl'">
                            <xsl:attribute name="code">
                              <xsl:text>C38216</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                        </xsl:choose>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>NA</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test="routeCodeDisplayName != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="routeCodeDisplayName"/>
                        </xsl:attribute>
                      </xsl:if>
                      <originalText>
                        <xsl:value-of select="routeCodeDisplayName"/>
                      </originalText>
                    </routeCode>
                  </xsl:if >

                  <!--Commented below Lines-->
                  <!-- code value and display name cannot be blank-->

                  <xsl:choose>
                    <xsl:when test ="(boolean(doseQuantityValue)) and doseQuantityValue != ''">
                      <doseQuantity>
                        <xsl:attribute name="value">
                          <xsl:value-of select="doseQuantityValue"/>
                        </xsl:attribute>
                        <!--<xsl:attribute name="unit">
                      <xsl:value-of select="doseQuantityUnit"/>
                    </xsl:attribute>-->
                      </doseQuantity>
                    </xsl:when>
                    <xsl:otherwise>
                      <doseQuantity nullFlavor="UNK"></doseQuantity>
                    </xsl:otherwise>
                  </xsl:choose>

                  <!--Commented below Lines-->
                  <!-- code value and display name cannot be blank-->
                  <xsl:if test =" (boolean(rateQuantityValue)) and rateQuantityValue != ''">
                    <rateQuantity>
                      <xsl:attribute name="value">
                        <xsl:value-of select="rateQuantityValue"/>
                      </xsl:attribute>
                      <xsl:attribute name="unit">
                        <xsl:value-of select="rateQuantityUnit"/>
                      </xsl:attribute>
                    </rateQuantity>
                  </xsl:if>
                  <consumable>
                    <manufacturedProduct classCode="MANU">
                      <templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.23"/>
                      <id root="2a620155-9d11-439e-92b3-5d9815ff4ee8"/>
                      <manufacturedMaterial>
                        <code>
                          <xsl:choose>
                            <xsl:when test ="manufacturedMaterialObj/codeSystem != ''">
                              <xsl:attribute name="codeSystem">
                                <xsl:value-of select="manufacturedMaterialObj/codeSystem"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="codeSystem">
                                <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:choose>
                            <xsl:when test ="manufacturedMaterialObj/manufacturedMaterialCode != ''">
                              <xsl:attribute name="code">
                                <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>UNK</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:if test ="manufacturedMaterialObj/manufacturedMaterialDisplayName != ''">
                            <xsl:attribute name="displayName">
                              <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/>
                            </xsl:attribute>
                          </xsl:if>
                        </code>
                      </manufacturedMaterial>
                      <manufacturerOrganization>
                        <name>Medication Factory Inc.</name>
                      </manufacturerOrganization>
                    </manufacturedProduct>
                  </consumable>
                  <!--<performer>
            <assignedEntity>
              <id nullFlavor="NI"/>
              <addr nullFlavor="UNK"/>
              <telecom nullFlavor="UNK"/>
              <representedOrganization>
                <id root="2.16.840.1.113883.19.5.9999.1393" extension="1016"/>
                <name>Get Well Clinic</name>
                <telecom nullFlavor="UNK"/>
                <addr nullFlavor="UNK"/>
              </representedOrganization>
            </assignedEntity>
          </performer>
          <participant typeCode="CSM">
            <participantRole classCode="MANU">
              <templateId root="2.16.840.1.113883.10.20.22.4.24"/>
              <code code="412307009" displayName="drug vehicle" codeSystem="2.16.840.1.113883.6.96"/>
              <playingEntity classCode="MMAT">

                -->
                  <!--Commented below Lines-->
                  <!--
                -->
                  <!-- Add code and displayName value -->
                  <!--
                <code codeSystem="2.16.840.1.113883.6.88" codeSystemName="RxNorm">
                  <xsl:attribute name="code">
                    <xsl:value-of select="participantPlayingEntityCode"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="participantPlayingEntityDisplayName"/>
                  </xsl:attribute>

                </code>
                <name>
                  <xsl:value-of select="participantPlayingEntityDisplayName"/>
                </name>
              </playingEntity>
            </participantRole>
          </participant>
          <entryRelationship typeCode="RSON">
            <observation classCode="OBS" moodCode="EVN">
              <templateId root="2.16.840.1.113883.10.20.22.4.19"/>
              <id root="db734647-fc99-424c-a864-7e3cda82e703" extension="1017"/>
              <code code="404684003" displayName="Finding" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/>
              <statusCode>
                -->
                  <!--Commented below Lines-->
                  <!--
                -->
                  <!-- Add prope code value -->
                  <!--
                <xsl:attribute name="code">
                  <xsl:value-of select="findingCode"/>
                </xsl:attribute>
              </statusCode>
              <effectiveTime>
                <low nullFlavor="UNK"/>

                <xsl:if test ="findingEffectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="findingEffectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:if >
              </effectiveTime>
              <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96">
                <xsl:attribute name="code">
                  <xsl:value-of select="findingCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="findingDisplayName"/>
                </xsl:attribute>
              </value>
            </observation>
          </entryRelationship>-->
                  <entryRelationship typeCode="REFR">
                    <!--To Identify Status-->
                    <observation classCode="OBS" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.1.47"/>
                      <code code="33999-4" displayName="Status"
                        codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
                      <value xsi:type="CE" code="55561003" displayName="Active"
                        codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                      </value>
                    </observation>
                  </entryRelationship>
                  <entryRelationship typeCode='SUBJ' inversionInd='true'>
                    <act classCode='ACT' moodCode='INT'>
                      <templateId root="2.16.840.1.113883.10.20.22.4.20" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
                      <code code="422037009" displayName="Provider medication administration instructions" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/>
                      <text>
                        <xsl:value-of select="instructions"/>
                      </text>
                      <statusCode code="completed" />
                    </act>
                  </entryRelationship>


                </substanceAdministration>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.38" />
            <code code="29549-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="MEDICATIONS ADMINISTERED" />
            <title>MEDICATIONS ADMINISTERED DURING VISIT</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="results">
    <xsl:choose>
      <xsl:when test="boolean(resultListObj/Result)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.3.1" extension="2015-08-01"/>
            <templateId root = "2.16.840.1.113883.10.20.22.2.3.1"/>
            <code code = "30954-2" codeSystem = "2.16.840.1.113883.6.1" codeSystemName = "LOINC" displayName = "RESULTS"/>
            <title>RESULTS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Actual Result</th>
                    <th>Date</th>
                    <th>Notes</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="resultListObj/Result">

                    <tr>
                      <td colspan="4">
                        Lab Order: <xsl:value-of select="codeDisplayName"/> <xsl:text> : </xsl:text>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <!--<xsl:value-of select="resultObs/ResultObs[1]/effectiveTime"/>-->
                            <xsl:value-of select="effectiveTime"/>
                          </xsl:with-param>
                        </xsl:call-template >
                        Status: <xsl:choose>
                          <xsl:when test="status != ''">
                            <xsl:value-of select="status"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:text>completed</xsl:text>
                          </xsl:otherwise>
                        </xsl:choose>

                      </td>
                    </tr>

                    <xsl:for-each select="resultObs/ResultObs">
                      <tr>
                        <td>
                          <xsl:value-of select="displayName"/>, [LOINC: <xsl:value-of select="code"/>]
                        </td>
                        <td>
                          <xsl:if test ="valueValue != ''">
                            <xsl:value-of select="valueValue"/> (<xsl:value-of select="valueUnit"/>) ,
                            Status: Completed
                          </xsl:if>
                          <xsl:if test="valueValue = ''">
                            Status: Pending
                          </xsl:if>
                        </td>
                        <td>
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime">
                              <xsl:value-of select="effectiveTime"/>
                            </xsl:with-param>
                          </xsl:call-template >
                        </td>
                        <td>
                          <xsl:value-of select="notes" />
                        </td>
                        <td>
                          <xsl:if test="LabAddressObj/name != ''">
                            <xsl:value-of select="LabAddressObj/name"/>
                            <br></br>
                            <xsl:value-of select="LabAddressObj/streetAddressLine"/>
                            <br></br>
                            <xsl:value-of select="LabAddressObj/city"/>, <xsl:value-of select="LabAddressObj/state"/>- <xsl:value-of select="LabAddressObj/postalCode"/>
                          </xsl:if>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:for-each >
                </tbody>
              </table>
              <xsl:if test="boolean(//ClinicalNotesObj/ClinicalNote)">
                <xsl:for-each select="//ClinicalNotesObj/ClinicalNote">
                  <!--<xsl:if test ="('LaboratoryNarrativeNote' = clinicalnotetypeobj) or ('DiagnosticImagingNarrativeNote' = clinicalnotetypeobj)">-->
                  <xsl:if test ="('LaboratoryNarrativeNote' = clinicalnotetypeobj)">
                    <table>
                      <thead>
                        <tr>
                          <th>Laboratory Narrative</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <xsl:value-of select="note" disable-output-escaping="yes"/>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </xsl:if>
                </xsl:for-each>
              </xsl:if>
            </text>
            <xsl:for-each select="resultListObj/Result">
              <entry typeCode = "DRIV">
                <organizer classCode = "BATTERY" moodCode = "EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.1" extension="2015-08-01"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.1"/>
                  <id root="7d5a02b0-67a4-11db-bd13-0800200c9a66">
                    <xsl:if test ="id != ''">
                      <xsl:attribute name="extension">
                        <xsl:value-of select="id"/>
                      </xsl:attribute>
                    </xsl:if>
                  </id>
                  <code xsi:type = "CE">
                    <xsl:if test ="codeSystem = ''">
                      <xsl:attribute name="codeSystem">
                        <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="boolean(codeSystem) = false">
                      <xsl:attribute name="codeSystem">
                        <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="codeSystem != ''">
                      <xsl:attribute name="codeSystem">
                        <xsl:value-of select="codeSystem"/>
                      </xsl:attribute>
                    </xsl:if>


                    <xsl:choose>
                      <xsl:when test="codeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="codeCode"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>NA</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>

                    <xsl:if test="codeDisplayName != ''">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="codeDisplayName"/>
                      </xsl:attribute>
                    </xsl:if>


                  </code>
                  <statusCode>
                    <xsl:attribute name="code">
                      <xsl:choose>
                        <xsl:when test="status != ''">
                          <xsl:value-of select="status"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>completed</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                  </statusCode>

                  <effectiveTime>
                    <xsl:choose>
                      <xsl:when test ="effectiveTime != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTime"/>
                          </xsl:attribute>
                        </low>
                        <high>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTime"/>
                          </xsl:attribute>
                        </high>
                      </xsl:when >
                      <xsl:otherwise>
                        <low nullFlavor="UNK"></low>
                        <high nullFlavor="UNK"></high>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>

                  <xsl:for-each select="resultObs/ResultObs">
                    <component>
                      <observation classCode = "OBS" moodCode = "EVN">
                        <templateId root="2.16.840.1.113883.10.20.22.4.2" extension="2015-08-01"/>
                        <templateId root="2.16.840.1.113883.10.20.22.4.2"/>
                        <id root = "107c2dc0-67a5-11db-bd13-0800200c9a66"/>
                        <code>
                          <xsl:if test ="codeSystem = ''">
                            <xsl:attribute name="codeSystem">
                              <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                            </xsl:attribute>
                          </xsl:if>
                          <xsl:if test ="boolean(codeSystem) = false">
                            <xsl:attribute name="codeSystem">
                              <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                            </xsl:attribute>
                          </xsl:if>
                          <xsl:if test ="codeSystem != ''">
                            <xsl:attribute name="codeSystem">
                              <xsl:value-of select="codeSystem"/>
                            </xsl:attribute>
                          </xsl:if>

                          <xsl:choose>
                            <xsl:when test="code != ''">
                              <xsl:attribute name="code">
                                <xsl:value-of select="code"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>NA</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>

                          <xsl:if test="codeDisplayName != ''">
                            <xsl:attribute name="displayName">
                              <xsl:value-of select="codeDisplayName"/>
                            </xsl:attribute>
                          </xsl:if>


                        </code>
                        <statusCode>
                          <xsl:attribute name="code">
                            <xsl:choose>
                              <xsl:when test="valueValue = ''">
                                <xsl:text>active</xsl:text>
                              </xsl:when>
                              <!--<xsl:when test="status != ''">
                            <xsl:value-of select="status"/>
                          </xsl:when>-->
                              <xsl:otherwise>
                                <xsl:text>completed</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:attribute>
                        </statusCode>

                        <effectiveTime>
                          <xsl:choose>
                            <xsl:when test ="effectiveTime != ''">
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTime"/>
                              </xsl:attribute>
                            </xsl:when >
                            <xsl:otherwise>
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>UNK</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                        </effectiveTime>
                        <xsl:if test="valueValue = '' and valuetype != 'ST'">
                          <value xsi:type = "ST">Pending</value>
                        </xsl:if>
                        <xsl:if test="valuetype = 'ST'">
                          <value xsi:type = "ST">
                            <xsl:value-of select="valueValue"/>
                          </value>
                        </xsl:if>

                        <xsl:if test="valueValue != '' and (boolean(valuetype) = false or valuetype = '')" >
                          <value xsi:type = "PQ">
                            <xsl:attribute name="value">
                              <xsl:value-of select="valueValue"/>
                            </xsl:attribute>
                            <xsl:choose>
                              <xsl:when test ="valueUnit != ''">
                                <xsl:attribute name="unit">
                                  <xsl:value-of select="valueUnit"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>OTH</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                          </value>
                        </xsl:if>

                        <xsl:if test="valueValue != '' and boolean(valuetype) = 'true' and valuetype = 'ST' and  boolean(valueUnit) = 'true' and (valueUnit != '')" >
                          <value xsi:type = "ST">
                            <xsl:attribute name="value">
                              <xsl:value-of select="valueValue"/>
                            </xsl:attribute>
                            <xsl:if test ="valueUnit != ''">
                              <xsl:attribute name="unit">
                                <xsl:value-of select="valueUnit"/>
                              </xsl:attribute>
                            </xsl:if>
                          </value>
                        </xsl:if>
                        <xsl:if test="LabAddressObj/name != ''">
                          <!--<author>
                        <templateId root="2.16.840.1.113883.10.20.22.4.119"/>
                        <time value="20161020194152+0000"/>
                        <assignedAuthor>
                          <id root="2.16.840.1.113883.19.5"/>
                          <assignedPerson>
                            <name>
                              <prefix nullFlavor="UNK"></prefix>
                              <given nullFlavor="UNK"></given>
                              <family nullFlavor="UNK"></family>
                              <suffix nullFlavor="UNK"></suffix>
                            </name>
                          </assignedPerson>

                          <representedOrganization>
                            <id root="2.16.840.1.113883.19.5"/>
                            <name>
                              <xsl:value-of select="LabAddressObj/name"/>
                            </name>
                            <addr use = "WP">
                              <xsl:choose>
                                <xsl:when test="LabAddressObj/streetAddressLine != ''">
                                  <streetAddressLine>
                                    <xsl:value-of select="LabAddressObj/streetAddressLine"/>
                                  </streetAddressLine>
                                </xsl:when>
                                <xsl:otherwise>
                                  <streetAddressLine nullFlavor="UNK"/>
                                </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                <xsl:when test="LabAddressObj/city != ''">
                                  <city>
                                    <xsl:value-of select="LabAddressObj/city"/>
                                  </city>
                                </xsl:when>
                                <xsl:otherwise>
                                  <city nullFlavor="UNK"/>
                                </xsl:otherwise>
                              </xsl:choose>

                              <xsl:choose>
                                <xsl:when test="LabAddressObj/state != ''">
                                  <state>
                                    <xsl:value-of select="LabAddressObj/state"/>
                                  </state>
                                </xsl:when>
                                <xsl:otherwise>
                                  <state nullFlavor="UNK"/>
                                </xsl:otherwise>
                              </xsl:choose>

                              <xsl:choose>
                                <xsl:when test="LabAddressObj/postalCode != ''">
                                  <postalCode>
                                    <xsl:value-of select="LabAddressObj/postalCode"/>
                                  </postalCode>
                                </xsl:when>
                                <xsl:otherwise>
                                  <postalCode nullFlavor="UNK"/>
                                </xsl:otherwise>
                              </xsl:choose>

                              <xsl:choose>
                                <xsl:when test="LabAddressObj/country != ''">
                                  <country>
                                    <xsl:value-of select="LabAddressObj/country"/>
                                  </country>
                                </xsl:when>
                                <xsl:otherwise>
                                  <country nullFlavor="UNK"/>
                                </xsl:otherwise>
                              </xsl:choose>
                            </addr>
                          </representedOrganization>
                        </assignedAuthor>
                      </author>-->
                        </xsl:if>
                        <xsl:if test ="leftrange != '' and rightrange != ''">
                          <referenceRange>
                            <observationRange>
                              <value xsi:type="IVL_PQ">
                                <low>
                                  <xsl:attribute name="value">
                                    <xsl:value-of select="leftrange"/>
                                  </xsl:attribute>
                                  <xsl:if test ="valueUnit != ''">
                                    <xsl:attribute name="unit">
                                      <xsl:value-of select="valueUnit"/>
                                    </xsl:attribute>
                                  </xsl:if>
                                </low>
                                <high>
                                  <xsl:attribute name="value">
                                    <xsl:value-of select="rightrange"/>
                                  </xsl:attribute>
                                  <xsl:if test ="valueUnit != ''">
                                    <xsl:attribute name="unit">
                                      <xsl:value-of select="valueUnit"/>
                                    </xsl:attribute>
                                  </xsl:if>
                                </high>
                              </value>
                            </observationRange>
                          </referenceRange>
                        </xsl:if>

                      </observation>
                    </component>
                  </xsl:for-each>
                </organizer>
              </entry>
            </xsl:for-each>


            <xsl:if test="boolean(//ClinicalNotesObj/ClinicalNote)">
              <xsl:for-each select="//ClinicalNotesObj/ClinicalNote">
                <!--<xsl:if test ="('LaboratoryNarrativeNote' = clinicalnotetypeobj) or ('DiagnosticImagingNarrativeNote' = clinicalnotetypeobj)">-->
                <xsl:if test ="('LaboratoryNarrativeNote' = clinicalnotetypeobj)">
                  <entry>
                    <act classCode="ACT" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.22.4.202" extension="2016-11-01"/>
                      <id root="9a6d1bac-17d3-4195-89a4-1121bc809123">
                        <xsl:if test ="id != ''">
                          <xsl:attribute name="extension">
                            <xsl:value-of select="id"/>
                          </xsl:attribute>
                        </xsl:if>
                      </id>
                      <code code="34109-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Note"></code>
                      <text>
                        <xsl:value-of select="note"/>
                      </text>
                      <statusCode code="completed"/>
                      <!-- Clinically-relevant time of the note -->
                      <effectiveTime>
                        <xsl:attribute name="value">
                          <xsl:value-of select="//author/visitDate"/>
                        </xsl:attribute>
                      </effectiveTime>
                      <xsl:if test="boolean(author)">
                        <author>
                          <xsl:choose>
                            <xsl:when test="boolean(author/givenName)">
                              <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                              <time>
                                <xsl:attribute name="value">
                                  <xsl:value-of select="author/visitDate"/>
                                </xsl:attribute>
                              </time>
                              <assignedAuthor>
                                <id  root = "2.16.840.1.113883.4.6">
                                  <xsl:attribute name="extension">
                                    <xsl:value-of select="author/providerid"/>
                                  </xsl:attribute>
                                </id>
                                <addr use = "WP">
                                  <xsl:call-template name="facilityAddressDetails"/>
                                </addr>
                                <telecom use = "WP">
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                      <xsl:attribute name="value">
                                        <xsl:text>tel:</xsl:text>
                                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                                      </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:attribute name="nullFlavor">
                                        <xsl:text>UNK</xsl:text>
                                      </xsl:attribute>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </telecom>
                                <assignedPerson>
                                  <name>
                                    <xsl:if test="author/suffix != ''">
                                      <suffix>
                                        <xsl:value-of select="author/suffix"/>
                                      </suffix>
                                    </xsl:if>
                                    <xsl:if test="author/prefix != ''">
                                      <prefix>
                                        <xsl:value-of select="author/prefix"/>
                                      </prefix>
                                    </xsl:if>
                                    <given>
                                      <xsl:value-of select="author/givenName"/>
                                    </given>
                                    <family>
                                      <xsl:value-of select="author/familyName"/>
                                    </family>
                                  </name>
                                </assignedPerson>
                                <representedOrganization>
                                  <id>
                                    <xsl:attribute name="root">
                                      <xsl:value-of select="//EHRID"/>
                                    </xsl:attribute>
                                  </id>
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                      <name>
                                        <xsl:value-of select="//FacilityAddressObj/name"/>
                                      </name>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <name nullFlavor="UNK"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <telecom use="WP">
                                    <xsl:choose>
                                      <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                        <xsl:attribute name="value">
                                          <xsl:text>tel:</xsl:text>
                                          <xsl:value-of select="//FacilityAddressObj/phone"/>
                                        </xsl:attribute>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:attribute name="nullFlavor">
                                          <xsl:text>UNK</xsl:text>
                                        </xsl:attribute>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </telecom>
                                  <addr use = "WP">
                                    <xsl:call-template name="facilityAddressDetails"/>
                                  </addr>
                                </representedOrganization>
                              </assignedAuthor>
                            </xsl:when>
                            <xsl:otherwise>
                              <author>
                                <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                <time nullFlavor="UNK" />
                                <assignedAuthor>
                                  <id nullFlavor="UNK" />
                                  <addr>
                                    <streetAddressLine nullFlavor="UNK"/>
                                    <city nullFlavor="UNK"/>
                                  </addr>
                                  <telecom nullFlavor="UNK" />
                                </assignedAuthor>
                              </author>
                            </xsl:otherwise>
                          </xsl:choose>
                        </author>
                      </xsl:if>
                    </act>
                  </entry>
                </xsl:if>
              </xsl:for-each>
            </xsl:if>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.3.1" extension="2015-08-01" />
            <templateId root="2.16.840.1.113883.10.20.22.2.3.1" />
            <code code="30954-2" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="RESULTS" />
            <title>RESULTS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="vitalsigns">
    <xsl:choose>
      <xsl:when test="boolean(vitalSignListObj/VitalSign/Observation/VitalSignObs)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.4.1" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.4.1"/>
            <code code="8716-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="VITAL SIGNS"/>
            <title>VITAL SIGNS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Type</th>
                    <th>Value</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="vitalSignListObj/VitalSign">
                    <xsl:for-each select="Observation/VitalSignObs">
                      <xsl:if test="valueValue != ''">
                        <tr>
                          <td>
                            <xsl:value-of select="codeDisplayName"/>

                            (Code:
                            <xsl:value-of select="codeCode"/>
                            )
                          </td>
                          <td>
                            <xsl:value-of select="valueValue"/><xsl:text> </xsl:text>
                            ( <xsl:value-of select="valueUnit"/> )
                          </td>
                          <td>
                            <xsl:call-template name="show-time">
                              <xsl:with-param name="datetime">
                                <xsl:value-of select="effectiveTime"/>
                              </xsl:with-param>
                            </xsl:call-template >
                          </td>
                        </tr>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="vitalSignListObj/VitalSign">
              <entry typeCode="DRIV">
                <organizer classCode="CLUSTER" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.26" extension="2015-08-01"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.26"/>
                  <!-- Vital signs organizer template -->
                  <id root="c6f88320-67ad-11db-bd13-0800200c9a66" extension="2000"/>
                  <code code="46680005" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED -CT" displayName="Vital signs">
                    <translation code="74728-7" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Vital signs"/>
                  </code>
                  <statusCode code="completed"/>
                  <effectiveTime>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeHigh"/>
                    </xsl:attribute>
                  </effectiveTime>
                  <xsl:for-each select="Observation/VitalSignObs">
                    <xsl:if test="valueValue != ''">
                      <component>
                        <observation classCode="OBS" moodCode="EVN">
                          <templateId root="2.16.840.1.113883.10.20.22.4.27" extension="2014-06-09"/>
                          <templateId root="2.16.840.1.113883.10.20.22.4.27"/>
                          <!-- Vital Sign Observation template -->
                          <id root="c6f88321-67ad-11db-bd13-0800200c9a66">
                            <xsl:choose>
                              <xsl:when test ="(boolean(id)) and id != ''">
                                <xsl:attribute name="extension">
                                  <xsl:value-of select="id"/>
                                </xsl:attribute>
                              </xsl:when >
                              <xsl:otherwise>
                                <xsl:attribute name="extension">
                                  <xsl:text>123456789</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                          </id>
                          <code>
                            <xsl:if test ="codeSystem = ''">
                              <xsl:attribute name="codeSystem">
                                <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                              </xsl:attribute>
                            </xsl:if>
                            <xsl:if test ="boolean(codeSystem) = false">
                              <xsl:attribute name="codeSystem">
                                <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                              </xsl:attribute>
                            </xsl:if>
                            <xsl:if test ="codeSystem != ''">
                              <xsl:attribute name="codeSystem">
                                <xsl:value-of select="codeSystem"/>
                              </xsl:attribute>
                            </xsl:if>

                            <xsl:choose>
                              <xsl:when test="codeCode != ''">
                                <xsl:attribute name="code">
                                  <xsl:value-of select="codeCode"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>NA</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>

                            <xsl:if test="codeDisplayName != ''">
                              <xsl:attribute name="displayName">
                                <xsl:value-of select="codeDisplayName"/>
                              </xsl:attribute>
                            </xsl:if>


                          </code>
                          <statusCode code="completed"/>
                          <effectiveTime>
                            <xsl:choose>
                              <xsl:when test ="effectiveTime != ''">
                                <xsl:attribute name="value">
                                  <xsl:value-of select="effectiveTime"/>
                                </xsl:attribute>
                              </xsl:when >
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>UNK</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                          </effectiveTime>

                        <xsl:if test="boolean(valuetype) and valuetype = 'ST'">
                          <value xsi:type = "ST">
                            <xsl:value-of select="valueValue"/>
                          </value>
                        </xsl:if>
                          
                        <xsl:if test="valueValue != '' and (boolean(valuetype) = false or valuetype = '' or valuetype = 'PQ')" >
                          <value xsi:type="PQ" >
                            <xsl:attribute name="value">
                              <xsl:value-of select="valueValue"/>
                            </xsl:attribute>
                            <xsl:choose>
                              <xsl:when test ="valueUnit != ''">
                                <xsl:attribute name="unit">
                                  <xsl:value-of select="valueUnit"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>OTH</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                          </value>
                        </xsl:if>
                          
                        <!--<xsl:if test="valueValue != '' and boolean(valuetype) = 'true' and valuetype = 'ST'" >
                          <value xsi:type = "ST">
                            <xsl:attribute name="value">
                              <xsl:value-of select="valueValue"/>
                            </xsl:attribute>
                            <xsl:if test ="boolean(valueUnit) and (valueUnit != '') and valueUnit != ''">
                              <xsl:attribute name="unit">
                                <xsl:value-of select="valueUnit"/>
                              </xsl:attribute>
                            </xsl:if>
                          </value>
                        </xsl:if>-->                                                      
                           
                         <interpretationCode code="N" codeSystem="2.16.840.1.113883.5.83" />
                          <xsl:if test="boolean(author)">
                            <author>
                              <xsl:choose>
                                <xsl:when test="boolean(author/givenName)">
                                  <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                  <time>
                                    <xsl:attribute name="value">
                                      <xsl:value-of select="author/visitDate"/>
                                    </xsl:attribute>
                                  </time>
                                  <assignedAuthor>
                                    <id  root = "2.16.840.1.113883.4.6">
                                      <xsl:attribute name="extension">
                                        <xsl:value-of select="author/providerid"/>
                                      </xsl:attribute>
                                    </id>
                                    <addr use = "WP">
                                      <xsl:call-template name="facilityAddressDetails"/>
                                    </addr>
                                    <telecom use = "WP">
                                      <xsl:choose>
                                        <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                          <xsl:attribute name="value">
                                            <xsl:text>tel:</xsl:text>
                                            <xsl:value-of select="//FacilityAddressObj/phone"/>
                                          </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <xsl:attribute name="nullFlavor">
                                            <xsl:text>UNK</xsl:text>
                                          </xsl:attribute>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </telecom>
                                    <assignedPerson>
                                      <name>
                                        <xsl:if test="author/suffix != ''">
                                          <suffix>
                                            <xsl:value-of select="author/suffix"/>
                                          </suffix>
                                        </xsl:if>
                                        <xsl:if test="author/prefix != ''">
                                          <prefix>
                                            <xsl:value-of select="author/prefix"/>
                                          </prefix>
                                        </xsl:if>
                                        <given>
                                          <xsl:value-of select="author/givenName"/>
                                        </given>
                                        <family>
                                          <xsl:value-of select="author/familyName"/>
                                        </family>
                                      </name>
                                    </assignedPerson>
                                    <representedOrganization>
                                      <id>
                                        <xsl:attribute name="root">
                                          <xsl:value-of select="//EHRID"/>
                                        </xsl:attribute>
                                      </id>
                                      <xsl:choose>
                                        <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                          <name>
                                            <xsl:value-of select="//FacilityAddressObj/name"/>
                                          </name>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <name nullFlavor="UNK"/>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                      <telecom use="WP">
                                        <xsl:choose>
                                          <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                            <xsl:attribute name="value">
                                              <xsl:text>tel:</xsl:text>
                                              <xsl:value-of select="//FacilityAddressObj/phone"/>
                                            </xsl:attribute>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <xsl:attribute name="nullFlavor">
                                              <xsl:text>UNK</xsl:text>
                                            </xsl:attribute>
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </telecom>
                                      <addr use = "WP">
                                        <xsl:call-template name="facilityAddressDetails"/>
                                      </addr>
                                    </representedOrganization>
                                  </assignedAuthor>
                                </xsl:when>
                                <xsl:otherwise>
                                  <author>
                                    <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                    <time nullFlavor="UNK" />
                                    <assignedAuthor>
                                      <id nullFlavor="UNK" />
                                      <addr>
                                        <streetAddressLine nullFlavor="UNK"/>
                                        <city nullFlavor="UNK"/>
                                      </addr>
                                      <telecom nullFlavor="UNK" />
                                    </assignedAuthor>
                                  </author>
                                </xsl:otherwise>
                              </xsl:choose>
                            </author>
                          </xsl:if>
                        </observation>
                      </component>
                    </xsl:if>
                  </xsl:for-each>
                </organizer>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.4.1" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.4.1"/>
            <code code="8716-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="VITAL SIGNS"/>
            <title>VITAL SIGNS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="socialhistory">
    <component>
      <!-- Social History ******** -->
      <section>
        <templateId root="2.16.840.1.113883.10.20.22.2.17" extension="2015-08-01"/>
        <templateId root="2.16.840.1.113883.10.20.22.2.17"/>
        <!-- ******** Social history section template ******** -->
        <code code="29762-2" codeSystem="2.16.840.1.113883.6.1" displayName="Social History"/>
        <title>SOCIAL HISTORY</title>
        <text>
          <table border = "1" width = "100%">
            <thead>
              <tr>
                <th>Description</th>
                <th>Effective Dates</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="socialHistoryListObj/SocialHistory">
                <tr>
                  <td>
                    <xsl:value-of select="valueDisplayName"/>, [Code: <xsl:value-of select="valueCode"/>]
                  </td>
                  <td>
                    <xsl:if test ="effectiveTimeLow != ''">
                      <xsl:call-template name="show-time">
                        <xsl:with-param name="datetime">
                          <xsl:value-of select="effectiveTimeLow"/>
                        </xsl:with-param>
                      </xsl:call-template >
                    </xsl:if>

                    <xsl:if test ="effectiveTimeHigh != ''">
                      <xsl:text>-</xsl:text>
                      <xsl:call-template name="show-time">
                        <xsl:with-param name="datetime">
                          <xsl:value-of select="effectiveTimeHigh"/>
                        </xsl:with-param>
                      </xsl:call-template >
                    </xsl:if>
                  </td>
                </tr>
              </xsl:for-each >
              <tr>
                <td>Birth Sex</td>
                <td>
                  <xsl:if test ="//patientRoleObj/administrativeGenderCode='ASKU' or //patientRoleObj/administrativeGenderCode='UNK' or //patientRoleObj/administrativeGenderCode=''">

                    <xsl:text>Unknown</xsl:text>

                  </xsl:if>
                  <xsl:if test ="//patientRoleObj/administrativeGenderCode !='ASKU' and //patientRoleObj/administrativeGenderCode !='UNK' and //patientRoleObj/administrativeGenderCode!=''">
                    <xsl:value-of select="//patientRoleObj/administrativeGenderCode"/>
                  </xsl:if>

                  (<xsl:value-of select="//patientRoleObj/administrativeGenderDisplayName"/>)


                </td>
              </tr>
            </tbody>
          </table>
        </text>
        <xsl:for-each select="socialHistoryListObj/SocialHistory">
          <entry typeCode="DRIV">
            <observation classCode="OBS" moodCode="EVN">
              <!-- Smoking status observation template -->
              <templateId root="2.16.840.1.113883.10.20.22.4.78"/>
              <id root="2.16.840.1.113883.19">
                <xsl:choose>
                  <xsl:when test ="(boolean(id)) and id != ''">
                    <xsl:attribute name="extension">
                      <xsl:value-of select="id"/>
                    </xsl:attribute>
                  </xsl:when >
                  <xsl:otherwise>
                    <xsl:attribute name="extension">
                      <xsl:text>123456789</xsl:text>
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
              </id>
              <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
              <statusCode code="completed"> </statusCode>
              <effectiveTime>
                <xsl:choose>
                  <xsl:when test ="(boolean(effectiveTimeLow)) and effectiveTimeLow != ''">
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeLow"/>
                    </xsl:attribute>
                  </xsl:when >
                  <xsl:otherwise>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
                <!--<xsl:if test ="effectiveTimeLow != ''">
                  <low>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeLow"/>
                    </xsl:attribute>
                  </low>
                </xsl:if >
                <xsl:if test ="effectiveTimeLow = ''">
                  <low>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </low>
                </xsl:if >
                <xsl:if test ="effectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:if >
                <xsl:if test ="effectiveTimeHigh = ''">
                  <high>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </high>
                </xsl:if >-->

              </effectiveTime>
              <value xsi:type="CD">
                <xsl:if test ="codeSystem = ''">
                  <xsl:attribute name="codeSystem">
                    <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="boolean(codeSystem) = false">
                  <xsl:attribute name="codeSystem">
                    <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="codeSystem != ''">
                  <xsl:attribute name="codeSystem">
                    <xsl:value-of select="codeSystem"/>
                  </xsl:attribute>
                </xsl:if>



                <xsl:choose>
                  <xsl:when test="valueCode != ''">
                    <xsl:attribute name="code">
                      <xsl:value-of select="valueCode"/>
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>NA</xsl:text>
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="valueDisplayName != ''">
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="valueDisplayName"/>
                  </xsl:attribute>
                </xsl:if>
              </value>
            </observation>
          </entry>
        </xsl:for-each>
        <entry>
          <observation classCode="OBS" moodCode="EVN">
            <templateId root="2.16.840.1.113883.10.20.22.4.200" extension="2016-06-01"/>
            <code code="76689-9" displayName="Sex assigned at birth" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
            <text>
              <reference value="#BirthSexInfo"/>
            </text>
            <statusCode code="completed"/>
            <value xsi:type="CD" codeSystem="2.16.840.1.113883.5.1">
              <xsl:if test ="//patientRoleObj/administrativeGenderCode='ASKU' or //patientRoleObj/administrativeGenderCode='UNK' or //patientRoleObj/administrativeGenderCode=''">
                <xsl:attribute name="nullFlavor">
                  <xsl:text>OTH</xsl:text>
                </xsl:attribute>
              </xsl:if>
              <xsl:if test ="//patientRoleObj/administrativeGenderCode !='ASKU' and //patientRoleObj/administrativeGenderCode !='UNK' and //patientRoleObj/administrativeGenderCode!=''">
                <xsl:attribute name="code">
                  <xsl:value-of select="//patientRoleObj/administrativeGenderCode"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:attribute name="displayName">
                <xsl:value-of select="//patientRoleObj/administrativeGenderDisplayName"/>
              </xsl:attribute>
            </value>
          </observation>
        </entry>
      </section>
    </component>
  </xsl:template>
  <xsl:template name="procedures">
    <xsl:choose>

      <xsl:when test="boolean(procedureListObj/Procedure)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.7.1" extension="2014-06-09"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.7.1"/>
            <!-- Procedures section template -->
            <code code="47519-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF PROCEDURES"/>
            <title>PROCEDURES</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Status</th>
                    <!--<th>Issuing Agency</th>-->
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="procedureListObj/Procedure">
                    <tr>
                      <td>
                        <xsl:value-of select="codeDisplayName"/>, [Code: <xsl:value-of select="codeCode"/>]
                        <!--<xsl:value-of select="deviceName"/>
                    <xsl:if test="deviceId!=''">
                      Device Code : <xsl:value-of select="deviceId"/>
                    </xsl:if>-->
                      </td>

                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="effectiveTimeHigh"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>

                      <td>Completed</td>

                      <!--<td>
                    <xsl:if test="deviceId !=''">
                      FDA
                    </xsl:if>
                  </td>-->
                    </tr>
                  </xsl:for-each >
                </tbody>
              </table>

              <xsl:if test="boolean(//ClinicalNotesObj/ClinicalNote)">
                <xsl:for-each select="//ClinicalNotesObj/ClinicalNote">
                  <xsl:if test ="'ProcedureNote' = clinicalnotetypeobj">
                    <table>
                      <thead>
                        <tr>
                          <th>Procedure Note</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <xsl:value-of select="note" disable-output-escaping="yes"/>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </xsl:if>
                </xsl:for-each>
              </xsl:if>
            </text>
            <xsl:for-each select="procedureListObj/Procedure">
              <entry typeCode="DRIV">
                <procedure classCode="PROC" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.14"/>
                  <!-- Procedure Activity Observation -->
                  <id root="2.16.840.1.113883.19">
                    <xsl:choose>
                      <xsl:when test ="(boolean(id)) and id != ''">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="extension">
                          <xsl:text>123456789</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </id>
                  <code>
                    <xsl:if test ="boolean(codeSystem) = false">
                      <xsl:attribute name="codeSystem">
                        <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test ="codeSystem = ''">
                      <xsl:attribute name="codeSystem">
                        <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="codeSystem != ''">
                      <xsl:attribute name="codeSystem">
                        <xsl:value-of select="codeSystem"/>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:choose>
                      <xsl:when test="codeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="codeCode"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>NA</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="codeDisplayName != ''">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="codeDisplayName"/>
                      </xsl:attribute>
                    </xsl:if>

                  </code>
                  <statusCode code="completed"/>


                  <xsl:choose>
                    <xsl:when test ="(boolean(effectiveTimeHigh)) and effectiveTimeHigh != ''">
                      <effectiveTime>
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTimeHigh"/>
                        </xsl:attribute>
                      </effectiveTime>
                    </xsl:when>
                    <xsl:otherwise>
                      <effectiveTime nullFlavor="UNK">
                      </effectiveTime>
                    </xsl:otherwise>
                  </xsl:choose>


                  <!--<effectiveTime>
                <xsl:attribute name="value">
                  <xsl:value-of select="effectiveTimeHigh"/>
                </xsl:attribute>
              </effectiveTime>-->

                  <priorityCode code="CR" codeSystem="2.16.840.1.113883.5.7" codeSystemName="ActPriority" displayName="Callback results"/>
                  <methodCode nullFlavor="UNK"/>
                  <targetSiteCode codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                    <xsl:if test ="not(targetSiteCodeCode)">
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>OTH</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="targetSiteCodeCode = ''">
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>OTH</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="targetSiteCodeCode != ''">
                      <xsl:attribute name="code">
                        <xsl:value-of select="targetSiteCodeCode"/>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="targetSiteCodeDisplayName != ''">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="targetSiteCodeDisplayName"/>
                      </xsl:attribute>
                    </xsl:if>

                  </targetSiteCode>



                  <xsl:choose>
                    <xsl:when test ="(boolean(performerAddress)) and performerAddress != ''">
                      <performer>
                        <assignedEntity>
                          <id root="2.16.840.1.113883.19.5.9999.456" extension="2981823"/>
                          <addr use="WP">
                            <streetAddressLine>
                              <xsl:value-of select="performerAddress/streetAddressLine"/>
                            </streetAddressLine>
                            <city>
                              <xsl:value-of select="performerAddress/city"/>
                            </city>
                            <state>
                              <xsl:value-of select="performerAddress/state"/>
                            </state>
                            <postalCode>
                              <xsl:value-of select="performerAddress/postalCode"/>
                            </postalCode>
                            <country>
                              <xsl:value-of select="performerAddress/country"/>
                            </country>
                          </addr>
                          <xsl:if test="boolean(performerAddress/phone)">
                            <telecom use="WP">
                              <xsl:attribute name="value">
                                <xsl:text>tel:</xsl:text>
                                <xsl:value-of select="performerAddress/phone"/>
                              </xsl:attribute>
                            </telecom>
                          </xsl:if>
                          <representedOrganization classCode="ORG">
                            <id>
                              <xsl:attribute name="root">
                                <xsl:value-of select="//EHRID"/>
                              </xsl:attribute>
                            </id>
                            <name>
                              <xsl:value-of select="performer"/>
                            </name>
                            <xsl:if test="boolean(performerAddress/phone)">
                              <telecom use="WP">
                                <xsl:attribute name="value">
                                  <xsl:text>tel:</xsl:text>
                                  <xsl:value-of select="performerAddress/phone"/>
                                </xsl:attribute>
                              </telecom>
                            </xsl:if>
                            <addr use="WP">
                              <streetAddressLine>
                                <xsl:value-of select="performerAddress/streetAddressLine"/>
                              </streetAddressLine>
                              <city>
                                <xsl:value-of select="performerAddress/city"/>
                              </city>
                              <state>
                                <xsl:value-of select="performerAddress/state"/>
                              </state>
                              <postalCode>
                                <xsl:value-of select="performerAddress/postalCode"/>
                              </postalCode>
                              <country>
                                <xsl:value-of select="performerAddress/country"/>
                              </country>
                            </addr>
                          </representedOrganization>
                        </assignedEntity>
                      </performer>
                    </xsl:when>
                    <xsl:otherwise>

                    </xsl:otherwise>
                  </xsl:choose>



                  <!--<xsl:if test="boolean(performerAddress)">
                <performer>
                  <assignedEntity>
                    <id root="2.16.840.1.113883.19.5.9999.456" extension="2981823"/>
                    <addr use="WP">
                      <streetAddressLine>
                        <xsl:value-of select="performerAddress/streetAddressLine"/>
                      </streetAddressLine>
                      <city>
                        <xsl:value-of select="performerAddress/city"/>
                      </city>
                      <state>
                        <xsl:value-of select="performerAddress/state"/>
                      </state>
                      <postalCode>
                        <xsl:value-of select="performerAddress/postalCode"/>
                      </postalCode>
                      <country>
                        <xsl:value-of select="performerAddress/country"/>
                      </country>
                    </addr>
                    <xsl:if test="boolean(performerAddress/phone)">
                      <telecom use="WP">
                        <xsl:attribute name="value">
                          <xsl:value-of select="performerAddress/phone"/>
                        </xsl:attribute>
                      </telecom>
                    </xsl:if>
                    <representedOrganization classCode="ORG">
                      <id root="2.16.840.1.113883.19.5.9999.1393"/>
                      <name>
                        <xsl:value-of select="performer"/>
                      </name>
                      <xsl:if test="boolean(performerAddress/phone)">
                        <telecom use="WP">
                          <xsl:attribute name="value">
                            <xsl:value-of select="performerAddress/phone"/>
                          </xsl:attribute>
                        </telecom>
                      </xsl:if>
                      <addr use="WP">
                        <streetAddressLine>
                          <xsl:value-of select="performerAddress/streetAddressLine"/>
                        </streetAddressLine>
                        <city>
                          <xsl:value-of select="performerAddress/city"/>
                        </city>
                        <state>
                          <xsl:value-of select="performerAddress/state"/>
                        </state>
                        <postalCode>
                          <xsl:value-of select="performerAddress/postalCode"/>
                        </postalCode>
                        <country>
                          <xsl:value-of select="performerAddress/country"/>
                        </country>
                      </addr>
                    </representedOrganization>
                  </assignedEntity>
                </performer>
              </xsl:if>-->

                  <!-- required for UDI -db -->
                  <xsl:if test="boolean(deviceId) and deviceId!=''">
                    <participant typeCode="DEV">
                      <participantRole classCode="MANU">
                        <!-- ** Product instance ** -->
                        <templateId root="2.16.840.1.113883.10.20.22.4.37"/>
                        <!-- UDI -db -->
                        <!-- this UDI provided by the test data is not valid as per CDA schema -db -->
                        <!-- <id root="00643169007222"/> -->
                        <id root="2.16.840.1.113883.3.3719" >
                          <xsl:attribute name="extension">
                            <xsl:value-of select="deviceId"/>
                          </xsl:attribute>
                        </id>
                        <playingDevice>
                          <code codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                            <xsl:if test ="not(deviceCode)">
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>OTH</xsl:text>
                              </xsl:attribute>
                            </xsl:if>
                            <xsl:if test ="deviceCode = ''">
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>OTH</xsl:text>
                              </xsl:attribute>
                            </xsl:if>
                            <xsl:if test ="deviceCode != ''">
                              <xsl:attribute name="code">
                                <xsl:value-of select="deviceCode"/>
                              </xsl:attribute>
                            </xsl:if>
                            <xsl:if test ="deviceName != ''">
                              <xsl:attribute name="displayName">
                                <xsl:value-of select="deviceName"/>
                              </xsl:attribute>
                            </xsl:if>
                          </code>
                        </playingDevice>
                        <!-- FDA Scoping Entity OID for UDI-db -->
                        <scopingEntity>
                          <id root="2.16.840.1.113883.3.3719"/>
                        </scopingEntity>
                      </participantRole>
                    </participant>
                  </xsl:if>

                  <!--<targetSiteCode codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                <xsl:attribute name="code">
                  <xsl:value-of select="targetSiteCodeCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="targetSiteCodeDisplayName"/>
                </xsl:attribute>
              </targetSiteCode>-->
                </procedure>
              </entry>
            </xsl:for-each>
            <xsl:if test="boolean(//ClinicalNotesObj/ClinicalNote)">
              <xsl:for-each select="//ClinicalNotesObj/ClinicalNote">
                <xsl:if test ="'ProcedureNote' = clinicalnotetypeobj">
                  <entry>
                    <act classCode="ACT" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.22.4.202" extension="2016-11-01"/>
                      <id root="9a6d1bac-17d3-4195-89a4-1231bc809b4e">
                        <xsl:if test ="id != ''">
                          <xsl:attribute name="extension">
                            <xsl:value-of select="id"/>
                          </xsl:attribute>
                        </xsl:if>
                      </id>
                      <code code="34109-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Note"></code>
                      <text>
                        <xsl:value-of select="note"/>
                      </text>
                      <statusCode code="completed"/>
                      <!-- Clinically-relevant time of the note -->
                      <effectiveTime>
                        <xsl:attribute name="value">
                          <xsl:value-of select="//author/visitDate"/>
                        </xsl:attribute>
                      </effectiveTime>
                      <xsl:if test="boolean(author)">
                        <author>
                          <xsl:choose>
                            <xsl:when test="boolean(author/givenName)">
                              <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                              <time>
                                <xsl:attribute name="value">
                                  <xsl:value-of select="author/visitDate"/>
                                </xsl:attribute>
                              </time>
                              <assignedAuthor>
                                <id  root = "2.16.840.1.113883.4.6">
                                  <xsl:attribute name="extension">
                                    <xsl:value-of select="author/providerid"/>
                                  </xsl:attribute>
                                </id>
                                <addr use = "WP">
                                  <xsl:call-template name="facilityAddressDetails"/>
                                </addr>
                                <telecom use = "WP">
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                      <xsl:attribute name="value">
                                        <xsl:text>tel:</xsl:text>
                                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                                      </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:attribute name="nullFlavor">
                                        <xsl:text>UNK</xsl:text>
                                      </xsl:attribute>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </telecom>
                                <assignedPerson>
                                  <name>
                                    <xsl:if test="author/suffix != ''">
                                      <suffix>
                                        <xsl:value-of select="author/suffix"/>
                                      </suffix>
                                    </xsl:if>
                                    <xsl:if test="author/prefix != ''">
                                      <prefix>
                                        <xsl:value-of select="author/prefix"/>
                                      </prefix>
                                    </xsl:if>
                                    <given>
                                      <xsl:value-of select="author/givenName"/>
                                    </given>
                                    <family>
                                      <xsl:value-of select="author/familyName"/>
                                    </family>
                                  </name>
                                </assignedPerson>
                                <representedOrganization>
                                  <id>
                                    <xsl:attribute name="root">
                                      <xsl:value-of select="//EHRID"/>
                                    </xsl:attribute>
                                  </id>
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                      <name>
                                        <xsl:value-of select="//FacilityAddressObj/name"/>
                                      </name>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <name nullFlavor="UNK"/>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                  <telecom use="WP">
                                    <xsl:choose>
                                      <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                        <xsl:attribute name="value">
                                          <xsl:text>tel:</xsl:text>
                                          <xsl:value-of select="//FacilityAddressObj/phone"/>
                                        </xsl:attribute>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:attribute name="nullFlavor">
                                          <xsl:text>UNK</xsl:text>
                                        </xsl:attribute>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                  </telecom>
                                  <addr use = "WP">
                                    <xsl:call-template name="facilityAddressDetails"/>
                                  </addr>
                                </representedOrganization>
                              </assignedAuthor>
                            </xsl:when>
                            <xsl:otherwise>
                              <author>
                                <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                                <time nullFlavor="UNK" />
                                <assignedAuthor>
                                  <id nullFlavor="UNK" />
                                  <addr>
                                    <streetAddressLine nullFlavor="UNK"/>
                                    <city nullFlavor="UNK"/>
                                  </addr>
                                  <telecom nullFlavor="UNK" />
                                </assignedAuthor>
                              </author>
                            </xsl:otherwise>
                          </xsl:choose>
                        </author>
                      </xsl:if>
                    </act>
                  </entry>
                </xsl:if>
              </xsl:for-each>
            </xsl:if>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.7.1" extension="2014-06-09" />
            <templateId root="2.16.840.1.113883.10.20.22.2.7.1" />
            <code code="47519-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF PROCEDURES" />
            <title>PROCEDURES</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="implants">
    <xsl:choose>
      <xsl:when test="boolean(procedureListObj/Procedure)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.23"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.23" extension="2014-06-09"/>
            <code code="46264-8" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Medical Equipment"/>
            <title>Implants</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Device Name</th>
                    <!--<th>Date</th>-->
                    <th>Status</th>
                    <th>Issuing Agency</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="procedureListObj/Procedure">
                    <xsl:if test="boolean(deviceId) and deviceId!=''">
                      <tr>
                        <td>
                          <xsl:value-of select="deviceName"/>
                          <xsl:if test="boolean(deviceId) and deviceId!=''">
                            Device Code : <xsl:value-of select="deviceId"/>
                          </xsl:if>
                        </td>

                        <!--<td>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime">
                        <xsl:value-of select="effectiveTimeHigh"/>
                      </xsl:with-param>
                    </xsl:call-template >
                  </td>-->

                        <td>Completed</td>

                        <td>
                          <xsl:if test="boolean(deviceId) and deviceId!=''">
                            FDA
                          </xsl:if>
                        </td>
                      </tr>
                    </xsl:if>
                  </xsl:for-each >
                  <tr>
                    <td></td>
                  </tr>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="procedureListObj/Procedure">
              <xsl:if test="boolean(deviceId) and deviceId!=''">
                <entry typeCode="DRIV">
                  <procedure classCode="PROC" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09"/>
                    <templateId root="2.16.840.1.113883.10.20.22.4.14"/>
                    <!-- Procedure Activity Observation -->
                    <id root="2.16.840.1.113883.19">
                      <xsl:choose>
                        <xsl:when test ="(boolean(id)) and id != ''">
                          <xsl:attribute name="extension">
                            <xsl:value-of select="id"/>
                          </xsl:attribute>
                        </xsl:when >
                        <xsl:otherwise>
                          <xsl:attribute name="extension">
                            <xsl:text>123456789</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>                      
                    </id>
                    <code>
                      <xsl:if test ="boolean(codeSystem) = false">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                        </xsl:attribute>
                      </xsl:if>

                      <xsl:if test ="codeSystem = ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="codeSystem"/>
                        </xsl:attribute>
                      </xsl:if>

                      <xsl:choose>
                        <xsl:when test="codeCode != ''">
                          <xsl:attribute name="code">
                            <xsl:value-of select="codeCode"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>NA</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test="codeDisplayName != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="codeDisplayName"/>
                        </xsl:attribute>
                      </xsl:if>

                    </code>
                    <statusCode code="completed"/>


                    <xsl:choose>
                      <xsl:when test ="(boolean(effectiveTimeHigh)) and effectiveTimeHigh != ''">
                        <effectiveTime>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeHigh"/>
                          </xsl:attribute>
                        </effectiveTime>
                      </xsl:when>
                      <xsl:otherwise>
                        <effectiveTime nullFlavor="UNK">
                        </effectiveTime>
                      </xsl:otherwise>
                    </xsl:choose>


                    <!--<effectiveTime>
                <xsl:attribute name="value">
                  <xsl:value-of select="effectiveTimeHigh"/>
                </xsl:attribute>
              </effectiveTime>-->

                    <priorityCode code="CR" codeSystem="2.16.840.1.113883.5.7" codeSystemName="ActPriority" displayName="Callback results"/>
                    <methodCode nullFlavor="UNK"/>
                    <targetSiteCode codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                      <xsl:if test ="not(targetSiteCodeCode)">
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>OTH</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="targetSiteCodeCode = ''">
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>OTH</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="targetSiteCodeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="targetSiteCodeCode"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="targetSiteCodeDisplayName != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="targetSiteCodeDisplayName"/>
                        </xsl:attribute>
                      </xsl:if>

                    </targetSiteCode>



                    <xsl:choose>
                      <xsl:when test ="(boolean(performerAddress)) and performerAddress != ''">
                        <performer>
                          <assignedEntity>
                            <id root="2.16.840.1.113883.19.5.9999.456" extension="2981823"/>
                            <addr use="WP">
                              <streetAddressLine>
                                <xsl:value-of select="performerAddress/streetAddressLine"/>
                              </streetAddressLine>
                              <city>
                                <xsl:value-of select="performerAddress/city"/>
                              </city>
                              <state>
                                <xsl:value-of select="performerAddress/state"/>
                              </state>
                              <postalCode>
                                <xsl:value-of select="performerAddress/postalCode"/>
                              </postalCode>
                              <country>
                                <xsl:value-of select="performerAddress/country"/>
                              </country>
                            </addr>
                            <xsl:if test="boolean(performerAddress/phone)">
                              <telecom use="WP">
                                <xsl:attribute name="value">
                                  <xsl:text>tel:</xsl:text>
                                  <xsl:value-of select="performerAddress/phone"/>
                                </xsl:attribute>
                              </telecom>
                            </xsl:if>
                            <representedOrganization classCode="ORG">
                              <id>
                                <xsl:attribute name="root">
                                  <xsl:value-of select="//EHRID"/>
                                </xsl:attribute>
                              </id>
                              <name>
                                <xsl:value-of select="performer"/>
                              </name>
                              <xsl:if test="boolean(performerAddress/phone)">
                                <telecom use="WP">
                                  <xsl:attribute name="value">
                                    <xsl:text>tel:</xsl:text>
                                    <xsl:value-of select="performerAddress/phone"/>
                                  </xsl:attribute>
                                </telecom>
                              </xsl:if>
                              <addr use="WP">
                                <streetAddressLine>
                                  <xsl:value-of select="performerAddress/streetAddressLine"/>
                                </streetAddressLine>
                                <city>
                                  <xsl:value-of select="performerAddress/city"/>
                                </city>
                                <state>
                                  <xsl:value-of select="performerAddress/state"/>
                                </state>
                                <postalCode>
                                  <xsl:value-of select="performerAddress/postalCode"/>
                                </postalCode>
                                <country>
                                  <xsl:value-of select="performerAddress/country"/>
                                </country>
                              </addr>
                            </representedOrganization>
                          </assignedEntity>
                        </performer>
                      </xsl:when>
                      <xsl:otherwise>

                      </xsl:otherwise>
                    </xsl:choose>




                    <!-- required for UDI -db -->
                    <xsl:if test="boolean(deviceId) and deviceId!=''">
                      <participant typeCode="DEV">
                        <participantRole classCode="MANU">
                          <!-- ** Product instance ** -->
                          <templateId root="2.16.840.1.113883.10.20.22.4.37"/>
                          <!-- UDI -db -->
                          <!-- this UDI provided by the test data is not valid as per CDA schema -db -->
                          <!-- <id root="00643169007222"/> -->
                          <id root="2.16.840.1.113883.3.3719" >
                            <xsl:attribute name="extension">
                              <xsl:value-of select="deviceId"/>
                            </xsl:attribute>
                          </id>
                          <playingDevice>
                            <code codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                              <xsl:if test ="not(deviceCode)">
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>OTH</xsl:text>
                                </xsl:attribute>
                              </xsl:if>
                              <xsl:if test ="deviceCode = ''">
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>OTH</xsl:text>
                                </xsl:attribute>
                              </xsl:if>
                              <xsl:if test ="deviceCode != ''">
                                <xsl:attribute name="code">
                                  <xsl:value-of select="deviceCode"/>
                                </xsl:attribute>
                              </xsl:if>
                              <xsl:if test ="deviceName != ''">
                                <xsl:attribute name="displayName">
                                  <xsl:value-of select="deviceName"/>
                                </xsl:attribute>
                              </xsl:if>
                            </code>
                          </playingDevice>
                          <!-- FDA Scoping Entity OID for UDI-db -->
                          <scopingEntity>
                            <id root="2.16.840.1.113883.3.3719"/>
                          </scopingEntity>
                        </participantRole>
                      </participant>
                    </xsl:if>

                    <!--<targetSiteCode codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT">
                <xsl:attribute name="code">
                  <xsl:value-of select="targetSiteCodeCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="targetSiteCodeDisplayName"/>
                </xsl:attribute>
              </targetSiteCode>-->
                  </procedure>
                </entry>
              </xsl:if>
            </xsl:for-each>

          </section>
        </component>
      </xsl:when>

      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.23" />
            <templateId root="2.16.840.1.113883.10.20.22.2.23" extension="2014-06-09" />
            <code code="46264-8" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Medical Equipment" />
            <title>Implants</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="immunization">
    <xsl:choose>
      <xsl:when test="boolean(immunizationListObj/Immunization)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.2.1"/>
            <!-- Entries Required -->
            <!-- ******** Immunizations section template ******** -->
            <code code="11369-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of immunizations"/>
            <title>IMMUNIZATIONS</title>

            <text>
              <table border="1" width="100%">
                <thead>
                  <tr>
                    <th>Vaccine</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Lot number</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="immunizationListObj/Immunization">
                    <tr>
                      <td>
                        <!--Commented below Lines-->
                        <!-- Need iterator for below Id as in immun2, immun3 -->
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationDisplayName"/>(Code: <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationCode"/>)
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                      <td>
                        <xsl:value-of select="status"/>

                        <xsl:choose>
                          <xsl:when test ="boolean(rejectionReason) and rejectionReason != ''">

                            <xsl:text>(</xsl:text>
                            <xsl:value-of select="rejectionReason"/>
                            <xsl:text>)</xsl:text>

                          </xsl:when >
                          <xsl:otherwise>
                          </xsl:otherwise>
                        </xsl:choose>

                      </td>
                      <td>
                        <xsl:value-of select="lotnumber"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="immunizationListObj/Immunization">
              <entry typeCode="DRIV">
                <substanceAdministration classCode="SBADM" moodCode="EVN" >
                  <xsl:choose>
                    <xsl:when test="negationInd = 'true' or negationInd = 'True' or negationInd = 'TRUE'">
                      <xsl:attribute name="negationInd">
                        <xsl:text>true</xsl:text>
                      </xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:attribute name="negationInd">
                        <xsl:text>false</xsl:text>
                      </xsl:attribute>
                    </xsl:otherwise>
                  </xsl:choose>

                  <templateId root="2.16.840.1.113883.10.20.22.4.52" extension="2015-08-01"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.52"/>
                  <!-- ******** Immunization activity template ******** -->
                  <id root="e6f1ba43-c0ed-4b9b-9f12-f435d8ad8f92" >
                    <xsl:attribute name="extension">
                      <xsl:value-of select="id"/>
                    </xsl:attribute>
                  </id>
                  <statusCode code="completed"/>
                  <effectiveTime xsi:type="IVL_TS">
                    <xsl:choose>
                      <xsl:when test ="effectiveTimeLow != ''">
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTimeLow"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>

                  <!--Commented below Lines-->
                  <!-- Route code and other info should not be empty -->

                  <xsl:if test ="routeCodeDisplayName != ''">
                    <routeCode codeSystem="2.16.840.1.113883.3.26.1.1" codeSystemName="NCI Thesaurus">
                      <xsl:if test ="routeCodeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="routeCodeCode"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test =" (boolean(routeCodeCode) = false) or routeCodeCode = ''">
                        <xsl:choose>
                          <xsl:when test="routeCodeDisplayName = 'ORAL' or routeCodeDisplayName = 'oral'">
                            <xsl:attribute name="code">
                              <xsl:text>C38288</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:when test="routeCodeDisplayName = 'inhl'">
                            <xsl:attribute name="code">
                              <xsl:text>C38216</xsl:text>
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="nullFlavor">
                              <xsl:text>NA</xsl:text>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:if>
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="routeCodeDisplayName"/>
                      </xsl:attribute>
                      <originalText>
                        <xsl:value-of select="routeCodeDisplayName"/>
                      </originalText>
                    </routeCode>
                  </xsl:if >
                  <consumable>
                    <manufacturedProduct classCode="MANU">
                      <templateId root="2.16.840.1.113883.10.20.22.4.54" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.54"/>
                      <!-- ******** Immunization Medication Information ******** -->
                      <!-- <manufacturedMaterial> 	<code code="103" codeSystem="2.16.840.1.113883.6.59" displayName="Tetanus and diphtheria toxoids - preservative free" codeSystemName="CVX"> <originalText>Tetanus and diphtheria toxoids - 	preservative free</originalText> <translation code="09" 	displayName="Tetanus and diphtheria toxoids - preservative free" 	codeSystemName="CVX" 	codeSystem="2.16.840.1.113883.6.59"/> 	</code> </manufacturedMaterial> -->
                      <manufacturedMaterial>
                        <code>
                          <xsl:if test ="codeSystem = ''">
                            <xsl:attribute name="codeSystem">
                              <xsl:text>2.16.840.1.113883.12.292</xsl:text>
                            </xsl:attribute>
                          </xsl:if>
                          <xsl:if test ="boolean(codeSystem) = false">
                            <xsl:attribute name="codeSystem">
                              <xsl:text>2.16.840.1.113883.12.292</xsl:text>
                            </xsl:attribute>
                          </xsl:if>
                          <xsl:if test ="codeSystem != ''">
                            <xsl:attribute name="codeSystem">
                              <xsl:value-of select="codeSystem"/>
                            </xsl:attribute>
                          </xsl:if>


                          <xsl:choose>
                            <xsl:when test="manufacturedMaterialObj/manufacturedMaterialTranslationCode != ''">
                              <xsl:attribute name="code">
                                <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationCode"/>
                              </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:attribute name="nullFlavor">
                                <xsl:text>NA</xsl:text>
                              </xsl:attribute>
                            </xsl:otherwise>
                          </xsl:choose>
                          <xsl:if test="manufacturedMaterialObj/manufacturedMaterialTranslationDisplayName != ''">
                            <xsl:attribute name="displayName">
                              <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationDisplayName"/>
                            </xsl:attribute>
                          </xsl:if>

                        </code>
                      </manufacturedMaterial>
                      <manufacturerOrganization>
                        <name>Immuno Inc.</name>
                      </manufacturerOrganization>
                    </manufacturedProduct>
                  </consumable>



                  <xsl:choose>
                    <xsl:when test ="boolean(rejectionReason) and rejectionReason != ''">
                      <entryRelationship typeCode="RSON">
                        <observation classCode="OBS" moodCode="EVN">
                          <!-- Immunization Refusal Reason  -->
                          <!-- there is no versioned version of this template -->
                          <!-- Included the reason since it may be relevant to a future clinician or quality measurement -->
                          <templateId root="2.16.840.1.113883.10.20.22.4.53"/>
                          <id root="c1296315-9a6d-45a2-aac0-ee225d375409"/>
                          <code codeSystemName="HL7 ActNoImmunizationReason" codeSystem="2.16.840.1.113883.5.8">
                            <xsl:if test="rejectionReason != ''">
                              <xsl:attribute name="displayName">
                                <xsl:value-of select="rejectionReason"/>
                              </xsl:attribute>
                            </xsl:if>
                            <xsl:choose>
                              <xsl:when test ="rejectionReasonCode != ''">
                                <xsl:attribute name="code">
                                  <xsl:value-of select="rejectionReasonCode"/>
                                </xsl:attribute>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:attribute name="nullFlavor">
                                  <xsl:text>OTH</xsl:text>
                                </xsl:attribute>
                              </xsl:otherwise>
                            </xsl:choose>
                          </code>
                          <statusCode code="completed"/>
                        </observation>
                      </entryRelationship>
                    </xsl:when>
                    <xsl:otherwise>

                    </xsl:otherwise>
                  </xsl:choose>


                </substanceAdministration>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.2.1" />
            <code code="11369-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of immunizations" />
            <title>IMMUNIZATIONS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="functionalstatus">
    <xsl:choose>
      <xsl:when test ="boolean(FunctionalStatusListObj/FunctionalStatus[Type = 'Functional']/Text)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.14" extension="2014-06-09"/>
            <!-- Functional Status Section -->
            <templateId root="2.16.840.1.113883.10.20.22.2.14"/>
            <code code = "47420-5" codeSystem = "2.16.840.1.113883.6.1"/>
            <title>FUNCTIONAL STATUS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Functional Condition</th>
                    <th>Date</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="FunctionalStatusListObj/FunctionalStatus[Type = 'Functional']">
                    <xsl:if test="Text != ''">
                      <tr>
                        <td>
                          <xsl:value-of select="Text"/>
                        </td>
                        <td>
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime">
                              <xsl:value-of select="effectiveTime"/>
                            </xsl:with-param>
                          </xsl:call-template >
                        </td>
                        <td>
                          Active
                        </td>
                      </tr>
                    </xsl:if >
                  </xsl:for-each >
                  <tr>
                    <td colspan="3">
                    </td>
                  </tr>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="FunctionalStatusListObj/FunctionalStatus[Type = 'Functional']">
              <xsl:if test="Text != ''">
                <entry>
                  <observation classCode="OBS" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.67" />
                    <id root="a7bc1062-8649-42a0-833d-ekd65bd013d1" >
                      <xsl:if test ="id != ''">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </xsl:if>
                    </id>
                    <code codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" code="64572001" displayName="Problem" />
                    <text>
                      <xsl:value-of select="Text"/>
                    </text>
                    <statusCode code="completed" />
                    <effectiveTime>
                      <xsl:choose>
                        <xsl:when test ="effectiveTime != ''">
                          <low>
                            <xsl:attribute name="value">
                              <xsl:value-of select="effectiveTime"/>
                            </xsl:attribute>
                          </low>
                        </xsl:when >
                        <xsl:otherwise>
                          <low nullFlavor="UNK"/>
                        </xsl:otherwise>
                      </xsl:choose>

                    </effectiveTime>
                    <value xsi:type="CD">
                      <xsl:choose>
                        <xsl:when test ="code != ''">
                          <xsl:attribute name="code">
                            <xsl:value-of select="code"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>UNK</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:choose>
                        <xsl:when test ="codeSystem != ''">
                          <xsl:attribute name="codeSystem">
                            <xsl:value-of select="codeSystem"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="codeSystem">
                            <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test ="Text != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="Text"/>
                        </xsl:attribute>
                      </xsl:if>
                    </value>
                  </observation>
                </entry>
              </xsl:if>
            </xsl:for-each >
          </section >
        </component >
      </xsl:when >
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.14" extension="2014-06-09" />
            <templateId root="2.16.840.1.113883.10.20.22.2.14" />
            <code code="47420-5" codeSystem="2.16.840.1.113883.6.1" />
            <title>FUNCTIONAL STATUS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test ="boolean(FunctionalStatusListObj/FunctionalStatus[Type = 'Cognitive']/Text)">
        <component>
          <section>
            <!-- note: the IG lists the wrong templateId in its example of this section, lists ...2,14 instead of 2.56 -db -->
            <!-- There is no R1.1 version of this template -db -->
            <templateId root="2.16.840.1.113883.10.20.22.2.56" extension="2015-08-01" />
            <!-- Mental Status Section -->
            <code code="10190-7" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="COGNITIVE STATUS" />
            <title>COGNITIVE STATUS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Condition</th>
                    <th>Date</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="FunctionalStatusListObj/FunctionalStatus[Type = 'Cognitive']">
                    <xsl:if test="Text != ''">
                      <tr>
                        <td>
                          <xsl:value-of select="Text"/>
                        </td>
                        <td>
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime">
                              <xsl:value-of select="effectiveTime"/>
                            </xsl:with-param>
                          </xsl:call-template >
                        </td>
                        <td>
                          Active
                        </td>
                      </tr>
                    </xsl:if >
                  </xsl:for-each >
                  <tr>
                    <td colspan="3">
                    </td>
                  </tr>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="FunctionalStatusListObj/FunctionalStatus[Type = 'Cognitive']">
              <xsl:if test="Text != ''">
                <entry>
                  <observation classCode="OBS" moodCode="EVN">
                    <!-- Mental Status Observation (V3) -->
                    <templateId root="2.16.840.1.113883.10.20.22.4.74" extension="2015-08-01" />
                    <!-- Cognitive Status Result Observation -->
                    <templateId root="2.16.840.1.113883.10.20.22.4.74"/>
                    <id root="a7bc1062-8649-42a0-833d-ekd65bd013d1">
                      <xsl:if test ="id != ''">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </xsl:if>
                    </id>
                    <code code="373930000" displayName="Cognitive function" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT">
                      <translation code="75275-8" displayName="Cognitive function" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"></translation>
                    </code>
                    <statusCode code="completed"/>
                    <effectiveTime>
                      <xsl:choose>
                        <xsl:when test ="effectiveTime != ''">
                          <low>
                            <xsl:attribute name="value">
                              <xsl:value-of select="effectiveTime"/>
                            </xsl:attribute>
                          </low>
                        </xsl:when >
                        <xsl:otherwise>
                          <low nullFlavor="UNK"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </effectiveTime>
                    <value xsi:type="CD">
                      <xsl:choose>
                        <xsl:when test ="code != ''">
                          <xsl:attribute name="code">
                            <xsl:value-of select="code"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>UNK</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:choose>
                        <xsl:when test ="codeSystem != ''">
                          <xsl:attribute name="codeSystem">
                            <xsl:value-of select="codeSystem"/>
                          </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:attribute name="codeSystem">
                            <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                          </xsl:attribute>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:if test ="Text != ''">
                        <xsl:attribute name="displayName">
                          <xsl:value-of select="Text"/>
                        </xsl:attribute>
                      </xsl:if>
                    </value>
                  </observation>
                </entry>
              </xsl:if>
            </xsl:for-each >
          </section >
        </component >
      </xsl:when >
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.14" extension="2014-06-09" />
            <templateId root="2.16.840.1.113883.10.20.22.2.14" />
            <code code="47420-5" codeSystem="2.16.840.1.113883.6.1" />
            <title>COGNITIVE STATUS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template >
  <xsl:template name="payer">
    <xsl:choose>
      <xsl:when test="boolean(patientRoleObj/insuranceProvider)">
        <xsl:for-each select="patientRoleObj">
          <component>
            <section>
              <!-- *** Payers Section (V3) *** -->
              <templateId root="2.16.840.1.113883.10.20.22.2.18" extension="2015-08-01"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.18"/>
              <code code="48768-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Payer"/>
              <title>INSURANCE PROVIDERS</title>
              <text>
                <table border="1" width="100%">
                  <thead>
                    <tr>
                      <th>Payer name</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>
                        <xsl:value-of select="insuranceProvider" />
                      </td>
                    </tr>
                  </tbody>
                </table>
              </text>
              <entry typeCode="DRIV">
                <act classCode="ACT" moodCode="EVN">
                  <!-- ** Coverage activity (V3) ** -->
                  <templateId root="2.16.840.1.113883.10.20.22.4.60" extension="2015-08-01"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.60"/>
                  <id root="1fe2cdd0-7aad-11db-9fe1-0800200c9a66"/>
                  <code code="48768-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Payment sources"/>
                  <statusCode code="completed"/>
                  <entryRelationship typeCode="COMP">
                    <sequenceNumber value="2"/>
                    <act classCode="ACT" moodCode="EVN">
                      <!-- ** Policy activity  (V3) ** -->
                      <templateId root="2.16.840.1.113883.10.20.22.4.61" extension="2015-08-01"/>
                      <!--Critical Change-->
                      <templateId root="2.16.840.1.113883.10.20.22.4.61"/>
                      <id root="3e676a50-7aac-11db-9fe1-0800200c9a66"/>
                      <code codeSystem="2.16.840.1.113883.3.221.5" xsi:type="CD" >
                        <xsl:if test="boolean(insuranceProviderCode) and (insuranceProviderCode != '')">
                          <xsl:attribute name="code">
                            <xsl:value-of select="insuranceProviderCode" />
                          </xsl:attribute>
                          <originalText>
                            <xsl:value-of select="insuranceProvider" />
                          </originalText>
                        </xsl:if>
                        <xsl:if test="(boolean(insuranceProviderCode) = false) or (insuranceProviderCode = '')">
                          <xsl:attribute name="code">
                            <xsl:text>349</xsl:text>
                          </xsl:attribute>
                          <originalText>
                            <xsl:text>other</xsl:text>
                          </originalText>
                        </xsl:if>
                      </code>
                      <statusCode code="completed"/>
                      <!-- Insurance Company Information -->
                      <!--
                <performer typeCode="PRF">
                  <templateId root="2.16.840.1.113883.10.20.22.4.87"/>
                  <assignedEntity>
                    <id root="2.16.840.1.113883.19"/>
                    <code code="PAYOR" codeSystem="2.16.840.1.113883.5.110" codeSystemName="HL7 RoleCode"/>
                    <addr use="WP">
                      <streetAddressLine>9009 Health Drive</streetAddressLine>
                      <city>Portland</city>
                      <state>OR</state>
                      <postalCode>99123</postalCode>
                      <country>US</country>
                    </addr>
                    <telecom value="tel:+1(555)555-1515" use="WP"/>
                    <representedOrganization>
                      <name>Good Health Insurance</name>
                      <telecom value="tel:+1(555)555-1515" use="WP"/>
                      <addr use="WP">
                        <streetAddressLine>9009 Health Drive</streetAddressLine>
                        <city>Portland</city>
                        <state>OR</state>
                        <postalCode>99123</postalCode>
                      </addr>
                    </representedOrganization>
                  </assignedEntity>
                </performer>
                -->
                      <!-- Guarantor Information... The person responsible for the final bill. -->
                      <!--
                <performer typeCode="PRF">
                  <templateId root="2.16.840.1.113883.10.20.22.4.88"/>
                  <time>
                    <low nullFlavor="UNK"/>
                    <high nullFlavor="UNK"/>
                  </time>
                  <assignedEntity>
                    <id root="329fcdf0-7ab3-11db-9fe1-0800200c9a66"/>
                    <code code="GUAR" codeSystem="2.16.840.1.113883.5.110" codeSystemName="HL7 RoleCode"/>
                    <addr use="HP">
                      <streetAddressLine>2222 Home Street</streetAddressLine>
                      <city>Beaverton</city>
                      <state>OR</state>
                      <postalCode>97867</postalCode>
                    </addr>
                    <telecom value="tel:+1(555)555-1000" use="HP"/>
                    <assignedPerson>
                      <name>
                        <given>Boris</given>
                        <family>Betterhalf</family>
                      </name>
                    </assignedPerson>
                  </assignedEntity>
                </performer>
                <participant typeCode="COV">
                  -->
                      <!-- Covered Party Participant -->
                      <!--
                  <templateId root="2.16.840.1.113883.10.20.22.4.89"/>
                  <time>
                    <low nullFlavor="UNK"/>
                    <high nullFlavor="UNK"/>
                  </time>
                  <participantRole classCode="PAT">
                    -->
                      <!-- Health plan ID for patient. -->
                      <!--
                    <id root="14d4a520-7aae-11db-9fe1-0800200c9a66" extension="1138345"/>
                    <code code="SELF" codeSystem="2.16.840.1.113883.5.111" displayName="Self"/>
                    <addr use="HP">
                      <streetAddressLine>2222 Home Street</streetAddressLine>
                      <city>Beaverton</city>
                      <state>OR</state>
                      <postalCode>97867</postalCode>
                    </addr>
                    <playingEntity>
                      <name>
                        -->
                      <!-- Name is needed if different than health plan name. -->
                      <!--
                        <given>Boris</given>
                        <family>Betterhalf</family>
                      </name>
                      <sdtc:birthTime value="19750501"/>
                    </playingEntity>
                  </participantRole>
                </participant>
                -->
                      <!-- Policy Holder -->
                      <!--
                <participant typeCode="HLD">
                  <templateId root="2.16.840.1.113883.10.20.22.4.90"/>
                  <participantRole>
                    <id extension="1138345" root="2.16.840.1.113883.19"/>
                    <addr use="HP">
                      <streetAddressLine>2222 Home Street</streetAddressLine>
                      <city>Beaverton</city>
                      <state>OR</state>
                      <postalCode>97867</postalCode>
                    </addr>
                  </participantRole>
                </participant>
                <entryRelationship typeCode="REFR">
                  <act classCode="ACT" moodCode="EVN">
                    -->
                      <!-- ** Authorization activity ** -->
                      <!--
                    <templateId root="2.16.840.1.113883.10.20.1.19"/>
                    <id root="f4dce790-8328-11db-9fe1-0800200c9a66"/>
                    <code nullFlavor="NA"/>
                    <entryRelationship typeCode="SUBJ">
                      <procedure classCode="PROC" moodCode="PRMS">
                        <code code="73761001" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="Colonoscopy"/>
                      </procedure>
                    </entryRelationship>
                  </act>
                </entryRelationship>
                -->
                      <!-- The above entryRelationship OR the following. <entryRelationship 
										typeCode="REFR"> <act classCode="ACT" moodCode="DEF"> <id root="f4dce790-8328-11db-9fe1-0800200c9a66"/> 
										<code nullFlavor="UNK"/> <text>Health Plan Name<reference value="PntrToHealthPlanNameInSectionText"/> 
										</text> <statusCode code="active"/> </act> </entryRelationship> -->
                    </act>
                  </entryRelationship>
                </act>
              </entry>
            </section>
          </component>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>


  </xsl:template>
  <xsl:template name="careplan">
    <xsl:choose>
      <xsl:when test="boolean(carePlanListObj/CarePlan) or boolean(labordersObjColl/Laborders) or boolean(ReferralListObj/Referral)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.10" extension="2014-06-09"/>
            <templateId root="2.16.840.1.113883.10.20.22.2.10"/>
            <!-- **** Plan of Care section template **** -->
            <code code="18776-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Treatment plan"/>
            <title>CARE PLAN</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="carePlanListObj/CarePlan">
                    <tr>
                      <td>
                        <xsl:value-of select="text"/>
                      </td>
                      <td>
                        <xsl:value-of select="plantype"/>
                        <!--(<xsl:value-of select="status"/>)-->
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="date"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                    </tr>
                  </xsl:for-each >
                  <xsl:for-each select="ReferralListObj/Referral">
                    <tr>
                      <td>
                        <xsl:value-of select="Reason"/>:
                        <xsl:value-of select="Details"/>
                      </td>
                      <td>
                        <xsl:text>Referal to other provider</xsl:text>
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="effectiveTime"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                    </tr>
                  </xsl:for-each >
                  <xsl:for-each select="labordersObjColl/Laborders">
                    <tr>
                      <td>
                        <xsl:value-of select="text"/>
                      </td>
                      <td>
                        Lab Order
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="time"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="carePlanListObj/CarePlan">
              <entry typeCode="DRIV">
                <act classCode="ACT" moodCode="INT">
                  <templateId root="2.16.840.1.113883.10.20.22.4.20"/>

                  <id root="3700b3b0-fbed-11e2-b778-0800200c9a66">
                    <xsl:if test ="id != ''">
                      <xsl:attribute name="extension">
                        <xsl:value-of select="id"/>
                      </xsl:attribute>
                    </xsl:if>
                  </id>

                  <code xsi:type="CE" displayName="Goal" >
                    <xsl:choose>
                      <xsl:when test ="codeCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="codeCode"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="codeSystem"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </code>
                  <text>
                    <xsl:value-of select="text"/>
                  </text>
                  <statusCode code="completed"></statusCode>

                  <xsl:choose>
                    <xsl:when test ="(boolean(date)) and date != ''">
                      <effectiveTime>
                        <xsl:attribute name="value">
                          <xsl:value-of select="date"/>
                        </xsl:attribute>
                      </effectiveTime>
                    </xsl:when>
                    <xsl:otherwise>
                      <effectiveTime nullFlavor="UNK">
                      </effectiveTime>
                    </xsl:otherwise>
                  </xsl:choose>

                </act>
              </entry>
            </xsl:for-each>
            <xsl:for-each select="ReferralListObj/Referral">
              <entry typeCode="DRIV">
                <act classCode="ACT" moodCode="INT">
                  <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
                  <id root="3700b3b0-fbed-11e2-b778-0800200c9a67">
                    <xsl:if test ="id != ''">
                      <xsl:attribute name="extension">
                        <xsl:value-of select="id"/>
                      </xsl:attribute>
                    </xsl:if>
                  </id>
                  <code xsi:type="CE" displayName="Referral" nullFlavor="OTH" codeSystem="2.16.840.1.113883.6.96">
                  </code>
                  <text>
                    <xsl:value-of select="Details"/>
                  </text>
                  <statusCode code="completed"></statusCode>
                  <effectiveTime>
                    <xsl:choose>
                      <xsl:when test ="effectiveTime != ''">
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTime"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>
                </act>
              </entry>
            </xsl:for-each>
            <xsl:for-each select="labordersObjColl/Laborders">
              <entry>
                <!-- For lab, this should be an RQO -->
                <observation classCode="OBS" moodCode="RQO">
                  <!-- Planned Observation (V2) -> Plan Of Care Activity Observation -->
                  <templateId root="2.16.840.1.113883.10.20.22.4.44" extension="2014-06-09"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.44"/>
                  <id root="b52bee94-c34b-4e2c-8c15-5ad9d6def513">
                    <xsl:if test ="id != ''">
                      <xsl:attribute name="extension">
                        <xsl:value-of select="id"/>
                      </xsl:attribute>
                    </xsl:if>
                  </id>

                  <code>
                    <xsl:choose>
                      <xsl:when test ="Code != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="Code"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="codeSystem"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.1</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="text != ''">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="text"/>
                      </xsl:attribute>
                    </xsl:if>
                  </code>

                  <!--Consol Planned Observation2 SHALL contain exactly one [1..1] statusCode 
							(CONF:1098-30453)/@code="active" Active (CodeSystem: 2.16.840.1.113883.5.14 ActStatus) (CONF:1098-32032) -->
                  <text>
                    <xsl:value-of select="text"/>
                  </text>
                  <statusCode code="active" />
                  <effectiveTime>
                    <xsl:choose>
                      <xsl:when test ="time != ''">
                        <xsl:attribute name="value">
                          <xsl:value-of select="time"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>
                </observation>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.10" extension="2014-06-09" />
            <templateId root="2.16.840.1.113883.10.20.22.2.10" />
            <code code="18776-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Treatment plan" />
            <title>CARE PLAN</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="assesment">
    <component>
      <section>
        <templateId root="2.16.840.1.113883.10.20.22.2.8"/>
        <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" code="51848-0" displayName="ASSESSMENTS"/>
        <title>ASSESSMENTS</title>
        <xsl:choose>
          <xsl:when test="boolean(assesmentListObj/Assesment)">
            <text>
              <table width = "100%" border = "1">
                <thead>
                  <tr>
                    <th>Assesments</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="assesmentListObj/Assesment">
                    <tr>
                      <td>
                        <xsl:value-of select="text"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
          </xsl:when>
          <xsl:otherwise>
            <text>Data in this section may be excluded or not available.</text>
          </xsl:otherwise>
        </xsl:choose>
      </section>
    </component>
  </xsl:template>
  <xsl:template name="healthconcern">

    <xsl:choose>
      <xsl:when test="boolean(healthConcernListObj/HealthConcern)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.58" extension="2015-08-01"/>
            <code code="75310-3" displayName="Health Concerns Document" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
            <title>HEALTH CONCERNS</title>
            <text>
              <table width = "100%" border = "1">
                <thead>
                  <tr>
                    <th>Observation</th>
                    <th>Status</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>

                  <xsl:choose>
                    <xsl:when test ="(boolean(healthStatusObj)) and healthStatusObj != ''">
                      <xsl:for-each select="healthStatusObj">
                        <tr>
                          <td>
                            <xsl:value-of select="value"/>
                          </td>
                          <td>Active</td>
                          <td>
                            <xsl:call-template name="show-time">
                              <xsl:with-param name="datetime">
                                <xsl:value-of select="date"/>
                              </xsl:with-param>
                            </xsl:call-template>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <tr>
                        <td></td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>

                </tbody>

              </table>

              <br></br>

              <table border="1" width="100%">
                <thead>
                  <tr>
                    <th>Concern</th>
                    <th>Status</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="healthConcernListObj/HealthConcern">
                    <tr>
                      <td>
                        <xsl:value-of select="value"/>
                      </td>
                      <td>
                        <xsl:value-of select="status"/>
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="date"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                    </tr>

                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="healthStatusObj">
              <entry>
                <observation classCode="OBS" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.5" extension="2014-06-09"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.5"/>
                  <id root="1eeb1e51-ee1d-1234-11xy-11z11ddb111z"/>
                  <code code="11323-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Health status"/>
                  <statusCode code="completed"/>
                  <value xsi:type="CD" >
                    <xsl:choose>
                      <xsl:when test ="code != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="code"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test ="codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="codeSystem"/>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.96</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test ="value != ''">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="value"/>
                      </xsl:attribute>
                    </xsl:if>
                  </value>
                </observation>
              </entry>
            </xsl:for-each>
            <xsl:for-each select="healthConcernListObj/HealthConcern">
              <entry>
                <!-- Health Concerns Act (V2) (V1 was added as a NEW template in R2.0, V2 was updated in R2.1) -db -->
                <act classCode="ACT" moodCode="EVN">
                  <templateId root="2.16.840.1.113883.10.20.22.4.132" extension="2015-08-01"/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.132"/>
                  <id root="4eab0e52-dd7d-4285-99eb-72d32ddb195c"/>
                  <code code="75310-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Health Concern"/>
                  <statusCode code="completed"/>
                  <!-- Concerns -db -->
                  <entryRelationship typeCode="REFR">
                    <act classCode="ACT" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.22.4.122"/>
                      <!-- This ID equals the problem, HyperTension in this case -db -->
                      <id root="33843155-1cc4-4232-a311-777849541779">
                        <xsl:if test ="id != ''">
                          <xsl:attribute name="extension">
                            <xsl:value-of select="id"/>
                          </xsl:attribute>
                        </xsl:if>
                      </id>
                      <!-- The code is nulled to "NP" Not Present" (as specified in reference -db) -->
                      <code nullFlavor="NP"/>
                      <statusCode code="completed"/>
                    </act>
                  </entryRelationship>
                </act>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.58" extension="2015-08-01" />
            <code code="75310-3" displayName="Health Concerns Document" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
            <title>HEALTH CONCERNS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  <xsl:template name="goals">
    <xsl:choose>
      <xsl:when test="boolean(goalListObj/Goal)">
        <component>
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.60"/>
            <code code="61146-7" displayName="GOALS" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
            <title>GOALS</title>
            <text>
              <table width = "100%" border = "1">
                <thead>
                  <tr>
                    <th>Goal</th>
                    <th>Value</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="goalListObj/Goal">
                    <tr>
                      <td>
                        <xsl:value-of select="text"/>
                      </td>
                      <td>
                        <xsl:value-of select="value"/>
                      </td>
                      <td>
                        <xsl:call-template name="show-time">
                          <xsl:with-param name="datetime">
                            <xsl:value-of select="date"/>
                          </xsl:with-param>
                        </xsl:call-template >
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </text>
            <xsl:for-each select="goalListObj/Goal">
              <entry>
                <!-- Goal Observation -->
                <observation classCode="OBS" moodCode="GOL">
                  <!-- Goal Observation -->
                  <templateId root="2.16.840.1.113883.10.20.22.4.121"/>
                  <id root="3700b3b0-fbed-11e2-b778-0800200c9a66">
                    <xsl:if test ="id != ''">
                      <xsl:attribute name="extension">
                        <xsl:value-of select="id"/>
                      </xsl:attribute>
                    </xsl:if>
                  </id>
                  <!-- TODO (min - not required for test data): find a more suitable LOINC code for generic fever or for Visual Inspection -db -->
                  <code code="58144-7" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Resident's overall goal established during assessment process"/>
                  <statusCode code="active"/>

                  <effectiveTime>
                    <xsl:choose>
                      <xsl:when test ="date != ''">
                        <xsl:attribute name="value">
                          <xsl:value-of select="date"/>
                        </xsl:attribute>
                      </xsl:when >
                      <xsl:otherwise>
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </effectiveTime>


                  <xsl:choose>
                    <xsl:when test ="boolean(text) and text != ''">
                      <value xsi:type="ST">
                        <xsl:value-of select="text"/>
                      </value>
                    </xsl:when >
                    <xsl:otherwise>
                      <value xsi:type="CD" nullFlavor="UNK"></value>
                    </xsl:otherwise>
                  </xsl:choose>


                  <!-- this may not be the recommended way to record a visual inspection -db -->
                  <!--<value xsi:type="ST">
                    <xsl:value-of select="text"/>
                  </value>-->

                  <!--<author>
						  <templateId root="2.16.840.1.113883.10.20.22.4.119"/>
						  <time value="20130730"/>
						  <assignedAuthor>
							  <id root="d839038b-7171-4165-a760-467925b43857"/>
							  <code code="163W00000X" displayName="Registered nurse" codeSystem="2.16.840.1.113883.6.101" codeSystemName="Healthcare Provider Taxonomy (HIPAA)"/>
							  <assignedPerson>
								  <name>
									  <given>Nurse</given>
									  <family>Florence</family>
									  <suffix>RN</suffix>
								  </name>
							  </assignedPerson>
						  </assignedAuthor>
					  </author>
					  <author typeCode="AUT">
						  <templateId root="2.16.840.1.113883.10.20.22.4.119"/>
						  <time/>
						  <assignedAuthor>
							  <id extension="996-756-495" root="2.16.840.1.113883.19.5"/>
						  </assignedAuthor>
					  </author>-->

                  <!-- removed (MAY) "Goal REFERS TO Health Concern" as not required by test data -db -->
                  <!-- removed (SHOULD) Priority Preference as not required by test data -db -->
                </observation>
              </entry>
            </xsl:for-each>
          </section>
        </component>
      </xsl:when>
      <xsl:otherwise>
        <component>
          <section nullFlavor="NI">
            <templateId root="2.16.840.1.113883.10.20.22.2.60" />
            <code code="61146-7" displayName="GOALS" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
            <title>GOALS</title>
            <text>Data in this section may be excluded or not available.</text>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="dischargeinstructions">
    <xsl:if test="dischargeinstructions != ''">
      <component>
        <section>
          <templateId root = "2.16.840.1.113883.10.20.22.2.41"/>
          <code code = "8653-8" codeSystem = "2.16.840.1.113883.6.1" codeSystemName = "LOINC" displayName = "HOSPITAL DISCHARGE INSTRUCTIONS"/>
          <title>HOSPITAL DISCHARGE INSTRUCTIONS</title>
          <text>
            <xsl:value-of select="dischargeinstructions"/>
          </text>
        </section>
      </component>
    </xsl:if>
  </xsl:template>
  <xsl:template name="referrals">
    <text>
      <xsl:for-each select="ReferralListObj/Referral">
        <paragraph>
          <xsl:value-of select="Reason"/><br></br>
          Details: <xsl:value-of select="Details"/><br></br>
          <xsl:if test ="effectiveTime != ''">
            Scheduled Appointment Date:
            <xsl:call-template name="show-time">
              <xsl:with-param name="datetime">
                <xsl:value-of select="effectiveTime"/>
              </xsl:with-param>
            </xsl:call-template >
          </xsl:if>
          <br></br>
        </paragraph>
      </xsl:for-each >
    </text>
    <xsl:for-each select="ReferralListObj/Referral">
      <entry>
        <act moodCode="INT" classCode="PCPR">
          <templateId root="2.16.840.1.113883.10.20.22.4.140" />
          <!-- This id may be referenced in the note received afterward -->
          <id root="9a6d1bac-17d3-4195-89a4-1121bc809b4e">
            <xsl:if test ="id != ''">
              <xsl:attribute name="extension">
                <xsl:value-of select="id"/>
              </xsl:attribute>
            </xsl:if>
          </id>
          <code code="103697008" displayName="Patient referral to specialist" codeSystemName="SNOMED CT" codeSystem="2.16.840.1.113883.6.96" ></code>
          <text>
            <xsl:value-of select="Details"/>
          </text>
          <statusCode code="active" />
          <effectiveTime value="20180623" />
        </act>
      </entry>
    </xsl:for-each >
  </xsl:template>
  <xsl:template name="formatDateTime">
    <xsl:param name="date"/>
    <!-- month -->
    <xsl:variable name="month" select="substring ($date, 5, 2)"/>
    <xsl:choose>
      <xsl:when test="$month='01'">
        <xsl:text>January </xsl:text>
      </xsl:when>
      <xsl:when test="$month='02'">
        <xsl:text>February </xsl:text>
      </xsl:when>
      <xsl:when test="$month='03'">
        <xsl:text>March </xsl:text>
      </xsl:when>
      <xsl:when test="$month='04'">
        <xsl:text>April </xsl:text>
      </xsl:when>
      <xsl:when test="$month='05'">
        <xsl:text>May </xsl:text>
      </xsl:when>
      <xsl:when test="$month='06'">
        <xsl:text>June </xsl:text>
      </xsl:when>
      <xsl:when test="$month='07'">
        <xsl:text>July </xsl:text>
      </xsl:when>
      <xsl:when test="$month='08'">
        <xsl:text>August </xsl:text>
      </xsl:when>
      <xsl:when test="$month='09'">
        <xsl:text>September </xsl:text>
      </xsl:when>
      <xsl:when test="$month='10'">
        <xsl:text>October </xsl:text>
      </xsl:when>
      <xsl:when test="$month='11'">
        <xsl:text>November </xsl:text>
      </xsl:when>
      <xsl:when test="$month='12'">
        <xsl:text>December </xsl:text>
      </xsl:when>
    </xsl:choose>
    <!-- day -->
    <xsl:choose>
      <xsl:when test='substring ($date, 7, 1)="0"'>
        <xsl:value-of select="substring ($date, 8, 1)"/>
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring ($date, 7, 2)"/>
        <xsl:text>, </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- year -->
    <xsl:value-of select="substring ($date, 1, 4)"/>
    <!-- time and US timezone -->
    <xsl:if test="string-length($date) > 8">
      <xsl:text>, </xsl:text>
      <!-- time -->
      <xsl:variable name="time">
        <xsl:value-of select="substring($date,9,6)"/>
      </xsl:variable>
      <xsl:variable name="hh">
        <xsl:value-of select="substring($time,1,2)"/>
      </xsl:variable>
      <xsl:variable name="mm">
        <xsl:value-of select="substring($time,3,2)"/>
      </xsl:variable>
      <xsl:variable name="ss">
        <xsl:value-of select="substring($time,5,2)"/>
      </xsl:variable>
      <xsl:if test="string-length($hh)&gt;1">
        <xsl:value-of select="$hh"/>
        <xsl:if test="string-length($mm)&gt;1 and not(contains($mm,'-')) and not (contains($mm,'+'))">
          <xsl:text>:</xsl:text>
          <xsl:value-of select="$mm"/>
          <xsl:if test="string-length($ss)&gt;1 and not(contains($ss,'-')) and not (contains($ss,'+'))">
            <xsl:text>:</xsl:text>
            <xsl:value-of select="$ss"/>
          </xsl:if>
        </xsl:if>
      </xsl:if>
      <!-- time zone -->
      <xsl:variable name="tzon">
        <xsl:choose>
          <xsl:when test="contains($date,'+')">
            <xsl:text>+</xsl:text>
            <xsl:value-of select="substring-after($date, '+')"/>
          </xsl:when>
          <xsl:when test="contains($date,'-')">
            <xsl:text>-</xsl:text>
            <xsl:value-of select="substring-after($date, '-')"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:choose>
        <!-- reference: http://www.timeanddate.com/library/abbreviations/timezones/na/ -->
        <xsl:when test="$tzon = '-0500' ">
          <xsl:text>, EST</xsl:text>
        </xsl:when>
        <xsl:when test="$tzon = '-0600' ">
          <xsl:text>, CST</xsl:text>
        </xsl:when>
        <xsl:when test="$tzon = '-0700' ">
          <xsl:text>, MST</xsl:text>
        </xsl:when>
        <xsl:when test="$tzon = '-0800' ">
          <xsl:text>, PST</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text> </xsl:text>
          <xsl:value-of select="$tzon"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template name="show-time">
    <xsl:param name="datetime"/>
    <xsl:choose>
      <xsl:when test="not($datetime)">
        <xsl:call-template name="formatDateTime">
          <xsl:with-param name="date" select="@value"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="formatDateTime">
          <xsl:with-param name="date" select="$datetime"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="ClinicalNotes">
    <xsl:param name="notetype"/>
    <xsl:param name="notetypedisplay"/>
    <xsl:param name="noteloinc"/>
    <xsl:choose>
      <xsl:when test="boolean(ClinicalNotesObj/ClinicalNote)">
        <xsl:for-each select="ClinicalNotesObj/ClinicalNote">
          <xsl:if test ="$notetype = clinicalnotetypeobj">
            <component>
              <section>
                <!-- Notes Section -->
                <templateId root="2.16.840.1.113883.10.20.22.2.65" extension="2016-11-01"/>
                <!-- This Notes Section is not intended to replace a C-CDA Consultation Note Document -->
                <!-- If your system captures Consultation Note information in Discrete sections it's not recommended to lump all the text together here. -->
                <!-- This Notes Section could be included in a Consultation Note Document with other discrete sections (Results, Vitals etc.)-->
                <!-- This Notes Section is most appropriate for an encounter specific document -->
                <!-- If this Notes section were included in a CCD, each Note Activity entry should be linked to an appropriate Encounter entry in the Encounters section -->
                <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Consultation note">
                  <xsl:attribute name="code">
                    <!--<xsl:text>28570-0</xsl:text>-->
                    <xsl:value-of select="$noteloinc"/>
                  </xsl:attribute>
                </code>
                <title>
                  <xsl:value-of select="$notetypedisplay"/>
                </title>
                <text>
                  <xsl:value-of select="note" disable-output-escaping="yes"/>
                </text>
                <!-- Note Activity entry -->
                <entry>
                  <act classCode="ACT" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.202" extension="2016-11-01"/>
                    <id root="9a6d1bac-17d3-4195-89a4-1121bc809923">
                      <xsl:if test ="id != ''">
                        <xsl:attribute name="extension">
                          <xsl:value-of select="id"/>
                        </xsl:attribute>
                      </xsl:if>
                    </id>

                    <code code="34109-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Note">

                      <translation codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="note">
                        <xsl:attribute name="code">
                          <xsl:value-of select="$noteloinc"/>
                        </xsl:attribute>
                      </translation>

                    </code>
                    <text>
                      <xsl:value-of select="note"/>
                    </text>
                    <statusCode code="completed"/>
                    <!-- Clinically-relevant time of the note -->
                    <effectiveTime>
                      <xsl:attribute name="value">
                        <xsl:value-of select="//author/visitDate"/>
                      </xsl:attribute>
                    </effectiveTime>
                    <xsl:if test="boolean(author)">
                      <author>
                        <xsl:choose>
                          <xsl:when test="boolean(author/givenName)">
                            <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                            <time>
                              <xsl:attribute name="value">
                                <xsl:value-of select="author/visitDate"/>
                              </xsl:attribute>
                            </time>
                            <assignedAuthor>
                              <id  root = "2.16.840.1.113883.4.6">
                                <xsl:attribute name="extension">
                                  <xsl:value-of select="author/providerid"/>
                                </xsl:attribute>
                              </id>
                              <addr use = "WP">
                                <xsl:call-template name="facilityAddressDetails"/>
                              </addr>
                              <telecom use = "WP">
                                <xsl:choose>
                                  <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                    <xsl:attribute name="value">
                                      <xsl:text>tel:</xsl:text>
                                      <xsl:value-of select="//FacilityAddressObj/phone"/>
                                    </xsl:attribute>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:attribute name="nullFlavor">
                                      <xsl:text>UNK</xsl:text>
                                    </xsl:attribute>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </telecom>
                              <assignedPerson>
                                <name>
                                  <xsl:if test="author/suffix != ''">
                                    <suffix>
                                      <xsl:value-of select="author/suffix"/>
                                    </suffix>
                                  </xsl:if>
                                  <xsl:if test="author/prefix != ''">
                                    <prefix>
                                      <xsl:value-of select="author/prefix"/>
                                    </prefix>
                                  </xsl:if>
                                  <given>
                                    <xsl:value-of select="author/givenName"/>
                                  </given>
                                  <family>
                                    <xsl:value-of select="author/familyName"/>
                                  </family>
                                </name>
                              </assignedPerson>
                              <representedOrganization>
                                <id>
                                  <xsl:attribute name="root">
                                    <xsl:value-of select="//EHRID"/>
                                  </xsl:attribute>
                                </id>
                                <xsl:choose>
                                  <xsl:when test="boolean(//FacilityAddressObj/name) and //FacilityAddressObj/name != ''">
                                    <name>
                                      <xsl:value-of select="//FacilityAddressObj/name"/>
                                    </name>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <name nullFlavor="UNK"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <telecom use="WP">
                                  <xsl:choose>
                                    <xsl:when test="boolean(//FacilityAddressObj/phone) and //FacilityAddressObj/phone != ''">
                                      <xsl:attribute name="value">
                                        <xsl:text>tel:</xsl:text>
                                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                                      </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                      <xsl:attribute name="nullFlavor">
                                        <xsl:text>UNK</xsl:text>
                                      </xsl:attribute>
                                    </xsl:otherwise>
                                  </xsl:choose>
                                </telecom>
                                <addr use = "WP">
                                  <xsl:call-template name="facilityAddressDetails"/>
                                </addr>
                              </representedOrganization>
                            </assignedAuthor>
                          </xsl:when>
                          <xsl:otherwise>
                            <author>
                              <templateId root="2.16.840.1.113883.10.20.22.4.119" />
                              <time nullFlavor="UNK" />
                              <assignedAuthor>
                                <id nullFlavor="UNK" />
                                <addr>
                                  <streetAddressLine nullFlavor="UNK"/>
                                  <city nullFlavor="UNK"/>
                                </addr>
                                <telecom nullFlavor="UNK" />
                              </assignedAuthor>
                            </author>
                          </xsl:otherwise>
                        </xsl:choose>
                      </author>
                    </xsl:if>

                  </act>
                </entry>
              </section>
            </component>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>