-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
--        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
--        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Tab>"] = { ":bn<CR>", desc = "Next buffer" },
        ["<S-Tab>"] = { ":bp<CR>", desc = "Previous buffer" },
        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- New mappings
        ["<C-s>"] = { "<cmd>w<cr>", desc = "Save file" },
        ["D"] = { "A", desc = "Insert at end of line" },
        ["A"] = { "I", desc = "Insert at beginning of line" },

        ["<leader>gi"] = { function() vim.lsp.buf.implementation() end, desc = "Go to Implementation" },
        ["K"] = { function() vim.lsp.buf.hover() end, desc = "Hover Documentation" },
        ["<leader>rn"] = { function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
        ["<leader>gr"] = { function() vim.lsp.buf.references() end, desc = "Find References" },


        -- Ergonomic navigation
        ["J"] = { "mzJ`z", desc = "Join lines without moving cursor" },
        ["<C-d>"] = { "<C-d>zz", desc = "Scroll down and center" },
        ["<C-u>"] = { "<C-u>zz", desc = "Scroll up and center" },
        ["n"] = { "nzzzv", desc = "Next search match centered" },
        ["N"] = { "Nzzzv", desc = "Previous search match centered" },

        ["gl"] = {
          function()
            vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
          end,
          desc = "Show diagnostics in popup",
        },
      },

      v = {
        ["<C-c>"] = { '"+y', desc = "Copy to system clipboard" },
        ["<C-x>"] = { '"+d', desc = "Cut to system clipboard" },
        ["<C-p>"] = { '"+p', desc = "Paste from system clipboard" },
      },


    },
  },
}
