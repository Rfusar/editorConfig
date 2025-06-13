import xml.etree.ElementTree as ET
from urllib.parse import urljoin
import requests, subprocess, os, re, sys


SEP = " = "
CC = "#"     #char comment

def clear_screen():
    subprocess.run("cls" if os.name == "nt" else "clear", shell=True)

def ParserHTML(content):
    result = []
    special_chars = {'"', '<', '>'}

    for row in content.split("\n"):
        if  " " in row.strip() and all(char not in row for char in special_chars):
            if re.search(r"\((\d{4})\)", row.strip()):
                result.append(row.strip())
    return result    

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

def reload_sitemap(provider_name, provider_details):
    try:
        response = requests.get(urljoin(provider_details["provider"], "/sitemap.xml"), timeout=10)
        response.raise_for_status()
        with open(f"DBs/{provider_name}.xml", "wb") as f: f.write(response.content)
        print(f"[200] - Sitemap {provider_details['provider']} aggiornato con successo")
        print()

    except requests.RequestException as e:
        print(f"Errore reload_sitemap: {e}")
        sys.exit(1)

def search_movies(root, namespace, title, provider_name):
    found = False
    for url in root.findall("ns:url", namespace):
        link = url.find("ns:loc", namespace).text
        normalized_link = link.replace("-", " ").lower()
        if re.search(title.lower(), normalized_link):
            watching_link = link.replace(".html", "/watching.html")
            print(f"[ {provider_name.upper()} ] {watching_link}")
            found = True
    return found
