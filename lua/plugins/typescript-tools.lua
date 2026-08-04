return {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
        settings = {
            tsserver_include_declaration_files = true,
            tsserver_file_preferences = {
                includeInlayParameterNameHits = "all"
            }
        }
    },
}
