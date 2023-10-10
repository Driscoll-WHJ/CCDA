// Decompiled with JetBrains decompiler
// Type: CCDA.Immunization
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class Immunization
  {
    public string id;
    public string status;
    public string effectiveTimeLow;
    public string routeCodeCode;
    public string routeCodeDisplayName;
    public string doseQuantityValue;
    public string doseQuantityUnit;
    public ManufacturedMaterial manufacturedMaterialObj;
    public string manufacturerOrganization;
    public string lotnumber;
    public string negationInd;
    public string rejectionReason;
    public string rejectionReasonCode;

    public Immunization() => this.manufacturedMaterialObj = new ManufacturedMaterial();
  }
}
