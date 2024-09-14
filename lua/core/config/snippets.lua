local key = vim.keymap.set


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



function handle_snippet()
    print("html || default page")
    print("gw1 || go server")
    print("gw2 || go server utils")
    print()

    local content = ""
    local res = vim.fn.input("Snippets: ")

    if res == "html" then content = html
    elseif res == "gw1" then content = goWeb_server
    elseif res == "gw2" then content = goWeb_utils
    else
        print("Snippet non riconosciuto")
        return
    end

    vim.fn.setreg("+", content)
end

vim.api.nvim_set_keymap('n', '<leader>sni', ':lua handle_snippet()<CR>', { noremap = true, silent = true })

