# My Editor Config (NVIM)

### Features

- [x]  [Some shortcut](lua/core/help.lua)
- [x]  Lsp Server Python, [here](lua/core/lsp_server/pyright.lua)
- [x]  Plug-in for integrating the [AI API](lua/core/API_AI/README.md) 
- [x]  Plug-in for searching a film [Custom API](lua/core/plugin/film/README.md) 
- [x]  Plug-in for Translate ITA to ENG, [Here](lua/core/plugin/translator/init.lua) 

### New Features

- [ ] SQL Viewer - maybe also with [integration with a potential SQLDB](https://github.com/kndndrj/nvim-dbee)
- [ ] Wrapper for debugger, [here](lua/core/debugger/init.lua)
- [ ] Plug-in for handling protocols SMTP/IMAP [tool email](lua/core/plugin/email/README.md) 

<details>
    <summary>Consts of a correct configuration (CUSTOM MENU)</summary>

    SNIPPETS_CONST:         "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/snippets/libs"
    SNIPPETS_CONFIG:        "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/snippets/menu.lua"
    
    CUSTOM_MENU_CONFIG:     "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/init.lua"
    
    DOCS_CONST:             "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/docs/const.lua"
    DOCS_CONFIG:            "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/docs/menu.lua"
    
    SET_FUNC_REG_CONST:     "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/scripts/lib"
    SET_FUNC_REG_CONFIG:    "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/scripts/menu.lua"
    
    TASKS_EDIT:             "C:/Users/Utente/AppData/Local/nvim/lua/core/ricordi/ricordi.md"

</details>

## Extra

per scaricare le dipendenze necessarie fare `:lua setup_environment()`

font che permettono di visualiizare web-icon [font Hack](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Medium/FiraMonoNerdFontMono-Medium.otf)

lettura della documentzione di vim/nvim [VIM docs](https://youtu.be/rT-fbLFOCy0?si=R5yYmHxDoNBdzHOa)
    
    refresh cache -> sudo fc-cahce -f -v

per avere degli info quando si scrive codice, bisogna avere `node` e i seguinti pachetti disponibili globalmente.
Nel caso si volesse avere javascript/typescript e python disponibili
    
    javascript/typescript -> npm install typescript-language-server
    python -> npm install pyright-langserver 

per utilizzare il lettore CSV [repository](https://github.com/YS-L/csvlens) </summary>
puo essere che vada in errore qualcosa, prova ad avviare nvim d'amministratore per vedere se si risolve
```lua
-- WINDOWS
winget install --id YS-L.csvlens
```    
per il debugger
    `pip install debugpy`

per utilizzare live_grep con telescope

```lua
-- WINDOWS
choco install ripgrep
```    
