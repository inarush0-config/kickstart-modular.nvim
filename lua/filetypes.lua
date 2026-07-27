vim.filetype.add({
    extension = {
        tfvars = "terraform-vars",
        tftpl = "terraform",
    },
    pattern = {
        ["*Dockerfile*"] = "dockerfile",
    },
})

vim.api.nvim_create_autocmd({ 'BufNewFile', "BufRead" }, {
    pattern = { "*.yaml", "*.yml" },
    callback = function()
        if vim.fn.search("AWSTemplateFormatVersion", "nw") ~= 0 then
            vim.bo.filetype = "yaml.cloudformation"
        end
    end,
})
