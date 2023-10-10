// Decompiled with JetBrains decompiler
// Type: CCDA.CCDA
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using System.Xml.Xsl;

namespace CCDA
{
  public class CCDA
  {
    public string CCDACode;
    public string CCDADisplayName;
    public string CCDAEffectiveTimeValue;
    public string DocumentID;
    public string EHRName;
    public string EHRID;
    public string dischargeinstructions;
    public PatientRole patientRoleObj;
    public AssignedPerson PrimaryProviderObj;
    public Author author;
    public DataEnterer dataEnterer;
    public Informant informant;
    public InformationRecepient informationRecepient;
    public List<Participant> participantListObj;
    public List<AssignedPerson> careTeamObj;
    public Address FacilityAddressObj;
    public List<Allergy> allergyListObj;
    public List<Encounter> encounterListObj;
    public List<Problem> problemListObj;
    public List<Result> resultListObj;
    public List<Laborders> labordersObjColl;
    public List<EncounterDiagnosis> encounterDiagnosisListObj;
    public List<VitalSign> vitalSignListObj;
    public List<SocialHistory> socialHistoryListObj;
    public List<Procedure> procedureListObj;
    public List<CarePlan> carePlanListObj;
    public List<Goal> goalListObj;
    public List<HealthConcern> healthConcernListObj;
    public List<Instructions> instructionListObj;
    public List<Assesment> assesmentListObj;
    public List<Medication> medicationListObj;
    public List<Medication> medicationAdministedListObj;
    public List<Immunization> immunizationListObj;
    public List<FunctionalStatus> FunctionalStatusListObj;
    public List<Referral> ReferralListObj;
    public HealthStatus healthStatusObj;
    public string Chiefcomplaint;
    public List<ClinicalNote> ClinicalNotesObj;
    public CCDA.CCDAType CCDATypeObj;
    public bool IsCCDADS4P;
    public PrivacyMarkings PrivacyMarkingsObj;
    public List<FamilyHistory> FamilyHistoryObj;
    public List<MedicalHistory> MedicalHistoryObj;

    public string XML { get; set; }

    public CCDA()
    {
      this.patientRoleObj = new PatientRole();
      this.allergyListObj = new List<Allergy>();
      this.problemListObj = new List<Problem>();
      this.resultListObj = new List<Result>();
      this.labordersObjColl = new List<Laborders>();
      this.encounterListObj = new List<Encounter>();
      this.encounterDiagnosisListObj = new List<EncounterDiagnosis>();
      this.socialHistoryListObj = new List<SocialHistory>();
      this.procedureListObj = new List<Procedure>();
      this.carePlanListObj = new List<CarePlan>();
      this.medicationListObj = new List<Medication>();
      this.immunizationListObj = new List<Immunization>();
      this.PrimaryProviderObj = new AssignedPerson();
      this.careTeamObj = new List<AssignedPerson>();
      this.FacilityAddressObj = new Address();
      this.FunctionalStatusListObj = new List<FunctionalStatus>();
      this.ReferralListObj = new List<Referral>();
      this.medicationAdministedListObj = new List<Medication>();
      this.assesmentListObj = new List<Assesment>();
      this.CCDATypeObj = CCDA.CCDAType.CCDA;
      this.IsCCDADS4P = false;
      this.PrivacyMarkingsObj = new PrivacyMarkings();
      this.ClinicalNotesObj = new List<ClinicalNote>();
      this.FamilyHistoryObj = new List<FamilyHistory>();
      this.MedicalHistoryObj = new List<MedicalHistory>();
    }

    public string SerializeThisObject()
    {
      XmlSerializer xmlSerializer = new XmlSerializer(typeof (CCDA));
      string empty = string.Empty;
      using (TextWriter w = (TextWriter) new StringWriterWithEncoding(Encoding.UTF8))
      {
        using (XmlWriter xmlWriter = (XmlWriter) new XmlTextWriter(w))
        {
          xmlSerializer.Serialize(xmlWriter, (object) this);
          return w.ToString();
        }
      }
    }

    public void Log(string logMessage, TextWriter w)
    {
      try
      {
        w.Write("\r\nLog Entry : ");
        TextWriter textWriter = w;
        string longTimeString = DateTime.Now.ToLongTimeString();
        string longDateString = DateTime.Now.ToLongDateString();
        string str1 = longTimeString;
        string str2 = longDateString;
        textWriter.WriteLine("{0} {1}", (object) str1, (object) str2);
        w.WriteLine("  :");
        w.WriteLine("  :{0}", (object) logMessage);
        w.WriteLine("-------------------------------");
      }
      catch
      {
      }
    }

    public string GenerateCCDA()
    {
      StringReader input1 = (StringReader) null;
      StringWriterWithEncoding results = (StringWriterWithEncoding) null;
      StringBuilder stringBuilder = new StringBuilder();
      string empty = string.Empty;
      try
      {
        string str = this.SerializeThisObject();
        XslCompiledTransform compiledTransform = new XslCompiledTransform();
        string name = "CCDA.CCDA.xsl";
        if (this.CCDATypeObj == CCDA.CCDAType.Referral_Note)
          name = "CCDA.CCDA_ReferralNote.xsl";
        using (Stream manifestResourceStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(name))
        {
          using (XmlReader stylesheet = XmlReader.Create(manifestResourceStream))
          {
            compiledTransform = new XslCompiledTransform();
            compiledTransform.Load(stylesheet);
          }
        }
        string s = str.Replace("xmlns=\"", "");
        this.XML = s;
        input1 = new StringReader(s);
        XmlReaderSettings settings = new XmlReaderSettings();
        XmlReader input2 = XmlReader.Create((TextReader) input1, settings);
        results = new StringWriterWithEncoding(Encoding.UTF8);
        results.Write(stringBuilder.ToString());
        compiledTransform.Transform(input2, new XsltArgumentList(), (TextWriter) results);
        return results.ToString().Replace("xmlns=\"\"", "");
      }
      catch (Exception ex)
      {
        using (StreamWriter w = File.AppendText("err.txt"))
          this.Log("Failed:  " + ex.Message, (TextWriter) w);
        throw new Exception("Error while generating from CCDA. Please check for invalid XML characters: Details:" + ex.Message);
      }
      finally
      {
        input1?.Close();
        results?.Close();
      }
    }

    public string GenerateCCDAAPI()
    {
      StringReader input1 = (StringReader) null;
      StringWriterWithEncoding results = (StringWriterWithEncoding) null;
      StringBuilder stringBuilder = new StringBuilder();
      string empty = string.Empty;
      try
      {
        string str = this.SerializeThisObject();
        XslCompiledTransform compiledTransform = new XslCompiledTransform();
        string name = "CCDA.CCDAAPI.xsl";
        using (Stream manifestResourceStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(name))
        {
          using (XmlReader stylesheet = XmlReader.Create(manifestResourceStream))
          {
            compiledTransform = new XslCompiledTransform();
            compiledTransform.Load(stylesheet);
          }
        }
        string s = str.Replace("xmlns=\"", "");
        this.XML = s;
        input1 = new StringReader(s);
        XmlReaderSettings settings = new XmlReaderSettings();
        XmlReader input2 = XmlReader.Create((TextReader) input1, settings);
        results = new StringWriterWithEncoding(Encoding.UTF8);
        results.Write(stringBuilder.ToString());
        compiledTransform.Transform(input2, new XsltArgumentList(), (TextWriter) results);
        return results.ToString().Replace("xmlns=\"\"", "");
      }
      catch (Exception ex)
      {
        using (StreamWriter w = File.AppendText("err.txt"))
          this.Log("Failed:  " + ex.Message, (TextWriter) w);
        throw new Exception("Error while generating from CCDA. Please check for invalid XML characters: Details:" + ex.Message);
      }
      finally
      {
        input1?.Close();
        results?.Close();
      }
    }

    [Serializable]
    public enum CCDAType
    {
      CCDA = 1,
      Referral_Note = 2,
    }
  }
}
