
using System;
using System.Globalization;
using System.Data;
using System.IO;
using Agility.Server.Scripting.ScriptAssembly;
//using Agility.Sdk.Model.Capture;
using TotalAgility.Sdk;

namespace MyValidator
{
    public class Validator
    {
        private string session;
        private string IdDocument;
        //private CaptureDocumentService service;

        public Validator() { }

        private decimal SetDecimal(object value)
        {
            if(value == null){return -1;}
            decimal result;
            if (decimal.TryParse(value.ToString(), NumberStyles.Any, new CultureInfo("it-IT"), out result))
                return result;
            return -1;
        }

        private string SetString(decimal value)
        {
            return value.ToString("N2", new CultureInfo("it-IT"));
        }

        [StartMethod]
        public void Main(ScriptParameters sp)
        {
            session = (string)sp.InputVariables["SPP_SYSTEM_SESSION_ID"];
            IdDocument = (string)sp.InputVariables["DOCID"];
        }
    }
}
