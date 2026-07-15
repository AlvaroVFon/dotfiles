return {
  { "catppuccin/nvim" },
  lazy = false,
  name = "catppuccin",
  opts = {
    flavour = "mocha",
    transparent_background = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
