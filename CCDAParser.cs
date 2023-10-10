// Decompiled with JetBrains decompiler
// Type: CCDA.CCDAParser
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.IO;
using System.Reflection;
using System.Threading;
using System.Xml;
using System.Xml.Xsl;

namespace CCDA
{
  public class CCDAParser
  {
    public static CCDA ParseCCDA(string inputXml)
    {
      CCDA ccda = new CCDA();
      ccda.XML = inputXml;
      XmlDocument xmlDocument = new XmlDocument();
      xmlDocument.LoadXml(inputXml);
      XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
      nsmgr.AddNamespace("def", "urn:hl7-org:v3");
      nsmgr.AddNamespace("sdtc", "urn:hl7-org:sdtc");
      try
      {
        ccda.CCDAEffectiveTimeValue = xmlDocument.SelectSingleNode("//def:ClinicalDocument/def:effectiveTime", nsmgr).Attributes["value"].Value;
      }
      catch
      {
      }
      try
      {
        ccda.FacilityAddressObj.name = xmlDocument.SelectSingleNode("//def:providerOrganization/def:name", nsmgr).InnerText;
      }
      catch
      {
      }
      try
      {
        ccda.PrimaryProviderObj.givenName = xmlDocument.SelectSingleNode("//def:author/def:assignedAuthor/def:assignedPerson/def:name/def:given", nsmgr).InnerText;
        ccda.PrimaryProviderObj.familyName = xmlDocument.SelectSingleNode("//def:author/def:assignedAuthor/def:assignedPerson/def:name/def:family", nsmgr).InnerText;
        ccda.PrimaryProviderObj.visitDate = xmlDocument.SelectSingleNode("//def:author/def:time", nsmgr).Attributes["value"].Value;
      }
      catch
      {
      }
      try
      {
        ccda.patientRoleObj.patientFirstName = xmlDocument.SelectSingleNode("//def:patient/def:name/def:given", nsmgr).InnerText;
        ccda.patientRoleObj.patientFamilyName = xmlDocument.SelectSingleNode("//def:patient/def:name/def:family", nsmgr).InnerText;
      }
      catch
      {
      }
      try
      {
        ccda.patientRoleObj.patientMiddleName = xmlDocument.SelectSingleNode("//def:patient/def:name/def:given[2]", nsmgr).InnerText;
        ccda.patientRoleObj.patientPreviousName = xmlDocument.SelectSingleNode("//def:patient/def:name[2]/def:given", nsmgr).InnerText;
        ccda.patientRoleObj.patientSuffix = xmlDocument.SelectSingleNode("//def:patient/def:name/def:suffix", nsmgr).InnerText;
        ccda.patientRoleObj.patientPrefix = xmlDocument.SelectSingleNode("//def:patient/def:name/def:prefix", nsmgr).InnerText;
      }
      catch
      {
      }
      try
      {
        ccda.patientRoleObj.birthTime = xmlDocument.SelectSingleNode("//def:patient/def:birthTime", nsmgr).Attributes["value"].Value;
      }
      catch
      {
      }
      try
      {
        ccda.patientRoleObj.patientAddress.streetAddressLine = xmlDocument.SelectSingleNode("//def:patientRole/def:addr/def:streetAddressLine", nsmgr).InnerText;
        ccda.patientRoleObj.patientAddress.city = xmlDocument.SelectSingleNode("//def:patientRole/def:addr/def:city", nsmgr).InnerText;
        ccda.patientRoleObj.patientAddress.state = xmlDocument.SelectSingleNode("//def:patientRole/def:addr/def:state", nsmgr).InnerText;
        ccda.patientRoleObj.patientAddress.postalCode = xmlDocument.SelectSingleNode("//def:patientRole/def:addr/def:postalCode", nsmgr).InnerText;
        ccda.patientRoleObj.patientAddress.country = xmlDocument.SelectSingleNode("//def:patientRole/def:addr/def:country", nsmgr).InnerText;
      }
      catch
      {
      }
      if (xmlDocument.SelectSingleNode("//def:patientRole/def:telecom", nsmgr).Attributes["value"] != null)
        ccda.patientRoleObj.patientAddress.phone = xmlDocument.SelectSingleNode("//def:patientRole/def:telecom", nsmgr).Attributes["value"].Value.Replace("tel:", "");
      if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:raceCode", nsmgr).Attributes["code"] != null)
        ccda.patientRoleObj.raceCode = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:raceCode", nsmgr).Attributes["code"].Value;
      if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:raceCode", nsmgr).Attributes["displayName"] != null)
        ccda.patientRoleObj.race = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:raceCode", nsmgr).Attributes["displayName"].Value;
      try
      {
        if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/sdtc:raceCode", nsmgr).Attributes["code"] != null)
          ccda.patientRoleObj.granularRacecode = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/sdtc:raceCode", nsmgr).Attributes["code"].Value;
        if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/sdtc:raceCode", nsmgr).Attributes["displayName"] != null)
          ccda.patientRoleObj.granularRace = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/sdtc:raceCode", nsmgr).Attributes["displayName"].Value;
      }
      catch
      {
      }
      if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:languageCommunication/def:languageCode", nsmgr).Attributes["code"] != null)
        ccda.patientRoleObj.languageCommunication = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:languageCommunication/def:languageCode", nsmgr).Attributes["code"].Value;
      if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:ethnicGroupCode", nsmgr).Attributes["code"] != null)
        ccda.patientRoleObj.ethnicGroupCode = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:ethnicGroupCode", nsmgr).Attributes["code"].Value;
      if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:ethnicGroupCode", nsmgr).Attributes["displayName"] != null)
        ccda.patientRoleObj.ethnicGroupCodeDisplayName = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:ethnicGroupCode", nsmgr).Attributes["displayName"].Value;
      try
      {
        if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:maritalStatusCode", nsmgr).Attributes["code"] != null)
          ccda.patientRoleObj.maritalStatusCode = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:maritalStatusCode", nsmgr).Attributes["code"].Value;
        if (xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:maritalStatusCode", nsmgr).Attributes["displayName"] != null)
          ccda.patientRoleObj.maritalStatusDisplayName = xmlDocument.SelectSingleNode("//def:patientRole/def:patient/def:maritalStatusCode", nsmgr).Attributes["displayName"].Value;
      }
      catch
      {
      }
      try
      {
        ccda.patientRoleObj.administrativeGenderCode = xmlDocument.SelectSingleNode("//def:patient/def:administrativeGenderCode", nsmgr).Attributes["code"].Value;
      }
      catch
      {
      }
      try
      {
        ccda.patientRoleObj.administrativeGenderDisplayName = xmlDocument.SelectSingleNode("//def:patient/def:administrativeGenderCode", nsmgr).Attributes["displayName"].Value;
      }
      catch
      {
      }
      foreach (XmlNode xmlNode in xmlDocument.SelectNodes("//def:section[./def:templateId[@root='2.16.840.1.113883.10.20.22.2.6.1']]", nsmgr)[0] == null ? xmlDocument.SelectNodes("//def:observation[.//def:templateId[@root='2.16.840.1.113883.10.20.22.4.7']]", nsmgr) : xmlDocument.SelectNodes("//def:section[./def:templateId[@root='2.16.840.1.113883.10.20.22.2.6.1']]", nsmgr)[0].SelectNodes("def:entry", nsmgr))
      {
        try
        {
          Allergy allergy = new Allergy();
          try
          {
            allergy.participantDisplayName = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:participant/def:participantRole/def:playingEntity/def:code", nsmgr).Attributes["displayName"].Value;
          }
          catch
          {
            continue;
          }
          allergy.effectiveTimeLow = "Unknown";
          if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:low", nsmgr) != null && xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:low", nsmgr).Attributes["value"] != null)
            allergy.effectiveTimeLow = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:low", nsmgr).Attributes["value"].Value;
          allergy.effectiveTimeHigh = "Unknown";
          if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:high", nsmgr) != null && xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:high", nsmgr).Attributes["value"] != null)
            allergy.effectiveTimeHigh = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:high", nsmgr).Attributes["value"].Value;
          allergy.participantCode = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:participant/def:participantRole/def:playingEntity/def:code", nsmgr).Attributes["code"].Value;
          allergy.status = "Active";
          if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.28']]/def:observation/def:value", nsmgr) != null)
            allergy.status = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.28']]/def:observation/def:value", nsmgr).Attributes["displayName"].Value;
          if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value", nsmgr) != null)
          {
            if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value", nsmgr).Attributes["displayName"] != null)
              allergy.reactionValueDisplayName = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value", nsmgr).Attributes["displayName"].Value;
            else if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value/def:originalText", nsmgr) != null)
              allergy.reactionValueDisplayName = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value/def:originalText", nsmgr).InnerText;
            if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value", nsmgr).Attributes["code"] != null)
              allergy.reactionValueCode = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.9']]/def:observation/def:value", nsmgr).Attributes["code"].Value;
          }
          try
          {
            if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.8']]/def:observation/def:value", nsmgr) != null)
              allergy.severityDisplayName = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.8']]/def:observation/def:value", nsmgr).Attributes["displayName"].Value;
            if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.8']]/def:observation/def:value", nsmgr) != null)
              allergy.severityCode = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.8']]/def:observation/def:value", nsmgr).Attributes["code"].Value;
          }
          catch (Exception ex)
          {
          }
          ccda.allergyListObj.Add(allergy);
        }
        catch (Exception ex)
        {
          Exception exception = new Exception("Error while parsing allergies from CCDA: Details:" + ex.Message);
        }
      }
      XmlNodeList xmlNodeList = xmlDocument.SelectNodes("//def:section[./def:templateId[@root='2.16.840.1.113883.10.20.22.2.1.1']]", nsmgr)[0] == null ? xmlDocument.SelectNodes("//def:substanceAdministration[.//def:templateId[@root='2.16.840.1.113883.10.20.22.4.16']]", nsmgr) : xmlDocument.SelectNodes("//def:section[./def:templateId[@root='2.16.840.1.113883.10.20.22.2.1.1']]", nsmgr)[0].SelectNodes("def:entry", nsmgr);
      int i = 0;
      foreach (XmlNode xmlNode in xmlNodeList)
      {
        try
        {
          if (xmlNode.SelectSingleNode("def:substanceAdministration", nsmgr).Attributes["negationInd"] != null)
          {
            if (xmlNode.SelectSingleNode("def:substanceAdministration", nsmgr).Attributes["negationInd"].Value.ToLower() == "true")
              continue;
          }
          Medication medication = new Medication();
          if (xmlNode.SelectSingleNode("def:substanceAdministration/def:text", nsmgr) != null)
            medication.administrationUnitDisplayName = xmlNode.SelectSingleNode("def:substanceAdministration/def:text", nsmgr).InnerText.Trim();
          medication.effectiveTimeLow = "Unknown";
          if (xmlNode.SelectSingleNode("def:substanceAdministration/def:effectiveTime/def:low", nsmgr) != null && xmlNode.SelectSingleNode("def:substanceAdministration/def:effectiveTime/def:low", nsmgr).Attributes["value"] != null)
            medication.effectiveTimeLow = xmlNode.SelectSingleNode("def:substanceAdministration/def:effectiveTime/def:low", nsmgr).Attributes["value"].Value;
          if (xmlNode.SelectNodes("def:substanceAdministration/def:effectiveTime", nsmgr).Count > 1 && xmlNode.SelectNodes("def:substanceAdministration/def:effectiveTime", nsmgr)[1].SelectSingleNode("def:period", nsmgr) != null)
          {
            medication.effectiveTimePeriodValue = xmlNode.SelectNodes("def:substanceAdministration/def:effectiveTime", nsmgr)[1].SelectSingleNode("def:period", nsmgr).Attributes["value"].Value;
            medication.effectiveTimePeriodUnit = xmlNode.SelectNodes("def:substanceAdministration/def:effectiveTime", nsmgr)[1].SelectSingleNode("def:period", nsmgr).Attributes["unit"].Value;
          }
          if (xmlNode.SelectSingleNode("def:substanceAdministration/def:doseQuantity", nsmgr) != null)
          {
            if (xmlNode.SelectSingleNode("def:substanceAdministration/def:doseQuantity", nsmgr).Attributes["value"] != null)
              medication.doseQuantityValue = xmlNode.SelectSingleNode("def:substanceAdministration/def:doseQuantity", nsmgr).Attributes["value"].Value;
            if (xmlNode.SelectSingleNode("def:substanceAdministration/def:doseQuantity", nsmgr).Attributes["unit"] != null)
              medication.doseQuantityUnit = xmlNode.SelectSingleNode("def:substanceAdministration/def:doseQuantity", nsmgr).Attributes["unit"].Value;
          }
          if (xmlNode.SelectSingleNode("def:substanceAdministration/def:rateQuantity", nsmgr) != null)
          {
            medication.rateQuantityValue = xmlNode.SelectSingleNode("def:substanceAdministration/def:rateQuantity", nsmgr).Attributes["value"].Value;
            medication.rateQuantityUnit = xmlNode.SelectSingleNode("def:substanceAdministration/def:rateQuantity", nsmgr).Attributes["unit"].Value;
          }
          try
          {
            if (xmlNode.SelectSingleNode("def:substanceAdministration/def:routeCode", nsmgr) != null)
            {
              medication.routeCodeCode = xmlNode.SelectSingleNode("def:substanceAdministration/def:routeCode", nsmgr).Attributes["code"].Value;
              medication.routeCodeDisplayName = xmlNode.SelectSingleNode("def:substanceAdministration/def:routeCode", nsmgr).Attributes["displayName"].Value;
            }
          }
          catch
          {
          }
          try
          {
            if (xmlNode.SelectSingleNode("def:substanceAdministration/def:administrationUnitCode", nsmgr) != null)
            {
              medication.administrationUnitCode = xmlNode.SelectSingleNode("def:substanceAdministration/def:administrationUnitCode", nsmgr).Attributes["code"].Value;
              medication.administrationUnitDisplayName = xmlNode.SelectSingleNode("def:substanceAdministration/def:administrationUnitCode", nsmgr).Attributes["displayName"].Value;
            }
          }
          catch
          {
          }
          medication.effectiveTimeHigh = "Unknown";
          if (xmlNode.SelectSingleNode("def:substanceAdministration/def:effectiveTime/def:high", nsmgr) != null && xmlNode.SelectSingleNode("def:substanceAdministration/def:effectiveTime/def:high", nsmgr).Attributes["value"] != null)
            medication.effectiveTimeHigh = xmlNode.SelectSingleNode("def:substanceAdministration/def:effectiveTime/def:high", nsmgr).Attributes["value"].Value;
          medication.manufacturedMaterialObj = new ManufacturedMaterial();
          if (xmlNode.SelectSingleNode("def:substanceAdministration/def:consumable/def:manufacturedProduct/def:manufacturedMaterial/def:code", nsmgr).Attributes["code"] != null)
          {
            medication.manufacturedMaterialObj.manufacturedMaterialCode = xmlNode.SelectSingleNode("def:substanceAdministration/def:consumable/def:manufacturedProduct/def:manufacturedMaterial/def:code", nsmgr).Attributes["code"].Value;
            medication.manufacturedMaterialObj.manufacturedMaterialDisplayName = xmlNode.SelectSingleNode("def:substanceAdministration/def:consumable/def:manufacturedProduct/def:manufacturedMaterial/def:code", nsmgr).Attributes["displayName"].Value;
          }
          else
          {
            medication.manufacturedMaterialObj.manufacturedMaterialCode = xmlNode.SelectSingleNode("def:substanceAdministration/def:consumable/def:manufacturedProduct/def:manufacturedMaterial/def:code/def:translation", nsmgr).Attributes["code"].Value;
            medication.manufacturedMaterialObj.manufacturedMaterialDisplayName = xmlNode.SelectSingleNode("def:substanceAdministration/def:consumable/def:manufacturedProduct/def:manufacturedMaterial/def:code/def:translation", nsmgr).Attributes["displayName"].Value;
          }
          try
          {
            medication.instructions = xmlNode.SelectNodes("../def:text/def:table/def:tbody/def:tr", nsmgr)[i].SelectNodes("def:td", nsmgr)[1].InnerText;
            medication.instructions = medication.instructions + " " + xmlNode.SelectNodes("../def:text/def:table/def:tbody/def:tr", nsmgr)[i].SelectNodes("def:td", nsmgr)[6].InnerText;
          }
          catch
          {
          }
          ++i;
          medication.status = "Active";
          ccda.medicationListObj.Add(medication);
          ccda.medicationAdministedListObj.Add(medication);
        }
        catch (Exception ex)
        {
          Exception exception = new Exception("Error while parsing medications from CCDA: Details:" + ex.Message);
        }
      }
      foreach (XmlNode xmlNode in xmlDocument.SelectNodes("//def:section[./def:templateId[@root='2.16.840.1.113883.10.20.22.2.5.1']]", nsmgr)[0] == null ? xmlDocument.SelectNodes("//def:observation[.//def:templateId[@root='2.16.840.1.113883.10.20.22.4.4']]", nsmgr) : xmlDocument.SelectNodes("//def:section[./def:templateId[@root='2.16.840.1.113883.10.20.22.2.5.1']]", nsmgr)[0].SelectNodes("def:entry", nsmgr))
      {
        try
        {
          if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation", nsmgr).Attributes["negationInd"] != null)
          {
            if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation", nsmgr).Attributes["negationInd"].Value.ToLower() == "true")
              continue;
          }
          Problem problem = new Problem();
          problem.topLevelEffectiveTimeLow = "Unknown";
          if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:low", nsmgr) != null && xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:low", nsmgr).Attributes["value"] != null)
            problem.topLevelEffectiveTimeLow = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:low", nsmgr).Attributes["value"].Value;
          problem.topLevelEffectiveTimeHigh = "Unknown";
          if (xmlNode.ParentNode.ParentNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:high", nsmgr) != null && xmlNode.ParentNode.ParentNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:high", nsmgr).Attributes["value"] != null)
            problem.topLevelEffectiveTimeHigh = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:effectiveTime/def:high", nsmgr).Attributes["value"].Value;
          problem.status = "Active";
          if (problem.topLevelEffectiveTimeHigh != "Unknown")
            problem.status = "Inactive";
          try
          {
            problem.problemNameDisplayName = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:value", nsmgr).Attributes["displayName"].Value;
          }
          catch
          {
            try
            {
              problem.problemNameDisplayName = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:value/def:translation", nsmgr).Attributes["displayName"].Value;
            }
            catch
            {
            }
          }
          try
          {
            problem.problemNameCode = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:value", nsmgr).Attributes["code"].Value;
          }
          catch
          {
            try
            {
              problem.problemNameCode = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:value/def:translation", nsmgr).Attributes["code"].Value;
            }
            catch
            {
            }
          }
          try
          {
            problem.codeSystem = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:value", nsmgr).Attributes["codeSystem"].Value;
          }
          catch
          {
            try
            {
              problem.codeSystem = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:value/def:translation", nsmgr).Attributes["codeSystem"].Value;
            }
            catch
            {
            }
          }
          try
          {
            if (xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.6']]/def:observation/def:value", nsmgr) != null)
              problem.status = xmlNode.SelectSingleNode("def:act/def:entryRelationship/def:observation/def:entryRelationship[./def:observation/def:templateId[@root='2.16.840.1.113883.10.20.22.4.6']]/def:observation/def:value", nsmgr).Attributes["displayName"].Value;
          }
          catch
          {
          }
          ccda.problemListObj.Add(problem);
        }
        catch (Exception ex)
        {
          Exception exception = new Exception("Error while parsing problems from CCDA: Details:" + ex.Message);
        }
      }
      return ccda;
    }

    public static CCDA ParseCCR(string inputXml)
    {
      try
      {
        CCDA ccr = new CCDA();
        ccr.XML = inputXml;
        XmlDocument xmlDocument = new XmlDocument();
        xmlDocument.LoadXml(inputXml);
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
        nsmgr.AddNamespace("ccr", "urn:astm-org:CCR");
        ccr.patientRoleObj.patientFirstName = xmlDocument.SelectSingleNode("//ccr:DateOfBirth/preceding::ccr:Name/ccr:BirthName/ccr:Given", nsmgr).InnerText;
        ccr.patientRoleObj.patientFamilyName = xmlDocument.SelectSingleNode("//ccr:DateOfBirth/preceding::ccr:Name/ccr:BirthName/ccr:Family", nsmgr).InnerText;
        ccr.patientRoleObj.birthTime = xmlDocument.SelectSingleNode("//ccr:DateOfBirth/ccr:ExactDateTime", nsmgr).InnerText;
        ccr.patientRoleObj.administrativeGenderDisplayName = xmlDocument.SelectSingleNode("//ccr:Gender/ccr:Text", nsmgr).InnerText;
        ccr.patientRoleObj.administrativeGenderCode = xmlDocument.SelectSingleNode("//ccr:Gender/ccr:Code/ccr:Value", nsmgr).InnerText;
        return ccr;
      }
      catch (Exception ex)
      {
        throw new Exception("Error while parsing CCR:" + ex.Message);
      }
    }

    public static CCDA ParseC32(string inputXml)
    {
      try
      {
        CCDA c32 = new CCDA();
        c32.XML = inputXml;
        XmlDocument xmlDocument = new XmlDocument();
        xmlDocument.LoadXml(inputXml);
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
        nsmgr.AddNamespace("def", "urn:hl7-org:v3");
        c32.patientRoleObj.patientFirstName = xmlDocument.SelectSingleNode("//def:patient/def:name/def:given", nsmgr).InnerText;
        c32.patientRoleObj.patientFamilyName = xmlDocument.SelectSingleNode("//def:patient/def:name/def:family", nsmgr).InnerText;
        c32.patientRoleObj.birthTime = xmlDocument.SelectSingleNode("//def:patient/def:birthTime", nsmgr).Attributes["value"].Value;
        c32.patientRoleObj.administrativeGenderCode = xmlDocument.SelectSingleNode("//def:patient/def:administrativeGenderCode", nsmgr).Attributes["code"].Value;
        c32.patientRoleObj.administrativeGenderDisplayName = xmlDocument.SelectSingleNode("//def:patient/def:administrativeGenderCode", nsmgr).Attributes["displayName"].Value;
        return c32;
      }
      catch (Exception ex)
      {
        throw new Exception("Error while parsing problems from C32: Details:" + ex.Message);
      }
    }

    public static string TransformXMLToHTML(string inputXml, string xsltString)
    {
      XslCompiledTransform compiledTransform = new XslCompiledTransform();
      xsltString = File.ReadAllText(xsltString);
      using (XmlReader stylesheet = XmlReader.Create((TextReader) new StringReader(xsltString)))
        compiledTransform.Load(stylesheet);
      StringWriter results = new StringWriter();
      using (XmlReader input = XmlReader.Create((TextReader) new StringReader(inputXml)))
        compiledTransform.Transform(input, (XsltArgumentList) null, (TextWriter) results);
      return results.ToString();
    }

    private static string TransformresourceToHTML(
      string inputXml,
      string resourcename,
      XsltArgumentList args)
    {
      string strHTML = "";
      Thread thread = new Thread((ThreadStart) (() => CCDAParser.BaseTransformerToHTML(inputXml, resourcename, args, out strHTML)), 8388608);
      thread.Start();
      thread.Join();
      return strHTML;
    }

    private static void BaseTransformerToHTML(
      string inputxml,
      string resourcename,
      XsltArgumentList args,
      out string strHTML)
    {
      StringWriter results = new StringWriter();
      try
      {
        XslCompiledTransform compiledTransform = new XslCompiledTransform();
        using (Stream manifestResourceStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(resourcename))
        {
          using (XmlReader stylesheet = XmlReader.Create(manifestResourceStream))
          {
            compiledTransform = new XslCompiledTransform();
            compiledTransform.Load(stylesheet);
          }
        }
        using (XmlReader input = XmlReader.Create((TextReader) new StringReader(inputxml)))
          compiledTransform.Transform(input, args, (TextWriter) results);
      }
      catch (Exception ex)
      {
      }
      strHTML = results.ToString();
    }

    public static string TransformCCDAToHTML(string inputXml, XsltArgumentList args) => CCDAParser.TransformresourceToHTML(inputXml, "CCDA.CDA.xsl", args);

    public static string TransformCCDAToHTMLString(string inputXml, string sections)
    {
      string[] strArray = sections.Split(",".ToCharArray());
      XmlDocument xmlDocument = new XmlDocument();
      xmlDocument.LoadXml(inputXml);
      XsltArgumentList args = new XsltArgumentList();
      XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
      nsmgr.AddNamespace("def", "urn:hl7-org:v3");
      nsmgr.AddNamespace("sdtc", "urn:hl7-org:sdtc");
      for (int index = 0; index < strArray.Length; ++index)
      {
        args.AddParam("a" + (index + 1).ToString(), "", (object) strArray[index]);
        if (strArray[index].ToLower().Contains("immunizations"))
        {
          try
          {
            foreach (XmlNode selectNode in xmlDocument.SelectNodes("//def:component/def:section/def:templateId[@root='2.16.840.1.113883.10.20.22.2.2']", nsmgr))
              selectNode.Attributes["root"].Value = "2.16.840.1.113883.10.20.22.2.2.1";
          }
          catch
          {
          }
        }
        if (strArray[index].ToLower().Contains("encounter diagnosis"))
        {
          try
          {
            foreach (XmlNode selectNode in xmlDocument.SelectNodes("//def:component/def:section/def:templateId[@root='2.16.840.1.113883.10.20.22.2.22']", nsmgr))
              selectNode.Attributes["root"].Value = "2.16.840.1.113883.10.20.22.2.22.1";
          }
          catch
          {
          }
        }
      }
      return CCDAParser.TransformCCDAToHTML(xmlDocument.OuterXml, args);
    }

    public static string TransformCCRToHTML(string inputXml, XsltArgumentList args) => CCDAParser.TransformresourceToHTML(inputXml, "CCDA.CCR.xsl", args);

    public static string TransformCCDAToHTML(string inputXml) => CCDAParser.TransformresourceToHTML(inputXml, "CCDA.CDAHTML.xsl", (XsltArgumentList) null);

    public static string TransformC32ToHTML(string inputXml, XsltArgumentList args) => CCDAParser.TransformresourceToHTML(inputXml, "CCDA.C32.xsl", args);

    public static string GetFileType(string inputXml)
    {
      try
      {
        XmlDocument xmlDocument = new XmlDocument();
        xmlDocument.LoadXml(inputXml);
        XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
        nsmgr.AddNamespace("def", "urn:hl7-org:v3");
        if (xmlDocument.SelectSingleNode("/").LastChild.Name == "ccr:ContinuityOfCareRecord")
          return "ccr";
        if (xmlDocument.SelectNodes("//def:templateId[@root = '2.16.840.1.113883.10.20.22.1.1']", nsmgr) != null && xmlDocument.SelectNodes("//def:templateId[@root = '2.16.840.1.113883.10.20.22.1.1']", nsmgr).Count > 0)
          return "ccda";
        if (xmlDocument.SelectNodes("//def:templateId[@root = '2.16.840.1.113883.10.20.3']", nsmgr).Count > 0)
          return "c32";
        if (xmlDocument.SelectNodes("//def:templateId[@root = '2.16.840.1.113883.10.20.1']", nsmgr).Count > 0)
          return "ccd";
      }
      catch
      {
      }
      return "invalid";
    }
  }
}
