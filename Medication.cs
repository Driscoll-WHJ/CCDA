// Decompiled with JetBrains decompiler
// Type: CCDA.Medication
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;

namespace CCDA
{
  [Serializable]
  public class Medication
  {
    public string id;
    public string status;
    public string effectiveTimeLow;
    public string effectiveTimeHigh;
    public string effectiveTimePeriodValue;
    public string effectiveTimePeriodUnit;
    public string routeCodeCode;
    public string routeCodeDisplayName;
    public string doseQuantityValue;
    public string doseQuantityUnit;
    public string instructions;
    public string rateQuantityValue;
    public string rateQuantityUnit;
    public string administrationUnitCode;
    public string administrationUnitDisplayName;
    public ManufacturedMaterial manufacturedMaterialObj;
    public string manufacturerOrganization;
    public string participantPlayingEntityCode;
    public string participantPlayingEntityDisplayName;
    public string findingCode;
    public string findingDisplayName;
    public string findingStatus;
    public string findingEffectiveTimeLow;
    public string findingEffectiveTimeHigh;
    public List<MedicationSupply> medicationSupplyObjLst;
    public string preconditionValueCode;
    public string preconditionValueDisplayName;
    public Author author;

    public Medication() => this.medicationSupplyObjLst = new List<MedicationSupply>();
  }
}
