local js = {
    ["KTA"] = {
        ["CaptureDocumentService"] = "https://docshield.tungstenautomation.com/KTA/en_US/7.6.0-d4fslp3xyr/help/API/latest/class_agility_1_1_sdk_1_1_services_1_1_capture_document_service.html"
    },
    ["KCM"] = {
        ["main_docs"] = "https://docshield.kofax.com/KCM/en_US/5.8.0-jx2hss7wd8/print/KofaxCommunicationsManagerTemplateScriptingLanguageDevelopersGuide_EN.pdf",
    },
    ["Programming Languages"] = {
        ["javascript"] = "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference",
        ["python"] = "https://docs.python.org/3/",
        ["C#"] = "https://learn.microsoft.com/en-us/dotnet/csharp/",
    },
    ["GUI"] = {
        ["tailwind"] = "https://tailwindcss.com/docs/installation/using-vite",
        ["nextjs"] = "https://nextjs.org/",
        ["react hooks"] = "https://react.dev/reference/react",
    },
    ["tools"] = {
        ["docker docs"] = "https://docs.docker.com/reference/cli/docker/",
    }, 
    ["AI"] = {
        ["chatGPT"] = "https://chatgpt.com/",
        ["deepseek"] = "https://chat.deepseek.com",
    },
    -- FUNCS
    ["Add New Doc Page"] = "",
}

local json_pretty = vim.fn.json_encode(js):gsub(",", ",\n"):gsub("{", "{\n"):gsub("}", "\n}")

vim.fn.writefile(vim.split(json_pretty, "\n"), "output.txt", "a")
