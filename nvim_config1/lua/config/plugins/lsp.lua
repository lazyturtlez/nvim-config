return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local caps = require("blink.cmp").get_lsp_capabilities()
      local util = require("lspconfig.util")

      vim.lsp.config("lua_ls", {
        capabilities = caps
      })

      vim.lsp.config("clangd", {
        capabilities = caps,
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--log=verbose',
          '--fallback-style=file',
        },
        root_dir = util.root_pattern(
          ".clang-format", -- ← look here first
          "compile_commands.json",
          ".git"
        ),
        init_options = {
          fallbackFlags = {
            '-std=c++17',
            '-std=c11',
            '-Wall',
            '-Iinclude',
          },
        },
      })

      vim.lsp.config("ruby_lsp", {
        capabilities = caps,
        cmd = { vim.fn.expand("~/.local/share/gem/ruby/3.4.0/bin/ruby-lsp") },
        init_options = {
          formatter = 'standard',
          linters = { 'standard' },
        },
      })

      vim.lsp.enable({ "lua_ls", "clangd", "ruby_lsp" })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end
      })
    end,
  }
}
