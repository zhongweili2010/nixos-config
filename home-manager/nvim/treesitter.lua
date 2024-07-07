require('nvim-treesitter.configs').setup {
    ensure_installed = { 'vim', 'vimdoc', 'lua', 'rust', 'python' },

    auto_install = false,

    highlight = { enable = true },

    indent = { enable = true },
}