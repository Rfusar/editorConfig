import requests as r
import os, json, time

def File(path:str):
    with open(path) as f: return f.read()

def Path(folders:list[str]) -> str: return os.path.join(*folders)


class Manager():
    def  __init__(self, nvim_home, path_home_tool):

        self.home = path_home_tool
        self.apikey = File(Path([nvim_home, "providers", "AI", "huggingface.txt"])).split("=")[1].strip()
        self.prompt = json.loads(File(Path([self.home, "body.json"])))



    def SetCall(self, action) -> bool:
        start_time = time.perf_counter()

        res = r.post(
            url=action,
            headers={
                "Authorization": "Bearer " + self.apikey,
                "Content-Type": "application/json"
            },
            json=self.prompt
        )
        with open(Path([self.home, "esito.json"]), "wb") as f:
            f.write(res.content)

        inputs = json.loads(File(Path([self.home, "esito.json"])))
        content = inputs["choices"][0]["message"]["content"]
        expense = {
            "prompt": inputs["usage"]["prompt_tokens"],
            "completation": inputs["usage"]["completion_tokens"],
            "total": inputs["usage"]["total_tokens"],
            "prompt_audio": inputs["usage"]["prompt_tokens_details"]["audio_tokens"],
            "prompt_cache": inputs["usage"]["prompt_tokens_details"]["cached_tokens"],
            "completation_audio": inputs["usage"]["completion_tokens_details"]["audio_tokens"],
            "completation_reasoning": inputs["usage"]["completion_tokens_details"]["reasoning_tokens"],
        }
        end_time = time.perf_counter()
        elapsed_time = end_time - start_time

        CONTENT = "\n### TIME ###\n"
        CONTENT += f"esecuzione -> {elapsed_time:.2f} s\n"
        CONTENT += "\n### EXPENSE ###\n"
        for k, v in expense.items(): CONTENT += f"{k} = {v}\n"
        CONTENT += "\n### CONTENT ###\n" + content + "\n"

        with open(Path([self.home, "result_python.txt"]), "w", encoding="utf-8") as f:
            f.write(CONTENT)

        return True
