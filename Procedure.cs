// Decompiled with JetBrains decompiler
// Type: CCDA.Procedure
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class Procedure
  {
    public string id;
    public string codeCode;
    public string codeDisplayName;
    public string codeSystem;
    public string status;
    public string effectiveTimeLow;
    public string effectiveTimeHigh;
    public string targetSiteCodeCode;
    public string targetSiteCodeDisplayName;
    public string performer;
    public Address performerAddress;
    public string deviceCode;
    public string deviceName;
    public string deviceId;

    public Procedure() => this.performerAddress = new Address();
  }
}
