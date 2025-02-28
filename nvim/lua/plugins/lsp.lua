return {
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
			require("mason-lspconfig").setup({
				-- Replace the language servers listed here
				-- with the ones you want to install
				ensure_installed = { "lua_ls", "rust_analyzer" },
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
			-- Reserve a space in the gutter
			-- This will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = "yes"

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- This is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

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
				end,
			})

			local cmp = require("cmp")
			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			cmp.setup({
				snippet = {
					-- expand = function(args)
					--     luasnip.lsp_expand(args.body)  -- For luasnip users.
					-- end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				},
				window = {
					completion = {
						border = border("CmpBorder"), -- Border style for completion menu
						winhighlight = "Normal:Normal,FloatBorder:CmpBorder", -- Set the highlights
					},
					documentation = {
						border = border("CmpBorder"), -- Border style for documentation
						winhighlight = "Normal:Normal,FloatBorder:CmpBorder", -- Set the highlights
					},
					hover = {
						border = border("CmpBorder"), -- Border style for documentation
						winhighlight = "Normal:Normal,FloatBorder:CmpBorder", -- Set the highlights
					},
				},
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT", -- Use 'Lua 5.1' if you are using Lua 5.1
						},
						diagnostics = {
							globals = { "vim" }, -- Add any global variables you want to recognize
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
						},
						telemetry = {
							enable = false, -- Disable telemetry
						},
					},
				},
			})
		end,
	},
}
