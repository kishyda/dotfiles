vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_terminal(opts)
    local opts = opts or {}
    -- Use numbers between 0.0 and 1.0 for percentage of screen size
    local width_percent = opts.width or 0.85
    local height_percent = opts.height or 0.85

    -- 1. Calculate the final pixel dimensions of the window
    local win_width = math.floor(vim.o.columns * width_percent)
    local win_height = math.floor(vim.o.lines * height_percent)

    -- 2. Calculate the top-left coordinate (col and row) for centering
    -- To center, take half the available space (screen size - window size)
    local col = math.floor((vim.o.columns - win_width) / 2)
    local row = math.floor((vim.o.lines - win_height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = win_width, -- Use calculated width
        height = win_height, -- Use calculated height
        col = col,           -- Use calculated center column
        row = row,           -- Use calculated center row
        style = "minimal",
        border = "rounded",
    }
    
    local win = vim.api.nvim_open_win(buf, true, win_config)
    
    -- Enter terminal mode if this is a new buffer (optional but helpful)
    if not vim.api.nvim_buf_is_valid(opts.buf) then
        vim.api.nvim_set_option_value("filetype", "terminal", { buf = buf })
        vim.api.nvim_buf_call(buf, function()
            vim.cmd("startinsert")
        end)
    end

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
