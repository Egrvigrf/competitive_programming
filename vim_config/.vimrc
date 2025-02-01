set nocp " nocompatible
syn on " syntax
set nu " number
set ts=4 sw=4 " tabstop shiftwidth
set ai cin " autoindent & cindent

au BufNewFile *.cpp -r C:\template.cpp 
set nobackup
set noswapfile
set nocompatible " 不与vi兼容


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

" 保存文件并编译 C++ 程序并执行（powershell）
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

nnoremap <C-/> :call ToggleComment()<CR>

inoremap <C-/> <Esc>:call ToggleComment()<CR>a

function! ToggleComment()
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

syntax enable
filetype plugin indent on

let g:rehash256 = 1

highlight NonText guibg=#060606
highlight Folded guibg=#0A0A0A guifg=#9090D0

set t_Co=256
set background=dark
"set guifont=Consolas:h17:cANSI:qDRAFT
set guifont=Fira_Code:h14 " set font (comes with windows: Consolas
set bs=indent,eol,start " fix backsapce error
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar




