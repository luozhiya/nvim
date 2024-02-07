-------------------------------------------------------------------------------
-- Design
--
-- 1. C/C++/JS/Java/Python/Markdown
-- 2. Simple
-- 3. Less dependencies
-- 
-- Outline
-- 1. Lazy
-- 2. Option
-- 3. Definition
-- 4. Plugins
-- 5. Keymap
-- 6. Autocmds
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 1. Lazy
-------------------------------------------------------------------------------

os.setlocale('C')
vim.g.mapleader = ','
vim.g.maplocalleader = ','

local lazypath = vim.fn.stdpath('config') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_echo({
    { 'Start clone Lazy.nvim', 'MoreMsg' },
  }, true, {})
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
  vim.api.nvim_echo({
    { 'Lazy.nvim cloned successful, Press any key to exit', 'MoreMsg' },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- 2. Option
-------------------------------------------------------------------------------

-- Font
vim.opt.guifont = 'NotoSansM Nerd Font:h13'

-- Neovim default
-- vim.cmd([[filetype plugin indent on]]) -- use language‐specific plugins for indenting (better):
-- autoindent = true, -- reproduce the indentation of the previous line
local vim_opts = {
  -- autochdir = true,
  -- shellslash = true, -- A forward slash is used when expanding file names. -- Bug: neo-tree
  lazyredraw = not jit.os:find('Windows'), -- no redraws in macros. Disabled for: https://github.com/neovim/neovim/issues/22674
  clipboard = 'unnamedplus', -- Allows neovim to access the system clipboard
  -- Appearance
  termguicolors = true, -- True color support. set 24-bit RGB color in the TUI
  shortmess = 'oOcCIFWS', -- See https://neovim.io/doc/user/options.html#'shortmess'
  showmode = false, -- Dont show mode since we have a statusline
  laststatus = 3, -- Status line style
  cmdheight = 0, -- Command-line.
  showtabline = 0, -- Always display tabline
  signcolumn = 'yes', -- Always show the signcolumn, otherwise it would shift the text each time
  scrolloff = 4, -- Minimal number of screen lines to keep above and below the cursor.
  sidescrolloff = 8, -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
  winminwidth = 5, -- Minimum window width
  cursorline = false, -- Enable highlighting of the current line
  number = true, -- Print line number
  relativenumber = true, -- Relative line numbers
  background = 'dark', -- The theme is used when the background is set to light
  -- Formatting
  wrap = false, -- Disable line wrap
  linebreak = true, -- Make it not wrap in the middle of a "word"
  textwidth = 120, -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
  -- colorcolumn = '80',
  tabstop = 2, -- Length of an actual \t character
  expandtab = true, -- Ff set, only insert spaces; otherwise insert \t and complete with spaces
  shiftwidth = 0, -- Number of spaces to use for each step of (auto)indent. (0 for ‘tabstop’)
  softtabstop = 0, -- length to use when editing text (eg. TAB and BS keys). (0 for ‘tabstop’, -1 for ‘shiftwidth’)
  shiftround = true, -- Round indentation to multiples of 'shiftwidth' when shifting text
  smartindent = true, -- Insert indents automatically
  cinoptions = vim.opt.cinoptions:append({ 'g0', 'N-s', ':0', 'E-s' }), -- gN. See https://neovim.io/doc/user/indent.html#cinoptions-values
  synmaxcol = 300, -- Don't syntax-highlight long lines
  ignorecase = true, -- Ignore case
  -- smartcase = true, -- Don't ignore case with capitals
  formatoptions = 'rqnl1jt', -- Improve comment editing
  -- Completion
  completeopt = { 'menuone', 'noselect', 'noinsert' },
  wildmode = 'full', -- Command-line completion mode
  -- Fold
  fillchars = { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ', vert = ' ' },
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,
  foldcolumn = '1',
  foldmethod = 'expr',
  foldexpr = 'nvim_treesitter#foldexpr()',
  -- Split Windows
  splitkeep = 'screen', -- Stable current window line
  splitbelow = true, -- Put new windows below current
  splitright = true, -- Put new windows right of current
  -- Edit
  incsearch = false,
  autoread = true, -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.
  undofile = true,
  undolevels = 10000,
  swapfile = false, -- Bug: Crashed Neovide
  -- Search
  grepformat = '%f:%l:%c:%m',
  grepprg = 'rg --vimgrep',
  -- Spell
  spell = false, -- Enable Spell Check Feature In Vim Editor
  -- spellfile = base.to_native(vim.fn.stdpath('config') .. '/spell/en.utf-8.add'),
  spelllang = 'en',
  -- spelllang = { 'en_us' }, -- 'en', -- Switch between multiple languages
  -- Misc
  inccommand = 'nosplit', -- preview incremental substitute
  timeout = true, -- Limit the time searching for suggestions to {millisec} milli seconds.
  timeoutlen = 600, -- Determine the behavior when part of a mapped key sequence has been received
  updatetime = 100, -- Save swap file and trigger CursorHold
  fileformats = 'unix,dos,mac', -- Detect formats
  sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  confirm = true, -- Confirm to save changes before exiting modified buffer
  conceallevel = 3, -- Hide * markup for bold and italic, also make json hide '"'
  mouse = 'a', -- Enable mouse for all available modes
  virtualedit = 'block', -- Allow going past the end of line in visual block mode
  autowrite = true, -- Enable auto write
  writebackup = false, -- Disable making a backup before overwriting a file
  list = false, -- default is hide
  listchars = 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+',
}
for k, v in pairs(vim_opts) do
  vim.opt[k] = v
end

-- Remove Neovim tips menu
vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]])

vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_no_idle = true
vim.g.neovide_input_ime = true

-------------------------------------------------------------------------------
-- 3. Definition
-------------------------------------------------------------------------------

function map(mode, lhs, rhs, opts)
  opts = opts or {}
  if type(opts) == 'string' then opts = { desc = opts } end
  if opts.silent == nil then opts.silent = true end
  -- By default, all mappings are nonrecursive by default
  vim.keymap.set(mode, lhs, rhs, opts)
end

-------------------------------------------------------------------------------
-- 4. Plugins
--
-- UI
--   vscode.nvim
--   neo-tree.nvim
--     nui.nvim
--     plenary.nvim
-- Editor
--   which-key
--   nvim-cmp
--     cmp-nvim-lsp
--     cmp-buffer
--     cmp-cmdline
--     cmp-path
--     cmp-luasnip
--     LuaSnip
--     cmp-dictionary
--   nvim-treesitter
--   telescope.nvim
--     plenary.nvim
--     project.nvim
--   move.nvim
-- Coding
--   nvim-lspconfig
--     clangd_extensions.nvim
--   godbolt.nvim
--   fittencode.nvim
-------------------------------------------------------------------------------

require('lazy').setup({
  {
    'Mofiqul/vscode.nvim',
    config = function() require('vscode').load() end,
    lazy = false,
    priority = 1000,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>fe', function() require('neo-tree.command').execute({ toggle = true, dir = vim.lsp.buf.list_workspace_folders()[1] }) end, desc = 'Explorer NeoTree (cwd)' },
      { '<leader>fE', function() require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() }) end, desc = 'Explorer NeoTree (cwd)' },
      { '<leader>ge', function() require('neo-tree.command').execute({ source = 'git_status', toggle = true }) end, desc = 'Git explorer' },
      { '<leader>be', function() require('neo-tree.command').execute({ source = 'buffers', toggle = true }) end, desc = 'Buffer explorer' },
    },
    config = function()
      vim.cmd([[
        highlight NeoTreeWinSeparator guifg=#363636 ctermfg=235 guibg=#363636 ctermbg=235 gui=NONE cterm=NONE
      ]])
      require('neo-tree').setup({
        close_if_last_window = true,
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
      })
    end,
  },  
  {
    'folke/which-key.nvim',
    config = true,
  },
  {
    'hrsh7th/nvim-cmp',
    -- enabled = false,
    event = 'VeryLazy',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'uga-rosa/cmp-dictionary',
    },
    config = function()
      local cmp = require('cmp')
      -- For instance, you can set the `buffer`'s source `group_index` to a larger number
      -- if you don't want to see `buffer` source items while `nvim-lsp` source is available:
      local sources_presets = {
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'luasnip', group_index = 1 },
        { name = 'buffer', group_index = 1 },
        {
          name = 'dictionary',
          keyword_length = 4,
          group_index = 1,
        },
        { name = 'path', group_index = 1 },
      }
      local function _forward()
        return cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' })
      end
      local function _backward()
        return cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' })
      end
      local opts = {
        sources = sources_presets,
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        mapping = {
          ['<c-b>'] = cmp.mapping.scroll_docs(-4),
          ['<c-f>'] = cmp.mapping.scroll_docs(4),
          ['<up>'] = cmp.mapping.select_prev_item(),
          ['<down>'] = cmp.mapping.select_next_item(),
          ['<tab>'] = _forward(),
          ['<s-tab>'] = _backward(),
        },
      }
      cmp.setup(opts)

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } },
        }),
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      --[[
        sudo apt install aspell aspell-en        
        aspell -d en dump master | aspell -l en expand > words_aspell.txt
      ]]
      require('cmp_dictionary').setup({
        paths = { vim.fn.stdpath('config') .. '/runtime/words_aspell.txt' },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local path = vim.fn.stdpath('config') .. '/parsers'
      local opts = {
        highlight = { enable = true },
        indent = { enable = true },
        parser_install_dir = path,
        ensure_installed = {
          'bash',
          'c',
          'cmake',
          'cpp',
          'html',
          'java',
          'javascript',
          'json',
          'lua',
          'luadoc',
          'markdown_inline',
          'markdown', -- LSP Hover
          'python',
          'query', -- Neovim Treesitter Playground
          'regex',
          'rust',
          'toml',
          'typescript',
          'vim',
          'vimdoc',
          'yaml',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
      }
      require('nvim-treesitter.install').prefer_git = true
      vim.opt.runtimepath:append(path)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ahmedkhalf/project.nvim',
    },
    keys = {
      { '<leader>,', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', desc = 'Switch Buffer' },
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
      { '<leader>fd', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
      { '<leader>fi', '<cmd>Telescope lsp_implementations<cr>', desc = 'Implementations' },
      { '<leader>fs', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Workspace Symbols' },
      { '<leader>fD', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
      { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Find Files (git-files)' },
    },
    config = function()
      require('telescope').setup()
      require('project_nvim').setup()
      require('telescope').load_extension('projects')
    end,
  },
  {
    'fedepujol/move.nvim',
    cmd = { 'MoveLine', 'MoveBlock', 'MoveHChar', 'MoveHBlock' },
  },
  {
    'neovim/nvim-lspconfig',
    -- enabled = false,
    dependencies = {
      'p00f/clangd_extensions.nvim',
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.lsp.set_log_level('OFF')

      local diagnostics = {
        virtual_text = false,
        signs = false,
        float = {
          source = 'always',
        },
        update_in_insert = false,
        underline = {
          severity_limit = 'Error',
        },
        severity_sort = true,
        right_align = true,
      }
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostics)
      vim.diagnostic.config(diagnostics)

      local function on_attach(client, buffer)
        local function _opts(desc) return { buffer = buffer, desc = desc } end
        map('n', 'gl', '<cmd>lua vim.diagnostic.open_float({ border = "rounded", max_width = 100 })<cr>', _opts('Line Diagnostics'))
        map('n', 'K', vim.lsp.buf.hover, _opts('Hover'))
        map('n', 'gK', vim.lsp.buf.signature_help, _opts('Signature Help'))
        map('n', 'gn', vim.lsp.buf.rename, _opts('Rename'))
        map('n', 'gr', vim.lsp.buf.references, _opts('References'))
        map('n', 'gd', function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end, _opts('Goto Definition'))
        map({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, _opts('Code Action'))
        map('x', '<leader>cf', function() vim.lsp.buf.format({ bufnr = buffer, force = true }) end, _opts('Format Range'))
        map('n', '<leader>cf', function() vim.lsp.buf.format({ bufnr = buffer, force = true }) end, _opts('Format Document'))
        require('clangd_extensions.inlay_hints').setup_autocmd()
        require('clangd_extensions.inlay_hints').set_inlay_hints()
      end

      local servers = { 'clangd', 'lua_ls' }
      for _, name in ipairs(servers) do
        require('lspconfig')[name].setup({
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        })
      end
      require('clangd_extensions').setup()

      --[[
        Visual Assist X Dark
        #FFD700   Classes,structs, enums, interfaces, typedefs
        #BDB76B   variables
        #BD63C5   Preprocessor macros
        #B9771E   Enum members
        #FF8000   Functions / methods
        #B8D7A3   Namespaces
      ]]
      vim.cmd([[
        hi @lsp.type.namespace ctermfg=Yellow guifg=#BBBB00 cterm=none gui=none
        hi @lsp.type.type ctermfg=Yellow guifg=#FFD700 cterm=none gui=none
      ]])
    end,
  },  
  {
    'p00f/godbolt.nvim',
    cmd = { 'Godbolt' },
    config = function()
      local opts = {
        languages = {
          cpp = { compiler = 'clangdefault', options = {} },
          c = { compiler = 'cclangdefault', options = {} },
        }, -- vc2017_64
        url = 'http://localhost:10240', -- https://godbolt.org
        quickfix = {
          enable = false, -- whether to populate the quickfix list in case of errors
          auto_open = false, -- whether to open the quickfix list in case of errors
        },
      }
      require('godbolt').setup(opts)
    end,
  },
  {
    -- dir = "D:/Source/fittencode.nvim",
    dir = '/home/qx/DataCenter/onWorking/fittencode.nvim',
    config = function() require('fittencode').setup() end,
  },
}, {
  root = vim.fn.stdpath('config') .. '/lazy',
  dev = {
    path = 'D:/Source',
  },
})

-------------------------------------------------------------------------------
-- 5. Keymap
-------------------------------------------------------------------------------

map('n', '<leader>v', function() vim.cmd('e ' .. vim.fn.stdpath('config') .. '/init.lua') end, 'Edit init.lua')

-- M.map('n', ';', ':') -- BUG: don't show ':' sometimes
vim.cmd([[
  nnoremap ; :
  nnoremap : ;
  vnoremap ; :
  vnoremap : ;
]])

-- Better up/down
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Better move cursor
map('n', '<c-j>', '15gj', 'Move Down 15 Lines')
map('n', '<c-k>', '15gk', 'Move Up 15 Lines')
map('v', '<c-j>', '15gj', 'Move Down 15 Lines')
map('v', '<c-k>', '15gk', 'Move Up 15 Lines')

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Selection/ Move Lines
map('n', '<a-j>', '<cmd>MoveLine(1)<cr>', 'Line: Move Up (move.nvim)')
map('n', '<a-k>', '<cmd>MoveLine(-1)<cr>', 'Line: Move Down (move.nvim)')
map('n', '<a-h>', '<cmd>MoveHChar(-1)<cr>', 'Line: Move Left (move.nvim)')
map('n', '<a-l>', '<cmd>MoveHChar(1)<cr>', 'Line: Move Right (move.nvim)')
map('v', '<a-j>', ':MoveBlock(1)<cr>', 'Block: Move Up (move.nvim)')
map('v', '<a-k>', ':MoveBlock(-1)<cr>', 'Block: Move Down (move.nvim)')
map('v', '<a-h>', ':MoveHBlock(-1)<cr>', 'Block: Move Left (move.nvim)')
map('v', '<a-l>', ':MoveHBlock(1)<cr>', 'Block: Move Right (move.nvim)')

-- Better indenting
map('v', '<', '<gv', 'deIndent Continuously')
map('v', '>', '>gv', 'Indent Continuously')

-- Add undo break-points
map('i', '<cr>', '<cr><c-g>u')
map('i', ' ', ' <c-g>u')
map('i', ':', ':<c-g>u')
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '"', '"<c-g>u')
map('i', '(', '(<c-g>u')
map('i', '{', '{<c-g>u')
map('i', '/', '/<c-g>u')

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', 'Escape And Clear hlsearch')

-- Search word under cursor
map({ 'n', 'x' }, 'gw', '*N', 'Search word under cursor')

-------------------------------------------------------------------------------
-- 6. Autocmds
-------------------------------------------------------------------------------

