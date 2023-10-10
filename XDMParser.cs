// Decompiled with JetBrains decompiler
// Type: CCDA.XDMParser
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Xml;

namespace CCDA
{
  public class XDMParser
  {
    public List<XDMFilesPulled> ParseAndGetFiles(string zipfilename, string tempFolderForProcessing)
    {
      List<XDMFilesPulled> andGetFiles = new List<XDMFilesPulled>();
      string str1 = Path.GetFileName(zipfilename) + "_" + DateTime.Now.ToString("yyyy_MM_dd_hh_mm_ss");
      string str2 = tempFolderForProcessing + "\\" + str1 + "\\source";
      ZipFile.ExtractToDirectory(zipfilename, str2);
      foreach (string enumerateFile in Directory.EnumerateFiles(str2, "*.xml", SearchOption.AllDirectories))
      {
        if (Path.GetFileNameWithoutExtension(enumerateFile).ToLower() == "metadata")
        {
          try
          {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(enumerateFile);
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDocument.NameTable);
            nsmgr.AddNamespace("xmlns1", "urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0");
            XmlNodeList xmlNodeList1 = xmlDocument.SelectNodes("//xmlns1:ExtrinsicObject[@mimeType='text/xml']", nsmgr);
            for (int i1 = 0; i1 < xmlNodeList1.Count; ++i1)
            {
              XmlNodeList xmlNodeList2 = xmlNodeList1[i1].SelectNodes("xmlns1:Slot[@name='URI']", nsmgr);
              for (int i2 = 0; i2 < xmlNodeList2.Count; ++i2)
              {
                XmlNode xmlNode = xmlNodeList2[i2].SelectSingleNode("xmlns1:ValueList/xmlns1:Value", nsmgr);
                if (xmlNode != null)
                {
                  string innerText = xmlNode.InnerText;
                  string directoryName = Path.GetDirectoryName(enumerateFile);
                  andGetFiles.Add(new XDMFilesPulled()
                  {
                    fileBytes = File.ReadAllBytes(directoryName + "\\" + innerText),
                    fileName = innerText
                  });
                }
              }
            }
          }
          catch (Exception ex)
          {
            throw ex;
          }
        }
      }
      return andGetFiles;
    }
  }
}
