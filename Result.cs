// Decompiled with JetBrains decompiler
// Type: CCDA.Result
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;
using System.Collections.Generic;

namespace CCDA
{
  [Serializable]
  public class Result
  {
    public string id;
    public string codeCode;
    public string codeDisplayName;
    public string status;
    public string effectiveTime;
    public List<ResultObs> resultObs;

    public Result() => this.resultObs = new List<ResultObs>();
  }
}
