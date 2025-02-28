return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "current",
				popup = {
					size = { height = "50", width = "120" },
					position = "50%", -- 50% means center it
				},
				mappings = {
					["P"] = {
						"toggle_preview",
						config = {
							use_float = true,
							-- use_image_nvim = true,
							-- title = 'Neo-tree Preview',
						},
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
				},
                auto_expand_depth = 99
			},
		})
	end,
}
