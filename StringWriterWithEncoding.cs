// Decompiled with JetBrains decompiler
// Type: CCDA.StringWriterWithEncoding
// Assembly: CCDA, Version=3.0.0.4, Culture=neutral, PublicKeyToken=null
// MVID: CDBE229D-9197-45C5-A0B4-016F76F12405
// Assembly location: C:\Users\DCH8220\Downloads\CCDA.dll

using System.IO;
using System.Text;

namespace CCDA
{
  public class StringWriterWithEncoding : StringWriter
  {
    private Encoding myEncoding;

    public override Encoding Encoding => this.myEncoding;

    public StringWriterWithEncoding(Encoding encoding) => this.myEncoding = encoding;
  }
}
