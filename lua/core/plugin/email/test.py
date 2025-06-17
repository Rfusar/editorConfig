import json
from datetime import datetime

with open("cache/database.json") as f:
    config = json.loads(f.read())

config_sorted = sorted(config, key=lambda k: datetime.strptime(
    k["headers"]["Date"], "%a, %d %b %Y %H:%M:%S %z"
).timestamp(), reverse=True) 


with open("results.txt", "w", encoding="utf-8") as f:
    for k in config_sorted:
        f.write("\n"+k["headers"]["Date"]+"\n")
        f.write(k["headers"]["To"]+"\n")
        f.write(k["headers"]["From"]+"\n")
        f.write(k["headers"]["Subject"]+"\n")
