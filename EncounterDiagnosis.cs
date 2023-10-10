// Decompiled with JetBrains decompiler
// Type: CCDA.EncounterDiagnosis
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class EncounterDiagnosis
  {
    public string id;
    public string effectiveTime;
    public string valueCode;
    public string codeSystem;
    public string valueDisplayName;
    public string performer;
    public string status;
    public AssignedEntity performerAssignedEntityObj;

    public EncounterDiagnosis() => this.performerAssignedEntityObj = new AssignedEntity();
  }
}
