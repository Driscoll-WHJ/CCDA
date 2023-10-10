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
    <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" >
      <xsl:attribute name="code">
        <xsl:value-of select="CCDACode"/>
      </xsl:attribute>
      <xsl:attribute name="displayName">
        <xsl:value-of select="CCDADisplayName"/>
      </xsl:attribute>
    </code>
    <title>
      <xsl:value-of select="CCDADisplayName"/>
    </title>
    <effectiveTime>
      <xsl:attribute name="value">
        <xsl:value-of select="CCDAEffectiveTimeValue"/>
      </xsl:attribute>
    </effectiveTime>
    <confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25"/>
    <languageCode code="en-US"/>
    <recordTarget>
      <xsl:call-template name="patientRoleObj"/>
    </recordTarget>

    <author>
      <xsl:choose>
        <xsl:when test="boolean(author/givenName)">
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
            <code code = "208D00000X " codeSystem = "2.16.840.1.113883.6.101" codeSystemName = "NUCC">
              <xsl:attribute name="displayName">
                <xsl:value-of select="FacilityAddressObj/name"/>
              </xsl:attribute>
            </code>
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
                <xsl:value-of select="FacilityAddressObj/phone"/>
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
                  <xsl:value-of select="//FacilityAddressObj/phone"/>
                </xsl:attribute>
              </telecom>
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

    <dataEnterer>
      <assignedEntity>
        <id  root = "2.16.840.1.113883.4.6">
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
            <xsl:value-of select="FacilityAddressObj/phone"/>
          </xsl:attribute>
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
            <xsl:value-of select="FacilityAddressObj/phone"/>
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
              <id extension = "1234567" root = "2.16.840.1.113883.4.6"/>
              <name>
                <xsl:value-of select="FacilityAddressObj/name"/>
              </name>
              <telecom use = "WP">
                <xsl:attribute name="value">
                  <xsl:value-of select="FacilityAddressObj/phone"/>
                </xsl:attribute>
              </telecom>
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

    <!--<informationRecipient>
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
            <given>
              <xsl:value-of select="informationRecepient/givenName"/>
            </given>
            <family>
              <xsl:value-of select="informationRecepient/familyName"/>
            </family>
          </name>
        </informationRecipient>
        <receivedOrganization>
          <name>
            <xsl:value-of select="//FacilityAddressObj/name"/>
          </name>
        </receivedOrganization>
      </intendedRecipient>
    </informationRecipient>-->

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
            <xsl:value-of select="FacilityAddressObj/phone"/>
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
            <xsl:value-of select="FacilityAddressObj/phone"/>
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
              <xsl:attribute name="assigningAuthorityName">
                <xsl:value-of select="//EHRName"/>
              </xsl:attribute>
            </id>
            <code >
              <xsl:choose>
                <xsl:when test="boolean(encounterListObj/Encounter/cptCodes)">
                  <xsl:attribute name="code">
                    <xsl:value-of select="encounterListObj/Encounter/cptCodes"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="encounterListObj/Encounter/text"/>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>NA</xsl:text>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
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

            </code>
            <effectiveTime>
              <xsl:if test ="encounterListObj/Encounter/effectiveTimeLow != ''">
                <low>
                  <xsl:attribute name="value">
                    <xsl:value-of select="encounterListObj/Encounter/effectiveTimeLow"/>
                  </xsl:attribute>
                </low>
              </xsl:if >
              <xsl:if test ="encounterListObj/Encounter/effectiveTimeHigh != ''">
                <high>
                  <xsl:attribute name="value">
                    <xsl:value-of select="encounterListObj/Encounter/effectiveTimeHigh"/>
                  </xsl:attribute>
                </high>
              </xsl:if >
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
                  <xsl:attribute name="assigningAuthorityName">
                    <xsl:value-of select="//EHRName"/>
                  </xsl:attribute>
                </id>
                <code code = "261QU0200X" codeSystem = "2.16.840.1.113883.6.101" codeSystemName = "NUCC" displayName = "Urgent Care"/>
                <location>
                  <name>
                    <xsl:value-of select="encounterListObj/Encounter/encounterlocation"/>
                  </name>
                  <addr>
                    <streetAddressLine>
                      <xsl:value-of select="encounterListObj/Encounter/encounteraddress/streetAddressLine"/>
                    </streetAddressLine>
                    <city>
                      <xsl:value-of select="encounterListObj/Encounter/encounteraddress/city"/>
                    </city>
                    <state>
                      <xsl:value-of select="encounterListObj/Encounter/encounteraddress/state"/>
                    </state>
                    <postalCode>
                      <xsl:value-of select="encounterListObj/Encounter/encounteraddress/postalCode"/>
                    </postalCode>
                    <country>
                      <xsl:value-of select="encounterListObj/Encounter/encounteraddress/country"/>
                    </country>
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
        </xsl:choose>
        <xsl:if test ="boolean(allergyListObj/Allergy)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.6.1" extension="2015-08-01"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.6.1"/>
              <!-- Alerts section template -->
              <code code="48765-2" codeSystem="2.16.840.1.113883.6.1"/>
              <title>ALLERGIES, ADVERSE REACTIONS</title>
              <xsl:call-template name="allergies"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test="boolean(immunizationListObj/Immunization)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.2.1"/>
              <!-- Entries Required -->
              <!-- ******** Immunizations section template ******** -->
              <code code="11369-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="History of immunizations"/>
              <title>IMMUNIZATIONS</title>
              <xsl:call-template name="immunization"/>
            </section>
          </component>
        </xsl:if>

        <xsl:if test="boolean(medicationListObj/Medication)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.1.1" extension="2014-06-09"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.1.1"/>
              <code code="10160-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF MEDICATION USE"/>
              <title>MEDICATIONS</title>
              <xsl:call-template name="medication"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test="boolean(medicationAdministedListObj/Medication)">
          <component>
            <section>
              <templateId root = "2.16.840.1.113883.10.20.22.2.38"/>
              <code code = "29549-3" codeSystem = "2.16.840.1.113883.6.1" codeSystemName = "LOINC" displayName = "MEDICATIONS ADMINISTERED"/>
              <title>MEDICATIONS ADMINISTERED DURING VISIT</title>
              <xsl:call-template name="medicationadministered"/>
            </section >
          </component >
        </xsl:if>

        <xsl:if test="boolean(carePlanListObj/CarePlan)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.10" extension="2014-06-09"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.10"/>
              <!-- **** Plan of Care section template **** -->
              <code code="18776-5" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Treatment plan"/>
              <title>CARE PLAN</title>
              <xsl:call-template name="careplan"/>
            </section>
          </component>
        </xsl:if>

        <xsl:if test="boolean(assesmentListObj/Assesment)">
          <xsl:call-template name="assesment"/>
        </xsl:if>
        <xsl:if test="boolean(healthConcernListObj/HealthConcern)">
          <xsl:call-template name="healthconcern"/>
        </xsl:if>
        <xsl:if test="boolean(goalListObj/Goal)">
          <xsl:call-template name="goals"/>
        </xsl:if>

        <xsl:if test="boolean(procedureListObj/Procedure)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.7.1"/>
              <!-- Procedures section template -->
              <code code="47519-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="HISTORY OF PROCEDURES"/>
              <title>PROCEDURES</title>
              <xsl:call-template name="procedures"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test ="boolean(socialHistoryListObj/SocialHistory)">
          <component>
            <!-- Social History ******** -->
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.17" extension="2015-08-01"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.17"/>
              <!-- ******** Social history section template ******** -->
              <code code="29762-2" codeSystem="2.16.840.1.113883.6.1" displayName="Social History"/>
              <title>SOCIAL HISTORY</title>
              <xsl:call-template name="socialhistory"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test="boolean(vitalSignListObj/VitalSign/Observation/VitalSignObs)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.4.1" extension="2015-08-01"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.4.1"/>
              <code code="8716-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="VITAL SIGNS"/>
              <title>VITAL SIGNS</title>
              <xsl:call-template name="vitalsigns"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test ="boolean(encounterListObj/Encounter)">
          <xsl:call-template name="encounters"/>
        </xsl:if>
        <xsl:if test="boolean(resultListObj/Result)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.3.1" extension="2015-08-01"/>
              <templateId root = "2.16.840.1.113883.10.20.22.2.3.1"/>
              <code code = "30954-2" codeSystem = "2.16.840.1.113883.6.1" codeSystemName = "LOINC" displayName = "RESULTS"/>
              <title>RESULTS</title>
              <xsl:call-template name="results"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test="boolean(problemListObj/Problem)">
          <component>
            <section>
              <templateId root="2.16.840.1.113883.10.20.22.2.5.1" extension="2015-08-01"/>
              <templateId root="2.16.840.1.113883.10.20.22.2.5.1"/>
              <code code="11450-4" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="PROBLEM LIST"/>
              <title>PROBLEMS</title>
              <xsl:call-template name="problems"/>
            </section>
          </component>
        </xsl:if>
        <xsl:if test ="boolean(FunctionalStatusListObj/FunctionalStatus/Text)">
          <xsl:call-template name="functionalstatus"/>
        </xsl:if>

        <xsl:if test="boolean(ReferralListObj/Referral)">
          <component>
            <section>
              <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1" extension="2014-06-09"/>
              <templateId root="1.3.6.1.4.1.19376.1.5.3.1.3.1"/>
              <code code="42349-1" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="REFERRALS"/>
              <title>REFERRALS</title>
              <xsl:call-template name="referrals"/>
            </section >
          </component >
        </xsl:if>

        <xsl:call-template name="dischargeinstructions"/>
      </structuredBody >
    </component >
  </xsl:template>
  <xsl:template name="patientRoleObj">
    <xsl:choose>
      <xsl:when test ="boolean(patientRoleObj/mrn)">
        <xsl:for-each select="patientRoleObj">
          <patientRole>
            <!-- CONF 5268-->

            <id>
              <xsl:attribute name="root">
                <xsl:value-of select="../EHRID"/>
              </xsl:attribute>
              <xsl:attribute name="extension">
                <xsl:value-of select="mrn"/>
              </xsl:attribute>
              <xsl:attribute name="assigningAuthorityName">
                <xsl:value-of select="../EHRName"/>
              </xsl:attribute>
            </id>
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

                <xsl:if test="boolean(patientMiddleName)">
                  <given>
                    <xsl:value-of select="patientMiddleName"/>
                  </given>
                </xsl:if>

                <family>
                  <xsl:value-of select="patientFamilyName"/>
                </family>

                <xsl:if test="boolean(patientSuffix)">
                  <suffix>
                    <xsl:value-of select="patientSuffix"/>
                  </suffix>
                </xsl:if>
              </name>

              <xsl:if test="boolean(patientPreviousName)">
                <name>
                  <given  qualifier="BR">
                    <xsl:value-of select="patientPreviousName"/>
                  </given>
                  <family>
                    <xsl:value-of select="patientFamilyName"/>
                  </family>
                </name>
              </xsl:if>

              <administrativeGenderCode codeSystem="2.16.840.1.113883.5.1" 	displayName="TBD:Female">
                <xsl:attribute name="code">
                  <xsl:value-of select="administrativeGenderCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="administrativeGenderDisplayName"/>
                </xsl:attribute>
              </administrativeGenderCode
              >
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
                <xsl:if test ="raceCode='ASKU' or raceCode='UNK' or raceCode=''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>ASKU</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="raceCode !='ASKU' and raceCode !='UNK' or raceCode!=''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="raceCode"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="race"/>
                </xsl:attribute>
              </raceCode>

              <xsl:if test="boolean(granularRacecode) = 'true'">
                <sdtc:raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                  <xsl:attribute name="code">
                    <xsl:value-of select="granularRacecode"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="granularRace"/>
                  </xsl:attribute>
                </sdtc:raceCode>
              </xsl:if>
              <xsl:if test="boolean(additionalraceCode) = 'true'">
                <raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity" xmlns="urn:hl7-org:sdtc" >
                  <xsl:if test ="additionalraceCode='ASKU'">
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>ASKU</xsl:text>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test ="additionalraceCode != 'ASKU'">
                    <xsl:attribute name="code">
                      <xsl:value-of select="additionalraceCode"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="additionalrace"/>
                  </xsl:attribute>
                </raceCode>
              </xsl:if>

              <xsl:if test="boolean(additionalgranularRacecode) = 'true'">
                <sdtc:raceCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                  <xsl:attribute name="code">
                    <xsl:value-of select="additionalgranularRacecode"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="additionalgranularRace"/>
                  </xsl:attribute>
                </sdtc:raceCode>
              </xsl:if>

              <ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                <xsl:if test ="ethnicGroupCode='ASKU' or ethnicGroupCode='UNK' or ethnicGroupCode=''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>ASKU</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="ethnicGroupCode !='ASKU' or ethnicGroupCode !='UNK' or ethnicGroupCode !=''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="ethnicGroupCode"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="ethnicGroupCodeDisplayName"/>
                </xsl:attribute>
              </ethnicGroupCode>
              <xsl:if test="boolean(granularethnicGroupCode) = 'true'">
                <sdtc:ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                  <xsl:attribute name="code">
                    <xsl:value-of select="granularethnicGroupCode"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="granularethnicGroupCodeDisplayName"/>
                  </xsl:attribute>
                </sdtc:ethnicGroupCode>
              </xsl:if>

              <xsl:if test="boolean(additionalethnicGroupCode) = 'true'">
                <ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity" xmlns="urn:hl7-org:sdtc">
                  <xsl:if test ="additionalethnicGroupCode='ASKU'">
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>ASKU</xsl:text>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test ="additionalethnicGroupCode != 'ASKU'">
                    <xsl:attribute name="code">
                      <xsl:value-of select="additionalethnicGroupCode"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="additionalethnicGroupCodeDisplayName"/>
                  </xsl:attribute>
                </ethnicGroupCode>
              </xsl:if>
              <xsl:if test="boolean(additionalgranularethnicGroupCode) = 'true'">
                <sdtc:ethnicGroupCode codeSystem="2.16.840.1.113883.6.238" codeSystemName="CDC - Race and Ethnicity">
                  <xsl:attribute name="code">
                    <xsl:value-of select="additionalgranularethnicGroupCode"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="additionalgranularethnicGroupCodeDisplayName"/>
                  </xsl:attribute>
                </sdtc:ethnicGroupCode>
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
                  <xsl:if test ="languageCommunication ='ASKU'">
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>ASKU</xsl:text>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test ="languageCommunication != 'ASKU'">
                    <xsl:attribute name="code">
                      <xsl:value-of select="languageCommunication"/>
                    </xsl:attribute>
                  </xsl:if>
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
                  <id root="1.1.1.1.1.1.1.1.4"/>
                  <name>
                    <xsl:value-of select="../FacilityAddressObj/name"/>
                  </name>
                  <telecom use = "WP">
                    <xsl:attribute name="value">
                      <xsl:value-of select="../FacilityAddressObj/phone"/>
                    </xsl:attribute>
                  </telecom>
                  <addr use = "WP">
                    <streetAddressLine>
                      <xsl:value-of select="../FacilityAddressObj/streetAddressLine"/>
                    </streetAddressLine>
                    <city>
                      <xsl:value-of select="../FacilityAddressObj/city"/>
                    </city>
                    <state>
                      <xsl:value-of select="../FacilityAddressObj/state"/>
                    </state>
                    <postalCode>
                      <xsl:value-of select="../FacilityAddressObj/postalCode"/>
                    </postalCode>
                    <country>
                      <xsl:value-of select="../FacilityAddressObj/country"/>
                    </country>
                  </addr>
                </providerOrganization>
              </xsl:when>
              <xsl:otherwise>
                <providerOrganization>
                  <id root="1.1.1.1.1.1.1.1.4"/>
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
          <id>
            <xsl:attribute name="root">
              <xsl:value-of select="//EHRID"/>
            </xsl:attribute>
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
            <xsl:attribute name="assigningAuthorityName">
              <xsl:value-of select="//EHRName"/>
            </xsl:attribute>
          </id>
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
                <assignedEntity>
                  <id>
                    <xsl:attribute name="root">
                      <xsl:value-of select="//EHRID"/>
                    </xsl:attribute>
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
                    <xsl:attribute name="assigningAuthorityName">
                      <xsl:value-of select="//EHRName"/>
                    </xsl:attribute>
                  </id>
                  <code code="200000000X" displayName="General Physicians" codeSystemName="Provider Codes" codeSystem="2.16.840.1.113883.6.101"/>
                  <addr>
                    <streetAddressLine>
                      <xsl:if test="streetAddressLine != ''">
                        <xsl:value-of select="streetAddressLine"/>
                      </xsl:if>
                      <xsl:if test="streetAddressLine = '' or boolean(streetAddressLine) = false">
                        <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
                      </xsl:if>
                    </streetAddressLine>
                    <city>
                      <xsl:if test="city != ''">
                        <xsl:value-of select="city"/>
                      </xsl:if>
                      <xsl:if test="city = '' or boolean(city) = false">
                        <xsl:value-of select="//FacilityAddressObj/city"/>
                      </xsl:if>
                    </city>
                    <state>
                      <xsl:if test="state != ''">
                        <xsl:value-of select="state"/>
                      </xsl:if>
                      <xsl:if test="state = '' or boolean(state) = false">
                        <xsl:value-of select="//FacilityAddressObj/state"/>
                      </xsl:if>
                    </state>
                    <postalCode>
                      <xsl:if test="postalCode != ''">
                        <xsl:value-of select="postalCode"/>
                      </xsl:if>
                      <xsl:if test="postalCode = '' or boolean(postalCode) = false">
                        <xsl:value-of select="//FacilityAddressObj/postalCode"/>
                      </xsl:if>
                    </postalCode>
                    <country>
                      <xsl:if test="country != ''">
                        <xsl:value-of select="country"/>
                      </xsl:if>
                      <xsl:if test="country = '' or boolean(country) = false">
                        <xsl:value-of select="//FacilityAddressObj/country"/>
                      </xsl:if>
                    </country>
                  </addr>
                  <telecom use="WP">
                    <xsl:attribute name="value">
                      <xsl:value-of select="//FacilityAddressObj/phone"/>
                    </xsl:attribute>
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
                    <id root="2.16.840.1.113883.19.5.9999.1393"/>
                    <name>
                      <xsl:value-of select="//FacilityAddressObj/name"/>
                    </name>
                    <telecom use="WP">
                      <xsl:attribute name="value">
                        <xsl:value-of select="//FacilityAddressObj/phone"/>
                      </xsl:attribute>
                    </telecom>

                    <addr>
                      <streetAddressLine>
                        <xsl:value-of select="//FacilityAddressObj/streetAddressLine"/>
                      </streetAddressLine>
                      <city>
                        <xsl:value-of select="//FacilityAddressObj/city"/>
                      </city>
                      <state>
                        <xsl:value-of select="//FacilityAddressObj//state"/>
                      </state>
                      <postalCode>
                        <xsl:value-of select="//FacilityAddressObj//postalCode"/>
                      </postalCode>
                      <country>
                        <xsl:value-of select="//FacilityAddressObj/country"/>
                      </country>
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
            </effectiveTime>
            <performer typeCode="PRF">
              <templateId root="2.16.840.1.113883.10.20.6.2.1"/>
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
                <xsl:if test ="topLevelEffectiveTimeLow != ''">
                  <low>
                    <xsl:attribute name="value">
                      <xsl:value-of select="topLevelEffectiveTimeLow"/>
                    </xsl:attribute>
                  </low>
                </xsl:if >
                <xsl:if test ="topLevelEffectiveTimeLow = ''">
                  <low nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="boolean(topLevelEffectiveTimeLow) = false">
                  <low nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="boolean(topLevelEffectiveTimeHigh) = false">
                  <high nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="topLevelEffectiveTimeHigh = ''">
                  <high nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="topLevelEffectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="topLevelEffectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:if >
              </effectiveTime>

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
                  <code code="64572001" displayName="Condition" codeSystemName="SNOMED-CT" codeSystem="2.16.840.1.113883.6.96">
                    <!-- This code SHALL contain at least one [1..*] translation, which SHOULD be selected from ValueSet Problem Type (LOINC) -->
                    <!-- Condition seems like the best option: No EXACT requirement was given in the test data -db -->
                    <translation code="75323-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Condition"/>
                  </code>
                  <!-- commented line below-->
                  <statusCode code="completed"/>

                  <effectiveTime>
                    <xsl:if test ="topLevelEffectiveTimeLow != ''">
                      <low>
                        <xsl:attribute name="value">
                          <xsl:value-of select="topLevelEffectiveTimeLow"/>
                        </xsl:attribute>
                      </low>
                    </xsl:if >
                    <xsl:if test ="topLevelEffectiveTimeLow = ''">
                      <low nullFlavor="UNK"/>
                    </xsl:if>
                    <xsl:if test ="boolean(topLevelEffectiveTimeLow) = false">
                      <low nullFlavor="UNK"/>
                    </xsl:if>


                    <xsl:if test ="boolean(topLevelEffectiveTimeHigh) = false">
                      <high nullFlavor="UNK"/>
                    </xsl:if>

                    <xsl:if test ="topLevelEffectiveTimeHigh = ''">
                      <high nullFlavor="UNK"/>
                    </xsl:if>
                    <xsl:if test ="topLevelEffectiveTimeHigh != ''">
                      <high>
                        <xsl:attribute name="value">
                          <xsl:value-of select="topLevelEffectiveTimeHigh"/>
                        </xsl:attribute>
                      </high>
                    </xsl:if >
                  </effectiveTime>

                  <value xsi:type="CD">
                    <xsl:attribute name="code">
                      <xsl:value-of select="problemNameCode"/>
                    </xsl:attribute>

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

                    <xsl:attribute name="displayName">
                      <xsl:value-of select="problemNameDisplayName"/>
                    </xsl:attribute>
                  </value>
                </observation>
              </entryRelationship>
            </act>
          </entry>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
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
            </effectiveTime>
            <entryRelationship typeCode="SUBJ">
              <observation classCode="OBS" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.4" extension="2015-08-01" />
                <templateId root="2.16.840.1.113883.10.20.22.4.4" />
                <id root="2.16.840.1.113883.3.441" extension="c5df6f29978b472f9fd6359c08a65c65" />
                <code code="55607006" displayName="Condition" codeSystemName="SNOMED-CT" codeSystem="2.16.840.1.113883.6.96">
                  <translation code="75323-6" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Condition" />
                </code>
                <statusCode code="completed" />
                <effectiveTime>
                  <low nullFlavor="UNK" />
                </effectiveTime>
                <value xsi:type="CD" code="55607006" displayName="Disease" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" />
              </observation>
            </entryRelationship>
          </act>
        </entry>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="encounters">
    <xsl:if test ="boolean(encounterListObj/Encounter)">
      <component>
        <section>
          <templateId root="2.16.840.1.113883.10.20.22.2.22.1">
          </templateId>
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
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="encounterListObj/Encounter">
                  <tr>
                    <td>
                      <xsl:value-of select="diagnosisName"/>[Code:<xsl:value-of select="diagnosisCode"/>]
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
                  </tr>
                </xsl:for-each >
              </tbody>
            </table>
          </text>
          <xsl:for-each select="encounterListObj/Encounter">
            <entry typeCode="DRIV">
              <encounter classCode="ENC" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.49"/>
                <!-- Encounter Activities -->
                <!-- ******** Encounter activity template ******** -->
                <id root="2a620155-9d11-439e-92b3-5d9815ff4de8">
                  <xsl:attribute name="extension">
                    <xsl:value-of select="visitID"/>
                  </xsl:attribute>
                </id>
                <code  codeSystemName="CPT" codeSystem="2.16.840.1.113883.6.12" codeSystemVersion="4">
                  <xsl:attribute name="code">
                    <xsl:value-of select="cptCodes"/>
                  </xsl:attribute>
                  <xsl:attribute name="displayName">
                    <xsl:value-of select="text"/>
                  </xsl:attribute>
                </code>
                <effectiveTime>
                  <xsl:if test ="effectiveTimeLow != ''">
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeLow"/>
                    </xsl:attribute>
                  </xsl:if >
                  <xsl:if test ="effectiveTimeLow = ''">
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test ="boolean(effectiveTimeLow) = false">
                    <xsl:attribute name="nullFlavor">
                      <xsl:text>UNK</xsl:text>
                    </xsl:attribute>
                  </xsl:if>
                </effectiveTime>
                <performer>
                  <assignedEntity>
                    <id root="2a620155-9d11-439e-92a3-5d9815ff4de8" >
                      <xsl:attribute name="extension">
                        <xsl:value-of select="//author/providerid"/>
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
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="encounterlocation"/>
                      </xsl:attribute>
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
                <entryRelationship typeCode="SUBJ">
                  <!-- ** Encounter Diagnosis (V3)** -->
                  <act classCode="ACT" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.80" extension="2015-08-01"/>
                    <templateId root="2.16.840.1.113883.10.20.22.4.19"/>
                    <id root="5a784260-6857-4f38-9638-80c751aff2fb"/>
                    <code xsi:type="CE"  code="29308-4" codeSystem="2.16.840.1.113883.6.1"  codeSystemName="LOINC" displayName="ENCOUNTER DIAGNOSIS"/>
                    <effectiveTime>
                      <xsl:if test ="effectiveTimeLow != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeLow"/>
                          </xsl:attribute>
                        </low>
                      </xsl:if >
                      <xsl:if test ="effectiveTimeLow = ''">
                        <low nullFlavor="UNK"/>
                      </xsl:if>
                      <xsl:if test ="boolean(effectiveTimeLow) = false">
                        <low nullFlavor="UNK"/>
                      </xsl:if>

                      <xsl:if test ="effectiveTimeHigh != ''">
                        <high>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTimeHigh"/>
                          </xsl:attribute>
                        </high>
                      </xsl:if >
                      <xsl:if test ="effectiveTimeHigh = ''">
                        <high nullFlavor="UNK"/>
                      </xsl:if>
                      <xsl:if test ="boolean(effectiveTimeHigh) = false">
                        <high nullFlavor="UNK"/>
                      </xsl:if>
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
                          <xsl:if test ="effectiveTimeLow != ''">
                            <low>
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTimeLow"/>
                              </xsl:attribute>
                            </low>
                          </xsl:if >
                          <xsl:if test ="effectiveTimeLow = ''">
                            <low nullFlavor="UNK"/>
                          </xsl:if>
                          <xsl:if test ="boolean(effectiveTimeLow) = false">
                            <low nullFlavor="UNK"/>
                          </xsl:if>

                          <xsl:if test ="effectiveTimeHigh != ''">
                            <high>
                              <xsl:attribute name="value">
                                <xsl:value-of select="effectiveTimeHigh"/>
                              </xsl:attribute>
                            </high>
                          </xsl:if >
                          <xsl:if test ="effectiveTimeHigh = ''">
                            <high nullFlavor="UNK"/>
                          </xsl:if>
                          <xsl:if test ="boolean(effectiveTimeHigh) = false">
                            <high nullFlavor="UNK"/>
                          </xsl:if>

                        </effectiveTime>
                        <value xsi:type="CD" >
                          <xsl:attribute name="code">
                            <xsl:value-of select="diagnosisCode"/>
                          </xsl:attribute>
                          <xsl:attribute name="displayName">
                            <xsl:value-of select="diagnosisName"/>
                          </xsl:attribute>
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
                        </value>
                      </observation>
                    </entryRelationship>
                  </act>
                </entryRelationship>
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
        <text>
          <table border = "1" width = "100%">
            <thead>
              <tr>
                <th>Substance</th>
                <th>Reaction</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="allergyListObj/Allergy">

                <!--Commented below Lines-->

                <!-- Need iterator for algsummary_1 id -->

                <tr>
                  <td>
                    <xsl:value-of select="participantDisplayName"/>, [Code: <xsl:value-of select="participantCode"/>]
                  </td>
                  <td>
                    <xsl:value-of select="reactionValueDisplayName"/>
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
                <xsl:if test ="boolean(effectiveTimeLow) = false">
                  <low nullFlavor="UNK"/>
                </xsl:if>

                <xsl:if test ="effectiveTimeLow != ''">
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
                </xsl:if >

                <xsl:if test ="boolean(effectiveTimeHigh) = false">
                  <high nullFlavor="UNK"/>
                </xsl:if>

              </effectiveTime>
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
                    <!--Commented below Lines-->
                    <!-- Following low node should not be present if the value is blank or null-->

                    <xsl:if test ="effectiveTimeLow = ''">
                      <low nullFlavor="UNK"/>
                    </xsl:if>


                    <xsl:if test ="boolean(effectiveTimeLow) = false">
                      <low nullFlavor="UNK"/>
                    </xsl:if>

                    <xsl:if test ="effectiveTimeLow != ''">
                      <low>
                        <xsl:attribute name="value">
                          <xsl:value-of select="effectiveTimeLow"/>
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
                      <high nullFlavor="UNK"/>
                    </xsl:if>

                    <xsl:if test ="boolean(effectiveTimeHigh) = false">
                      <high nullFlavor="UNK"/>
                    </xsl:if>

                  </effectiveTime>
                  <value xsi:type="CD" code="419511003" displayName="Propensity to adverse reaction to drug" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"> </value>
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

                          <xsl:attribute name="displayName">
                            <xsl:value-of select="participantDisplayName"/>
                          </xsl:attribute>
                        </code>
                      </playingEntity>
                    </participantRole>
                  </participant>

                  <entryRelationship typeCode="MFST" inversionInd="true">
                    <observation classCode="OBS" moodCode="EVN">
                      <templateId root="2.16.840.1.113883.10.20.22.4.9" extension="2014-06-09"/>
                      <templateId root="2.16.840.1.113883.10.20.22.4.9"/>
                      <!-- Reaction observation template -->
                      <id root="4adc1020-7b14-11db-9fe1-0800200c9a64"/>

                      <code nullFlavor="NA"/>
                      <text>
                        <xsl:value-of select="reactionValueDisplayName"/>
                      </text>

                      <statusCode code="completed"/>
                      <effectiveTime>
                        <xsl:if test ="effectiveTimeLow != ''">
                          <low>
                            <xsl:attribute name="value">
                              <xsl:value-of select="effectiveTimeLow"/>
                            </xsl:attribute>
                          </low>
                        </xsl:if >
                        <xsl:if test ="boolean(effectiveTimeLow) = false">
                          <low nullFlavor="UNK"/>
                        </xsl:if>
                        <xsl:if test ="effectiveTimeLow = ''">
                          <low nullFlavor="UNK"/>
                        </xsl:if>
                      </effectiveTime>


                      <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96">
                        <xsl:if test ="boolean(reactionValueCode) = false">
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>UNK</xsl:text>
                          </xsl:attribute>
                        </xsl:if>
                        <xsl:if test ="reactionValueCode = ''">
                          <xsl:attribute name="nullFlavor">
                            <xsl:text>UNK</xsl:text>
                          </xsl:attribute>
                        </xsl:if>
                        <xsl:if test ="reactionValueCode != ''">
                          <xsl:attribute name="code">
                            <xsl:value-of select="reactionValueCode"/>
                          </xsl:attribute>
                        </xsl:if>
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
                            <xsl:attribute name="code">
                              <xsl:value-of select="severityCode"/>
                            </xsl:attribute>
                            <xsl:attribute name="displayName">
                              <xsl:value-of select="severityDisplayName"/>
                            </xsl:attribute>
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
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry>
          <act classCode="ACT" moodCode="EVN">
            <templateId root="2.16.840.1.113883.10.20.22.4.30" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.30"/>
            <id root="2.16.840.1.113883.3.441.1.50.300011.51.26562.57" extension="1307" />
            <code code="48765-2" displayName="Allergies, adverse reactions, alerts" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" />
            <statusCode code="active" />
            <effectiveTime>
              <low nullFlavor="UNK" />
            </effectiveTime>
            <entryRelationship typeCode="SUBJ" inversionInd="true">
              <observation classCode="OBS" moodCode="EVN" negationInd="false">
                <templateId root="2.16.840.1.113883.10.20.22.4.7" extension="2014-06-09"/>
                <templateId root="2.16.840.1.113883.10.20.22.4.7"/>
                <id root="2.16.840.1.113883.3.441" extension="03d2b31b04fd4042a24423b657750245" />
                <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4" />
                <statusCode code="completed" />
                <effectiveTime>
                  <low nullFlavor="UNK" />
                </effectiveTime>
                <value xsi:type="CD" code="419199007" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="Allergy to substance (disorder)" />
                <participant typeCode="CSM">
                  <participantRole classCode="MANU">
                    <playingEntity classCode="MMAT">
                      <code nullFlavor="NA"/>
                    </playingEntity>
                  </participantRole>
                </participant>

                <entryRelationship typeCode="MFST" inversionInd="true">
                  <!--Patient asserted that there are no allergies-->
                  <!--<observation classCode="OBS" moodCode="EVN" negationInd="true">-->

                  <!--I didn't ask whether there are any allergies (and have no other information)-->
                  <!--<observation classCode="OBS" moodCode="EVN" nullFlavor="NASK">-->

                  <!--don't know whether there are any allergies-->
                  <observation classCode="OBS" moodCode="EVN" nullFlavor="NI">
                    <templateId root="2.16.840.1.113883.10.20.22.4.9" extension="2014-06-09"/>
                    <templateId root="2.16.840.1.113883.10.20.22.4.9"/>
                    <id root="2.16.840.1.113883.3.441" extension="121213121312" />
                    <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
                    <statusCode code="completed"/>
                    <effectiveTime>
                      <!-- Use value or nullFlavor, not both -->
                      <low nullFlavor="UNK"/>
                    </effectiveTime>
                    <value xsi:type="CD" code="419199007"
                      codeSystem="2.16.840.1.113883.6.96" displayName="Allergy to Substance"/>
                  </observation>
                </entryRelationship>
              </observation>
            </entryRelationship>
          </act>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="medication">
    <xsl:choose>
      <xsl:when test="boolean(medicationListObj/Medication)">
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
                    <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/>, [Code :<xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>]
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
              </id>
              <statusCode code="active"/>
              <effectiveTime xsi:type="IVL_TS">
                <xsl:if test ="effectiveTimeLow != ''">
                  <low>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeLow"/>
                    </xsl:attribute>
                  </low>
                </xsl:if >
                <xsl:if test ="effectiveTimeLow = ''">
                  <low nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="boolean(effectiveTimeLow) = false">
                  <low nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="boolean(effectiveTimeHigh) = false">
                  <high nullFlavor="UNK"/>
                </xsl:if>

                <xsl:if test ="effectiveTimeHigh = ''">
                  <high nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="effectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:if >
              </effectiveTime>
              <!--Commented below Lines-->
              <!-- code value and display name cannot be blank-->
              <xsl:if test ="effectiveTimePeriodValue != ''">
                <!--<effectiveTime xsi:type="PIVL_TS" institutionSpecified="true" operator="A">
                  <period>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimePeriodValue"/>
                    </xsl:attribute>
                    <xsl:attribute name="unit">
                      <xsl:value-of select="effectiveTimePeriodUnit"/>
                    </xsl:attribute>
                  </period>
                </effectiveTime>-->
              </xsl:if>

              <xsl:if test ="routeCodeDisplayName != ''">
                <!--<routeCode codeSystem="2.16.840.1.113883.3.26.1.1" codeSystemName="NCI Thesaurus">-->
                <routeCode nullFlavor="UNK">
                  <!--<xsl:if test ="routeCodeCode != ''">
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
                  </xsl:attribute>-->
                  <originalText>
                    <xsl:value-of select="routeCodeDisplayName"/>
                  </originalText>
                </routeCode>
              </xsl:if >

              <!--Commented below Lines-->
              <!-- code value and display name cannot be blank-->
              <xsl:if test =" (boolean(doseQuantityValue)) and doseQuantityValue != ''">
                <doseQuantity>
                  <xsl:attribute name="value">
                    <xsl:value-of select="doseQuantityValue"/>
                  </xsl:attribute>
                  <!--<xsl:attribute name="unit">
                    <xsl:value-of select="doseQuantityUnit"/>
                  </xsl:attribute>-->
                </doseQuantity>
              </xsl:if>
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
                      <xsl:if test ="boolean(manufacturedMaterialObj/codeSystem) = false">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="manufacturedMaterialObj/codeSystem = ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="manufacturedMaterialObj/codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="manufacturedMaterialObj/codeSystem"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="manufacturedMaterialObj/manufacturedMaterialCode = ''">
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="manufacturedMaterialObj/manufacturedMaterialCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/>
                      </xsl:attribute>
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
                  <templateId root='2.16.840.1.113883.10.20.1.49'/>
                  <templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.3'/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
                  <code code='PINSTRUCT' codeSystem='1.3.6.1.4.1.19376.1.5.3.2' codeSystemName='IHEActCode' />
                  <text>
                    <xsl:value-of select="instructions"/>
                  </text>
                  <statusCode code="completed" />
                </act>
              </entryRelationship>
            </substanceAdministration>
          </entry>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry>
          <substanceAdministration moodCode="EVN" classCode="SBADM" negationInd="true">
            <templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.16"/>
            <id root="2.16.840.1.113883.3.441.1.50.300011.51.26562.58" extension="2052" />
            <text>No Known Medication</text>
            <statusCode code="completed" />
            <effectiveTime xsi:type="IVL_TS">
              <low nullFlavor="UNK" />
              <high nullFlavor="UNK" />
            </effectiveTime>
            <doseQuantity nullFlavor="UNK"  />
            <consumable>
              <manufacturedProduct classCode="MANU">
                <templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"/>
                <templateId root="2.16.840.1.113883.10.20.22.4.23"/>
                <manufacturedMaterial classCode="MMAT">
                  <code nullFlavor="OTH">
                    <originalText>
                      <reference value="#ID0EAEANABA" />
                    </originalText>
                    <translation code="410942007" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="drug or medication" />
                  </code>
                </manufacturedMaterial>
              </manufacturedProduct>
            </consumable>
          </substanceAdministration>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="medicationadministered">
    <xsl:choose>
      <xsl:when test="boolean(medicationAdministedListObj/Medication)">
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

              </id>
              <text>
                <xsl:value-of select="instructions"/>
              </text>
              <statusCode code="active"/>
              <effectiveTime xsi:type="IVL_TS">
                <xsl:if test ="effectiveTimeLow != ''">
                  <low>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeLow"/>
                    </xsl:attribute>
                  </low>
                </xsl:if >
                <xsl:if test ="effectiveTimeLow = ''">
                  <low nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="boolean(effectiveTimeLow) = false">
                  <low nullFlavor="UNK"/>
                </xsl:if>

                <xsl:if test ="boolean(effectiveTimeHigh) = false">
                  <high nullFlavor="UNK"/>
                </xsl:if>

                <xsl:if test ="effectiveTimeHigh = ''">
                  <high nullFlavor="UNK"/>
                </xsl:if>
                <xsl:if test ="effectiveTimeHigh != ''">
                  <high>
                    <xsl:attribute name="value">
                      <xsl:value-of select="effectiveTimeHigh"/>
                    </xsl:attribute>
                  </high>
                </xsl:if >
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

                  <xsl:attribute name="displayName">
                    <xsl:value-of select="routeCodeDisplayName"/>
                  </xsl:attribute>
                  <originalText>
                    <xsl:value-of select="routeCodeDisplayName"/>
                  </originalText>
                </routeCode>
              </xsl:if >

              <!--Commented below Lines-->
              <!-- code value and display name cannot be blank-->
              <xsl:if test =" (boolean(doseQuantityValue)) and doseQuantityValue != ''">
                <doseQuantity>
                  <xsl:attribute name="value">
                    <xsl:value-of select="doseQuantityValue"/>
                  </xsl:attribute>
                  <xsl:attribute name="unit">
                    <xsl:value-of select="doseQuantityUnit"/>
                  </xsl:attribute>
                </doseQuantity>
              </xsl:if>
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
                      <xsl:if test ="boolean(manufacturedMaterialObj/codeSystem) = false">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                        </xsl:attribute>
                      </xsl:if>

                      <xsl:if test ="manufacturedMaterialObj/codeSystem = ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:text>2.16.840.1.113883.6.88</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="manufacturedMaterialObj/codeSystem != ''">
                        <xsl:attribute name="codeSystem">
                          <xsl:value-of select="manufacturedMaterialObj/codeSystem"/>
                        </xsl:attribute>
                      </xsl:if>

                      <xsl:if test ="manufacturedMaterialObj/manufacturedMaterialCode = ''">
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>UNK</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="manufacturedMaterialObj/manufacturedMaterialCode != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialCode"/>
                        </xsl:attribute>
                      </xsl:if>

                      <xsl:attribute name="displayName">
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialDisplayName"/>
                      </xsl:attribute>

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
                  <templateId root='2.16.840.1.113883.10.20.1.49'/>
                  <templateId root='1.3.6.1.4.1.19376.1.5.3.1.4.3'/>
                  <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
                  <code code='PINSTRUCT' codeSystem='1.3.6.1.4.1.19376.1.5.3.2'
                    codeSystemName='IHEActCode' />
                  <text>
                    <xsl:value-of select="instructions"/>
                  </text>
                  <statusCode code="completed" />
                </act>
              </entryRelationship>


            </substanceAdministration>
          </entry>
        </xsl:for-each>

      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry>
          <substanceAdministration moodCode="EVN" classCode="SBADM" negationInd="true">
            <templateId root="2.16.840.1.113883.10.20.22.4.16" extension="2014-06-09"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.16"/>
            <id root="2.16.840.1.113883.3.441.1.50.300011.51.26562.58" extension="2052" />
            <text>No Known Medication</text>
            <statusCode code="completed" />
            <effectiveTime xsi:type="IVL_TS">
              <low nullFlavor="UNK" />
              <high nullFlavor="UNK" />
            </effectiveTime>
            <doseQuantity nullFlavor="UNK"  />
            <consumable>
              <manufacturedProduct classCode="MANU">
                <templateId root="2.16.840.1.113883.10.20.22.4.23" extension="2014-06-09"/>
                <templateId root="2.16.840.1.113883.10.20.22.4.23"/>
                <manufacturedMaterial classCode="MMAT">
                  <code nullFlavor="OTH">
                    <originalText>
                      <reference value="#ID0EAEANABA" />
                    </originalText>
                    <translation code="410942007" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" displayName="drug or medication" />
                  </code>
                </manufacturedMaterial>
              </manufacturedProduct>
            </consumable>
          </substanceAdministration>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="results">
    <xsl:choose>
      <xsl:when test="boolean(resultListObj/Result)">
        <text>
          <table border = "1" width = "100%">
            <thead>
              <tr>
                <th>Name</th>
                <th>Actual Result</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="resultListObj/Result">
                <xsl:for-each select="resultObs/ResultObs">
                  <tr>
                    <td>
                      <xsl:value-of select="displayName"/>, [LOINC: <xsl:value-of select="code"/>]
                    </td>
                    <td>
                      <xsl:if test ="valueValue != ''">
                        <xsl:value-of select="valueValue"/> (<xsl:value-of select="valueUnit"/>) ,
                        Status: <xsl:value-of select="status"/>
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
                  </tr>
                </xsl:for-each>
              </xsl:for-each >
            </tbody>
          </table>
        </text>
        <xsl:for-each select="resultListObj/Result">
          <entry typeCode = "DRIV">
            <organizer classCode = "BATTERY" moodCode = "EVN">
              <templateId root="2.16.840.1.113883.10.20.22.4.1" extension="2015-08-01"/>
              <templateId root="2.16.840.1.113883.10.20.22.4.1"/>
              <id root = "7d5a02b0-67a4-11db-bd13-0800200c9a66"/>
              <code xsi:type = "CE" codeSystemName = "LOINC" codeSystem = "2.16.840.1.113883.6.1">
                <xsl:attribute name="code">
                  <xsl:value-of select="codeCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="codeDisplayName"/>
                </xsl:attribute>
              </code>
              <statusCode code="completed"/>
              <xsl:for-each select="resultObs/ResultObs">
                <component>
                  <observation classCode = "OBS" moodCode = "EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.2" extension="2015-08-01"/>
                    <templateId root = "2.16.840.1.113883.10.20.22.4.2"/>
                    <id root = "107c2dc0-67a5-11db-bd13-0800200c9a66"/>
                    <code codeSystem = "2.16.840.1.113883.6.1">
                      <xsl:attribute name="code">
                        <xsl:value-of select="code"/>
                      </xsl:attribute>
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="displayName"/>
                      </xsl:attribute>
                    </code>
                    <statusCode code="completed"></statusCode>
                    <effectiveTime>
                      <xsl:attribute name="value">
                        <xsl:value-of select="effectiveTime"/>
                      </xsl:attribute>
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
                        <xsl:if test ="valueUnit != ''">
                          <xsl:attribute name="unit">
                            <xsl:value-of select="valueUnit"/>
                          </xsl:attribute>
                        </xsl:if>
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
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry typeCode = "DRIV">
          <organizer classCode = "BATTERY" moodCode = "EVN">
            <templateId root="2.16.840.1.113883.10.20.22.4.1" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.1"/>
            <id root = "7d5a02b0-67a4-11db-bd13-0800200c9a66"/>
            <code xsi:type = "CE" codeSystemName = "LOINC" codeSystem = "2.16.840.1.113883.6.1" nullFlavor="UNK"></code>
            <statusCode code="completed"></statusCode>
            <component>
              <observation classCode = "OBS" moodCode = "EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.2" extension="2015-08-01"/>
                <templateId root = "2.16.840.1.113883.10.20.22.4.2"/>
                <id root = "107c2dc0-67a5-11db-bd13-0800200c9a66"/>
                <code codeSystem = "2.16.840.1.113883.6.1" nullFlavor="OTH"></code>
                <statusCode code="completed"></statusCode>
                <effectiveTime nullFlavor="UNK"></effectiveTime>
                <value xsi:type="PQ" nullFlavor="NA"></value>
                <interpretationCode code = "N" codeSystem = "2.16.840.1.113883.5.83"/>
              </observation>
            </component>
          </organizer>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="vitalsigns">
    <xsl:choose>
      <xsl:when test="boolean(vitalSignListObj/VitalSign/Observation/VitalSignObs)">
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
                  <tr>
                    <td>
                      <xsl:value-of select="codeDisplayName"/>
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
                <component>
                  <observation classCode="OBS" moodCode="EVN">
                    <templateId root="2.16.840.1.113883.10.20.22.4.27" extension="2014-06-09"/>
                    <templateId root="2.16.840.1.113883.10.20.22.4.27"/>
                    <!-- Vital Sign Observation template -->
                    <id root="c6f88321-67ad-11db-bd13-0800200c9a66" extension="2001"/>
                    <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" >
                      <xsl:attribute name="code">
                        <xsl:value-of select="codeCode"/>
                      </xsl:attribute>
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="codeDisplayName"/>
                      </xsl:attribute>
                    </code>
                    <statusCode code="completed"/>
                    <effectiveTime>
                      <xsl:attribute name="value">
                        <xsl:value-of select="effectiveTime"/>
                      </xsl:attribute>
                    </effectiveTime>
                    <value xsi:type="PQ" >
                      <xsl:attribute name="value">
                        <xsl:value-of select="valueValue"/>
                      </xsl:attribute>
                      <xsl:if test ="valueUnit != ''">
                        <xsl:attribute name="unit">
                          <xsl:value-of select="valueUnit"/>
                        </xsl:attribute>
                      </xsl:if>
                    </value>
                    <interpretationCode code="N" codeSystem="2.16.840.1.113883.5.83" />
                  </observation>
                </component>
              </xsl:for-each>
            </organizer>
          </entry>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry typeCode="DRIV">
          <organizer classCode="CLUSTER" moodCode="EVN">
            <templateId root="2.16.840.1.113883.10.20.22.4.26" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.26"/>
            <!-- Vital signs organizer template -->
            <id root="c6f88320-67ad-11db-bd13-0800200c9a66" extension="2000"/>
            <code code="46680005" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" displayName="Vital signs">
              <!-- A vitals organizer conformant to both C-CDA 1.1 and C-CDA 2.1 would contain the SNOMED code (46680005) from R1.1 in the root code and a LOINC code in the translation -->
              <translation code="74728-7" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Vital signs"/>
            </code>
            <statusCode code="completed"/>
            <effectiveTime nullFlavor="UNK"></effectiveTime>
            <component>
              <observation classCode="OBS" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.27" extension="2014-06-09"/>
                <templateId root="2.16.840.1.113883.10.20.22.4.27"/>
                <!-- Vital Sign Observation template -->
                <id root="c6f88321-67ad-11db-bd13-0800200c9a66" extension="2001"/>
                <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" nullFlavor="OTH"></code>
                <statusCode code="completed"></statusCode>
                <effectiveTime nullFlavor="UNK"></effectiveTime>
                <value xsi:type="CD" nullFlavor="NI"></value>
              </observation>
            </component>
          </organizer>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="socialhistory">
    <xsl:choose>
      <xsl:when test ="boolean(socialHistoryListObj/SocialHistory)">
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
            </tbody>
          </table>
        </text>
        <xsl:for-each select="socialHistoryListObj/SocialHistory">
          <entry typeCode="DRIV">
            <observation classCode="OBS" moodCode="EVN">
              <!-- Smoking status observation template -->
              <templateId root="2.16.840.1.113883.10.20.22.4.78"/>
              <id extension="123456789" root="2.16.840.1.113883.19"/>
              <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
              <statusCode code="completed"> </statusCode>
              <effectiveTime>

                <xsl:if test ="effectiveTimeLow != ''">
                  <xsl:attribute name="value">
                    <xsl:value-of select="effectiveTimeLow"/>
                  </xsl:attribute>
                </xsl:if >
                <xsl:if test ="effectiveTimeLow = ''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:if >


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
              <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96">
                <xsl:attribute name="code">
                  <xsl:value-of select="valueCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="valueDisplayName"/>
                </xsl:attribute>
              </value>
            </observation>
          </entry>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry typeCode="DRIV">
          <observation classCode="OBS" moodCode="EVN">
            <!-- Smoking status observation template -->
            <templateId root="2.16.840.1.113883.10.20.22.4.78"/>
            <id extension="123456789" root="2.16.840.1.113883.19"/>
            <code code="ASSERTION" codeSystem="2.16.840.1.113883.5.4"/>
            <statusCode code="completed"> </statusCode>
            <effectiveTime >
              <low nullFlavor="UNK"/>
            </effectiveTime>
            <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96" nullFlavor="NI"></value>
          </observation>
        </entry>
      </xsl:otherwise>
    </xsl:choose>

    <entry>
      <observation classCode="OBS" moodCode="EVN">
        <templateId root="2.16.840.1.113883.10.20.22.4.200" extension="2016-06-01"/>
        <code code="76689-9" displayName="Sex assigned at birth" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
        <text>
          <reference value="#BirthSexInfo"/>
        </text>
        <statusCode code="completed"/>
        <value xsi:type="CD" codeSystem="2.16.840.1.113883.5.1">

          <xsl:attribute name="code">
            <xsl:value-of select="//patientRoleObj/administrativeGenderCode"/>
          </xsl:attribute>

          <xsl:attribute name="displayName">
            <xsl:value-of select="//patientRoleObj/administrativeGenderDisplayName"/>
          </xsl:attribute>

        </value>
      </observation>
    </entry>

  </xsl:template>
  <xsl:template name="procedures">
    <xsl:choose>
      <xsl:when test="boolean(procedureListObj/Procedure)">
        <text>
          <table border = "1" width = "100%">
            <thead>
              <tr>
                <th>Name</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="procedureListObj/Procedure">
                <tr>
                  <td>
                    <xsl:value-of select="codeDisplayName"/>, [Code: <xsl:value-of select="codeCode"/>]
                    <xsl:value-of select="deviceName"/>
                  </td>

                  <td>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime">
                        <xsl:value-of select="effectiveTimeHigh"/>
                      </xsl:with-param>
                    </xsl:call-template >
                  </td>
                </tr>
              </xsl:for-each >
            </tbody>
          </table>
        </text>
        <xsl:for-each select="procedureListObj/Procedure">
          <entry typeCode="DRIV">
            <procedure classCode="PROC" moodCode="EVN">
              <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09"/>
              <templateId root="2.16.840.1.113883.10.20.22.4.14"/>
              <!-- Procedure Activity Observation -->
              <id extension="123456789" root="2.16.840.1.113883.19"/>
              <code codeSystem="2.16.840.1.113883.6.96"
              codeSystemName="SNOMED-CT">
                <xsl:attribute name="code">
                  <xsl:value-of select="codeCode"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="codeDisplayName"/>
                </xsl:attribute>
              </code>
              <statusCode code="completed"/>
              <effectiveTime>
                <xsl:attribute name="value">
                  <xsl:value-of select="effectiveTimeHigh"/>
                </xsl:attribute>
              </effectiveTime>
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

              <xsl:if test="boolean(performerAddress)">
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
              </xsl:if>
              <!-- required for UDI -db -->
              <xsl:if test="boolean(deviceCode)">
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
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry typeCode="DRIV">
          <procedure classCode="PROC" moodCode="EVN">
            <templateId root="2.16.840.1.113883.10.20.22.4.14" extension="2014-06-09"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.14"/>
            <!-- Procedure Activity Observation -->
            <id extension="123456789" root="2.16.840.1.113883.19"/>
            <code codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED-CT" nullFlavor="OTH"></code>
            <statusCode code="completed"></statusCode>
            <effectiveTime nullFlavor="UNK"></effectiveTime>
            <priorityCode code="CR" codeSystem="2.16.840.1.113883.5.7" codeSystemName="ActPriority" displayName="Callback results"/>
            <methodCode nullFlavor="UNK"/>
            <targetSiteCode codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" nullFlavor="OTH" ></targetSiteCode>
          </procedure>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="immunization">
    <xsl:choose>
      <xsl:when test="boolean(immunizationListObj/Immunization)">
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
                    <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationDisplayName"/>(CVX: <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationCode"/>)
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
              <xsl:if test="boolean(negationInd) and negationInd != ''">
                <xsl:if test="negationInd = 'true' or negationInd = 'True' or negationInd = 'TRUE'">
                  <xsl:attribute name="negationInd">
                    <xsl:text>true</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="negationInd = ''">
                  <xsl:attribute name="negationInd">
                    <xsl:text>false</xsl:text>
                  </xsl:attribute>
                </xsl:if>

              </xsl:if>

              <xsl:if test="boolean(negationInd) = false or negationInd = 'false'">
                <xsl:attribute name="negationInd">
                  <xsl:text>false</xsl:text>
                </xsl:attribute>
              </xsl:if>

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
                <xsl:if test ="boolean(effectiveTimeLow) = false">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="effectiveTimeLow != ''">
                  <xsl:attribute name="value">
                    <xsl:value-of select="effectiveTimeLow"/>
                  </xsl:attribute>
                </xsl:if >
                <xsl:if test ="effectiveTimeLow = ''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:if>

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
                    <code codeSystem="2.16.840.1.113883.12.292" codeSystemName="CVX">
                      <xsl:attribute name="code">
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationCode"/>
                      </xsl:attribute>

                      <xsl:attribute name="displayName">
                        <xsl:value-of select="manufacturedMaterialObj/manufacturedMaterialTranslationDisplayName"/>
                      </xsl:attribute>
                    </code>
                  </manufacturedMaterial>
                  <manufacturerOrganization>
                    <name>Immuno Inc.</name>
                  </manufacturerOrganization>
                </manufacturedProduct>
              </consumable>
              <xsl:if test="boolean(rejectionReason) and rejectionReason != ''">
                <entryRelationship typeCode="RSON">
                  <observation classCode="OBS" moodCode="EVN">
                    <!-- Immunization Refusal Reason  -->
                    <!-- there is no versioned version of this template -->
                    <!-- Included the reason since it may be relevant to a future clinician or quality measurement -->
                    <templateId root="2.16.840.1.113883.10.20.22.4.53"/>
                    <id root="c1296315-9a6d-45a2-aac0-ee225d375409"/>
                    <code codeSystemName="HL7 ActNoImmunizationReason" codeSystem="2.16.840.1.113883.5.8">
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="rejectionReason"/>
                      </xsl:attribute>
                      <xsl:attribute name="code">
                        <xsl:value-of select="rejectionReasonCode"/>
                      </xsl:attribute>
                    </code>
                    <statusCode code="completed"/>
                  </observation>
                </entryRelationship>
              </xsl:if>
            </substanceAdministration>
          </entry>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry typeCode="DRIV">
          <substanceAdministration classCode="SBADM" moodCode="EVN" negationInd="false">
            <templateId root="2.16.840.1.113883.10.20.22.4.52" extension="2015-08-01"/>
            <templateId root="2.16.840.1.113883.10.20.22.4.52"/>
            <id root="e6f1ba43-c0ed-4b9b-9f12-f435d8ad8f92" extension="1014"/>
            <statusCode code="completed"></statusCode>
            <effectiveTime nullFlavor="UNK"></effectiveTime>
            <consumable>
              <manufacturedProduct classCode="MANU">
                <templateId root="2.16.840.1.113883.10.20.22.4.54" extension="2014-06-09"/>
                <templateId root="2.16.840.1.113883.10.20.22.4.54"/>
                <manufacturedMaterial>
                  <code codeSystem="2.16.840.1.113883.12.292" codeSystemName="CVX" nullFlavor="OTH"></code>
                </manufacturedMaterial>
                <manufacturerOrganization>
                  <name></name>
                </manufacturerOrganization>
              </manufacturedProduct>
            </consumable>
            <entryRelationship typeCode="SUBJ" inversionInd="true">
              <act classCode="ACT" moodCode="INT">
                <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
                <code xsi:type="CE" code="171044003" codeSystem="2.16.840.1.113883.6.96" displayName="immunization education"/>
                <statusCode code="completed"/>
              </act>
            </entryRelationship>
          </substanceAdministration>
        </entry>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="functionalstatus">
    <xsl:choose>
      <xsl:when test ="boolean(FunctionalStatusListObj/FunctionalStatus/Text)">
        <component>
          <section>
            <templateId root = "2.16.840.1.113883.10.20.22.2.14"/>
            <!--**** Functional status section template **** -->
            <code code = "47420-5" codeSystem = "2.16.840.1.113883.6.1"/>
            <title>FUNCTIONAL STATUS</title>
            <text>
              <table border = "1" width = "100%">
                <thead>
                  <tr>
                    <th>Functional Condition</th>
                    <th>Type</th>
                    <th>Date</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="FunctionalStatusListObj/FunctionalStatus">
                    <xsl:if test="Text != ''">
                      <tr>
                        <td>
                          <xsl:value-of select="Text"/>
                        </td>
                        <td>
                          <xsl:value-of select="Type"/>
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
                </tbody>
              </table>
            </text>
            <xsl:for-each select="FunctionalStatusListObj/FunctionalStatus">
              <xsl:if test="Text != ''">
                <entry>
                  <observation classCode="OBS" moodCode="EVN">
                    <xsl:if test="Type = 'Functional'">
                      <templateId root="2.16.840.1.113883.10.20.22.4.68" />
                    </xsl:if>
                    <xsl:if test="Type = 'Cognitive'">
                      <templateId root="2.16.840.1.113883.10.20.22.4.73" />
                    </xsl:if>
                    <id root="2.16.840.1.113883.3.441.1.50.300011.51.26604.68" >
                      <xsl:attribute name="extension">
                        <xsl:value-of select="id"/>
                      </xsl:attribute>
                    </id>

                    <code codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT" code="64572001" displayName="Problem" />
                    <text>
                      <xsl:value-of select="Text"/>
                    </text>
                    <statusCode code="completed" />
                    <effectiveTime>
                      <xsl:if test ="effectiveTime != ''">
                        <low>
                          <xsl:attribute name="value">
                            <xsl:value-of select="effectiveTime"/>
                          </xsl:attribute>
                        </low>
                      </xsl:if >
                      <xsl:if test ="effectiveTime = ''">
                        <low nullFlavor="UNK"/>
                      </xsl:if>
                      <xsl:if test ="boolean(effectiveTime) = false">
                        <low nullFlavor="UNK"/>
                      </xsl:if>
                    </effectiveTime>
                    <value xsi:type="CD">
                      <xsl:if test ="code = ''">
                        <xsl:attribute name="nullFlavor">
                          <xsl:text>OTH</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:if test ="code != ''">
                        <xsl:attribute name="code">
                          <xsl:value-of select="code"/>
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
                      <xsl:attribute name="displayName">
                        <xsl:value-of select="Text"/>
                      </xsl:attribute>
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
          <section>
            <templateId root="2.16.840.1.113883.10.20.22.2.14"/>
            <code code="47420-5" codeSystem="2.16.840.1.113883.6.1"/>
            <title>FUNCTIONAL STATUS</title>
            <text>Data in this section may be excluded or not available.</text>
            <entry typeCode="DRIV">
              <observation classCode="OBS" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.73"/>
                <id root="24dda93c-dcdf-4b42-a30e-84481af75c2f"/>
                <code code="373930000" codeSystem="2.16.840.1.113883.6.96" displayName="Cognitive function finding"/>
                <text></text>
                <statusCode code="completed"/>
                <effectiveTime>
                  <low nullFlavor="UNK"/>
                </effectiveTime>
                <value xsi:type="CD" nullFlavor="OTH" />
              </observation>
            </entry>
            <entry typeCode="DRIV">
              <observation classCode="OBS" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.68"/>
                <id root="24dda93c-dcdf-4b42-a30e-84481af75c2f"/>
                <code nullFlavor="NI"/>
                <statusCode code="completed"/>
                <effectiveTime>
                  <low nullFlavor="UNK"/>
                </effectiveTime>
                <value xsi:type="CD" codeSystem="2.16.840.1.113883.6.96"/>
              </observation>
            </entry>
          </section>
        </component>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template >
  <xsl:template name="careplan">
    <xsl:choose>
      <xsl:when test="boolean(carePlanListObj/CarePlan)">
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
              <code xsi:type="CE" displayName="Goal" >
                <xsl:if test ="codeCode = ''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>OTH</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="codeCode != ''">
                  <xsl:attribute name="code">
                    <xsl:value-of select="codeCode"/>
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
              </code>
              <text>
                <xsl:value-of select="text"/>
              </text>
              <statusCode code="completed"></statusCode>
              <effectiveTime>
                <xsl:attribute name="value">
                  <xsl:value-of select="date"/>
                </xsl:attribute>
              </effectiveTime>
            </act>
          </entry>
        </xsl:for-each>
        <xsl:for-each select="ReferralListObj/Referral">
          <entry typeCode="DRIV">
            <act classCode="ACT" moodCode="INT">
              <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
              <code xsi:type="CE" displayName="Referral" nullFlavor="OTH" codeSystem="2.16.840.1.113883.6.96">
              </code>
              <text>
                <xsl:value-of select="Details"/>
              </text>
              <statusCode code="completed"></statusCode>
              <effectiveTime>
                <xsl:if test ="boolean(effectiveTime) = false">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test ="effectiveTime != ''">
                  <xsl:attribute name="value">
                    <xsl:value-of select="effectiveTime"/>
                  </xsl:attribute>
                </xsl:if >
                <xsl:if test ="effectiveTime = ''">
                  <xsl:attribute name="nullFlavor">
                    <xsl:text>UNK</xsl:text>
                  </xsl:attribute>
                </xsl:if>
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
              <id root="b52bee94-c34b-4e2c-8c15-5ad9d6def513" ></id>
              <code codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" >
                <xsl:attribute name="code">
                  <xsl:value-of select="Code"/>
                </xsl:attribute>
                <xsl:attribute name="displayName">
                  <xsl:value-of select="text"/>
                </xsl:attribute>
              </code>
              <!--Consol Planned Observation2 SHALL contain exactly one [1..1] statusCode 
							(CONF:1098-30453)/@code="active" Active (CodeSystem: 2.16.840.1.113883.5.14 ActStatus) (CONF:1098-32032) -->
              <statusCode code="active" />
              <effectiveTime>
                <xsl:attribute name="value">
                  <xsl:value-of select="time"/>
                </xsl:attribute>

              </effectiveTime>
            </observation>
          </entry>
        </xsl:for-each>


      </xsl:when>
      <xsl:otherwise>
        <text>Data in this section may be excluded or not available.</text>
        <entry typeCode="DRIV">
          <act classCode="ACT" moodCode="INT">
            <templateId root="2.16.840.1.113883.10.20.22.4.20"/>
            <code xsi:type="CE" nullFlavor="OTH" codeSystem="2.16.840.1.113883.6.96" displayName="Goal"/>
            <text></text>
            <statusCode code="completed"></statusCode>
          </act>
        </entry>
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
            <!--<entry typeCode = "DRIV">
              <act classCode = "ACT" moodCode = "INT">
                <templateId root = "2.16.840.1.113883.10.20.22.4.20"/>
                <code xsi:type = "CE" code = "311401005" codeSystem = "2.16.840.1.113883.6.96" displayName = "Patient Instructions"/>
                <text></text>
                <statusCode code = "completed"/>
              </act>
            </entry>-->
          </xsl:otherwise>
        </xsl:choose>
      </section>
    </component>
  </xsl:template>
  <xsl:template name="healthconcern">
    <component>
      <section>
        <templateId root="2.16.840.1.113883.10.20.22.2.58" extension="2015-08-01"/>
        <code code="75310-3" displayName="Health Concerns Document" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
        <title>HEALTH CONCERNS</title>
        <xsl:choose>
          <xsl:when test="boolean(healthConcernListObj/HealthConcern)">
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
                        </xsl:call-template >

                      </td>
                    </tr>

                  </xsl:for-each>
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
                    <xsl:if test ="boolean(code) = false">
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test ="code != ''">
                      <xsl:attribute name="code">
                        <xsl:value-of select="code"/>
                      </xsl:attribute>
                    </xsl:if>

                    <xsl:if test ="code = ''">
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
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

                    <xsl:if test ="codeSystem = ''">
                      <xsl:attribute name="codeSystem">
                        2.16.840.1.113883.6.96
                      </xsl:attribute>
                    </xsl:if>

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

          </xsl:when>
          <xsl:otherwise>
            <text>Data in this section may be excluded or not available.</text>
            <entry typeCode = "DRIV">
              <act classCode="ACT" moodCode="EVN">
                <templateId root="2.16.840.1.113883.10.20.22.4.132" extension="2015-08-01"/>
                <templateId root="2.16.840.1.113883.10.20.22.4.132"></templateId>
                <id root="4eab0e52-dd7d-4285-99eb-72d32ddb195c"/>
                <code code="75310-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Health Concern"/>
                <text></text>
                <statusCode code = "completed"/>
              </act>
            </entry>
          </xsl:otherwise>
        </xsl:choose>
      </section>
    </component>
  </xsl:template>
  <xsl:template name="goals">



    <component>
      <section>
        <templateId root="2.16.840.1.113883.10.20.22.2.60"/>
        <code code="61146-7" displayName="GOALS" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC"/>
        <title>GOALS</title>
        <xsl:choose>
          <xsl:when test="boolean(goalListObj/Goal)">
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
                    <xsl:if test ="boolean(date) = false">
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="date != ''">
                      <xsl:attribute name="value">
                        <xsl:value-of select="date"/>
                      </xsl:attribute>
                    </xsl:if >
                    <xsl:if test ="date = ''">
                      <xsl:attribute name="nullFlavor">
                        <xsl:text>UNK</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                  </effectiveTime>

                  <!-- this may not be the recommended way to record a visual inspection -db -->
                  <value xsi:type="ST">
                    <xsl:value-of select="text"/>
                  </value>

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


          </xsl:when>
          <xsl:otherwise>
            <text>Data in this section may be excluded or not available.</text>
            <entry typeCode = "DRIV">
              <observation classCode="OBS" moodCode="GOL">
                <templateId root = "2.16.840.1.113883.10.20.22.4.121"/>
                <id root="3700b3b0-fbed-11e2-b778-0800200c9a66"/>
                <!-- TODO (min - not required for test data): find a more suitable LOINC code for generic fever or for Visual Inspection -db -->
                <code code="58144-7" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Resident's overall goal established during assessment process"/>
                <statusCode code="active"/>
              </observation>
            </entry>
          </xsl:otherwise>
        </xsl:choose>
      </section>
    </component>
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
          Scheduled Appointment Date:   <xsl:call-template name="show-time">
            <xsl:with-param name="datetime">
              <xsl:value-of select="effectiveTime"/>
            </xsl:with-param>
          </xsl:call-template >
          <br></br>
        </paragraph>
      </xsl:for-each >
    </text>
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
</xsl:stylesheet>