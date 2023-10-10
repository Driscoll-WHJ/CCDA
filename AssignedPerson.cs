// Decompiled with JetBrains decompiler
// Type: CCDA.AssignedPerson
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public class AssignedPerson
  {
    public string prefix;
    public string suffix;
    public string givenName;
    public string familyName;
    public string streetAddressLine;
    public string city;
    public string state;
    public string postalCode;
    public string phone;
    public string providerid;
    public string country;

    public string visitDate { get; set; }
  }
}
