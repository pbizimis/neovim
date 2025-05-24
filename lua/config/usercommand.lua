-----------------------------------------------------------------
-- Ruff “do-everything” helper  ─  :RuffAll  or  <leader>rf
-----------------------------------------------------------------
local function run_action(kind)
    vim.lsp.buf.code_action({
        context = { only = { kind } },
        apply   = true,
    })
end

vim.api.nvim_create_user_command("RuffAll", function()
    -- 1) lint fixes (includes quick-fixes for most rules)
    run_action("source.fixAll")
    -- 2) import-sorting (rule group I)
    run_action("source.organizeImports")
    -- 3) final Black-style formatting
    vim.lsp.buf.format({
        async  = false,
        filter = function(client) return client.name == "ruff" end,
    })
end, { desc = "Ruff: fix-all + import-sort + format" })

-- optional keymap
vim.keymap.set("n", "<leader>rf", "<cmd>RuffAll<CR>", { desc = "Ruff: format & fix" })
