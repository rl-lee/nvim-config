return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500 -- timeout in milliseconds
    end,
    opts = {
        --your configuration here
        --leave empty for default settings
    },
}
