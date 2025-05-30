
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
        private CaptureDocumentService service;

        public Validator() { }

        //METHOD 1
        private decimal SetDecimal(object value)
        {
            if(value == null){return -1;}
            decimal result;
            if (decimal.TryParse(value.ToString(), NumberStyles.Any, new CultureInfo("it-IT"), out result))
                return result;
            return -1;
        }

        //METHOD 2
        private string SetString(decimal value)
        {
            return value.ToString("N2", new CultureInfo("it-IT"));
        }

        //METHOD 3
        private void LogMessage(string message)
        {
            string logFilePath = "E:\\Customers\\Fasdac\\LOG_MODULI.txt";
            using (StreamWriter sw = new StreamWriter(logFilePath, true))
            {
                sw.WriteLine(message);
            }
        }

        //METHOD 3.1
        private void LogObjectProperties(string objectName, object obj)
        {
            if (obj == null)
            {
                LogMessage(objectName+" è NULL");
                return;
            }
        
            LogMessage("\n\n=== PROPRIETÀ DI "+objectName.ToUpper()+" ===");
            
            var properties = obj.GetType().GetProperties();
            foreach (var prop in properties)
            {
                try
                {
                    if(Convert.ToBoolean(prop.GetValue(obj)))
                    {
                        LogMessage(prop.Name+": "+prop.GetValue(obj));
                    }
                    else{LogMessage(prop.Name+": null");}
                }
                catch (Exception ex)
                {
                    LogMessage(prop.Name+": [ERRORE] "+ex.Message);
                }
            }
        }

        public void SetValue(string campo, string value, int row, int col)
        {
            service.UpdateDocumentFieldValue(
                session,
                null,
                IdMasterDocument,
                new RuntimeField
                {
                    Name = campo,
                    Id = campo,
                    TableRow = row,
                    TableColumn = col,
                    Value = value
                }
            );
        }

        [StartMethod]
        public void Main(ScriptParameters sp)
        {
            session = (string)sp.InputVariables["SPP_SYSTEM_SESSION_ID"];
            IdDocument = (string)sp.InputVariables["DOCID"];
        }
    }
}
