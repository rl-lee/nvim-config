return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
			cpp = { "cppcheck", "clangtidy" },
			cmake = { "cmakelint" },
			latex = { "lacheck" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		--Set pylint to work in venv
		lint.linters.pylint.cmd = "python3"
		-- This line below seems to cause a bug...
		-- lint.linters.pylint.args = { "-m", "pylint", "-f", "json" }

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
