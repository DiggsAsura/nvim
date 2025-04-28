-- ~/.config/nvim/lua/plugins/init.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Tema: Catppuccin med transparens
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true, -- Transparent bakgrunn
        term_colors = true,
        styles = {
          comments = { "italic" },
          keywords = { "bold" },
        },
      })
      vim.cmd.colorscheme("catppuccin-mocha") -- Moderne farger, ikke for prangende
    end,
  },

  -- LSP-støtte
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Autocompletion for LSP
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP-servere for språkene dine
      local servers = { "intelephense", "html", "ts_ls", "cssls", "pyright", "bashls", "rust_analyzer" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Trær for bedre kodeoversikt
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "php", "html", "javascript", "css", "python", "bash", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Filutforsker
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- vim-fugitive for Git-integrasjon
  {
    "tpope/vim-fugitive",
    config = function()
      -- Valgfri konfigurasjon, keymaps håndteres i keymaps.lua
    end,
  },

  -- gitsigns.nvim for visuelle Git-tegn og hunk-håndtering
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        signcolumn = true, -- Vis tegn i linjenummer-kolonnen
        numhl = false, -- Ikke fremhev linjenumre
        linehl = false, -- Ikke fremhev hele linjen
        word_diff = false, -- Ikke vis inline diff som standard
        current_line_blame = false, -- Deaktiver blame på nåværende linje som standard
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigasjon mellom hunks
          map("n", "]c", gs.next_hunk, { desc = "Neste Git hunk" })
          map("n", "[c", gs.prev_hunk, { desc = "Forrige Git hunk" })
        end,
      })
    end,
  },
})
