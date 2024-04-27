vim.cmd("highlight Normal guibg=black")

local c = {				
    grigio = "#383838",
    rossoAcceso = "#fc0505",
    rossoNormale = "#a30707",
    rossoChiaro = "#b84444",
				arancio = "#f26507",
				giallo = "#f0d805",
				verde = "#03ad1d",
				azzurroAcceso = "#055deb",
				azzurro = "#06ba96",
				azzurroScuro = "#038a87",
				bluChiaro = "#028bb5",
				blu = "#0508a6",
				violaAcceso = "#8607f5",
    violaChiaro = "#a651f0",
				rosaAcceso = "#f505d1",
				rosa = "#c746b4",
}

local syntax = {
    Comment = "guifg="..c.grigio.." gui=italic",
    Constant = "guifg="..c.arancio,
				Repeat = "guifg="..c.azzurroAcceso.."gui=italic",
--  Number = "guifg="..c.
				Conditional = "guifg="..c.violaAcceso.."gui=italic",
				Function = "guifg="..c.azzurroAcceso.."gui=italic",
				Exception = "guifg="..c.violaAcceso.."gui=italic",
    Keyword = "guifg="..c.violaChiaro,
				boolean = "guifg="..c.rosa,
				String = "guifg="..c.verde,
				Identifier = "guifg="..c.rossoNormale,
    Type = "guifg="..c.rossoChiaro,
				Statement = "guifg="..c.violaAcceso,
				Structure = "guifg="..c.violaAcceso,
}
for k, v in pairs(syntax) do vim.cmd("hi ".. k .. " ".. v) end



