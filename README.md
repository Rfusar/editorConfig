# My Editor Config (NVIM)

## 1. Shortcut

| Comando                | Descrizione                |
| ---------------------- | -------------------------- |
| Leader + sa            | Save all files             |
| Leader + 123           | Row absolue                |
| Leader + 010           | Row relative               |
| Leader + f             | Menu Search                |
| Leader + g             | Menu Git                   |
| Leader + c             | Copy on system clipboard   |
| Leader + cr            | Clean registries           |
| Leader + crs           | Clear Search               |
| Leader + pu            | PackerUpdate               |
| Leader + ps            | PackerSync                 |
| Leader + so            | Execute current file.lua   |
| Leader + tag           | Set tag html               |
| Leader + cfg           | Open nvim project          |
| Leader + help          | Open this file             |
| Leader + Leader + p    | Menu projects              |
| Leader + Leader + t    | Display task               |
| Leader + Leader + c    | Set char comment           |
| Ctrl + s               | Save current file          |
| Ctrl + b               | Open/close treeExplorer    |
| Ctrl + p               | Menu Macros                |

    details:
        with <leader><leader>c ->
            you use the register 'e', meaning `@e`,
            in visual block mode

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


### Extra

font che permettono di visualiizare web-icon [font Hack](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Medium/FiraMonoNerdFontMono-Medium.otf)

lettura della documentzione di vim/nvim [VIM docs](https://youtu.be/rT-fbLFOCy0?si=R5yYmHxDoNBdzHOa)
    
    refresh cache -> sudo fc-cahce -f -v

per avere degli info quando si scrive codice, bisogna avere `node` e i seguinti pachetti disponibili globalmente.
Nel caso si volesse avere javascript/typescript e python disponibili
    
    javascript/typescript -> npm install typescript-language-server
    python -> npm install pyright-langserver 
