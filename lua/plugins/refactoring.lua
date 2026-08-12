return {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "lewis6991/async.nvim",
    },
    keys = {
        { "<leader>re", mode = "v", desc = "Extract Function" },
        { "<leader>rv", mode = "v", desc = "Extract Variable" },
        { "<leader>rb", mode = "n", desc = "Extract Block" },
    },
    config = function()
        local refactoring = require("refactoring")
        refactoring.setup()

        -- Visual-mode Extract Function
        vim.keymap.set("v", "<leader>re", function()
            return refactoring.extract_func()
        end, { desc = "Extract Function", expr = true })

        -- Visual-mode Extract Variable
        vim.keymap.set("v", "<leader>rv", function()
            return refactoring.extract_var()
        end, { desc = "Extract Variable", expr = true })

        -- Normal-mode Extract Block
        vim.keymap.set("n", "<leader>rb", function()
            return refactoring.extract_block()
        end, { desc = "Extract Block", expr = true })
    end,
}
