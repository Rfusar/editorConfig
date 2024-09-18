# My Editor Config (NVIM)

## 1. Shortcut

| Comando                | Descrizione                |
| ---------------------- | -------------------------- |
| Ctrl + s               | Save current file          |
| Ctrl + b               | Open/close treeExplorer    |
| Ctrl + p               | Menu Macros                |
| Leader + sa            | Save all files             |
| Leader + 123           | Row absolue                |
| Leader + 010           | Row relative               |
| Leader + f             | Menu Search                |
| Leader + g             | Menu Git                   |
| Leader + c             | Copy on system clipboard   |
| Leader + cr            | Clean registries           |
| Leader + crs           | Clear Search               |
| Leader + pu            | PackerUpdate               |
| Leader + ps            | Save the cwd in clipboard  |
| Leader + so            | Execute current file.lua   |
| Leader + tag           | Set tag html               |
| Leader + cfg           | Open nvim project          |
| Leader + help          | Open this file             |
| Leader + Leader + p    | Menu projects              |
| Leader + Leader + ps   | PackerSync                 |
| Leader + Leader + t    | Display tasks              |
| Leader + Leader + c    | Set char comment           |
| Leader + Leader + m    | Move in a Folder not saved |


    details:
        with <leader><leader>c ->
            you use the register 'e', meaning `@e`,
            in visual block mode
    start:
        @q: Select a word in visual mode and add double quotes around it.
        @w: Select a text block in visual mode and add double quotes around the selection.
        @d: In block visual mode, select multiple rows and delete the first character of each row.
        @v: In block visual mode, select multiple rows and add a character at the beginning of each row.
    PS:
        Before using @v, you must populate the `v` register.

```lua
function CleanRegistries()
    local registers = { 
        '"', '0', '1', '2', '3', '4', '5', 
        '6', '7', '8', '9', 'a', 'b', 'c', 
        'd','f', 'g', 'h', 'i', 'j', 
        'k', 'l', 'm', 'n', 'o', 'p', 
        's', 'u', 'v', 'x', 
        'y', 'z', '*', '+'
    }
    -- ...
```


## 2. Layout

    - Gestione grandezza Finestra in caso lo schermo ha piu file da gestire

| Comando    | Descrizione    |
| ---------- | -------------- |
| Alt + ,    | To the left    |
| Alt + .    | To the right   |
| Alt + u    | To the up      |
| Alt + d    | To the down    |


## 3. Lettori

| Comando      | Descrizione                            |
| ------------ | -------------------------------------- |
| Leader + csv | Read files CVS                         |
| Leader + mds | Enable server mode to read the file MD |
| Leader + mdq | Disable server mode to read the file MD |


## 4. Snippets (Template)

| Comando                | Descrizione                  |
| ---------------------- | ---------------------------- |
| Leader + sni           | Menu Template                |


## 5. Debugger (Normal Mode)

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

## 6. Helpers

| Comando                | Descrizione                |
| ---------------------- | -------------------------- |
| Leader + Leader + lo   | LSP-Servers Off            |
| Leader + Leader + lp   | LSP-Server Python          |
| Leader + Leader + lj   | LSP-Server Js/Ts           |




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
