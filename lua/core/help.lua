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
     # NVIM Basic

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

     :PushGithub 
     :h TagsXml (Not Available)
     :CreateNextJs

     -- Tool AI
     :Domanda
     
     -- Tool for translations
     :InputTraduzione
     :GeneraTraduzione


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

     K (above the variable)  | View docs
     gd (above the variable) | View docs
     Leader+e                | View errors and warnings
     Leader+view             | View in the current buf errors and warnings
    
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
    
    -- Imposta le linee nel buffer
    local lines = vim.fn.split(menu, "\n")
    vim.api.nvim_buf_set_lines(b, 0, -1, false, lines)
    
    -- Definisci gli highlight groups
    vim.api.nvim_set_hl(0, 'MenuHelpSection', { fg = '#FF9E64', bold = true })  -- Colore arancione per le sezioni
    vim.api.nvim_set_hl(0, 'MenuHelpCommand', { fg = '#7EE787' })               -- Colore verde per i comandi
    vim.api.nvim_set_hl(0, 'MenuHelpKey', { fg = '#79C0FF' })                   -- Colore blu per i tasti
    
    -- Applica gli highlight alle linee
    for i, line in ipairs(lines) do
        -- Se la linea inizia con '#', applica l'highlight della sezione
        if line:match('%s+#') then
            vim.api.nvim_buf_add_highlight(b, -1, 'MenuHelpSection', i-1, 0, -1)
        end
        
        -- Highlight per i tasti (prima parte prima del |)
        local key_part = line:match('^(.-|)')
        if key_part then
            vim.api.nvim_buf_add_highlight(b, -1, 'MenuHelpKey', i-1, 0, #key_part)
        end
        
        -- Highlight per i comandi (dopo il |)
        local cmd_part = line:match('|(.*)$')
        if cmd_part then
            vim.api.nvim_buf_add_highlight(b, -1, 'MenuHelpCommand', i-1, line:find('|') or 0, -1)
        end
    end
    
    -- Imposta il filetype per eventuale syntax highlighting aggiuntivo
    vim.api.nvim_buf_set_option(b, 'filetype', 'help')
    
    -- Chiudi la finestra quando si preme q
    vim.api.nvim_buf_set_keymap(b, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(b, 'n', '<ESC>', ':q<CR>', { noremap = true, silent = true })
end

vim.keymap.set('n', '<leader>help', ':lua MenuHelp()<CR>', {})
