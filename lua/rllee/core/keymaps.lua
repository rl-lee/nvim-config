vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "{", "{{wzz")
keymap.set("n", "}", "}wzz")

keymap.set("n", "<leader>rw", vim.cmd.Ex)

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--half page navigation
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("v", "<C-d>", "<C-d>zz")
keymap.set("v", "<C-u>", "<C-u>zz")
keymap.set("n", "G", "Gzz")

--search occurence navigation
keymap.set("n", "n", "nzz")
keymap.set("n", "N", "Nzz")

--increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) --increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Increment number" }) --increment

--window management
-- keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
-- keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal size
-- keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split window" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close new tab" }) -- close new tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- open current buffer in new tab

keymap.set(
	"n",
	"<leader>py",
	"<C-w>v<cmd>terminal ipython<CR>i%matplotlib qt<CR>%load_ext autoreload<CR>%autoreload 2<CR><C-\\><C-n>G<C-w>h",
	{ desc = "Open a vertical split with a terminal running ipython" }
)

vim.keymap.set("n", "<leader>fl", function()
	-- Prompt for input
	local text = vim.fn.input("Figlet text: ")
	if text == "" then
		return
	end

	-- Run figlet and capture output
	local result = vim.fn.systemlist("figlet " .. vim.fn.shellescape(text))
	if vim.v.shell_error ~= 0 then
		vim.notify("figlet not found. Install it with your package manager.", vim.log.levels.ERROR)
		return
	end

	-- Get the comment string for the current filetype
	local commentstr = vim.bo.commentstring
	if commentstr == "" then
		commentstr = "# %s" -- fallback
	end

	-- Format each line as a comment
	local commented = {}
	for _, line in ipairs(result) do
		table.insert(commented, commentstr:format(line))
	end

	-- Insert lines below the cursor
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row, row, false, commented)
end, { desc = "Insert figlet comment" })

-- Create a vim-slime cell
vim.keymap.set("n", "<leader>nc", function()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local prefix = "# %% "
	local width = 80
	local marker = prefix .. string.rep("-", math.max(width - #prefix, 0))
	vim.api.nvim_buf_set_lines(0, row, row, false, { "", marker, "" })
	vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
	vim.cmd("startinsert")
end, { desc = "Insert new slime cell below" })

-- Jump between vim-slime cells
local function goto_cell(direction)
	local pattern = vim.g.slime_cell_delimiter or "^# %%"
	local flags = direction == "next" and "W" or "bW"
	local found = vim.fn.search(pattern, flags)
	if found == 0 then
		vim.notify("No " .. direction .. " cell", vim.log.levels.INFO)
	else
		vim.cmd("normal! zz")
	end
end

vim.keymap.set("n", "<leader>]", function()
	goto_cell("next")
end, { desc = "Next slime cell" })
vim.keymap.set("n", "<leader>[", function()
	goto_cell("prev")
end, { desc = "Previous slime cell" })
