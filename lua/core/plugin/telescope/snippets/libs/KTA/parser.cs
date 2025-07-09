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
}
