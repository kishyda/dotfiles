vim.opt.smarttab = true
vim.o.relativenumber = true

vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for.
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- Use spaces instead of tabs.
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.guicursor = ""
vim.opt.conceallevel = 2

vim.o.wrap = false

vim.opt.clipboard:append("unnamedplus")

vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true

    -- Alternatively, customize specific options
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})
