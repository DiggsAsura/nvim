-- Sett ledernøkkel først - Space
vim.g.mapleader = " "

-- ~/.config/nvim/init.lua
require("config.options")  -- Generelle innstillinger
require("config.keymaps")  -- Tastatursnarveier
require("plugins")         -- Plugins via Lazy
