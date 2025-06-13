import argparse

import xml.etree.ElementTree as ET
from urllib.parse import urljoin
import requests, os, sys
import glob
from utils import clear_screen, ParserHTML, reload_sitemap, load_config, search_movies


def readAllFile(folder):
    output = []
    os.makedirs(folder, exist_ok=True)
    for file in glob.glob(f"{folder}/*"):
        temp_obj = {
            "name": os.path.basename(file).split(".")[0]
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
    print("Pulizia Effettuata")
    print()

if args.reload:
    for provider in CONFIG:
        reload_sitemap(provider["name"], provider["config"])

if args.search_film:
    title = input("Che film vuoi vedere? ").strip()
    for file in DB:
        try: root = ET.fromstring(file["content"])
        except ET.ParseError as e:
            print(f"Error parsing data.xml: {e}")
            sys.exit(1)

        namespace = {'ns': 'http://www.sitemaps.org/schemas/sitemap/0.9'}
        
        if not search_movies(root, namespace, title, file["name"]):
            print("Film non disponibile")
        print()
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


