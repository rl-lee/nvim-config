vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- Remap j and k to move by visual lines,
-- but move by physical lines if a count is provided (e.g., 10j)
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "$", "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
-- vim.keymap.set({ "n", "v" }, "_", "v:count == 0 ? 'g_' : '_'", { expr = true, silent = true })
