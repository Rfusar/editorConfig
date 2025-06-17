import sys, os
from tool import Manager

try:
    nvim_home  = sys.argv[1]
    action = sys.argv[2]
    #action = "https://router.huggingface.co/novita/v3/openai/chat/completions"
    #nvim_home = "C:\\Users\\Utente\\AppData\\Local\\nvim"
    #nvim_home = "/home/riccardo/.config/nvim"
    HOME_PATH = os.path.join(nvim_home, "lua", "core", "plugin", "API_AI")
    
    mgr = Manager(nvim_home, HOME_PATH)
    mgr.SetCall(action)

except Exception as err:
    with open("nvim_tool_AI_error.log", "w") as f:
        f.write(str(err))
    
