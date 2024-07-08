local parser_install_dir = vim.fn.stdpath('data') .. '/parsers'
vim.fn.mkdir(parser_install_dir, 'p')

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'vim', 'vimdoc', 'lua', 'rust', 'python' },

    auto_install = false,

    highlight = { enable = true },

    indent = { enable = true },

    parser_install_dir = parser_install_dir,  -- Add this line

}