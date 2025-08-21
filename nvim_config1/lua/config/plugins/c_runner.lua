return {
  {
    -- treat your entire config dir as a “local plugin” so this always loads
    dir    = vim.fn.stdpath("config"),
    lazy   = false,
    -- only load when you open a C file
    ft     = "c",
    config = function()
      -- compile returns true on success, false (and prints) on error
      -- in your lazy.nvim spec’s `config = function() … end`
      local function compile(name)
        if name == "" then
          print("⚠️  compilation canceled")
          return false
        end
        vim.cmd("write")
        local src = vim.fn.expand("%:p")
        local out = vim.fn.expand("%:p:h") .. "/" .. name
        vim.fn.system({ "gcc", src, "-o", out })
        if vim.v.shell_error ~= 0 then
          print("❌  compilation failed")
          return false
        end
        print("✅  Compiled `" .. name .. "`")
        return true
      end

      local function run(name)
        local cwd = vim.fn.expand("%:p:h")
        vim.cmd("lcd " .. cwd)
        -- capture and print your program’s stdout cleanly:
        local output = vim.fn.system({ "./" .. name })
        if vim.v.shell_error ~= 0 then
          print("❌  runtime error:\n" .. output)
        else
          print(output)
        end
      end

      vim.keymap.set("n", "<leader>cc", function()
        vim.ui.input({ prompt = "file name: " }, function(name)
          if not name or name == "" then return end
          if compile(name) then run(name) end
        end)
      end, { desc = "Compile current C file and run if successful" })
    end,
  },
}
