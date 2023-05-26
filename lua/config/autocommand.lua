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
autocmd({"BufWritePre"}, {
    group = CustomAugroup,
    command = [[%s/\s\+$//e]],
})
