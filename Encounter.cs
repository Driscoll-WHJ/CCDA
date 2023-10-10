// Decompiled with JetBrains decompiler
// Type: CCDA.Encounter
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;

namespace CCDA
{
  [Serializable]
  public class Encounter
  {
    public string id;
    public string text;
    public string effectiveTimeLow;
    public string effectiveTimeHigh;
    public string diagnosisName;
    public string diagnosisCode;
    public string codeSystem;
    public string cptCodes;
    public string encounterlocation;
    public string visitID;
    public Address encounteraddress;
    public Author author;
    public List<AssignedPerson> careTeamObj;

    public Encounter()
    {
      this.careTeamObj = new List<AssignedPerson>();
      this.encounteraddress = new Address();
    }
  }
}
