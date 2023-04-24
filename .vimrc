call plug#begin()

Plug 'madox2/vim-ai' "ChatGPT with vim. Wohooo!
Plug 'dense-analysis/ale' " Ale plugin for linting
Plug 'github/copilot.vim' " Github pluging for copliot

call plug#end()

" remapping copilot keys ro Ctrl + J
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

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
syntax on
" Highlight cursor line underneath the cursor horizontally with only highlighting the number instead of full line.
hi CursorLineNr guifg=#af00af
set cursorline
set cursorlineopt=number
" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

set number
colorscheme delek
set tabstop=4
set expandtab

autocmd BufWritePre * :%s/\s\+$//e
