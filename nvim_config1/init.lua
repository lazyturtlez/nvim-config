require("config.lazy")

-- sets the leaderkey
vim.g.mapleader = " "

-- sets global nvim options
local opt = vim.opt

opt.shiftwidth = 4
opt.number = true
opt.relativenumber = true


-- sets global nvim keymaps
local km = vim.keymap

km.set("n", "<leader>pv", ":Ex<CR>", { desc = "returns to file explorer" })
km.set("n", "<leader>cd", ":lcd %:p:h<CR>", { desc = "changes vim's cwd to the working file/folder" })
km.set("n", "<leader><leader>x", "<cmd>source %<CR>")
km.set("n", "<leader>x", ":.lua<CR>")
km.set("n", "<leader>hi", function() print("test message!") end, { desc = "say hello" })
km.set("v", "<leader>x", ":lua<CR>")

km.set("n", "<M-j>", "<cmd>cnext<CR>")
km.set("n", "<M-k>", "<cmd>cprev<CR>")


vim.diagnostic.config(
  {
    virtual_text = true,
    underline = false
  })
