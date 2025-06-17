import argparse

import xml.etree.ElementTree as ET
from urllib.parse import urljoin
import requests, os, sys
import glob
from utils import (
    clear_screen, ParserHTML, reload_sitemap, load_config, search_movies,
    HandleXML, HandleJSON
)


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

CACHE = readAllFile("cache")
DB = readAllFile("DBs")

CONFIG = load_config(readAllFile(os.path.join("..","..","..","..","providers","film")))

cmd = argparse.ArgumentParser(
        prog="Search a film"
    )

cmd.add_argument("-r", "--reload", action="store_true")
cmd.add_argument("-sf", "--search-film", action="store_true")
cmd.add_argument("-cc", "--clear-cache", action="store_true")
cmd.add_argument("-g", "--genere", nargs="+")

args = cmd.parse_args()


clear_screen()

if args.clear_cache:
    for file in glob.glob("cache/*"): os.remove(file)
    for file in glob.glob("DBs/*"): os.remove(file)
    print("Pulizia Effettuata")
    print()

if args.reload:
    for provider in CONFIG:
        reload_sitemap(provider["name"].split(".")[0], provider["config"])

if args.search_film:
    title = input("Che film vuoi vedere? ").strip()
    clear_screen()
    for file in DB:
        if file["name"].split(".")[1] == "xml": HandleXML(file, title)
        elif file["name"].split(".")[1] == "json": HandleJSON(file, title)
    sys.exit(0)

if args.genere:
    with open("result_search.log", "w", encoding="utf-8") as f: f.write("")

    for g in args.genere:
        if g in ["horror", "fantascienza", "commedia"]:
            for provider in CONFIG:
                response = requests.get(urljoin(provider["config"]["provider"], provider["config"][g]), timeout=10)
                with open(f"cache/{provider['name']}_{g}.html", "wb") as f:
                    f.write(response.content)
                
                results = ParserHTML(response.text)
                with open("result_search.log", "a+", encoding="utf-8") as f:
                    for r in results: print(r); f.write(r+"\n")


