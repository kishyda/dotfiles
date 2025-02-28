local function cs(colorscheme)
    -- Set the colorscheme
    vim.cmd("colorscheme " .. colorscheme)

    -- Set transparency for various highlight groups
    local highlight_groups = {
        "StatusLine", "StatusLineNC", "Normal", "NonText",
        "NormalNC", "SignColumn", "LineNr", "EndOfBuffer",
        "TelescopePromptBorder", "TelescopePromptTitle", "TelescopePreviewTitle",
        "TelescopeResultsTitle", "TelescopeNormal", "TelescopePreviewNormal",
        "TelescopePromptNormal", "TelescopeResultsNormal",
        "DiagnosticUnderlineError", "DiagnosticUnderlineWarn",
        "DiagnosticUnderlineInfo", "DiagnosticUnderlineHint",
        "DiagnosticUnderlineOk", "LspInlayHint", "HarpoonWindow", "HarpoonBorder"
    }

    -- Set each highlight group with transparent background
    for _, group in ipairs(highlight_groups) do
        vim.cmd(string.format([[highlight %s guibg=NONE ctermbg=NONE]], group))
    end

    -- Set CmpBorder color to #6E6A86 with custom background color
    vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#6E6A86", bg = "#181818" })

end

vim.api.nvim_create_user_command('Cs', function(opts) cs(opts.args) end, { nargs = 1 })  -- Allow passing colorscheme as argument

local function setDarkMode()
	require("rose-pine").setup({
		variant = "auto", -- auto, main, moon, or dawn
		dark_variant = "moon", -- main, moon, or dawn
		dim_inactive_windows = false,
		extend_background_behind_borders = true,

		enable = {
			terminal = true,
			legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
			migrations = true, -- Handle deprecated options automatically
		},
		styles = {
			bold = false,
			italic = false,
			transparency = true,
		},

		groups = {
			border = "muted",
			link = "iris",
			panel = "surface",

			error = "love",
			hint = "iris",
			info = "foam",
			note = "pine",
			todo = "rose",
			warn = "gold",

			git_add = "foam",
			git_change = "rose",
			git_delete = "love",
			git_dirty = "rose",
			git_ignore = "muted",
			git_merge = "iris",
			git_rename = "pine",
			git_stage = "iris",
			git_text = "rose",
			git_untracked = "subtle",

			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},

		palette = {
			-- Override the builtin palette per variant
			-- moon = {
			--     base = '#18191a',
			--     overlay = '#363738',
			-- },
		},

		highlight_groups = {
			-- Comment = { fg = "foam" },
			-- VertSplit = { fg = "muted", bg = "muted" },
		},

		before_highlight = function(group, highlight, palette)
			-- Disable all undercurls
			if highlight.undercurl then
				highlight.undercurl = false
			end
			--
			-- Change palette colour
			-- if highlight.fg == palette.pine then
			--     highlight.fg = palette.foam
			-- end
		end,
	})
    cs("rose-pine")
end

-- Below code is to give Hover, or Shift-k a white border
local _border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
	-- Additional options can be set here if needed
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
	-- Additional options can be set here if needed
})
vim.diagnostic.config({
	float = { border = "single" }, -- Correctly set the border table for float
})
-- Above code is to give Hover, or Shift-k a white border

vim.api.nvim_create_autocmd({ "Filetype" }, {
	pattern = "harpoon",
	callback = function()
		vim.opt.cursorline = true
		vim.api.nvim_set_hl(0, "HarpoonWindow", { link = "Normal" })
		vim.api.nvim_set_hl(0, "HarpoonBorder", { link = "Normal" })
	end,
})

-- Helper function to simplify setting highlights
local function set_highlight(group, bg, fg)
	vim.api.nvim_set_hl(0, group, { ctermbg = bg, ctermfg = fg })
end

local function setLightMode()
	-- Set up the rose-pine theme with 'dawn' variant for light mode
	require("rose-pine").setup({
		variant = "dawn", -- auto, main, moon, or dawn
		dark_variant = "dawn", -- main, moon, or dawn (can be removed if not necessary)
		dim_inactive_windows = false,
		extend_background_behind_borders = true,

		enable = {
			terminal = true,
			legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
			migrations = true, -- Handle deprecated options automatically
		},

		styles = {
			bold = false,
			italic = false,
			transparency = false,
		},

		groups = {
			border = "muted",
			link = "iris",
			panel = "surface",

			error = "love",
			hint = "iris",
			info = "foam",
			note = "pine",
			todo = "rose",
			warn = "gold",

			git_add = "foam",
			git_change = "rose",
			git_delete = "love",
			git_dirty = "rose",
			git_ignore = "muted",
			git_merge = "iris",
			git_rename = "pine",
			git_stage = "iris",
			git_text = "rose",
			git_untracked = "subtle",

			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},

		palette = {
			-- Override the builtin palette per variant (can be extended if needed)
			-- moon = { base = '#18191a', overlay = '#363738' },
		},

		highlight_groups = {
			-- Comment = { fg = "foam" },
			-- VertSplit = { fg = "muted", bg = "muted" },
		},

		before_highlight = function(group, highlight, palette)
			-- Example customization (can be uncommented and adjusted if needed)
			-- if highlight.undercurl then
			--     highlight.undercurl = false
			-- end
			-- if highlight.fg == palette.pine then
			--     highlight.fg = palette.foam
			-- end
		end,
	})

	-- Apply the color scheme
	vim.cmd("colorscheme rose-pine")

	-- Define custom highlight color (reuse the same color for various elements)
	local highlight_color = "#FAF4ED"

	vim.api.nvim_set_hl(0, "Cursor", { fg = "#FFFFFF", bg = "#FFFFFF" })

	-- -- Use the helper function to apply the highlight colors
	-- set_highlight("StatusLine", highlight_color, highlight_color)
	-- set_highlight("StatusLineNC", highlight_color, highlight_color)
	-- set_highlight("Normal", highlight_color, highlight_color)
	-- set_highlight("NonText", highlight_color, highlight_color)
	-- set_highlight("NormalNC", highlight_color, highlight_color)
	-- set_highlight("SignColumn", highlight_color, highlight_color)
	-- set_highlight("LineNr", highlight_color, highlight_color)
	-- set_highlight("EndOfBuffer", highlight_color, highlight_color)
	-- -- Set transparency for Telescope popup
	-- set_highlight("TelescopePromptBorder", highlight_color, highlight_color)
	-- set_highlight("TelescopePromptTitle", highlight_color, highlight_color)
	-- set_highlight("TelescopePreviewTitle", highlight_color, highlight_color)
	-- set_highlight("TelescopeResultsTitle", highlight_color, highlight_color)
	-- set_highlight("TelescopeNormal", highlight_color, highlight_color)
	-- set_highlight("TelescopePreviewNormal", highlight_color, highlight_color)
	-- set_highlight("TelescopePromptNormal", highlight_color, highlight_color)
	-- set_highlight("TelescopeResultsNormal", highlight_color, highlight_color)
	--
	-- -- Set CmpBorder color
	-- vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#6E6A86", bg = highlight_color })
	--
	-- -- Define custom highlight groups for Harpoon
	-- set_highlight("HarpoonWindow", highlight_color, highlight_color)
	-- set_highlight("HarpoonBorder", highlight_color, highlight_color)
	--
	-- -- Set LSP Inlay Hint highlight color
	-- set_highlight("LspInlayHint", highlight_color, highlight_color)
end

setDarkMode()

vim.api.nvim_create_user_command("LM", setLightMode, {})
vim.api.nvim_create_user_command("DM", setDarkMode, {})
