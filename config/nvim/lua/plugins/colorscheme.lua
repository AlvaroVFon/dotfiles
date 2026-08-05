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
--return {
return {
  {
    "kdheepak/monochrome.nvim",
    lazy = false,
    priority = 1000,

    config = function()
      require("monochrome").setup({
        transparent = false,
        italic_comments = true,
        bold = false,
        terminal_colors = true,
      })

      vim.cmd.colorscheme("monochrome")

      local hl = vim.api.nvim_set_hl

      -- Comentarios discretos
      hl(0, "Comment", { fg = "#6a6a6a", italic = true })

      -- Variables y parámetros sin color
      hl(0, "@variable", { link = "Normal" })
      hl(0, "@variable.parameter", { link = "Normal" })
      hl(0, "@variable.member", { link = "Normal" })

      -- Funciones sin negrita
      hl(0, "Function", { bold = false })

      -- Tipos discretos
      hl(0, "Type", { bold = false })

      -- CursorLine muy sutil
      hl(0, "CursorLine", { bg = "#1e1e1e" })

      -- Selección
      hl(0, "Visual", { bg = "#303030" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monochrome",
    },
  },
}
