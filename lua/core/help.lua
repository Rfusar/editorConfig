
function MenuHelp()
    local b = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(b, true, {
      relative = 'win',
      width = 70,
      height = 60,
      row = 10,
      col = 15,
      style = 'minimal',
      border = 'single',
      title = "|  Menu Help  |",
      title_pos = "right",
    })
    local menu = [[
     Leader + pu            | PackerUpdate                            
     Leader + Leader + ps   | PackerSync                              
     Leader + so            | Execute current file.lua                
     Leader + fh            | nvim's menu help                        
    
     Ctrl + s               | Save current file                       
     Ctrl + b               | Open/close treeExplorer                 
     Leader + sa            | Save all files                          
     Leader + c             | Copy on system clipboard                


     Leader + cr            | Clean registries                        
     Leader + crs           | Clear Search                            
    
     Leader + help          | Open this file                          
     Leader + s             | search a word into current directory

     Leader + Leader + t    | Display tasks                           
     Leader + Leader + a    | Display notes                           

     # Autocommand

     :h PushGithub 
     :h TagsXml

     # Menu
    
     F2                     | Fast links (multiselect with tab)       
     Leader + sni           | Menu Template                           
     Leader + p             | Menu Shortcut                           
     ctrl + p               | Menu Projects                           
     Leader + doc           | Menu Docs                               

     # Layout
    
     Alt + ,                | To the left                             
     Alt + .                | To the right                            
     Alt + u                | To the up                               
     Alt + d                | To the down                             
     Leader + 123           | Row absolue                             
     Leader + 101           | Row relative                            
    
     #  Viewer
    
     Leader + csv           | Read files CVS                          
     Leader + mds           | Enable server mode to read the file MD  
     Leader + mdq           | Disable server mode to read the file MD 
    
     # Help
    
     Leader + Leader + lo   | LSP-Servers Off                         
     Leader + Leader + lp   | LSP-Server Python                       
     Leader + Leader + lj   | LSP-Server Js/Ts                        
     Alt + d                | Docs func (if lsp is active)            
    
     #  Debug
    
     Leader + Leader + b   | Set debug python(system)                 
     Leader + Leader + bv  | Set debug python(venv)                   
     Leader + b            | Set BreakPoint                           
     Leader + du           | View/close debugger-ui                   
     Leader + db           | Show panel Brakpoints                    
     Leader + dv           | Show panel Variables                     
     Leader + ds           | Show panel Scopes                        
     Leader + dt           | Terminate Debugger Session               
     F5                    | Start Debugger Session                   
     F10                   | Next Move                                
     F11                   | Next Step                                
     F12                   | ???                                      
    
    ]]
    vim.api.nvim_buf_set_lines(b, 2, -1, false, vim.fn.split(menu, "\n"))
end



vim.keymap.set('n', '<leader>help', ':lua MenuHelp()<CR>', {})
