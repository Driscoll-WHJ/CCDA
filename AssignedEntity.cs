// Decompiled with JetBrains decompiler
// Type: CCDA.AssignedEntity
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class AssignedEntity
  {
    public string codeCode;
    public string codeDisplayName;
    public Address addrObj;
    public string telecom;
    public AssignedPerson assignedPersonObj;

    public AssignedEntity()
    {
      this.assignedPersonObj = new AssignedPerson();
      this.addrObj = new Address();
    }
  }
}
