return {
	"jpalardy/vim-slime",
	init = function()
		vim.g.slime_target = "neovim"
		vim.g.slime_python_ipython = 1
		vim.g.slime_bracketed_paste = 1
		-- vim.g.slime_default_config = { socket_name = "default", target_pane = "{right-of}" }
	end,
}
