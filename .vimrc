set nobackup
set noswapfile
set nocompatible " 不与vi兼容

set guifont=Consolas:h17:cANSI:qDRAFT
set number                  " 显示行号
set nowrap                  " 不自动换行，保持一行显示
set mouse=a               " 允许在 Vim 中使用鼠标
set cmdheight=1
set clipboard=unnamedplus

set backspace=indent,eol,start
set fileencoding=utf-8
set hlsearch
set shiftwidth=4
"set expandtab             " 使用空格代替 Tab

" 自动缩进和智能代码格式化
set tabstop=4
set shiftwidth=4
set expandtab            " 使用空格代替 Tab
set autoindent           " 自动缩进
set smartindent          " 启用智能缩进
set smarttab             " 在插入时使用智能 Tab

set termguicolors
set signcolumn=yes
set ignorecase            " 忽略大小写
set smartcase             " 启用智能大小写搜索
set splitright            " 右侧打开新窗口
set splitbelow            " 下方打开新窗口

" :set filetype=cpp

inoremap ' ''<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
map <C-A> ggVG"+y  "ctrl-A复制所有到剪贴板，(gvim)

" 保存文件并编译 C++ 程序并执行
function! CompileAndRun()
    " 保存文件
    write

    " 显示编译命令的输出
    echo "正在编译..."
    silent !g++ -g -O3 -std=c++23 -o .\main.exe %

    " 如果编译成功，则运行程序并等待按键后关闭 cmd 窗口
    if v:shell_error == 0
        echo "编译成功，运行程序..."
        silent !start cmd /c ".\main.exe && pause && exit"
    else
        echo "编译失败，请查看错误信息。"
    endif
endfunction

nmap <Space>r :call CompileAndRun()<CR>

" 在普通模式下，按 Ctrl + / 添加或去除单行注释
nnoremap <C-/> :call ToggleComment()<CR>

" 在插入模式下，按 Ctrl + / 添加或去除单行注释
inoremap <C-/> <Esc>:call ToggleComment()<CR>a

" 定义 ToggleComment 函数来判断并切换注释
function! ToggleComment()
    " 记录当前光标位置和当前模式
    let cursor_pos = getpos('.')
    let mode = mode()
    let line = getline('.')
      if line =~ '^\s*\/\/'
        execute 'normal! 0xx'
    else
        execute 'normal! 0i//'
    endif
    call setpos('.', cursor_pos)
    if mode ==# 'i'
        execute 'startinsert'
    endif
endfunction

" 启用语法高亮
syntax enable
filetype plugin indent on

let g:rehash256 = 1

highlight NonText guibg=#060606
highlight Folded guibg=#0A0A0A guifg=#9090D0

set t_Co=256
set background=dark

" login
map <C-L> :call SetTitle()<CR> 

func SetTitle()

let l = 0
let l = l + 1 | call setline(l, '#include <bits/stdc++.h>')
let l = l + 1 | call setline(l, 'using namespace std;')
let l = l + 1 | call setline(l, 'using ll = long long;')
let l = l + 1 | call setline(l, '//#define int ll')
let l = l + 1 | call setline(l, 'void solve() {')
let l = l + 1 | call setline(l, '')
let l = l + 1 | call setline(l, '}')
let l = l + 1 | call setline(l, '')
let l = l + 1 | call setline(l, 'signed main() {')
let l = l + 1 | call setline(l, '	ios::sync_with_stdio(false);')
let l = l + 1 | call setline(l, '	cin.tie(nullptr);')
let l = l + 1 | call setline(l, '	int T = 1; ')
let l = l + 1 | call setline(l, '	cin >> T;')
let l = l + 1 | call setline(l, '	while(T--) solve();')
let l = l + 1 | call setline(l, '	return 0;')
let l = l + 1 | call setline(l, '}')

endfunc
