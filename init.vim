set t_Co=256
set termguicolors
set number

set modeline
set encoding=utf-8
set fileencodings=jso-2022-jp,euc-jp,sjis,utf-8

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set clipboard+=unnamedplus
set autoindent
set ignorecase
set nohlsearch
set foldmethod=indent
set foldlevel=1

tnoremap <ESC> <C-\><C-n>
nnoremap <Space>l $
nnoremap <Space>h ^
nnoremap <Space>p %
nnoremap <Space>vs :vsp<Enter>:term<Enter><C-w><C-x><C-w><C-l>A
"nnoremap <Space>vs :VimShell<Enter>
nnoremap <Space>vp :VimShellPop<Enter>
nnoremap <Space>vt :VimShellTab<Enter>
nnoremap <Space>u :Unite file<Enter>
nnoremap <Space>nt :NERDTree<Enter>
nnoremap '' ''zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <Space>B oimport pdb;pdb.set_trace()<ESC>
""inoremap { {}<LEFT>
""inoremap ( ()<LEFT>
""inoremap [ []<LEFT>
""inoremap " ""<LEFT>
""inoremap ' ''<LEFT>
inoremap <Tab> <C-n>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap ' 'zdi'<C-R>z'<ESC>
vnoremap " "zdi"<C-R>z"<ESC>

if &compatible
    set nocompatible
endif

set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('$HOME/.vim/dein/repos/github.com/Shougo/dein.vim')
    call dein#begin('$HOME/.vim/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/unite.vim')

    call dein#add('Shougo/deol.nvim', {'rev':'alb5108fb'})
    call dein#add('kassio/neoterm')
    call dein#add('thinca/vim-quickrun')
    "memo : add vimproc
    
    "NERDTree
    call dein#add('scrooloose/nerdtree')
    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

    "deoplete
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neco-vim')
    call dein#add('Shougo/neco-syntax')
    call dein#add('ujihisa/neco-look')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    "color
    call dein#add('tomasr/molokai')
    call dein#add('mechatroner/rainbow_csv')

    "fzf
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    "git tool
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    "error checker
    call dein#add('w0rp/ale')

    "Status Line
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    "many icons
    "requirement https://github.com/ryanoasis/nerd-fonts#font-installation
    call dein#add('ryanoasis/vim-devicons')
    
    "others
    call dein#add('tpope/vim-surround')
    call dein#add('Yggdroot/indentLine')
    call dein#add('simeji/winresizer')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('Lokaltog/vim-easymotion')


    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"NeoBundle 'Shougo/vimproc',{'build':{'unix':'make -f make_unix.mak', 'cygwin':'make -f make_cygwin.mak'}, }

"vim-fugitive
nnoremap <Space>gv :Gvdiff<CR>
nnoremap <Space>gs :Gstatus<CR>

"indentline
let g:indentLine_color_gui = '#ffffff'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "/<Plug>(neosnippet_expand_or_jump)" : "/<TAB>"

"airline
let g:airline_solarized_bg='dark'
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline_section_c = '%t'
let g:airline_section_x = '%{&filetype}'
let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
let g:airline#extensions#ale#error_symbol = ''
let g:airline#extensions#ale#warning_symbol = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1

"ale
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_lint_on_text_changed = 0
let g:ale_set_quickfix = 0
let g:ale_lint_on_enter = 0
function! s:ale_list()
    let g:ale_open_list = 1
    call ale#Queue(0, 'lint_file')
endfunction
command! ALEList call s:ale_list()
"display ale window
nnoremap <Space>a :ALEList<CR>
"hide ale window
nnoremap <Space>A :let g:ale_open_list = 0<CR>

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

"preview https://wonderwall.hatenablog.com/entry/2017/10/07/220000
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"deoplete setting
let g:python3_host_prog='$HOME/.pyenv/shims/python3'
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_smart_case=1
let g:deoplete#max_list=10
let g:deoplete#auto_complete_delay=0
let g:deoplete#auto_complete_start_length=1
"let g:neocomplcache_enable_underbar_completion=1
"let g:neocomplcache_min_syntax_length=3
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"let g:neocomplcache_filetype_lists={
"            \ 'default':'',
"            \ 'vimshell':$HOME.'/.vimshell_hist'
"            \}

"nerd-tree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = ''
let g:NERDTreeDirArrowCollapsible = '▼'
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

"easymotion http://haya14busa.com/mastering-vim-easymotion/
"map \ <Plug>(easymotion-prefix)
"map \ <Plug>(easymotion-s2)
map + <Plug>(easymotion-s2)
map <Space>s <Plug>(easymotion-s2)
map <Space>w <Plug>(easymotion-w)
map <Space>W <Plug>(easymotion-b)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

"devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ja'] = 'ﱲ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['enja'] = 'ﱲ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zhja'] = 'ﱲ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['en'] = 'ﳅ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jaen'] = 'ﳅ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zh'] = 'ﲽ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jazh'] = 'ﲽ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''

"winresizer [Space+e : start]
nnoremap <Space>e :WinResizerStartResize<CR>
let g:winresizer_horiz_resize = 1
let g:winresizer_vert_resize = 2

filetype plugin indent on
colorscheme molokai
syntax enable
