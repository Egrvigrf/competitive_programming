set guifont=Consolas:h17:cANSI:qDRAFT
set number
" set relativenumber 相对数字禁用
set nowrap                " 不自动换行，保持一行显示
set mouse=a               " 允许在 Vim 中使用鼠标
set cmdheight=2
set clipboard=unnamedplus
set cursorline
set fileencoding=utf-8
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab             " 使用空格代替 Tab
set autoindent
set termguicolors
set signcolumn=yes
set ignorecase            " 忽略大小写
set smartcase             " 启用智能大小写搜索
set splitright            " 右侧打开新窗口
set splitbelow            " 下方打开新窗口
set nobackup
set noswapfile
"  启用语法高亮
syntax enable
filetype plugin indent on
" :set filetype=cpp
" 保存文件并编译 C++ 程序并执行
nmap <Space>r :w<CR>:!g++ -g -O3 -std=c++23 -o %:h/main % && %:h/main<CR>

inoremap ' ''<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i
map <C-A> ggVG"+y  "ctrl-A复制所有到剪贴板，(gvim)


let g:rehash256 = 1


highlight NonText guibg=#060606

highlight Folded guibg=#0A0A0A guifg=#9090D0

set t_Co=256

set background=dark

map <F2> :call SetTitle()<CR> 

func SetTitle()

let l = 0
let l = l + 1 | call setline(l, '#include <bits/stdc++.h>')
let l = l + 1 | call setline(l, 'using namespace std;')
let l = l + 1 | call setline(l, 'using ll = long long;')
let l = l + 1 | call setline(l, '')
let l = l + 1 | call setline(l, 'signed main(){')
let l = l + 1 | call setline(l, '    cin.tie(nullptr)->ios::sync_with_stdio(false);')
let l = l + 1 | call setline(l, '')
let l = l + 1 | call setline(l, '    return 0;')
let l = l + 1 | call setline(l, '}')

endfunc


