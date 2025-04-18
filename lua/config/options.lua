-- ~/.config/nvim/lua/config/options.lua
vim.opt.number = true          -- Vis linjenummer
vim.opt.relativenumber = true  -- Relative linjenummer
vim.opt.expandtab = true       -- Bruk mellomrom i stedet for tab
vim.opt.shiftwidth = 2         -- 2 mellomrom for innrykk
vim.opt.tabstop = 2            -- 2 mellomrom per tab
vim.opt.smartindent = true     -- Smart innrykk
vim.opt.termguicolors = true   -- Aktiver 24-bit farger
vim.opt.background = "dark"    -- Mørkt tema
vim.opt.signcolumn = "yes"     -- Alltid vis tegnkolonne for LSP
vim.opt.updatetime = 250       -- Raskere oppdatering (for LSP osv.)
vim.opt.mouse = "a"            -- Aktiver musestøtte
vim.opt.clipboard = "unnamedplus" -- Synkroniser med systemklippebord
