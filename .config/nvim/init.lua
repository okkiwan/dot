vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--------------- LAZY ---------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--------------- LAZY PLUGINS ---------------

require('lazy').setup({
    -- gruvbox
    { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ... },

    -- utils
    { 'ibhagwan/fzf-lua' },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },
    { 'tpope/vim-sleuth' },
    { 'folke/ts-comments.nvim', opts = {}, event = 'VeryLazy' },

    -- lsp, treesitter & formatter
    { 'neovim/nvim-lspconfig' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'sbdchd/neoformat' },

    -- autocomplete
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip', dependencies = { 'rafamadriz/friendly-snippets' } },
    { 'saadparwaiz1/cmp_luasnip' },
})

--------------- PLUGINS CONFIGS ---------------

-- gruvbox
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- fzf
require('fzf-lua').setup({
    winopts = { height = 0.95, width = 0.95 },
    keymap = {
        builtin = { ['<C-d>'] = 'preview-page-down', ['<C-u>'] = 'preview-page-up' },
        fzf = { ['ctrl-d'] = 'preview-down', ['ctrl-u'] = 'preview-up' },
    },
})

-- treesitter
require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

-- cmp
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})
cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }),
    matching = { disallow_symbol_nonprefix_matching = false },
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['cssls'].setup({ capabilities = capabilities })
require('lspconfig')['html'].setup({ capabilities = capabilities })
require('lspconfig')['tsserver'].setup({ capabilities = capabilities })
require('lspconfig')['clangd'].setup({ capabilities = capabilities })
-- friendly snippets
require('luasnip.loaders.from_vscode').lazy_load()

--------------- KEYS ---------------

-- fzf
vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set('n', '<leader>g', "<cmd>lua require('fzf-lua').git_status()<CR>", { silent = true })
vim.keymap.set('n', '<leader>f', "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })

-- lsp
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, noremap = true, silent = true })

-- neoformat
vim.keymap.set('n', '<leader>i', '<cmd>:Neoformat<CR>', { silent = true })

-- netrw
vim.keymap.set('n', '-', '<cmd>:Ex<CR>', { silent = true })

--------------- SETS ---------------

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.updatetime = 250
vim.o.wrap = false
vim.o.mouse = ''
vim.o.expandtab = true
vim.o.clipboard = 'unnamedplus'
vim.g.netrw_banner = 'false'
