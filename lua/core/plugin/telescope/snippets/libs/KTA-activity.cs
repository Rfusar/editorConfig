//. Classi aggiuntive

//. Logger
//TODO da migliorare Properties
//.     - void Log(string msg) -> scrivi delle stringhe in un file
//.     - void Properties(string idetifier, string msg) -> scrivi delle stringhe in un file


//. Parser
//.    - JSON___Str_Str(Dictonary(<string>, <string>))
//.    - JSON___arrayStr(List<string>)

using System;
using System.Globalization;
using System.Data;
using Agility.Server.Scripting.ScriptAssembly;
using System.IO;
using System.Collections.Generic;

namespace MyValidator
{

    //*In caso servissero degli oggetti
    public class Check
    {
    }

    //*In caso servisse gestire un errore in un Validation Handler
    public class ReturnValues
    {
        public string Fieldname;
        public string ErrorDescription;
    }

    public class Validator
    {
        private static Check c;
        private static Logger l; //Non serve in produzione
        private static ReturnValues rv;

        [StartMethod]
        public void Main(ScriptParameters sp)
        {
            c = new Check();
            l = new Logger("E:\\Temp\\EXAMPLE_FILE_LOG_SNIPPETS.txt");  //Non serve in produzione
        }



        //*Validation
        public static ReturnValues Validation(string json)
        {
        }

    }


    //*Converter
    public class Parser
    {
        public string[] JSON___Str_Str(string json) 
        //  {
        //    "...": "...",
        //    ...
        //  } 
        {
            var lista = new List<string>();
            bool inQuotes = false;
            var current = "";
            json = json.Trim().TrimStart('{').TrimEnd('}');
            for (int i = 0; i < json.Length; i++)
            {
                char c = json[i];
                if (c == '\"') {inQuotes = !inQuotes;}
                if (c == ',' && !inQuotes)
                {
                    lista.Add(current.ToString().Trim());
                    current = "";
                }
                else{ current = current + c;}
            }
            if (current.Length > 0){lista.Add(current.ToString().Trim());}
            var result = new List<string>();
            foreach (var pair in lista)
            {
                var parts = pair.Split(new[] { ':' }, 2);
                if (parts.Length == 2)
                {
                    string key = parts[0].Trim().Trim('\"');
                    string value = parts[1].Trim().Trim('\"');
                    result.Add(key+" "+value);
                }
            }
            return result.ToArray();
        }

        public static string[] JSON___arrayStr(dynamic json)
        //  [
        //      [..., ...],
        //      ...
        //  ]
        {
            List<string> rows = new List<string>();;
            string result = "";
            foreach(var row in json)
            {
                foreach(var r in row)
                {
                    result += r+",";
                }
                string[] fields = result.Split(',');
                string fieldname = fields[fields.Length-3];
                string fieldvalue = fields[7];
                rows.Add(result);
                result = "";
            }
            return rows.ToArray()
        }
    }

    //*Debug
    //non serve in produzione
    public class Logger
    {
        private static string path;
        
        public Logger (string path_filelog)
        {
            path = path_filelog;
        }

        public void Log(string message)
        {
            using (StreamWriter sw = new StreamWriter(path, true))
            {
                sw.WriteLine(message);
            }
        }

        public void Properties(string objectName, object obj)
        {
            if (obj == null)
            {
                Log(objectName+" è NULL");
                return;
            }
        
            Log("\n\n=== PROPRIETÀ DI "+objectName.ToUpper()+" ===");
            
            var properties = obj.GetType().GetProperties();
            foreach (var prop in properties)
            {
                try
                {
                    if(Convert.ToBoolean(prop.GetValue(obj)))
                    {
                        Log(prop.Name+": "+prop.GetValue(obj));
                    }
                    else{Log(prop.Name+": null");}
                }
                catch (Exception ex)
                {
                    Log(prop.Name+": [ERRORE] "+ex.Message);
                }
            }
        }
    }
}
