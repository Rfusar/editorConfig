# My Editor Config (NVIM)

## Shortcut

### 0. NVIM

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
| Leader + cfg           | Open nvim project                |
| Ctrl + s               | Save current file                |
| Ctrl + b               | Open/close treeExplorer          |
| Ctrl + f               | change colorschema               |
| Leader + g             | Menu Git                         |
| Leader + sa            | Save all files                   |
| Leader + c             | Copy on system clipboard         |
| Leader + cr            | Clean registries                 |
| Leader + crs           | Clear Search                     |
| Leader + f             | Menu Search                      |
| Leader + help          | Open this file                   |


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
| Leader + 010           | Row relative                     |



### 3. Previewer file

> For now yes I can read md files, with the relative command, start a server where the service to interpret markdown files is exposed
similar also for CSV files

| Comando      | Descrizione                            |
| ------------ | -------------------------------------- |
| Leader + csv | Read files CVS                         |
| Leader + mds | Enable server mode to read the file MD |
| Leader + mdq | Disable server mode to read the file MD |

| Comando                | Descrizione                      |
| ---------------------- | --------------------------       |
| Leader + qs            | Set a funcs on registry          | 
| Leader + qe            | excecute a funcs of registry     | 
| Leader + Leader + t    | Display tasks                    |
| Leader + Leader + m    | Move in a Folder not saved       |


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

| Comando                | Descrizione                |
| ---------------------- | -------------------------- |
| Leader + Leader + lo   | LSP-Servers Off            |
| Leader + Leader + lp   | LSP-Server Python          |
| Leader + Leader + lj   | LSP-Server Js/Ts           |
| Alt + d                | Docs func (if exists)      |

## CustomTools

### 1. Snippets (Template)

> With this tool, going to the file C:\Users\User\AppData\Local\nvim\lua\core\snippets\gui.lua you can customize the paths of the snippets
and in the folder "libs" present in the folder "snippets" you can update your things, in the main clipboard.

| Comando                | Descrizione                  |
| ---------------------- | ---------------------------- |
| Leader + sni           | Menu Template                |

### 1. Change Project

> With this tool, going to the file C:\Users\User\AppData\Local\nvim\lua\core\snippets\gui.lua you can customize the paths of the snippets
and in the folder "libs" present in the folder "snippets" you can update your things, in the main clipboard.

| Comando                | Descrizione                  |
| ---------------------- | ---------------------------- |
| Leader + ps            | Menu Project                 |


### Extra

per scaricare le dipendenze necessarie fare `:lua setup_environment()`

font che permettono di visualiizare web-icon [font Hack](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Medium/FiraMonoNerdFontMono-Medium.otf)

lettura della documentzione di vim/nvim [VIM docs](https://youtu.be/rT-fbLFOCy0?si=R5yYmHxDoNBdzHOa)
    
    refresh cache -> sudo fc-cahce -f -v

per avere degli info quando si scrive codice, bisogna avere `node` e i seguinti pachetti disponibili globalmente.
Nel caso si volesse avere javascript/typescript e python disponibili
    
    javascript/typescript -> npm install typescript-language-server
    python -> npm install pyright-langserver 

per il debugger
    `pip install debugpy`
