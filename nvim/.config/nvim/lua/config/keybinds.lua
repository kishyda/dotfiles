vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "-", ":Yazi<Cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", ":form<CR>", "ggVG=", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Fmt", "lua vim.lsp.buf.format()", {})

vim.api.nvim_set_keymap("n", "<leader>ft", ":Neotree current<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-e>", ":lua vim.diagnostic.open_float()<CR>")

vim.keymap.set("n", "<C-i>", "<cmd>lua vim.lsp.buf.hover()<cr>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
