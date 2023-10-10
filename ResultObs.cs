// Decompiled with JetBrains decompiler
// Type: CCDA.ResultObs
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class ResultObs
  {
    public string id;
    public string code;
    public string displayName;
    public string status;
    public string effectiveTime;
    public string valueValue;
    public string valueUnit;
    public string leftrange;
    public string rightrange;
    public string valuetype;
    public Address LabAddressObj;
    public string interpretationCode;
    public string notes;

    public ResultObs() => this.LabAddressObj = new Address();
  }
}
