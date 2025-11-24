return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
        "permissions",
        "size",
      },
    },
    -- Optional dependencies
    dependencies = {
      { "nvim-mini/mini.icons",            opts = {} },
      { "JezerM/oil-lsp-diagnostics.nvim", opts = {} },
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
