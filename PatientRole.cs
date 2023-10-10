// Decompiled with JetBrains decompiler
// Type: CCDA.PatientRole
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class PatientRole
  {
    public Address patientAddress;
    public Address patientPreviousAddress;
    public string raceCode;
    public string race;
    public string granularRacecode;
    public string granularRace;
    public string additionalraceCode;
    public string additionalrace;
    public string additionalgranularRacecode;
    public string additionalgranularRace;
    public string ethnicGroupCode;
    public string ethnicGroupCodeDisplayName;
    public string granularethnicGroupCode;
    public string granularethnicGroupCodeDisplayName;
    public string additionalethnicGroupCode;
    public string additionalethnicGroupCodeDisplayName;
    public string additionalgranularethnicGroupCode;
    public string additionalgranularethnicGroupCodeDisplayName;
    public string patientPrefix;
    public string patientSuffix;
    public string patientMiddleName;
    public string patientFirstName;
    public string patientPreviousName;
    public string patientFamilyName;
    public string patientHealthVaultID;
    public string administrativeGenderCode;
    public string administrativeGenderDisplayName;
    public string maritalStatusCode;
    public string maritalStatusDisplayName;
    public string religiousAffiliationCodeCode;
    public string religiousAffiliationCodeDisplayName;
    public string birthTime;
    public string languageCommunication;
    public string languageCommunicationDisplayname;
    public string languageCommunicationModeCodeCode;
    public string languageCommunicationModeCodeDisplayName;
    public string languageCommunicationPreferenceInd;
    public string insuranceProvider;
    public string insuranceProviderCode;
    public string mrn;

    public PatientRole()
    {
      this.patientAddress = new Address();
      this.patientPreviousAddress = new Address();
    }
  }
}
