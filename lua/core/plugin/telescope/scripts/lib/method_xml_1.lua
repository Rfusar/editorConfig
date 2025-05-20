-- HOW TO USE
--
-- on the registry a you got a macro for doing this:
--
-- FROM
--  <cmd/>
--  
-- TO
--  <cmd>value</cmd>
--
-- execute the function with :lua setValue()

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function setValue(value)
    vim.fn.setreg("a", t("A<Esc>vh<Del>vbyA>"..value.."</<Esc>pa>"))
end
