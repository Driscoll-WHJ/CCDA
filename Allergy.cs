// Decompiled with JetBrains decompiler
// Type: CCDA.Allergy
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class Allergy
  {
    public string id;
    public string effectiveTimeLow;
    public string effectiveTimeHigh;
    public string participantCode;
    public string codeSystem;
    public string participantDisplayName;
    public string status;
    public string reactionValueCode;
    public string reactionValueDisplayName;
    public string severityCode;
    public string severityDisplayName;
    public string negationInd;
    public Author author;
  }
}
