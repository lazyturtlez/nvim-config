return {
  {
    "folke/tokyonight.nvim",
    -- these opts will be passed to tokyonight.setup()
    opts = {
      transparent = false,
      -- if you want sidebars/floats transparent as well:
      styles = {
        sidebars = "transparent",
        floats   = "transparent",
      },
    },
    -- run the setup and then apply the colorscheme
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
