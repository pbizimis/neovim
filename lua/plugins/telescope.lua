return {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    keys = function()
        local builtin = require('telescope.builtin')
        return {
            {"<leader>pf", builtin.find_files},
            {"<leader>pg", builtin.git_files},
            {"<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end}

        }
    end,
}
