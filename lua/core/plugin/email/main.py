import os
from argparse import ArgumentParser
from parser.action import load_config, readAllFile, Download, Logging


#* Commands
cmd = ArgumentParser(prog="email tool")

cmd.add_argument("-r", "--download", action="store_true",
help="It saves a small record of the email in to database.json"
)
cmd.add_argument("-l", "--log", action="store_true",
help="It saves the log of the process"
)
cmd.add_argument("-cc", "--clear-cache", action="store_true",
help="it Deletes all file in cache"
)
cmd.add_argument("-se", "--store-eml", action="store_true", 
help="it saves also the files eml in cache"
)
cmd.add_argument("-nh", "--nvim-home",
help="It serves for integration with NVIM", required=True
)


args = cmd.parse_args()
    
try:
    #* Start Config
    CONFIG = load_config(readAllFile(os.path.join(args.nvim_home,"providers","email")))
    HOME_PATH = os.path.join(args.nvim_home, "lua", "core","plugin", "email")
    FOLDER_CACHE = os.path.join(HOME_PATH, "cache")
    os.makedirs(FOLDER_CACHE, exist_ok=True)

    #* MAIN
    if args.clear_cache: 
        os.removedirs(FOLDER_CACHE)
        Logging(args.log, "INFO", FOLDER_CACHE, "Ho pulito la cache")
    if args.download: 
        Download(CONFIG, args.store_eml, FOLDER_CACHE, args.log)

except Exception as err:
    with open("NVIM_Plugin_email____error.log", "w") as f: f.write(str(err))
        
