-- CATPPUCCIN MOCHA
-- return {
--   { "catppuccin/nvim" },
--   lazy = false,
--   name = "catppuccin",
--   opts = {
--     flavour = "mocha",
--     transparent_background = true,
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin",
--     },
--   },
-- }

-- NO CLOWN FIESTA
-- return {
--   {
--     "aktersnurra/no-clown-fiesta.nvim",
--     priority = 1000,
--     config = function()
--       require("no-clown-fiesta").setup({
--         transparent = false,
--         styles = {
--           comments = { italic = true },
--           keywords = {},
--           functions = {},
--           variables = {},
--           type = {},
--         },
--       })
--
--       vim.cmd.colorscheme("no-clown-fiesta")
--     end,
--   },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "no-clown-fiesta",
--     },
--   },
-- }

-- return {
--   {
--     "cdmill/neomodern.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("neomodern").setup({
--         theme = "moon",
--
--         cursorline = true,
--
--         transparent = false,
--
--         -- Estilos
--         styles = {
--           comments = { italic = true },
--           keywords = { bold = false },
--           functions = {},
--           variables = {},
--         },
--
--         -- Plugins
--         plugins = {
--           treesitter = true,
--           telescope = true,
--           cmp = true,
--           indent_blankline = true,
--           gitsigns = true,
--           lualine = true,
--           notify = true,
--         },
--       })
--
--       require("neomodern").load()
--     end,
--   },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "neomodern",
--     },
--   },
-- return {
--   {
--     "kdheepak/monochrome.nvim",
--     lazy = false,
--     priority = 1000,
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "monochrome",
--     },
--   },
-- }
return {
  {
    "idr4n/github-monochrome.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      terminal_colors = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github-monochrome",
    },
  },
}
