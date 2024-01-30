" vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般的设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $VIMRUNTIME/mswin.vim
behave mswin

set nocp
set hidden

syntax enable
filetype plugin indent on

set cursorline          " 高亮当前行
" set lines=24 columns=120    " 35行，160列
set clipboard=unnamedplus
set scrolloff=3         " cursor 接近 buffer 顶部和底部时会尽量保持 3 行的距离
set showmatch           " 输入代码时高亮显示匹配的括号
set matchtime=5         " 匹配括号时高亮的时间。500ms
set showmode            " 当前 NVIM 的模式
set showcmd             " 在非 : 模式下输入的 command 会显示在状态栏
set ruler               " 状态栏右下角始终显示当前 cursor 位置和滚动比例
set nu                  " 显示行号
set ignorecase          " 一般情况大小写不敏感搜索
set smartcase           " 如果搜索时使用了大写，则自动对大小写敏感
" set autoindent          " 新的一行保持和上一行一样的 indent
" set cindent             " 标准 C 代码风格的动态 indent,
set cinoptions+=g0
set smarttab            " 根据文件整体情况来决定 tab 是几个 space
set bs=indent,eol,start " 让 backspace 可以删除很多种间隔

" set tabstop=2           " 一个 tab 等于多少 space
" set shiftwidth=2        " 一级 indent 是多少 space
" set softtabstop=2       " 按一次 del 或者 backspace 时，应该删除多少个 space
set et ts=4 sts=4 sw=4

set shiftround          " 自动 indent 应该是 shiftwidth 的整数倍
set expandtab           " tab 转换成 space, 不出现制表字符
" set textwidth=80        " 文件固定宽度为 80 个字符
" set colorcolumn=+1      " 显示偏移了 N 个字符宽度的 textwidth 界线（80+1）
set laststatus=2        " 始终显示状态栏
set cmdheight=1         " command-line 的行数
set fileformat=unix     " 默认的文件行末尾格式 unix
set fileformats=unix,dos,mac   " 依次检测文件格式： unix, dos, mac
set hidden              " 即使 buffer 被改变还没保存，也允许其隐藏
set history=100         " 搜索和 command 的历史
set undolevels=100      " 很多的 undo
set autoread            " 自动加载在外部被改变的文件
set foldlevelstart=99   " 默认打开所有的 folds
set whichwrap+=<,>,h,l  " 让 backspace， cursor 移动时可以跨行
set shortmess=atI       " 减少启动时画面显示的东西
set noswapfile          " 停止备份，swap，undo 文件
set nobackup
" set noundofile
set noerrorbells visualbell t_vb=   " 关闭所有的 bells, visual
set nohlsearch          " 搜索时不高亮, 特别是新的 buffer 里直接按 n
set incsearch           " 键入时高亮
set gdefault            " search/replace global
" set regexpengine=1      " 新的正则表达式引擎，在 NVIM 中设置始终有效
set wildmenu            " 开启 command 补齐
set wildmode=list:longest,full  " 列出所有最长子串的补齐，和其他完整的匹配
set completeopt=menu,menuone,longest " 关闭 preview 窗口
set path+=/usr/lib/gcc/**/include " 包括 gcc 多个版本的库
set path+=** " 递归上向查找. 比如打开 #include 文件
set tags=./tags;/       " 递归上向查找tags文件

" 设置打开文件的编码格式
" set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" set fileencoding=utf-8
set enc=utf-8           " Unicode 和中文支持
set fencs=utf-8,ucs-bom,euc-jp,shift-jis,gb18030,gbk,gb2312,cp936

set langmenu=en_US
let $LANG= 'en_US'

" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim

" set guifontwide=YaHei\ Consolas\ Hybrid:h14 "
set guifont=NotoSansM\ Nerd\ Font\ Mono\ 14

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Optionally reset the cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

autocmd FileType lua setlocal shiftwidth=2 tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 主要的键盘 Map 设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","   " 设置 <leader> 为 space, 默认是\
noremap <leader>e :e! $MYVIMRC<CR>   " 打开 .nvimrc
nnoremap <leader>v :execute 'Vex %:p:h'<CR>
nnoremap <leader>b :execute 'e %:p:h'<CR>
nnoremap <leader>u :execute ':set fileencoding=utf-8'<CR> "文件编码转换为 utf-8

" 用 ; 代替 : 不用去按 Shift 了。受这个的影响就不要用简单的 map : 了
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" 用 j, k 循环补齐列表
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" ctrl-j, ctrl-k 每次跳转15行
noremap <c-j> 15gj
noremap <c-k> 15gk

" 创建普通、终端的窗口，TODO: 还没找到合适的键
noremap <c-n> :vert topleft new<CR>
" noremap <c-m> :vert topleft new \| te<CR>

" Window/buffer 的切换
" tnoremap <Esc> <C-\><C-n>
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-h> <c-w>h
nnoremap <a-l> <c-w>l
vnoremap <a-j> <c-\><c-n><c-w>j
vnoremap <a-k> <c-\><c-n><c-w>k
vnoremap <a-h> <c-\><c-n><c-w>h
vnoremap <a-l> <c-\><c-n><c-w>l
inoremap <a-j> <c-\><c-n><c-w>j
inoremap <a-k> <c-\><c-n><c-w>k
inoremap <a-h> <c-\><c-n><c-w>h
inoremap <a-l> <c-\><c-n><c-w>l
cnoremap <a-j> <c-\><c-n><c-w>j
cnoremap <a-k> <c-\><c-n><c-w>k
cnoremap <a-h> <c-\><c-n><c-w>h
cnoremap <a-l> <c-\><c-n><c-w>l

" Shift+Insert will paste from system buffer (Control+C)
cmap <S-Insert>     <C-R>+
exe 'inoremap <script> <S-Insert>' paste#paste_cmd['i']

" CTRL+S saves the buffer
nmap <C-s> :w<CR>

" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>
vnoremap <S-Tab> <<

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color Scheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256            " 让 NVIM 在终端中显示 256 色
" colorscheme atom-dark-256   " 设置主题 atom-dark-256
" set background=dark     " 可以让终端亮一些

" Vim color file
"
" Author: Federico Ramirez
" https://github.com/gosukiwi/vim-atom-dark
"
" Note: Based on the Monokai theme variation by Tomas Restrepo
" https://github.com/tomasr/molokai

hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="atom-dark"

hi Boolean         guifg=#99CC99
hi Character       guifg=#A8FF60
hi Number          guifg=#99CC99
hi String          guifg=#A8FF60
hi Conditional     guifg=#92C5F7               gui=none
hi Constant        guifg=#99CC99               gui=none
hi Cursor          guifg=#F1F1F1 guibg=#777777
hi iCursor         guifg=#F1F1F1 guibg=#777777
hi Debug           guifg=#BCA3A3               gui=none
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=none

hi Directory       guifg=#AAAAAA               gui=none
hi Error           guifg=#A8FF60 guibg=#1E0010
hi ErrorMsg        guifg=#92C5F7 guibg=#232526 gui=none
hi Exception       guifg=#DAD085               gui=none
hi Float           guifg=#99CC99
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#DAD085
hi Identifier      guifg=#B6B7EB
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#92C5F7               gui=none
hi Label           guifg=#A8FF60               gui=none
hi Macro           guifg=#C4BE89               gui=none
hi SpecialKey      guifg=#66D9EF               gui=none

hi MatchParen      guifg=#B7B9B8 guibg=#444444 gui=none
hi ModeMsg         guifg=#A8FF60
hi MoreMsg         guifg=#A8FF60
hi Operator        guifg=#92C5F7

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#DAD085               gui=none
hi PreProc         guifg=#DAD085
hi Question        guifg=#66D9EF
hi Repeat          guifg=#92C5F7               gui=none
hi Search          guifg=#000000 guibg=#B4EC85
" marks
hi SignColumn      guifg=#DAD085 guibg=#232526
hi SpecialChar     guifg=#92C5F7               gui=none
hi SpecialComment  guifg=#7C7C7C               gui=none
hi Special         guifg=#66D9EF guibg=bg      gui=none
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#92C5F7               gui=none
hi StatusLine      guifg=#455354 guibg=fg      gui=none
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#B6B7EB               gui=none
hi Structure       guifg=#66D9EF
hi Tag             guifg=#92C5F7               gui=none
hi Title           guifg=#B6B7EB               gui=none
hi Todo            guifg=#FFFFFF guibg=bg      gui=none

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=#1D1F21 guibg=#1D1F21
hi TabLine         guibg=#1D1F21 guifg=#808080 gui=none

hi Normal          guifg=#F8F8F2 guibg=#1D1F21
hi Comment         guifg=#7C7C7C
hi CursorLine                    guibg=#293739
hi CursorLineNr    guifg=#B6B7EB               gui=none
hi CursorColumn                  guibg=#293739
hi ColorColumn     guifg=#B62323 guibg=#232526
hi LineNr          guifg=#465457 guibg=#232526
hi NonText         guifg=#465457
hi SpecialKey      guifg=#465457

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark

