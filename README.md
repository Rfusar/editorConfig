# My Editor Config (NVIM)

## Shortcut

### NVIM

> For updating the system


| Comando                | Descrizione                      |
| ---------------------- | --------------------------       |
| Leader + pu            | PackerUpdate                     |
| Leader + Leader + ps   | PackerSync                       |
| Leader + so            | Execute current file.lua         |
| Leader + fh            | nvim's menu help                 |

    
### 1. System

| Comando                | Descrizione                      |
| ---------------------- | --------------------------       |
| Ctrl + s               | Save current file                |
| Ctrl + b               | Open/close treeExplorer          |
| Leader + sa            | Save all files                   |
| Leader + c             | Copy on system clipboard         |
| Leader + cr            | Clean registries                 |
| Leader + crs           | Clear Search                     |
| Leader + help          | Open this file                   |

##### 1. Custom Menus

```c 
SNIPPETS_CONST:         "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/snippets/libs"
SNIPPETS_CONFIG:        "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/snippets/menu.lua"

CUSTOM_MENU_CONFIG:     "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/init.lua"

DOCS_CONST:             "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/docs/const.lua"
DOCS_CONFIG:            "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/docs/menu.lua"

SET_FUNC_REG_CONST:     "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/scripts/lib"
SET_FUNC_REG_CONFIG:    "C:/Users/User/AppData/Local/nvim/lua/core/plugin/telescope/scripts/menu.lua"

TASKS_EDIT:             "C:/Users/Utente/AppData/Local/nvim/lua/core/ricordi/ricordi.md"
```

| Comando                | Descrizione                            |
| ---------------------- | -------------------------------------- |
| Leader + sni           | Menu Template                          |
| Leader + p             | Menu Shortcut                          |
| ctrl + p               | Menu Projects                          |
| Leader + doc           | Menu Docs                              |
| F2                     | Fast links (multiselect with tab)      |
| Leader + Leader + t    | Display tasks                          |
| Leader + Leader + a    | Display notes                          |
| Leader + qs            | [Set a funcs on registry](lua/core/plugin/telescope/scripts/README.md)          | 
| Leader + qe            | excecute a funcs of registry           | 

##### 2. Custom funcs
```lua
-- The separetor is the comma plus a space like this ", "
:PushGithub master, origin, your comment

-- Create a NextJS Project with your custom components and other
:CreateNextJS

-- create a fast tags xml
:TagsXml
```

### 2. Layout

#### 2.1  Current tab size management
> In case you have multiple files open at the same time, it allows you to resize the tab

| Comando    | Descrizione    |
| ---------- | -------------- |
| Alt + ,    | To the left    |
| Alt + .    | To the right   |
| Alt + u    | To the up      |
| Alt + d    | To the down    |

#### 2.2 Row numbering tab
> To set the numbers to the edge of the tab

| Comando    | Descrizione    |
| ---------- | -------------- |
| Leader + 123           | Row absolue                      |
| Leader + 101           | Row relative                     |

### 3. Previewer file

> For now yes I can read md files, with the relative command, start a server where the service to interpret markdown files is exposed
similar also for CSV files

| Comando      | Descrizione                            |
| ------------ | -------------------------------------- |
| Leader + csv | Read files CVS                         |
| Leader + mds | Enable server mode to read the file MD |
| Leader + mdq | Disable server mode to read the file MD |

### 3. Debugger (Normal Mode)

| Comando               | Descrizione                 |
| --------------------- | --------------------------- |
| Leader + Leader + b   | Set debug python(system)    |
| Leader + Leader + bv  | Set debug python(venv)      |
| Leader + b            | Set BreakPoint              |
| Leader + du           | View/close debugger-ui      |
| Leader + db           | Show panel Brakpoints       |
| Leader + dv           | Show panel Variables        |
| Leader + ds           | Show panel Scopes           |
| Leader + dt           | Terminate Debugger Session  |
| F5                    | Start Debugger Session      |
| F10                   | Next Move                   |
| F11                   | Next Step                   |
| F12                   | ???                         |

### 4. Helpers

| Comando                | Descrizione                  |
| ---------------------- | -----------------------------|
| Leader + Leader + lo   | LSP-Servers Off              |
| Leader + Leader + lp   | LSP-Server Python            |
| Leader + Leader + lj   | LSP-Server Js/Ts             |
| Alt + d                | Docs func (if lsp is active) |


### New Features

- [ ] Plug-in for integrating the [AI API](lua\core\API_AI\README.md) 



### Extra


per scaricare le dipendenze necessarie fare `:lua setup_environment()`

font che permettono di visualiizare web-icon [font Hack](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Medium/FiraMonoNerdFontMono-Medium.otf)

lettura della documentzione di vim/nvim [VIM docs](https://youtu.be/rT-fbLFOCy0?si=R5yYmHxDoNBdzHOa)
    
    refresh cache -> sudo fc-cahce -f -v

per avere degli info quando si scrive codice, bisogna avere `node` e i seguinti pachetti disponibili globalmente.
Nel caso si volesse avere javascript/typescript e python disponibili
    
    javascript/typescript -> npm install typescript-language-server
    python -> npm install pyright-langserver 

per utilizzare il lettore CSV [repository](https://github.com/YS-L/csvlens)
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
