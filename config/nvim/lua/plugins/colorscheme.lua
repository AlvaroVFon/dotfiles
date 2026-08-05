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

return {
  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 1000,
    config = function()
      require("no-clown-fiesta").setup({
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},
        },
      })

      vim.cmd.colorscheme("no-clown-fiesta")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "no-clown-fiesta",
    },
  },
}
