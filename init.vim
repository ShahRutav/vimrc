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
Plug 'tpope/vim-commentary'              " Comment toggling
Plug 'tpope/vim-fugitive'                " Git integration
Plug 'jpalardy/vim-slime'                " Send code to tmux
Plug 'airblade/vim-gitgutter'            " Git diff indicators
Plug 'folke/tokyonight.nvim'             " Tokyonight colorscheme

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
EOF

" Optional: Enable code folding using Treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable


" ======================= toggleterm.nvim =======================
lua <<EOF
require'toggleterm'.setup {
  size = 15,
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '0.2',
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = false,
  shell = vim.o.shell,
}
EOF
" Define a Lua function to toggle a terminal by ID
lua << EOF
function _G.toggle_n_term(term_id)
  vim.cmd("ToggleTerm " .. term_id)
end
EOF

" Loop to create key mappings for multiple terminals (1 to 10)
for i in range(1, 10)
  execute 'nnoremap <silent> <leader>t' . i . ' :lua toggle_n_term(' . i . ')<CR>'
endfor
autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>

" ======================= Copilot Settings =======================
lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF

" ======================= Telescope Settings =======================
noremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" ======================= Basic Settings ========================
set nocompatible             " Disable vi compatibility
" filetype on                  " Enable file type detection
" filetype plugin on           " Enable plugin loading for file types
" filetype indent on           " Enable indentation rules for file types
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
colorscheme tokyonight

" =================== Autocommands ====================
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
