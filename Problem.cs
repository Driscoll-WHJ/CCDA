// Decompiled with JetBrains decompiler
// Type: CCDA.Problem
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class Problem
  {
    public string id;
    public string topLevelEffectiveTimeLow;
    public string topLevelEffectiveTimeHigh;
    public string status;
    public string problemTypeSnomedCode;
    public string problemTypeTranslationLOINCCode;
    public string problemTypeDescription;
    public string problemNameCode;
    public string codeSystem;
    public string problemNameDisplayName;
    public Author author;
    public string negationInd;
  }
}
