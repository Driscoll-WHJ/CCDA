﻿// Decompiled with JetBrains decompiler
// Type: CCDA.Performer
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class Performer
  {
    public string id;
    public string functionCodeCode;
    public string functionCodeDisplayName;
    public string timeLow;
    public string timeHigh;
    public AssignedEntity assignedEntityObj;

    public Performer() => this.assignedEntityObj = new AssignedEntity();
  }
}
