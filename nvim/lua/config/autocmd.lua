vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.defer_fn(function()
			vim.cmd("lua vim.lsp.inlay_hint.enable()")
			vim.cmd([[highlight LspInlayHint guibg=NONE ctermbg=NONE]])
		end, 2000)
		vim.defer_fn(function()
			vim.cmd("lua vim.lsp.inlay_hint.enable()")
			vim.cmd([[highlight LspInlayHint guibg=NONE ctermbg=NONE]])
		end, 5000)
	end,
})

vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
