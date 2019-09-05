"-- SYSTEM --
if has('win32')
  let g:python3_host_prog = 'C:/Python37/python'
elseif has('mac')
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

set relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set termguicolors

nmap <Leader>c :term cmd.exe /k "C:\\tools\\cmder\\vendor\\init.bat"<CR>

" -- MOVE BETWEEN WINDOWS --
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

"-- MOUSE SUPPORT --
:set mouse=a

"-- COLOR SCHEME --
syntax on
colorscheme desert

"-- LINE NUMBER --
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=#515252 guibg=NONE

"-- INDENTATION --
set expandtab
set shiftwidth=4
set softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"-- PASTE FROM SYSTEM CLIPBOARD --
set clipboard+=unnamedplus

"-------------
"-- PLUGINS --
call plug#begin()

"-- ale --
Plug 'w0rp/ale'

"-- deoplete --
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'markomannux/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ervandew/supertab'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/confirm-quit'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'leafgarland/typescript-vim'
Plug 'dbeniamine/todo.txt-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-obsession'

call plug#end()
"-----------------
"-- PLUGINS END --
"-----------------

"--------------------
"-- AUTOCOMPLETION --
"--------------------
filetype plugin on

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_auto_close_preview = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose! | endif

highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  "enable keyboard shortcuts
  let g:tern_map_keys=1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"-- super TAB completion
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"------------------------
"-- AUTOCOMPLETION END --
"------------------------

"-- ALE plugin configuration --
" see https://medium.com/@alexlafroscia/writing-js-in-vim-4c971a95fd49
nmap <leader>d <Plug>(ale_fix)
let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }
let g:ale_sign_error = '>'
let g:ale_sign_warning = '*'

"-- LIGHTLINE --
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"-- FZF --
" use ag as default search command for fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

nnoremap <Leader>; :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>t :Tags<CR>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" -- Gutentag --
let g:gutentags_project_root = ['.cproject']
let g:gutentags_add_default_project_roots=0

" -- EasyAlign -- 
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" -- Terminal mode --
tnoremap <Esc> <C-\><C-n>
autocmd! TermOpen term://*FZF tnoremap <silent> <buffer> <esc> <C-c>

" -- Todo mode
au filetype todo setlocal omnifunc=todo#Complete
" Auto complete projects
au filetype todo imap <buffer> + +<C-X><C-O>

" Auto complete contexts
au filetype todo imap <buffer> @ @<C-X><C-O>

inoremap {<CR> {<CR>}<esc>O<tab>
inoremap [<CR> [<CR>]<esc>O<tab>
inoremap {<space> {}<c-o>i
inoremap [<space> []<c-o>i
inoremap (<space> ()<c-o>i
