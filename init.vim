"-- SYSTEM --
let g:python3_host_prog = "C:/Python37/python"

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
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'ervandew/supertab'

call plug#end()
"-----------------
"-- PLUGINS END --
"-----------------

"-- MOUSE SUPPORT --
:set mouse=a

"-- COLOR SCHEME --
syntax on
colorscheme desert

"-- INDENTATION --
set expandtab
set shiftwidth=4
set softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

"-- PASTE FROM SYSTEM CLIPBOARD --
set clipboard+=unnamedplus

"-- FILE EXPLORER --
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

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
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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
nmap <leader>d <Plug>(ale_fix)
let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }

