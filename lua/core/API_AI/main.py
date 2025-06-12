import sys, os
from tool import Manager

try:
    nvim_home  = sys.argv[1]
    action = sys.argv[2]
    #action = "https://router.huggingface.co/novita/v3/openai/chat/completions"
    #nvim_home = "C:\\Users\\Utente\\AppData\\Local\\nvim"
    with open(os.path.join(nvim_home,"log.log"), "w") as f:
        f.write(f"{action=} {nvim_home=}")
    
    mgr = Manager(nvim_home)
    mgr.SetCall(action)

except Exception as err:
    with open("nvim_tool_AI_error.log", "w") as f:
        f.write(str(err))
    
