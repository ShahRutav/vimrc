" Initialize vim-plug plugin manager
call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

" Plugin List
Plug 'dense-analysis/ale'                " ALE for linting
Plug 'github/copilot.vim'                " GitHub Copilot plugin
Plug 'lervag/vimtex'                     " VimTeX for LaTeX support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF binary install
Plug 'junegunn/fzf.vim'                  " FZF Vim integration
Plug 'nordtheme/vim'                     " Nord colorscheme
Plug 'preservim/nerdtree'                " NERDTree for file navigation
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'tpope/vim-commentary'              " Comment toggling
Plug 'tpope/vim-fugitive'                " Git integration
Plug 'jpalardy/vim-slime'                " Send code to tmux
Plug 'airblade/vim-gitgutter'            " Git diff indicators
Plug 'folke/tokyonight.nvim'             " Tokyonight colorscheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }


" Initialize plugins
call plug#end()

" ----------------------- Plugin Settings -----------------------
" ======================= nvim-treesitter =======================
" Treesitter setup
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "javascript", "html", "css" },  -- Add desired languages
  highlight = {
    enable = true,              -- Enable syntax highlighting
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true               -- Enable Treesitter-based indentation
  }
}
local ok, context = pcall(require, 'treesitter-context')
if ok then
  context.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    multiwindow = false, -- Enable multiwindow support.
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  }
else
  vim.api.nvim_err_writeln("treesitter-context not found. Please install it.")
end
EOF

" Optional: Enable code folding using Treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable


" ======================= Copilot Settings =======================
lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
vim.keymap.set("n", "<leader>ccq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick chat" })
EOF

" Map <leader>cch to CopilotChat help actions
lua << EOF
vim.api.nvim_set_keymap('n', '<leader>cch', [[<cmd>lua require("CopilotChat.integrations.telescope").pick(require("CopilotChat.actions").help_actions())<CR>]], { noremap = true, silent = true, desc = "CopilotChat - Help actions" })

vim.api.nvim_set_keymap('n', '<leader>ccp', [[<cmd>lua require("CopilotChat.integrations.telescope").pick(require("CopilotChat.actions").prompt_actions())<CR>]], { noremap = true, silent = true, desc = "CopilotChat - Prompt actions" })

vim.api.nvim_set_keymap('n', '<leader>cc', ':CopilotChat<CR>', { noremap = true, silent = true })   -- Open Copilot chat
vim.api.nvim_set_keymap('n', '<leader>cq', ':CopilotChatStop<CR>', { noremap = true, silent = true })   -- Quit Copilot chat

EOF



" ======================= Telescope Settings =======================
noremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" ======================= Basic Settings ========================
set nocompatible             " Disable vi compatibility
filetype on                  " Enable file type detection
filetype plugin on           " Enable plugin loading for file types
filetype indent on           " Enable indentation rules for file types
set signcolumn=auto

" syntax on                    " Enable syntax highlighting
set termguicolors            " Enable 24-bit RGB color
set encoding=utf8            " Set encoding to UTF-8
set number                   " Show line numbers
set expandtab                " Use spaces instead of tabs
set tabstop=4                " Set tab width to 4 spaces
set shiftwidth=4             " Indent with 4 spaces
set cursorline               " Highlight the current line

" ===================== Key Mappings =====================
" NERDTree key mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" FZF buffer search
nnoremap <silent> <C-b> :Buffers<CR>

" Vim-Slime settings for tmux
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
let g:slime_bracketed_paste = 1

" ALE settings
let g:ale_fixers = {'python': ['pylint']}
let g:ale_linters = {'python': ['pylint']}
let g:ale_python_pylint_options = '--disable=all --enable=E'

" =================== Copilot Settings ====================
" Remap Copilot accept to Ctrl + J
inoremap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" =================== VimTeX Settings ====================
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_automatic = 0

" Mapping for italicizing text in LaTeX
vnoremap <C-i> :s/\%V\(.\+\)\%V/\\emph{\1}/g<CR>

" =================== FZF Colors ====================
let g:fzf_colors = {
  \ 'fg':      ['white', 'Normal'],
  \ 'bg':      ['black', 'Normal'],
  \ 'hl':      ['yellow', 'Comment'],
  \ 'fg+':     ['white', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['black', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['white', 'Statement'],
  \ 'info':    ['white', 'PreProc'],
  \ 'border':  ['white', 'Ignore'],
  \ 'prompt':  ['white', 'Conditional'],
  \ 'pointer': ['white', 'Exception'],
  \ 'marker':  ['white', 'Keyword'],
  \ 'spinner': ['white', 'Label'],
  \ 'header':  ['white', 'Comment'] }

" =================== Colorscheme ====================
" colorscheme polar  " Use the polar colorscheme
" colorscheme catppuccin
colorscheme tokyonight

highlight WinSeparator guifg=#FFFFFF
" Define a transparent highlight group

" Apply the highlight to inactive windows
autocmd WinEnter * setlocal winhighlight=Normal:Normal
autocmd WinLeave * setlocal winhighlight=Normal:InactiveWindow

set fillchars+=vert:\┃



" =================== Autocommands ====================
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


" ======================= toggleterm.nvim =======================
" make the background of toggleterm transparent
" print all the colors available in lua script after local colors
" print(vim.inspect(colors))
lua <<EOF
local colors = require("tokyonight.colors").setup()
require'toggleterm'.setup {
  size = 20,
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 3,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'horizontal',  -- Default direction
  close_on_exit = false,
  shell = vim.o.shell,
  highlights = {
    Normal = {
      guibg = colors.fg_gutter,
    }
  }
}
EOF

" highlight InactiveWindow guibg w.r.t. to tokynight colorscheme
highlight InactiveWindow guibg=#414868

" Define Lua functions to toggle terminals horizontally or vertically
lua <<EOF
function _G.toggle_n_term_horizontal(term_id)
  require('toggleterm.terminal').Terminal:new({ id = term_id, direction = 'horizontal' }):toggle()
end

function _G.toggle_n_term_vertical(term_id)
  require('toggleterm.terminal').Terminal:new({ id = term_id, direction = 'vertical' }):toggle()
end
EOF

" Create key mappings for horizontal terminal toggles (1 to 10)
for i in range(1, 10)
  execute 'nnoremap <silent> <leader>th' . i . ' :lua toggle_n_term_horizontal(' . i . ')<CR>'
endfor

" Create key mappings for vertical terminal toggles (1 to 10)
for i in range(1, 10)
  execute 'nnoremap <silent> <leader>tv' . i . ' :lua toggle_n_term_vertical(' . i . ')<CR>'
endfor

" Map <Esc> to exit terminal mode
autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
autocmd InsertLeave,TextChanged * silent! write

" Set fold method (options: manual, indent, expr, marker, syntax)
set foldmethod=indent

" Set fold level to start with all folds open
set foldlevel=99
