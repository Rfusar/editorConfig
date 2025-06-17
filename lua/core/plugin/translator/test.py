from argparse import ArgumentParser
import os,requests, re, json
import urllib.parse

cmd = ArgumentParser(
    prog="API Transalator",
    description="",
)

cmd.add_argument("-lin", "--lang-input", help="language input", default="it_IT")
cmd.add_argument("-lout", "--lang-output", help="language output", default="en_US")
cmd.add_argument("-nh", "--nvim-home", help="for integration with nvim", default="./")

args = cmd.parse_args()

try:
    with open(os.path.join(args.nvim_home,"_input.txt"), "r", encoding="utf-8") as f: file_input = f.read()
    
    headers = {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    }

    data = {
        "from": args.lang_input,
        "to": args.lang_output,
        "text": file_input,
        "platform": "dp"
    }

    encoded = urllib.parse.urlencode(data)
    res = requests.post("https://lingvanex.com/translation/translate", headers=headers, data=encoded)
    
    jres = json.loads(res.text)

    with open(os.path.join(args.nvim_home,"_input.txt"), "a+") as f:
        f.write("\n\n")
        f.write("### TRADUZIONE ###\n")
        f.write(jres["result"])

except Exception as err: 

    with open(os.path.join(args.nvim_home,"error.log"), "w") as f:
        f.write(f"Err: {err}")

