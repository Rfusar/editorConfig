import os, glob, sys, json
from argparse import ArgumentParser
from parser.email import MyEmail

SEP = " = "
CC = "#"     #char comment

cmd = ArgumentParser(prog="email tool")
cmd.add_argument("-r", "--reload", action="store_true")
cmd.add_argument("-cc", "--clear-cache", action="store_true")
cmd.add_argument("-nh", "--nvim-home")


def load_config(providers):
    for p in providers:
        p["config"] = {}
        for line in p["content"].split("\n"):
            p["name"] = p["name"].split(".")[0]
            line = line.strip()
            if line and not line.startswith(CC):
                try:
                    k, v = map(str.strip, line.split(SEP, 1))
                    p["config"][k] = v
                except ValueError: continue
    return providers

def readAllFile(folder):
    output = []
    os.makedirs(folder, exist_ok=True)
    for file in glob.glob(f"{folder}/*"):
        temp_obj = {
            "name": os.path.basename(file)
        }  
        with open(file) as f:
            temp_obj["content"] = f.read()
        output.append(temp_obj)
    return output

args = cmd.parse_args()
    
try:
    CONFIG = load_config(readAllFile(os.path.join(args.nvim_home,"providers","email")))
    HOME_PATH = os.path.join(args.nvim_home, "lua", "core","plugin", "email")
    FOLDER_CACHE = os.path.join(HOME_PATH, "cache")
    os.makedirs(FOLDER_CACHE, exist_ok=True)
    
    if args.clear_cache: os.remove(FOLDER_CACHE)
    
    if args.reload:
        for provider in CONFIG:
            with open(os.path.join(FOLDER_CACHE, "database.json"), "w", encoding="utf-8") as f: f.write("")
        
            p = MyEmail(provider["config"]["server"], provider["config"]["user"], provider["config"]["pw"])
            esito, email = p.download(provider["config"]["provider"], save=FOLDER_CACHE)
            if esito:
                for file in os.scandir(FOLDER_CACHE):
                    if file.is_dir():
                        for email in os.scandir(file.path):
                            jemail = json.dumps(MyEmail.Parser(email))
                            with open(os.path.join(FOLDER_CACHE, "database.json"), "a+", encoding="utf-8") as f:
                                f.write(jemail)
        sys.exit(0)
                
except Exception as err:
    with open("error.log", "w") as f: f.write(str(err))
        
