//! Creare Pagina Help
//. Classi aggiuntive

//. Logger
//TODO da migliorare Properties
//.     - void Log(string msg) -> scrivi delle stringhe in un file
//.     - void Properties(string idetifier, string msg) -> scrivi delle stringhe in un file


//. Parser
//.    - JSON___Str_Str(Dictonary(<string>, <string>))
//.    - JSON___arrayStr(List<string>)
//! ...........................................................................................

using System;
using System.Globalization;
using System.Data;
using Agility.Server.Scripting.ScriptAssembly;
using System.IO;
using System.Collections.Generic;

namespace MyValidator
{
    //*In caso servisse gestire un errore in un Validation Handler
    public class ReturnValues
    {
        public string Fieldname;
        public string ErrorDescription;
    }

    public class Validator
    {

        [StartMethod]
        public void Main(ScriptParameters sp)
        {
            //
            // Scrivi Qui il tuo codice
            //
        }


        //*In caso servisse gestire Un Validator
        public static ReturnValues Validation(string json)
        {
        }

    }
}
