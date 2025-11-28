-----------------------------------------------------------
-- Plugin manager: vim-plug (still works from init.lua)
-----------------------------------------------------------
vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

" Core plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'zbirenbaum/copilot.lua'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }

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
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'Vigemus/iron.nvim'

" avante
Plug 'yetone/avante.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

" transfer nvim
Plug 'coffebar/transfer.nvim'

call plug#end()
]]

----------------------- Avante setup ----------------------
require("avante").setup {
  provider = "openai",               -- Pick your model/provider
  instructions_file = "avante.md",   -- Optional: custom filename
}
vim.opt.laststatus = 3

----------------------- transfer.nvim setup ----------------------`
----- transfer.nvim setup
local ok, transfer = pcall(require, "transfer")
if ok then
  transfer.setup({})
end
-- Optional: keymaps for convenience
vim.keymap.set("n", "<leader>tu", "<cmd>TransferUpload<CR>",   { desc = "Transfer: upload" })
vim.keymap.set("n", "<leader>td", "<cmd>TransferDownload<CR>", { desc = "Transfer: download" })
vim.keymap.set("n", "<leader>ti", "<cmd>TransferInit<CR>",     { desc = "Transfer: init config" })



-----------------------------------------------------------
-- Basic settings
-----------------------------------------------------------
local opt = vim.opt

opt.termguicolors = true         -- 24-bit colors
opt.encoding = "utf-8"
opt.number = true                -- line numbers
opt.expandtab = true             -- spaces instead of tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.cursorline = true
opt.fillchars:append({ vert = "┃" })

-- Folds: start with all folds open, indent-based
opt.foldmethod = "indent"
opt.foldlevel = 99

-----------------------------------------------------------
-- Colorscheme & highlights
-----------------------------------------------------------
vim.cmd [[colorscheme tokyonight]]

-- Window separators and inactive window background
vim.cmd [[highlight WinSeparator guifg=#FFFFFF]]
vim.cmd [[highlight InactiveWindow guibg=#414868]]

-- Inactive window dimming via winhighlight
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local winhl_group = augroup("WinHighlightConfig", { clear = true })
autocmd("WinEnter", {
  group = winhl_group,
  pattern = "*",
  command = "setlocal winhighlight=Normal:Normal",
})
autocmd("WinLeave", {
  group = winhl_group,
  pattern = "*",
  command = "setlocal winhighlight=Normal:InactiveWindow",
})

-----------------------------------------------------------
-- Treesitter
-----------------------------------------------------------
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "python", "javascript", "html", "css" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}

-----------------------------------------------------------
-- Telescope keymaps
-----------------------------------------------------------
local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true, desc = "Telescope: Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { silent = true, desc = "Telescope: Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true, desc = "Telescope: Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true, desc = "Telescope: Help tags" })

-----------------------------------------------------------
-- NERDTree keymaps
-----------------------------------------------------------
map("n", "<leader>n", ":NERDTreeFocus<CR>", { silent = true })
map("n", "<C-n>", ":NERDTree<CR>", { silent = true })
map("n", "<C-t>", ":NERDTreeToggle<CR>", { silent = true })
map("n", "<C-f>", ":NERDTreeFind<CR>", { silent = true })

-----------------------------------------------------------
-- FZF
-----------------------------------------------------------
vim.g.fzf_colors = {
  fg      = { "white", "Normal" },
  bg      = { "black", "Normal" },
  hl      = { "yellow", "Comment" },
  ["fg+"] = { "white", "CursorLine", "CursorColumn", "Normal" },
  ["bg+"] = { "black", "CursorLine", "CursorColumn" },
  ["hl+"] = { "white", "Statement" },
  info    = { "white", "PreProc" },
  border  = { "white", "Ignore" },
  prompt  = { "white", "Conditional" },
  pointer = { "white", "Exception" },
  marker  = { "white", "Keyword" },
  spinner = { "white", "Label" },
  header  = { "white", "Comment" },
}

-- FZF buffer search
map("n", "<C-b>", ":Buffers<CR>", { silent = true })

-----------------------------------------------------------
-- Vim-Slime (tmux)
-----------------------------------------------------------
vim.g.slime_target = "tmux"
vim.g.slime_default_config = { socket_name = "default", target_pane = "1" }
vim.g.slime_bracketed_paste = 1

-----------------------------------------------------------
-- ALE
-----------------------------------------------------------
vim.g.ale_fixers = { python = { "pylint" } }
vim.g.ale_linters = { python = { "pylint" } }

-----------------------------------------------------------
-- VimTeX
-----------------------------------------------------------
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_automatic = 0

-- Mapping for italicizing text in LaTeX (visual selection -> \emph{})
-- This one is easier with a Vim command:
vim.cmd [[vnoremap <C-i> :s/\%V\(.\+\)\%V/\\emph{\1}/g<CR>]]

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-- Remove trailing whitespace on save
local trim_group = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = trim_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Map <Esc> to exit terminal mode
local term_group = augroup("TerminalConfig", { clear = true })
autocmd("TermOpen", {
  group = term_group,
  pattern = "*",
  callback = function()
    map("t", "<Esc>", [[<C-\><C-n>]], { buffer = true })
  end,
})

-- Auto-write on InsertLeave and TextChanged
local autosave_group = augroup("AutoSave", { clear = true })
autocmd({ "InsertLeave", "TextChanged" }, {
  group = autosave_group,
  pattern = "*",
  command = "silent! write",
})

-----------------------------------------------------------
-- CopilotChat settings
-----------------------------------------------------------
require("CopilotChat").setup {
  debug = true,
  -- add any extra config here
}

-- Quick chat mapping
map("n", "<leader>ccq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick chat" })

-- Telescope integrations for CopilotChat
local copilot_actions = require("CopilotChat.actions")
local copilot_tel = require("CopilotChat.integrations.telescope")

map("n", "<leader>cch", function()
  copilot_tel.pick(copilot_actions.help_actions())
end, { silent = true, desc = "CopilotChat - Help actions" })

map("n", "<leader>ccp", function()
  copilot_tel.pick(copilot_actions.prompt_actions())
end, { silent = true, desc = "CopilotChat - Prompt actions" })

map("n", "<leader>cc", ":CopilotChat<CR>", { silent = true, desc = "CopilotChat - Open" })
map("n", "<leader>cq", ":CopilotChatStop<CR>", { silent = true, desc = "CopilotChat - Stop" })

-----------------------------------------------------------
-- toggleterm.nvim
-----------------------------------------------------------
local colors = require("tokyonight.colors").setup()

require("toggleterm").setup {
  size = 20,
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 3,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = false,
  direction = "horizontal",
  close_on_exit = false,
  shell = vim.o.shell,
  highlights = {
    Normal = {
      guibg = colors.fg_gutter,
    },
  },
}

-- Global functions for toggleterm (horizontal / vertical)
function _G.toggle_n_term_horizontal(term_id)
  require("toggleterm.terminal").Terminal:new({
    id = term_id,
    direction = "horizontal",
  }):toggle()
end

function _G.toggle_n_term_vertical(term_id)
  require("toggleterm.terminal").Terminal:new({
    id = term_id,
    direction = "vertical",
  }):toggle()
end

-- Keymaps for horizontal & vertical terminals (1-9)
for i = 1, 9 do
  map("n", "<leader>th" .. i, function()
    _G.toggle_n_term_horizontal(i)
  end, { silent = true, desc = "Toggleterm horizontal " .. i })

  map("n", "<leader>tv" .. i, function()
    _G.toggle_n_term_vertical(i)
  end, { silent = true, desc = "Toggleterm vertical " .. i })
end

-----------------------------------------------------------
-- Disable g; and g, jump-to-older-changes mappings
-----------------------------------------------------------
map("n", "g;", "<Nop>")
map("n", "g,", "<Nop>")

-----------------------------------------------------------
-- Iron.nvim (REPL)
-----------------------------------------------------------
local view = require("iron.view")
local repl_open_cmd = view.split("40%")
local iron = require("iron.core")

iron.setup {
  config = {
    scratch_repl = true,
    repl_definition = {
      sh = {
        command = { "zsh" },
      },
      python = {
        command = { "ipython", "--no-autoindent" },
        format = require("iron.fts.common").bracketed_paste_python,
      },
    },
    repl_open_cmd = repl_open_cmd,
  },
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_paragraph = "<space>sp",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  highlight = {
    italic = true,
  },
  ignore_blank_lines = true,
}

map("n", "<space>rs", "<cmd>IronRepl<cr>")
map("n", "<space>rr", "<cmd>IronRestart<cr>")
map("n", "<space>rf", "<cmd>IronFocus<cr>")
map("n", "<space>rh", "<cmd>IronHide<cr>")
