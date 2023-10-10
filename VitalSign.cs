// Decompiled with JetBrains decompiler
// Type: CCDA.VitalSign
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;

namespace CCDA
{
  [Serializable]
  public class VitalSign
  {
    public string effectiveTimeLow;
    public string effectiveTimeHigh;
    public string status;
    public List<VitalSignObs> Observation;

    public VitalSign() => this.Observation = new List<VitalSignObs>();
  }
}
