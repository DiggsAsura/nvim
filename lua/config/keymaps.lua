-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set
map("n", "<leader>e", ":Explore<CR>", { desc = "Åpne filutforsker" })
map("n", "<leader>w", ":w<CR>", { desc = "Lagre fil" })
map("n", "<leader>q", ":q<CR>", { desc = "Lukk vindu" })

-- Navigere mellom vinduer
map("n", "<leader>h", "<C-w>h", { desc = "Gå til vindu til venstre" })
map("n", "<leader>l", "<C-w>l", { desc = "Gå til vindu til høyre" })
map("n", "<leader>j", "<C-w>j", { desc = "Gå til vindu nedenfor" })
map("n", "<leader>k", "<C-w>k", { desc = "Gå til vindu ovenfor" })
map("n", "<leader><leader>", "<C-w>p", { desc = "Toggle til forrige vindu" })
map("n", "<leader>t", "<C-w>p", { desc = "Alt Toggle til forrige vindu" })

-- Navigere gjennom buffere
map("n", "<leader>n", ":bnext<CR>", { desc = "Neste buffer" })
map("n", "<leader>p", ":bprev<CR>", { desc = "Forrige buffer" })
map("n", "<tab>", ":b#<CR>", { desc = "Toggle til sist brukte buffer" })

-- Git-relaterte mappinger (vim-fugitive)
map("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
map("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
map("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff for nåværende fil" })
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
