// Decompiled with JetBrains decompiler
// Type: CCDA.MedicationSupply
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class MedicationSupply
  {
    public string id;
    public string supplyStatus;
    public string supplyEffectiveTimeLow;
    public string supplyEffectiveTimeHigh;
    public string supplyQuantity;
    public string supplyRepeatNumber;
    public ManufacturedMaterial manufacturedMaterialObj;
    public string manufacturerOrganization;
    public AssignedEntity performerObj;
    public AssignedPerson authorAssignedPersonObj;

    public MedicationSupply()
    {
      this.manufacturedMaterialObj = new ManufacturedMaterial();
      this.performerObj = new AssignedEntity();
      this.authorAssignedPersonObj = new AssignedPerson();
    }
  }
}
