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
     -- cmp-nvim-lsp er nå en dependency for nvim-cmp, fjernet herfra for ryddighet
    config = function()
      local lspconfig = require("lspconfig")
      -- Bruk capabilities fra cmp-nvim-lsp (som nå lastes som dependency for nvim-cmp)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP-servere for språkene dine
      local servers = { "intelephense", "html", "ts_ls", "cssls", "pyright", "bashls", "rust_analyzer" } -- Bruker tsserver fra din forrige config
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
    end,
  },

  -- Autocompletion (Oppdatert for Copilot)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",     -- Flyttet hit, nødvendig for LSP completions i cmp
      "zbirenbaum/copilot-cmp",   -- <--- Ny avhengighet for Copilot
    },
    config = function()
      local cmp = require("cmp")
      require("copilot_cmp").setup() -- <--- Ny linje: Initialiser copilot-cmp

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- Dine eksisterende mappings beholdes:
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "copilot" },   -- <--- Ny kilde for Copilot
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Trær for bedre kodeoversikt (Beholdt fra din forrige versjon)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "php", "html", "javascript", "css", "python", "bash", "rust", 'lua', 'vim', 'vimdoc', 'blade' },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Filutforsker (Beholdt uendret)
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- vim-fugitive for Git-integrasjon (Beholdt uendret)
  {
    "tpope/vim-fugitive",
    config = function()
      -- Valgfri konfigurasjon, keymaps håndteres i keymaps.lua
    end,
  },

  -- gitsigns.nvim for visuelle Git-tegn og hunk-håndtering (Beholdt uendret, inkl. din on_attach)
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
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        current_line_blame = false,
        -- Din eksisterende on_attach beholdes:
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

  -- GitHub Copilot (Offisiell plugin)  <--- Ny plugin-blokk
  {
    "github/copilot.vim",
    config = function()
      -- Anbefalt: Deaktiver automatisk start. Aktiver med :Copilot enable
      vim.g.copilot_auto_enable = 0
    end,
  },

}) -- Slutt på require("lazy").setup
