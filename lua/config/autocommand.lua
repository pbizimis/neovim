local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local CustomAugroup = augroup('CustomAugroup', {})

-- Highlight text after yank
autocmd('TextYankPost', {
    group = CustomAugroup,
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 400,
        })
    end,
})

-- Remove trailing whitespaces on save
autocmd({ "BufWritePre" }, {
    group = CustomAugroup,
    command = [[%s/\s\+$//e]],
})

-- Overwrite tab width for js/ts files
autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "css", "scss", "markdown", "yaml" },
  callback = function()
    vim.bo.expandtab  = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop    = 2
    vim.bo.softtabstop= 2
  end,
})
