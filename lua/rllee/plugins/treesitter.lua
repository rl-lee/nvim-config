return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.setup()

		-- install parsers (async, skips ones already installed)
		treesitter.install({
			-- "cmake",
			"c",
			"cpp",
			"python",
			"latex",
			"lua",
			"gitignore",
			"json",
		})

		-- enable syntax highlighting and indentation per buffer
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				-- silently skip filetypes that have no parser
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		-- autotagging now has its own setup (no longer part of treesitter's config)
		require("nvim-ts-autotag").setup()
	end,
}
