// Decompiled with JetBrains decompiler
// Type: CCDA.ClinicalNoteType
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System;

namespace CCDA
{
  [Serializable]
  public enum ClinicalNoteType
  {
    ProcedureNote = 1,
    ConsultationNote = 2,
    ProgressNote = 3,
    LaboratoryNarrativeNote = 4,
    HistoryAndPhysicalNarrativeNote = 5,
    DiagnosticImagingNarrativeNote = 6,
  }
}
