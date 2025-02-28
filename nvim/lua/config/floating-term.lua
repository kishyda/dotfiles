vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_terminal(opts)
    local opts = opts or {}
    local width = opts.width or 1.0
    local height = opts.height or 1.0

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = math.floor(vim.o.columns * width),
        height = math.floor(vim.o.lines * height),
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }
    local win = vim.api.nvim_open_win(buf, true, win_config)
    return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("FT", function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_terminal({buf = state.floating.buf})
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end, {})

vim.keymap.set("n", "<leader>t", ":FT<CR>", { desc = "Open floating terminal" })
vim.keymap.set("n", "<leader>g", ":FT<CR> | i lazygit<CR>", { desc = "Open floating terminal" })
vim.keymap.set("n", "<C-`>", ":FT<CR>", { desc = "Open floating terminal" })
vim.keymap.set("n", "<C-t>", ":FT<CR>", { desc = "Open floating terminal" })
