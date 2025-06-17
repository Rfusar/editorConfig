import os, glob, sys, json
from .email import MyEmail
from datetime import datetime as dt

SEP = " = "
CC = "#"     #char comment

def Logging(log:bool, prefix:str, FOLDER_CACHE:str, description:str):
    if log:
        filename = dt.now().strftime(f"%Y%m%d__%H%M%S")+"___"+prefix
        os.makedirs(FOLDER_CACHE, exist_ok=True)
        with open(os.path.join(FOLDER_CACHE, filename), "a+") as f:
            f.write(
                    "[200]" if prefix=="INFO" else "[500]" if prefix=="ERR" else "[???]"+
                    " "+description+"\n")


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


def Download(CONFIG:dict, save:bool, FOLDER_CACHE:str, log:bool):
    """
        Config it serve for your configuration profile
    """
    Logging(log, "INFO", FOLDER_CACHE, "Inizio Scaricare l'email")
    records = []
    for provider in CONFIG:
        p = provider["config"]
        label, server, user, pw = [p["provider"],p["server"],p["user"],p["pw"]]

        Logging(log, "INFO", FOLDER_CACHE, f"{label} - inizio collegamento")
        p = MyEmail(server, user, pw)
        esito, email = p.download(label, save=FOLDER_CACHE if save else "")
        
        Logging(
            log,
            "INFO" if esito else "ERR", 
            FOLDER_CACHE, 
            f"{label} - fine collegamento" if esito else email
        )
        
        if esito: records = email
        else:
            for file in os.scandir(FOLDER_CACHE):
                if file.is_dir():
                    for email in os.scandir(file.path):
                        records.append(MyEmail.Parser(email.path))

    with open(os.path.join(FOLDER_CACHE, "database.json"), "w", encoding="utf-8") as f:
        f.write(json.dumps(records))
    Logging(log,"INFO", FOLDER_CACHE, f"Database inizializzato" if esito else email)
