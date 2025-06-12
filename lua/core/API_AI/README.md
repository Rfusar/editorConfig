# HOW TO USE PLUG-IN AI (NOT AVAILABLE)

I decied to use the [Hunggingface API](https://huggingface.co/) for this tool
because exists a free plan for the AI models

| MODELS | USED FOR                                      | 
| -------|---------------------------------------------- |
|        | Translator of Natual Languages (ITA-ENG-....) |


## Logic

for simplify the process I used [Python](https://www.python.org/) for call the API.

**what does it to do?**

#### 1. It reads the *body.json* file like:
```json
{
    "messages": [
        {
            "role": "user",
            "content": "genera 10 token di testo"
        }
    ],
    "model": "deepseek/deepseek-v3-0324",
    "stream": false
}
```

#### 2. It calls the API and save the *Response* in the *esito.json* file
> an example deepeek's response

```json
{
    "id": "021749322661802411cd377557adf775541642e5855eb35a663aa",
    "object": "chat.completion",
    "created": 1749322663,
    "model": "deepseek/deepseek-v3-0324",
    "choices": [
        {
            "index": 0,
            "message": {
                "role": "assistant",
                "content": "Ecco una risposta breve che utilizza circa 10 token:  \n\n\"Certamente! Cosa vuoi sapere?\"  \n\n(10 token)"
            },
            "finish_reason": "stop",
            "content_filter_results": {
                "hate": {
                    "filtered": false
                },
                "self_harm": {
                    "filtered": false
                },
                "sexual": {
                    "filtered": false
                },
                "violence": {
                    "filtered": false
                },
                "jailbreak": {
                    "filtered": false,
                    "detected": false
                },
                "profanity": {
                    "filtered": false,
                    "detected": false
                }
            }
        }
    ],
    "usage": {
        "prompt_tokens": 14,
        "completion_tokens": 31,
        "total_tokens": 45,
        "prompt_tokens_details": {
            "audio_tokens": 0,
            "cached_tokens": 0
        },
        "completion_tokens_details": {
            "audio_tokens": 0,
            "reasoning_tokens": 0
        }
    },
    "system_fingerprint": ""
}
```

#### 3. It saves in a *result.txt* file the utilis content present in the Response

```txt

EXPENSE
prompt = 14
completation = 31
total = 45
prompt_audio = 0
prompt_cache = 0
completation_audio = 0
completation_reasoning = 0

CONTENT
Ecco una risposta breve che utilizza circa 10 token:  

"Certamente! Cosa vuoi sapere?"  

(10 token)
```

Finally the script ***init.lua*** display the result.
