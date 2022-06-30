set t_Co=256
"set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set number
set cursorline
"highlight Cursor guifg=Gray guibg=Red

set modeline
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

set sh=zsh
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set clipboard+=unnamedplus
set autoindent
set ignorecase
set nohlsearch
set foldmethod=manual
"set foldlevel=2
set inccommand=split

tnoremap <ESC> <C-\><C-n>
map <Space>l $
map <Space>h ^
map <Space>p %
nnoremap <Space>vs :vsp<Enter>:term<Enter><C-w><C-x><C-w><C-l>A
nnoremap <Space>te :tabnew<Enter>:te<Enter>
nnoremap '' ''zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <Space>B oimport pdb;pdb.set_trace()<ESC>
inoremap <Tab> <C-n>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap ' 'zdi'<C-R>z'<ESC>
vnoremap " "zdi"<C-R>z"<ESC>

let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog=expand('$HOME/.pyenv/shims/python3')
let s:dein_config_dir =$XDG_CONFIG_HOME.'/nvim'
let s:dein_cache_dir =$XDG_CACHE_HOME.'/dein'

if &compatible
    set nocompatible
endif

set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)
    
    " deol
    call dein#add('Shougo/deol.nvim')

    "fzf
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    call dein#load_toml(s:dein_config_dir . '/dein.toml', {'lazy':0})
    call dein#load_toml(s:dein_config_dir . '/dein_lazy.toml', {'lazy':1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"fzf
nnoremap <Space>f :Files<Enter>
nnoremap <Space>b :History<Enter>
nnoremap <Space>z :Lines<Enter>
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
  
" https://maguro.dev/coc-pairs-cursor/
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"preview https://wonderwall.hatenablog.com/entry/2017/10/07/220000
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

filetype plugin indent on
syntax enable
colorscheme iceberg
