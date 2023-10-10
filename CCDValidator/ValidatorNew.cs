// Decompiled with JetBrains decompiler
// Type: CCDA.CCDValidator.ValidatorNew
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Xml;
using System.Xml.Linq;

namespace CCDA.CCDValidator
{
  public class ValidatorNew
  {
    public List<CCDValidator.ValidatorResult> ValidatorResult;
    public XmlDocument XmlDocCCDr11v1Template;
    public XmlNamespaceManager nsmgr;
    public string POSSIBLE_VALUES_SEPARATOR = "##$$##";
    public string PLACE_HOLDER_SRAIGHT_NODE_XPATH = "##NSPLACHR##";
    public string[] IGNORENODESLISTFROMEMPTYNODES = new string[3]
    {
      "tr",
      "td",
      "br"
    };

    public ValidatorNew()
    {
      this.nsmgr = (XmlNamespaceManager) null;
      this.ValidatorResult = new List<CCDValidator.ValidatorResult>();
      this.XmlDocCCDr11v1Template = new XmlDocument();
      string name = "CCDA.Validator.CCDTemplates.CCD_Validator_Template.xml";
      string xml = "";
      using (Stream manifestResourceStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(name))
      {
        using (TextReader textReader = (TextReader) new StreamReader(manifestResourceStream))
          xml = textReader.ReadToEnd();
      }
      this.XmlDocCCDr11v1Template.LoadXml(xml);
    }

    private void AddToValidatorResult(
      string xPath,
      string Message,
      string Value,
      string ComponentSectionTemplateId)
    {
      CCDValidator.ValidatorResult validatorResult = new CCDValidator.ValidatorResult();
      validatorResult.xpath = xPath;
      validatorResult.message = Message;
      validatorResult.value = Value;
      try
      {
        ComponentSectionTemplateId = ComponentSectionTemplateId + " Section: (" + this.XmlDocCCDr11v1Template.SelectSingleNode("settings/componentsection/node[@templateid='" + ComponentSectionTemplateId + "']").Attributes["displayname"].Value + " ) ";
      }
      catch
      {
      }
      validatorResult.componentsectiontemplateid = ComponentSectionTemplateId;
      this.ValidatorResult.Add(validatorResult);
    }

    private string FormXpathStringXElement(XElement xSelfNodeInputCCD)
    {
      string str = xSelfNodeInputCCD.Name.LocalName;
      if (xSelfNodeInputCCD.Parent != null && xSelfNodeInputCCD.Parent.NodeType == XmlNodeType.Element)
        str = this.FormXpathStringXElement(xSelfNodeInputCCD.Parent) + "/" + str;
      return str;
    }

    private string FormXpathString(XmlNode node)
    {
      StringBuilder stringBuilder = new StringBuilder();
      while (node != null)
      {
        switch (node.NodeType)
        {
          case XmlNodeType.Element:
            int elementIndex = this.FindElementIndex((XmlElement) node);
            stringBuilder.Insert(0, "/" + node.Name + "[" + elementIndex.ToString() + "]");
            node = node.ParentNode;
            continue;
          case XmlNodeType.Attribute:
            stringBuilder.Insert(0, "/@" + node.Name);
            node = (XmlNode) ((XmlAttribute) node).OwnerElement;
            continue;
          case XmlNodeType.Document:
            return stringBuilder.ToString();
          default:
            throw new ArgumentException("Only elements and attributes are supported");
        }
      }
      throw new ArgumentException("Node was not in a document");
    }

    private int FindElementIndex(XmlElement element)
    {
      XmlNode parentNode = element.ParentNode;
      if (parentNode is XmlDocument)
        return 1;
      XmlElement xmlElement = (XmlElement) parentNode;
      int elementIndex = 1;
      foreach (XmlNode childNode in xmlElement.ChildNodes)
      {
        if (childNode is XmlElement && childNode.Name == element.Name)
        {
          if (childNode == element)
            return elementIndex;
          ++elementIndex;
        }
      }
      throw new ArgumentException("Couldn't find element within parent");
    }

    private void CheckIfPatientFirstPreviousMiddleNameAvailable(XmlDocument xmlDocCCDInput)
    {
      string str = "ns:ClinicalDocument/ns:recordTarget/ns:patientRole/ns:patient/ns:name/ns:given";
      XmlNodeList xmlNodeList = xmlDocCCDInput.SelectNodes(str, this.nsmgr);
      bool flag1 = true;
      bool flag2 = false;
      for (int i = 0; i < xmlNodeList.Count; ++i)
      {
        if (xmlNodeList[i].Attributes != null && xmlNodeList[i].Attributes.Count > 0)
        {
          if (xmlNodeList[i].Attributes["qualifier"].Value.ToLower() == "br" && xmlNodeList[i].InnerText == "")
            flag1 = false;
        }
        else if (xmlNodeList[i].InnerText != "")
          flag2 = true;
      }
      if (!flag1)
        this.AddToValidatorResult(str, "Patient Previous name not found", "", "");
      if (flag2)
        return;
      this.AddToValidatorResult(str, "Patient First name not found", "", "");
    }

    private bool PerformAdditionalChecksForComponentSection(
      XmlNode xNodeSearchTemplateCCD,
      XmlNode xNodeOneComponentSectionInputCCD)
    {
      bool flag = false;
      XmlNodeList xmlNodeList = xNodeSearchTemplateCCD.SelectNodes("additonalcheck");
      if (xmlNodeList != null && xmlNodeList.Count > 0)
      {
        for (int i = 0; i < xmlNodeList.Count; ++i)
        {
          if (xmlNodeList[i].Attributes != null && xmlNodeList[i].Attributes.Count > 0)
          {
            flag = false;
            int int32 = Convert.ToInt32(xmlNodeList[i].Attributes["nodelevelup"].Value);
            XmlNode xmlNode1 = xNodeOneComponentSectionInputCCD;
            for (int index = 0; index < int32; ++index)
              xmlNode1 = xmlNode1.ParentNode;
            if (xmlNode1 != null)
            {
              XmlNode xmlNode2 = xmlNode1;
              if (int32 > 0)
                xmlNode2 = xmlNode1.SelectSingleNode("ns:" + xmlNodeList[i].Attributes["nodename"].Value, this.nsmgr);
              if (xmlNode2 != null)
              {
                string[] strArray = new string[0];
                string[] source = xmlNodeList[i].SelectSingleNode("attrib").Attributes["possiblevalues"].Value.ToLower().Split(new string[1]
                {
                  this.POSSIBLE_VALUES_SEPARATOR
                }, StringSplitOptions.RemoveEmptyEntries);
                string name = xmlNodeList[i].SelectSingleNode("attrib").Attributes["name"].Value;
                string lower = xmlNode2.Attributes[name].Value.ToLower();
                if (((IEnumerable<string>) source).Contains<string>(lower))
                  flag = true;
              }
            }
          }
        }
      }
      else
        flag = true;
      return flag;
    }

    private string[] GetPossibleValuesFromValuesFile(string FileName)
    {
      string[] strArray = new string[0];
      using (Stream manifestResourceStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(FileName))
      {
        using (TextReader textReader = (TextReader) new StreamReader(manifestResourceStream))
          return textReader.ReadToEnd().ToLower().Split(new string[1]
          {
            Environment.NewLine
          }, StringSplitOptions.RemoveEmptyEntries);
      }
    }

    private void CompareValues(
      XmlNode xNodeOneComponentSectionTemplateCCD,
      XmlNode xNodeOneComponentSectionInputCCD,
      string xPathForTemplateCCD,
      string ComponentSectionTemplateId)
    {
      try
      {
        XmlNodeList xmlNodeList1 = xNodeOneComponentSectionTemplateCCD.SelectNodes("node[@xpathname='" + xPathForTemplateCCD + "']");
        for (int i1 = 0; i1 < xmlNodeList1.Count; ++i1)
        {
          XmlNode xNodeSearchTemplateCCD = xmlNodeList1[i1];
          if (xNodeSearchTemplateCCD != null && this.PerformAdditionalChecksForComponentSection(xNodeSearchTemplateCCD, xNodeOneComponentSectionInputCCD) && xNodeSearchTemplateCCD.Attributes != null && xNodeSearchTemplateCCD.Attributes.Count > 0)
          {
            string xPath = this.FormXpathString(xNodeOneComponentSectionInputCCD);
            XmlNodeList xmlNodeList2 = xNodeSearchTemplateCCD.SelectNodes("attrib");
            for (int i2 = 0; i2 < xmlNodeList2.Count; ++i2)
            {
              XmlNode xmlNode = xmlNodeList2[i2];
              if (xmlNode.Attributes != null)
              {
                string[] strArray = new string[0];
                string name = xmlNode.Attributes["name"].Value;
                bool flag = false;
                try
                {
                  if (xmlNode.Attributes["dofilelookup"].Value.ToLower() == "yes")
                    flag = true;
                }
                catch
                {
                  flag = false;
                }
                string[] source;
                if (flag)
                {
                  string str = "";
                  try
                  {
                    str = xNodeOneComponentSectionInputCCD.Attributes["codeSystem"].Value;
                  }
                  catch
                  {
                  }
                  string innerText;
                  if (str != "")
                  {
                    try
                    {
                      innerText = xmlNode.SelectSingleNode("filename[@codeSystem = '" + str + "']").InnerText;
                    }
                    catch
                    {
                      continue;
                    }
                  }
                  else
                    innerText = xmlNode.SelectSingleNode("filename").InnerText;
                  source = this.GetPossibleValuesFromValuesFile(innerText);
                }
                else
                  source = xmlNode.Attributes["possiblevalues"].Value.ToLower().Split(new string[1]
                  {
                    this.POSSIBLE_VALUES_SEPARATOR
                  }, StringSplitOptions.RemoveEmptyEntries);
                string str1 = "yes";
                try
                {
                  str1 = xmlNode.Attributes["attribreq"].Value;
                }
                catch
                {
                }
                try
                {
                  if (xNodeOneComponentSectionInputCCD != null)
                  {
                    if (xNodeOneComponentSectionInputCCD.Attributes != null)
                    {
                      if (xNodeOneComponentSectionInputCCD.Attributes.Count > 0)
                      {
                        if (xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"] != null)
                        {
                          if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "unk"))
                          {
                            if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "na"))
                            {
                              if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "oth"))
                              {
                                if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "asku"))
                                {
                                  if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "ni"))
                                  {
                                    if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "nask"))
                                    {
                                      if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "msk"))
                                      {
                                        if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "trc"))
                                        {
                                          if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "ninf"))
                                          {
                                            if (!(xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "pinf"))
                                            {
                                              if (xNodeOneComponentSectionInputCCD.Attributes["nullFlavor"].Value.ToLower() == "nav")
                                                continue;
                                            }
                                            else
                                              continue;
                                          }
                                          else
                                            continue;
                                        }
                                        else
                                          continue;
                                      }
                                      else
                                        continue;
                                    }
                                    else
                                      continue;
                                  }
                                  else
                                    continue;
                                }
                                else
                                  continue;
                              }
                              else
                                continue;
                            }
                            else
                              continue;
                          }
                          else
                            continue;
                        }
                        try
                        {
                          if (!((IEnumerable<string>) source).Contains<string>(xNodeOneComponentSectionInputCCD.Attributes[name].Value.ToLower()))
                            this.AddToValidatorResult(xPath, "Attribute Value " + xNodeOneComponentSectionInputCCD.Attributes[name].Value + " is incorrect or not part of valueset for " + name, "", ComponentSectionTemplateId);
                        }
                        catch (Exception ex)
                        {
                          if (str1 == "yes")
                            this.AddToValidatorResult(xPath, "Attribute " + name + " not found.", "", "");
                        }
                      }
                    }
                  }
                }
                catch (Exception ex)
                {
                  if (str1 == "yes")
                    this.AddToValidatorResult(xPath, "Attribute " + name + " not found.", "", ComponentSectionTemplateId);
                }
              }
            }
          }
        }
      }
      catch (Exception ex)
      {
      }
    }

    private void DoValidateComponentSection(
      XmlNode xNodeOneComponentSectionInputCCD,
      XmlNode xNodeOneComponentSectionTemplateCCD,
      string xPathForTemplateCCD_PARENT,
      string ComponentSectionTemplateId)
    {
      string empty1 = string.Empty;
      if (xNodeOneComponentSectionInputCCD.NodeType != XmlNodeType.Element)
        return;
      XmlNode xNodeOneComponentSectionInputCCD1 = xNodeOneComponentSectionInputCCD;
      if (xNodeOneComponentSectionInputCCD1.HasChildNodes)
      {
        for (int i = 0; i < xNodeOneComponentSectionInputCCD1.ChildNodes.Count; ++i)
        {
          string empty2 = string.Empty;
          if (xNodeOneComponentSectionInputCCD1.ChildNodes[i].NodeType == XmlNodeType.Element)
          {
            string xPathForTemplateCCD_PARENT1 = xPathForTemplateCCD_PARENT + "/" + xNodeOneComponentSectionInputCCD1.ChildNodes[i].Name;
            this.DoValidateComponentSection(xNodeOneComponentSectionInputCCD1.ChildNodes[i], xNodeOneComponentSectionTemplateCCD, xPathForTemplateCCD_PARENT1, ComponentSectionTemplateId);
          }
        }
        string empty3 = string.Empty;
        string xPathForTemplateCCD = xPathForTemplateCCD_PARENT + "/" + empty3;
        this.CompareValues(xNodeOneComponentSectionTemplateCCD, xNodeOneComponentSectionInputCCD1, xPathForTemplateCCD, ComponentSectionTemplateId);
      }
      else
      {
        string xPathForTemplateCCD = xPathForTemplateCCD_PARENT + "/" + empty1;
        this.CompareValues(xNodeOneComponentSectionTemplateCCD, xNodeOneComponentSectionInputCCD1, xPathForTemplateCCD, ComponentSectionTemplateId);
      }
    }

    private bool ValidateTimeValue(string datetimestring)
    {
      string[] strArray1 = new string[0];
      string[] strArray2 = datetimestring.Split(new string[2]
      {
        "-",
        "+"
      }, StringSplitOptions.RemoveEmptyEntries);
      bool flag;
      try
      {
        DateTime.ParseExact(strArray2[0], "yyyyMMdd", (IFormatProvider) new CultureInfo("en-US"));
        flag = true;
      }
      catch (Exception ex)
      {
        flag = false;
      }
      if (!flag)
      {
        try
        {
          DateTime.ParseExact(strArray2[0], "yyyyMMddHHmm", (IFormatProvider) new CultureInfo("en-US"));
          flag = true;
        }
        catch (Exception ex)
        {
          flag = false;
        }
      }
      if (!flag)
      {
        try
        {
          DateTime.ParseExact(strArray2[0], "yyyyMMddHHmmss", (IFormatProvider) new CultureInfo("en-US"));
          flag = true;
        }
        catch (Exception ex)
        {
          flag = false;
        }
      }
      if (!flag)
      {
        try
        {
          DateTime.ParseExact(strArray2[0], "yyyyMMddHHmm", (IFormatProvider) new CultureInfo("en-US"));
          flag = true;
        }
        catch (Exception ex)
        {
          flag = false;
        }
      }
      if (!flag)
      {
        try
        {
          DateTime.ParseExact(strArray2[0], "yyyy", (IFormatProvider) new CultureInfo("en-US"));
          flag = true;
        }
        catch (Exception ex)
        {
          flag = false;
        }
      }
      return flag;
    }

    private void ValidateEffectiveTime(XmlDocument xmlDocCCDInput)
    {
      XmlNodeList xmlNodeList = xmlDocCCDInput.SelectNodes("//ns:effectiveTime", this.nsmgr);
      for (int i1 = 0; i1 < xmlNodeList.Count; ++i1)
      {
        if (xmlNodeList[i1].HasChildNodes)
        {
          for (int i2 = 0; i2 < xmlNodeList[i1].ChildNodes.Count; ++i2)
          {
            XmlNode childNode = xmlNodeList[i1].ChildNodes[i2];
            if (childNode.NodeType == XmlNodeType.Element && (childNode.Name == "low" || childNode.Name == "high") && childNode != null && childNode.Attributes != null && childNode.Attributes.Count > 0 && (childNode.Attributes["nullFlavor"] == null || !(childNode.Attributes["nullFlavor"].Value.ToLower() == "unk")) && childNode.Attributes["value"] != null && !this.ValidateTimeValue(childNode.Attributes["value"].Value.ToString()))
              this.AddToValidatorResult(this.FormXpathString(childNode), "Attribute Value " + childNode.Attributes["value"].Value + " is incorrect for attribute.", "", "");
          }
        }
        else if (xmlNodeList[i1].Attributes != null && xmlNodeList[i1].Attributes.Count > 0 && (xmlNodeList[i1].Attributes["nullFlavor"] == null || !(xmlNodeList[i1].Attributes["nullFlavor"].Value.ToLower() == "unk")) && xmlNodeList[i1].Attributes["value"] != null && !this.ValidateTimeValue(xmlNodeList[i1].Attributes["value"].Value.ToString()))
          this.AddToValidatorResult(this.FormXpathString(xmlNodeList[i1]), "Attribute Value " + xmlNodeList[i1].Attributes["value"].Value + " is incorrect for attribute.", "", "");
      }
    }

    private void DoValidateComponentSectionForCompulsoryNodes(
      XmlNode xNodeOneComponentSectionInputCCD,
      XmlNode xNodeOneComponentSectionTemplateCCD,
      string ComponentSectionTemplateId)
    {
      string empty = string.Empty;
      if (xNodeOneComponentSectionInputCCD.NodeType != XmlNodeType.Element)
        return;
      XmlNodeList xmlNodeList = xNodeOneComponentSectionTemplateCCD.SelectNodes("node[@nodereq='yes']");
      if (xmlNodeList == null || xmlNodeList.Count <= 0)
        return;
      for (int i = 0; i < xmlNodeList.Count; ++i)
      {
        try
        {
          string str1;
          string str2 = str1 = xmlNodeList[i].Attributes["xpathname"].Value.ToString();
          string xpath = str1.Remove(str1.Length - 1, 1).Replace("/", "/ns:").Remove(0, 1);
          if (xNodeOneComponentSectionInputCCD.SelectSingleNode(xpath, this.nsmgr) == null)
          {
            string str3 = "";
            try
            {
              str3 = xmlNodeList[i].Attributes["displayname"].Value.ToString();
            }
            catch
            {
            }
            this.AddToValidatorResult("ClinicalDocument/component/structuredBody/component/section" + str2, str3 + " missing. ", "", ComponentSectionTemplateId);
          }
        }
        catch
        {
        }
      }
    }

    private void StartComponentSectionValidationForCompulsoryNodes(
      XmlNode xNodeCompSecNodeInputCCD,
      string xpathForComponentSection)
    {
      this.XmlDocCCDr11v1Template.SelectNodes(xpathForComponentSection.Replace("ns:", ""));
      if (xNodeCompSecNodeInputCCD.SelectSingleNode("ns:templateId", this.nsmgr) == null)
        return;
      string ComponentSectionTemplateId = xNodeCompSecNodeInputCCD.SelectSingleNode("ns:templateId", this.nsmgr).Attributes["root"].Value.ToString();
      XmlNode xNodeOneComponentSectionTemplateCCD = this.XmlDocCCDr11v1Template.SelectSingleNode("//settings/componentsection/node[@xpathname='ClinicalDocument/component/structuredBody/component/section' and @templateid='" + ComponentSectionTemplateId + "']");
      if (xNodeOneComponentSectionTemplateCCD == null)
        return;
      string empty = string.Empty;
      this.DoValidateComponentSectionForCompulsoryNodes(xNodeCompSecNodeInputCCD, xNodeOneComponentSectionTemplateCCD, ComponentSectionTemplateId);
    }

    private void StartComponentSectionValidation(
      XmlNode xNodeCompSecNodeInputCCD,
      string xpathForComponentSection)
    {
      this.XmlDocCCDr11v1Template.SelectNodes(xpathForComponentSection.Replace("ns:", ""));
      if (xNodeCompSecNodeInputCCD.SelectSingleNode("ns:templateId", this.nsmgr) == null)
        return;
      string ComponentSectionTemplateId = xNodeCompSecNodeInputCCD.SelectSingleNode("ns:templateId", this.nsmgr).Attributes["root"].Value.ToString();
      XmlNode xNodeOneComponentSectionTemplateCCD = this.XmlDocCCDr11v1Template.SelectSingleNode("//settings/componentsection/node[@xpathname='ClinicalDocument/component/structuredBody/component/section' and @templateid='" + ComponentSectionTemplateId + "']");
      if (xNodeOneComponentSectionTemplateCCD == null)
        return;
      string empty = string.Empty;
      this.DoValidateComponentSection(xNodeCompSecNodeInputCCD, xNodeOneComponentSectionTemplateCCD, empty, ComponentSectionTemplateId);
    }

    private void ReportEmptyNodes(XmlDocument xmlDocCCDInput)
    {
      IEnumerator<XElement> enumerator = XElement.Parse(xmlDocCCDInput.OuterXml).Descendants().Where<XElement>((Func<XElement, bool>) (e => string.IsNullOrEmpty(e.Value) && !e.HasElements && !e.HasAttributes)).GetEnumerator();
      while (enumerator.MoveNext())
      {
        XElement current = enumerator.Current;
        string xPath = this.FormXpathStringXElement(current);
        if (current.Value == "" && !((IEnumerable<string>) this.IGNORENODESLISTFROMEMPTYNODES).Contains<string>(current.Name.LocalName))
          this.AddToValidatorResult(xPath, "Node " + current.Name.LocalName + " has empty value.", "", "");
      }
    }

    private void ValidateBackwardCompatibility(XmlDocument xmlDocCCDInput)
    {
      XmlNodeList xmlNodeList = this.XmlDocCCDr11v1Template.SelectNodes("//settings/backwardcompatibility/node");
      for (int i = 0; i < xmlNodeList.Count; ++i)
      {
        XmlNode xNodeOneBackCompatTemplateCCD = xmlNodeList[i];
        string xPathToSearchInCCDInput = xNodeOneBackCompatTemplateCCD.Attributes["name"].Value.ToString();
        if (xPathToSearchInCCDInput.ToLower() == "templateid")
          this.CheckTemplateIdBackwardCompatibilityWithNoExtension(xNodeOneBackCompatTemplateCCD, xmlDocCCDInput, xPathToSearchInCCDInput);
      }
    }

    private void CheckTemplateIdBackwardCompatibilityWithNoExtension(
      XmlNode xNodeOneBackCompatTemplateCCD,
      XmlDocument xmlDocCCDInput,
      string xPathToSearchInCCDInput)
    {
      string xpath = "//ns:" + xPathToSearchInCCDInput;
      XmlNodeList xmlNodeList1 = xNodeOneBackCompatTemplateCCD.SelectNodes("attrib");
      for (int i1 = 0; i1 < xmlNodeList1.Count; ++i1)
      {
        XmlNode xmlNode = xmlNodeList1[i1];
        string name = xmlNode.Attributes["name"].Value.ToString();
        string str = xmlNode.Attributes["value"].Value.ToString();
        XmlNodeList xmlNodeList2 = xmlDocCCDInput.SelectNodes(xpath, this.nsmgr);
        bool flag = false;
        string xPath = "";
        for (int i2 = 0; i2 < xmlNodeList2.Count; ++i2)
        {
          XmlNode node = xmlNodeList2[i2];
          if (node.Attributes[name].Value.ToString().ToLower() == str.ToLower())
          {
            xPath = this.FormXpathString(node);
            if (node.Attributes.Count == 1)
            {
              flag = true;
              break;
            }
          }
        }
        if (!flag)
        {
          string Message = str + "  does not contain support for ccda R1.1 ";
          this.AddToValidatorResult(xPath, Message, "", "");
        }
      }
    }

    private void ValidateStraightNodes(XmlDocument xmlDocCCDInput)
    {
      XmlNodeList xmlNodeList1 = this.XmlDocCCDr11v1Template.SelectNodes("//settings/straight/node");
      for (int i1 = 0; i1 < xmlNodeList1.Count; ++i1)
      {
        XmlNode xmlNode = xmlNodeList1[i1];
        XmlNodeList xmlNodeList2 = xmlNode.SelectNodes("attrib");
        string xpath = xmlNode.Attributes["xpathname"].Value.Replace(this.PLACE_HOLDER_SRAIGHT_NODE_XPATH, "ns:");
        XmlNodeList xmlNodeList3 = xmlDocCCDInput.SelectNodes(xpath, this.nsmgr);
        string str1 = xmlNode.Attributes["nodereq"].Value;
        string str2 = "Node ";
        try
        {
          str2 = xmlNode.Attributes["displayname"].Value;
        }
        catch
        {
        }
        if (str1 == "yes" && xmlNodeList3.Count <= 0)
          this.AddToValidatorResult("", str2 + "  " + xpath + " missing.", "", "");
        if (xmlNode.Attributes["nodevaluereq"].Value.ToLower() == "yes")
        {
          for (int i2 = 0; i2 < xmlNodeList3.Count; ++i2)
          {
            if (xmlNodeList3[i2].NodeType == XmlNodeType.Element && xmlNodeList3[i2].InnerText.Trim() == string.Empty)
              this.AddToValidatorResult(this.FormXpathString(xmlNodeList3[i2]), "Node " + xmlNodeList3[i2].Name + " has empty value.", "", "");
          }
        }
        for (int i3 = 0; i3 < xmlNodeList2.Count; ++i3)
        {
          string name = xmlNodeList2[i3].Attributes["name"].Value;
          string[] strArray = new string[0];
          xmlNodeList2[i3].Attributes["possiblevalues"].Value.Split(new string[1]
          {
            this.POSSIBLE_VALUES_SEPARATOR
          }, StringSplitOptions.RemoveEmptyEntries);
          bool flag = false;
          try
          {
            if (xmlNodeList2[i3].Attributes["dofilelookup"].Value.ToLower() == "yes")
              flag = true;
          }
          catch
          {
            flag = false;
          }
          string[] source;
          if (flag)
            source = this.GetPossibleValuesFromValuesFile(xmlNodeList2[i3].SelectSingleNode("filename").InnerText);
          else
            source = xmlNodeList2[i3].Attributes["possiblevalues"].Value.ToLower().Split(new string[1]
            {
              this.POSSIBLE_VALUES_SEPARATOR
            }, StringSplitOptions.RemoveEmptyEntries);
          string str3 = "yes";
          try
          {
            str3 = xmlNodeList2[i3].Attributes["attribreq"].Value;
          }
          catch
          {
          }
          for (int i4 = 0; i4 < xmlNodeList3.Count; ++i4)
          {
            if (xmlNodeList3[i4].NodeType == XmlNodeType.Element)
            {
              string xPath = this.FormXpathString(xmlNodeList3[i4]);
              if (xmlNodeList3[i4].Attributes != null)
              {
                if (xmlNodeList3[i4].Attributes["nullFlavor"] != null)
                {
                  if (!(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "unk") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "na") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "oth") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "asku") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "ni") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "nask") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "msk") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "trc") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "ninf") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "pinf") && !(xmlNodeList3[i4].Attributes["nullFlavor"].Value.ToLower() == "nav"))
                    this.AddToValidatorResult(xPath, "Attribute Value " + xmlNodeList3[i4].Attributes["nullFlavor"].Value + " is incorrect for Attribute nullFlavor", "", "");
                }
                else
                {
                  try
                  {
                    if (!((IEnumerable<string>) source).Contains<string>(xmlNodeList3[i4].Attributes[name].Value.ToLower()))
                      this.AddToValidatorResult(xPath, "Attribute Value " + xmlNodeList3[i4].Attributes[name].Value + " is incorrect or not part of valueset for " + name, "", "");
                  }
                  catch (Exception ex)
                  {
                    if (str3 == "yes")
                      this.AddToValidatorResult(xPath, "Attribute " + name + " not found.", "", "");
                  }
                }
              }
            }
          }
        }
        XmlNodeList xmlNodeList4 = xmlNode.SelectNodes("childnode");
        for (int i5 = 0; i5 < xmlNodeList3.Count; ++i5)
        {
          for (int i6 = 0; i6 < xmlNodeList4.Count; ++i6)
          {
            XmlNodeList xmlNodeList5 = xmlNodeList3[i5].SelectNodes("ns:" + xmlNodeList4[i6].Attributes["name"].Value.ToString(), this.nsmgr);
            string str4 = this.FormXpathString(xmlNodeList3[i5]);
            if (xmlNodeList5.Count <= 0)
              this.AddToValidatorResult("", str2 + "  " + str4 + "/" + xmlNodeList4[i6].Attributes["name"].Value.ToString() + " missing.", "", "");
          }
        }
      }
    }

    public List<CCDValidator.ValidatorResult> Validate(string CCDAContent)
    {
      try
      {
        XmlDocument xmlDocCCDInput = new XmlDocument();
        bool flag = false;
        try
        {
          xmlDocCCDInput.LoadXml(CCDAContent);
          flag = true;
        }
        catch (Exception ex)
        {
          this.AddToValidatorResult("Bad Xml, not a valid CCDA", "", "", ex.Message);
        }
        if (flag)
        {
          this.nsmgr = new XmlNamespaceManager(xmlDocCCDInput.NameTable);
          this.nsmgr.AddNamespace("ns", xmlDocCCDInput.DocumentElement.NamespaceURI);
          if (CCDAParser.GetFileType(xmlDocCCDInput.OuterXml) != "ccda")
            return this.ValidatorResult;
          this.ValidateEffectiveTime(xmlDocCCDInput);
          try
          {
            this.ValidateBackwardCompatibility(xmlDocCCDInput);
          }
          catch (Exception ex)
          {
          }
          this.CheckIfPatientFirstPreviousMiddleNameAvailable(xmlDocCCDInput);
          this.ValidateStraightNodes(xmlDocCCDInput);
          string str = "ns:ClinicalDocument/ns:component/ns:structuredBody/ns:component/ns:section";
          XmlNodeList xmlNodeList = xmlDocCCDInput.SelectNodes(str, this.nsmgr);
          for (int i = 0; i < xmlNodeList.Count; ++i)
          {
            if (xmlNodeList[i].Attributes["nullFlavor"] == null || !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "ni") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "unk") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "na") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "oth") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "asku") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "ni") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "nask") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "msk") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "trc") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "ninf") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "pinf") && !(xmlNodeList[i].Attributes["nullFlavor"].Value.ToLower() == "nav"))
            {
              this.StartComponentSectionValidation(xmlNodeList[i], str);
              this.StartComponentSectionValidationForCompulsoryNodes(xmlNodeList[i], str);
            }
          }
        }
      }
      catch (Exception ex)
      {
      }
      return this.ValidatorResult;
    }
  }
}
