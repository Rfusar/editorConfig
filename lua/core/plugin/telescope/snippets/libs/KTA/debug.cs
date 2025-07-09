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
