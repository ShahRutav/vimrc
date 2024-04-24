call plug#begin()

Plug 'madox2/vim-ai' "ChatGPT with vim. Wohooo!
Plug 'dense-analysis/ale' " Ale plugin for linting
Plug 'github/copilot.vim' " Github pluging for copliot
Plug 'lervag/vimtex' " Vimtex plugin for latex
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nordtheme/vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'jupyter-vim/jupyter-vim'
Plug 'tpope/vim-fugitive'
Plug 'jpalardy/vim-slime'
Plug 'airblade/vim-gitgutter'
Plug 'habamax/vim-polar'

call plug#end()

" ======================= vim-slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
" let g:slime_python_ipython = 1
let g:slime_bracketed_paste = 1

" ======================= jupyter-vim
vmap <leader>jr :JupyterSendRange<CR>
nnoremap <leader>rf :JupyterRunFile<CR>
nnoremap <leader>im :PythonImportThisFile<CR>

"======================= FZF

let $FZF_DEFAULT_OPTS = '--color=preview-bg:234'
let g:fzf_colors =
\ { 'fg':      ['white', 'Normal'],
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
"========================== Embark theme

" ======================= NERDTREE
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeFileLines = 1

" ======================= VIMTEX
set encoding=utf8
let g:vimtex_view_method = 'zathura'
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_automatic = 0
" adding a shortcute of italic. Ctrl + i
vnoremap <C-i> :s/\%V\(.\+\)\%V/\\emph{\1}/g<CR>


" ======================= COPILOT
" remapping copilot keys ro Ctrl + J
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" ======================= VIM-AI: GPT4
" complete text on the current line or in visual selection
nnoremap <leader>a :AI<CR>
xnoremap <leader>a :AI<CR>
" edit text with a custom prompt
xnoremap <leader>s :AIEdit fix grammar and spelling<CR>
nnoremap <leader>s :AIEdit fix grammar and spelling<CR>
" trigger chat
xnoremap <leader>c :AIChat<CR>
nnoremap <leader>c :AIChat<CR>
" redo last AI command
nnoremap <leader>r :AIRedo<CR>

" ======================= ALE
" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['pylint']
" let g:ale_linters = {'python': ['pylint']}
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
" let g:ale_completion_enabled = 1

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Load an indent file for the detected file type.
filetype indent on
" Turn syntax highlighting on.
filetype plugin indent on
syntax on
" Highlight cursor line underneath the cursor horizontally with only highlighting the number instead of full line.
set cursorline
" Set the color of highlighted cursor line.
set cursorlineopt=number
" set cursor color to white

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

set number
set tabstop=4
set termguicolors
colorscheme polar
" colorscheme nord
" set background=dark
set expandtab

autocmd BufWritePre * :%s/\s\+$//e
