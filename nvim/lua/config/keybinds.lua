local function rightFileTree()
    vim.cmd("Neotree right")
    vim.cmd("vertical resize 60")
end

local function floatingFileTree()
    vim.cmd("Neotree float")
end

local function bruh()
	require("conform").format()
end

vim.g.mapleader = " "

vim.keymap.set("n", "_", rightFileTree)

vim.keymap.set("n", "-", floatingFileTree, { desc = "Open parent directory" })

vim.api.nvim_set_keymap("n", ":form<CR>", "ggVG=", { noremap = true, silent = true })

vim.keymap.set("n", "<C-e>", ":lua vim.diagnostic.open_float()<CR>")

vim.api.nvim_create_user_command("Fmt", bruh, {})

