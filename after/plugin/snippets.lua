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

local goWeb_server = [=[
package main

import (
    "net/http"
    "fmt"
    "time"
)
var server = &http.Server{
    	Addr:           ":8080",
    	Handler:        MiddleWare(http.DefaultServeMux),
    	ReadTimeout:    10 * time.Second,
    	WriteTimeout:   10 * time.Second,
    	MaxHeaderBytes: 1 << 20,
    }

var html = "templates"
var static = "static"
type Percorso struct{
    route   string
    f       func(http.ResponseWriter, *http.Request)  
}

var percorsi = []Percorso{
    {route: "/",  
        f: func(w http.ResponseWriter, r *http.Request){
                    http.ServeFile(w, r, "templates/pagina.html")
            },
    },
}

func main(){
    fs := http.FileServer(http.Dir(static))
    http.Handle("/"+static+"/", http.StripPrefix("/"+static+"/", fs))

    for _, file := range percorsi {http.HandleFunc(file.route, file.f)}
    fmt.Println("Server acceso ===> http://127.0.0.1:8080")
    server.ListenAndServe()    
}

]=]
local goWeb_utils = [=[
package main

import (
    "net/http"
    "fmt"
    "io/ioutil"
    "strings"
    "time"
)
var Check_request = true
func log_sendFile(path string, r *http.Request){
    parts := strings.Split(path, ".")
    start := time.Now()
    body, _ := ioutil.ReadAll(r.Body)
    estensioni := []string{
        "css", "html", "js",
    } 

    if (len(parts) == 1){
        route := parts[0]
        fmt.Printf("***DATA: %v\n", start)
        for k, v := range r.Header{ fmt.Printf("\t%s: %s\n", k, v) }

        fmt.Printf("BODY: %s\n", body)
        fmt.Printf("[%v] ROUTE %s\n", time.Since(start), route)
    
    } else {
        for _, est := range estensioni{
            if (est == parts[1]){
                fmt.Printf("[%v] %s === %s\n", time.Since(start), est, path)
            }
        }
    }
}




func MiddleWare(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        if(Check_request==true){
            pathChan := make(chan string)
            go func(p string) {pathChan <- p}(r.URL.Path)
            path := <-pathChan
            log_sendFile(path, r)
        }
        next.ServeHTTP(w, r)
    })
}









func pag___methodGET(path string, w http.ResponseWriter, r *http.Request) bool {
    if (r.Method == "GET"){


        return true} else {return false}
}

func pag___methodPOST(path string, w http.ResponseWriter, r *http.Request) bool {
    if (r.Method == "POST"){return true} else {return false}
}
]=]



-- Funzione per salvare la variabile nella clipboard
local function saveToClipboard(content)
    vim.fn.setreg('+', content)
end

-- Definizione delle mappature di tasti per la modalità visuale
key('n', '<leader>html', function() saveToClipboard(html) end, {noremap = true, silent = true})
key('n', '<leader>gw1', function() saveToClipboard(goWeb_server) end, {noremap = true, silent = true})
key('n', '<leader>gw2', function() saveToClipboard(goWeb_utils) end, {noremap = true, silent = true})





