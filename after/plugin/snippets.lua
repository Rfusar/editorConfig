vim.opt.readonly = false
local key = vim.keymap.set


-- Definizione delle variabili html e goWeb
local html = [=[
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My Website</title>
    <link rel="stylesheet" href="./style.css">
    <link rel="icon" href="./favicon.ico" type="image/x-icon">
  </head>
  <body>
    <main>
        <h1>Welcome to My Website</h1>  
    </main>
    <script src="index.js"></script>
  </body>
</html>
]=]

local goWeb = [=[
import (
    "net/http"
)

var (
    percorso = "./path/to/dir"

    percorsi = map[string]string{

        "/route": percorso+"/file.html",

    }
)

func main(){
    fs := http.FileServer(http.Dir("static"))
    http.Handle("/static/", http.StripPrefix("/static/", fs))

     for path, filePath := range percorsi {
          path := path; filePath := filePath 
          http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
             pag___methodGET(path, w, r)
             http.ServeFile(w, r, filePath)
        })
    }

                http.ListenAndServe("127.0.0.1:8080", nil)
}
]=]

-- Funzione per salvare la variabile nella clipboard
local function saveToClipboard(content)
    vim.fn.setreg('+', content)
end

-- Definizione delle mappature di tasti per la modalità visuale
key('n', '<leader>html', function() saveToClipboard(html) end, {noremap = true, silent = true})
key('n', '<leader>gw', function() saveToClipboard(goWeb) end, {noremap = true, silent = true})





