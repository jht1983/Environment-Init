set nocompatible            " nocp " turn off vi-compatible-mode
if(has("win32") || has("win64"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif
autocmd!
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/github-theme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/taglist.vim'     " 提供单个源代码文件的函数列表之类的功能
Plugin 'majutsushi/tagbar'           " 相对 TagList 能更好的支持面向对象
Plugin 'scrooloose/nerdtree'         " NERD_tree 提供展示文件/目录列表的功能
Plugin 'Xuyuanp/nerdtree-git-plugin' " 基于 NERDTree 的可以展示 git status 的插件
Plugin 'fholgado/minibufexpl.vim'    " 多 buffer 时, 在编辑器上方显示 buffer 的标签
Plugin 'Yggdroot/indentLine'         " 缩进线
Plugin 'scrooloose/nerdcommenter'    " 提供快速注释/反注释代码块的功能
Plugin 'octol/vim-cpp-enhanced-highlight'    " C++ 语法高亮
call vundle#end()
filetype plugin indent on   " 使插件能使用
set expandtab               " et    " 用空格替换<tab>
set smarttab                " sta   " 插入<tab>时使用'shiftwidt'
set tabstop=4               " ts
set shiftwidth=4            " sw
set softtabstop=4           " sts
set cindent                 " cin   " 实现C程序的缩进
set cino=:0,g0,t0,(s,us     " 设定 C/C++ 风格自动缩进的选项
set autoindent              " ai    " 使用自动对齐, 也就是把当前行的对齐格式应用到下一行
set smartindent             " si    " 设置 cindent 时无效
set copyindent              " ####
set mouse=a                 " 始终用鼠标
set selection=inclusive
set selectmode=mouse,key
set whichwrap=b,s,h,l,<,>,[,]
set backspace=2             " 允许在插入模式下可以使用<BS>删除任意字符  " 使退格键正常处理indent, eol, start等
set showmatch               " 设置匹配模式, 类似当输入一个左括号时会匹配相应的那个右括号
set matchtime=2             " 匹配括号高亮的时间（单位是0.2s）
set report=0                " 使用:commands时命令, 告诉我们文件的哪一行被改变过
set autochdir               " 自动切换当前目录为当前文件所在的目录
set autoread                " 文件在外部改变时, 自动更新
set autowrite               " 自动写回
set nobackup                " 覆盖文件时不备份
set confirm                 " 在处理未保存或只读文件的时候, 弹出确认
set history=100             " 记录历史的行数
set clipboard+=unnamed      " 共享剪贴板
set viminfo+=!,<500         " 保存全局变量
syntax on                   " 允许用指定语法高亮配色方案替换默认方案
set t_Co=256
set shortmess=atI           " 启动的时候不显示那个援助乌干达儿童的提示
set helplang=cn
set number                  " nu " 显示行号
set cursorline              " 突出显示当前行
set scrolloff=3             " 光标移动到buffer的顶部和底部时保持3行距离
set sidescrolloff=7         " 在 wrap 置位时, 光标与列边缘保持7列距离
set showcmd                 " 输入的命令显示, 出来的清楚些
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,extends:$,precedes:$
set foldmethod=syntax       " 代码折叠
set foldlevel=4             " 启动vim时自动折叠代码的层数
set hlsearch                " hls   " 高亮搜索
set incsearch               " is    " 在输入要搜索的文字时, 实时匹配
set ignorecase              " 搜索时忽略大小写
set smartcase               " 但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan              " 禁止在搜索到文件两端时重新搜索
set fileformats=unix
set encoding=utf-8          " 设置编码为中文
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb18030,big5,euc-jp,euc-kr,latin1 " 设置编码的自动识别。
set termencoding=utf-8
if(iswindows)
    set langmenu=zh_CN.UTF-8    " 使用中文菜单及UTF-8编码, 没有这句, 在非UTF-8的系统, 如Windows, 用了UTF-8的encoding后菜单会乱码
    language messages zh_CN.utf-8   " 使用中文提示信息及UTF-8编码, 没有这句, 在非UTF-8的系统, 如Windows, 用了UTF-8的encoding 后系统提示会乱码
endif
set laststatus=2            " 显示状态栏 (默认值为 1, 无法一直显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %0(%{&encoding}\ %c:%l/%L%)\ [%p%%]\    " 设置在状态行显示的信息
if (has("gui_running"))
    set guioptions+=emgTbh  " 见 help
    "colorscheme github      " 越下面的主题我越喜欢
    "colorscheme desert
    "let g:molokai_original = 1
    "colorscheme molokai     " molokai 仅适用于 dark
    "set background=dark     " 对 GUI, solarized 主题亮暗都漂亮
    set background=light
    colorscheme solarized
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 11.5
    set guitablabel=%M\ %t
    set mousemodel=popup    " 当右键单击窗口的时候, 弹出快捷菜单。
    set nowrap              " 指定不折行。使用图形界面, 指定不折行视觉效果会好得多
    set sidescrolloff=5     " Keep 5 columns at the size
    " 全屏开/关快捷键       " 需要安装wmctl
    "map <silent> <F11> :call call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
else
    "colorscheme github      " 越下面的主题我越喜欢
    colorscheme ron
    let g:rehash256 = 1
    let g:molokai_original = 1
    "colorscheme molokai
    set wrap
    set linebreak           " 不在单词中间断行
endif
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
au FileType make   setlocal noexpandtab
au BufRead,BufNewFile .vimrc nnoremap cC :%s/^".*$//g<CR>
au BufRead,BufNewFile *.proto set filetype=proto
au BufNewFile *.{cpp,[ch],cc,py,rb,sh} silent 0r ~/.vim/skel/Template.%:e | normal G
au BufNewFile *.{cpp,[ch],cc,java} call SetTitle()
map <A-F12> :call SetTitle()<CR>
fun! SetTitle()
    call append(0,"// > Last Update:   ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(1,"// *****************************************")
    call append(2,"// > File Name:     ".expand("%"))
    call append(3,"// > Author:        will_lijiecheng")
    call append(4,"// > Mail:          ljclg_1516@foxmail.com")
    call append(5,"// > Created Time:  ".strftime("%Y-%m-%d %H:%M:%S"))
    call append(6,"// *****************************************")
    call append(7,"// > Description:   ")
endf
au BufWritePre,FileWritePre *.{cpp,cc,[ch],java} ks | silent call LastMod() | 's
fun! LastMod()
    if line("$") > 20
        let l = 20
    else
        let l = line("$")
    endif
    exe "1," . l . "g/Last Update: /s/Last Update: .*/Last Update:   ".strftime("%Y-%m-%d %H:%M:%S")
endf
let mapleader = "\\"
imap <C-e> <ESC>
nmap lA    0
nmap lE    $
nmap qq    %
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
func! ClosePair(char)   " 处理手动输入一对结对符的情况
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
map  <C-a> ggVG$"+y
map  <C-x> "+x
map  <C-c> "+y
map  <C-v> "+gP
imap <C-v> <Esc>l"+gPi
map  <C-z> u
imap <C-z> <Esc>ui
map  <C-y> <C-R>
imap <C-y> <Esc><C-R>i
nnoremap <A-Up>   ddkP
inoremap <A-Up>   <Esc>ddkPi
nnoremap <A-Down> ddp
inoremap <A-Down> <Esc>ddpi
nnoremap tT  :retab<CR>
nnoremap cS  :%s/\s\+$//g<CR>
nnoremap cM  :%s/\r\+$//g<CR>
nnoremap cL  :g/^\s*$/d<CR>
nnoremap cll :g/^\s*$\n\s*$/d<CR>
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
map <F5> :call Compile_Run()<CR>
fun! Compile_Run()
    exe "w"
    if &filetype == 'c'
        exe "make"
        exe "!time ./%<"
    elseif &filetype == 'cpp'
        exe "!g++ % -o %<"
        exe "!time ./%<"
    elseif &filetype == 'java'
        exe "!javac %"
        exe "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exe "!time python %"
    elseif &filetype == 'html'
        exe "!firefox % &"
    elseif &filetype == 'mkd' "########
        exe "!~/.vim/markdown.pl % > %.html &"
        exe "!firefox %.html &"
    endif
endf
au FileType c,cpp map <buffer> <F7> :w<CR>:make<CR>
map <F12> :call FormartSrc()<CR><CR>
fun! FormartSrc()  " 需要 install astyle&autopep8##########
    exe "w"
    if &filetype == 'c'
        exe "r !astyle --style=ansi -a --suffix=none %> /var/tmp/null 2>&1"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exe "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /var/tmp/null 2>&1"
    elseif &filetype == 'perl'
        exe "r !astyle --style=gnu --suffix=none %> /var/tmp/null 2>&1"
    elseif &filetype == 'py'||&filetype == 'python'
        exe "r !autopep8 -i --aggressive %> /var/tmp/null 2>&1"
    elseif &filetype == 'java'
        exe "r !astyle --style=java --suffix=none %> /var/tmp/null 2>&1"
    elseif &filetype == 'jsp'
        exe "r !astyle --style=gnu --suffix=none %> /var/tmp/null 2>&1"
    elseif &filetype == 'xml'
        exe "r !astyle --style=gnu --suffix=none %> /var/tmp/null 2>&1"
    else
        exe "normal gg=G"
        return
    endif
    exe "e! %"
endf
map  <F3> :TagbarClose<CR>:TlistToggle<CR>
imap <F3> <ESC>:TagbarClose<CR>:TlistToggle<CR>
map  <F4> :TlistClose<CR>:TagbarToggle<CR>
imap <F4> <Esc>:TlistClose<CR>:TagbarToggle<CR>
map  <F6> :!ctags -R --c++-kinds=+p+l+x --fields=+liaS --extra=+q .<CR><CR> :cs -Rbq<CR><CR> :cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>:TlistUpdate<CR>
imap <F6> <ESC>:!ctags -R --c++-kinds=+p+l+x --fields=+liaS --extra=+q .<CR><CR> :cs -Rbq<CR><CR> :cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>:TlistUpdate<CR>
map  <F9> :NERDTreeToggle<CR>
imap <F9> <ESC>:NERDTreeToggle<CR>
set tags=tags;                          " 设置 tags
set tags+=~/OpenSrc/linux-*/tags        " 表示在搜寻 tags 文件的时候, 也要搜寻 ~/OpenSrc/linux-*/ 文件夹下的tags文件
set tags+=~/OpenSrc/glibc-*/tags        " 表示在搜寻 tags 文件的时候, 也要搜寻 ~/OpenSrc/glibc-*/ 文件夹下的tags文件
set tags+=~/OpenSrc/libcxx-*/tags       " 表示在搜寻 tags 文件的时候, 也要搜寻 ~/OpenSrc/libcxx-*/ 文件夹下的tags文件
set tags+=~/OpenSrc/libcxxabi-*/tags    " 表示在搜寻 tags 文件的时候, 也要搜寻 ~/OpenSrc/libcxxabi-*/ 文件夹下的tags文件
let g:Tlist_Ctags_Cmd = 'ctags'         " 因为 ctags 已经加入 PATH
let g:Tlist_Auto_Open = 0               " 不默认打开 Taglist
let g:Tlist_Compart_Format = 1          " 压缩方式
let g:Tlist_Enable_Fold_Column = 1      " 显示折叠树
let g:Tlist_Exit_OnlyWindow = 1         " 如果 taglist 窗口是最后一个窗口, 则退出 vim
let g:Tlist_File_Fold_Auto_Close = 1    " 不自动折叠
let g:Tlist_Sort_Type = "order"         " sort by order(出现顺序排序) 在 Tlist buffer 按 s 切换 sort by order or name
let g:Tlist_Show_One_File = 1           " 不同时显示多个文件的 tag, 只显示当前文件的
let g:Tlist_Use_Right_Window = 1        " 在右侧显示窗口
let g:Tlist_WinWidth = 30               " 设置窗口宽度
let g:tagbar_ctags_bin = 'ctags'        " ctags 程序的路径
let g:tagbar_autopreview = 1
let g:tagbar_autoshowtag = 1            " 光标下的标签自动展开折叠
let g:tagbar_compact = 1                " 不显示 help
let g:tagbar_foldlevel = 2              " 自动折叠 2 层以上
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_sort = 0                   " sort by order(出现顺序排序) 在 Tagbar buffer 按 s 切换 sort by order or name
let g:tagbar_previewwin_pos = "aboveleft"
let g:tagbar_width = 30                 " 设置窗口宽度
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:0:1',
        \ 'p:prototypes:0:1',
        \ 'c:classes:0:1',
        \ 's:structs:0:1',
        \ 'u:unions:0:1',
        \ 'g:enums:0:1',
        \ 'e:enumerators:0:1',
        \ 't:typedefs:0:1',
        \ 'n:namespaces:0:1',
        \ 'f:functions:0:1',
        \ 'm:members:0:1',
        \ 'v:global:0:1',
        \ 'l:local:0:1',
        \ 'x:external:0:1'
    \ ],
\ }
 "当打开 vim 且没有文件时自动打开 NERDTree, ###只剩 NERDTree 时自动关闭(sth wrong)
au VimEnter * if !argc() | NERDTree | endif
au BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeChDirMode = 1
let g:NERDTreeMouseMode = 1
let g:NERDTreeMinimalUI = 1             " 不显示冗余帮助信息
let g:NERDTreeShowHidden = 1            " 显示隐藏文件
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeWinSize = 30
let g:NERDTreeIgnore=['\~$', '\tmp', '\.git', '\.svn', '\.swo', '\.swp', '\.dsp', '\.opt', '\.exe', '\.dll', '\.so', '\.o', '\.obj', '\.pyc', '\.pyo', '\.zip', '\.png', '\.jpg', '\.gif', '\.pdf']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
let g:miniBufExplCycleArround = 1       " buffer 跳转到头就循环开始
noremap <C-w> <C-w>w
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l
noremap <C-Tab> :MBEbn<CR>
noremap <S-Tab> :MBEbp<CR>
map <Leader>b :MBEToggle<CR>
let g:indentLine_char = '¦'
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_color_term = 145
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_color_tty_light = 6
let g:indentLine_color_tty_dark = 1
if has("cscope")
    set csto=0                              " 优先搜索cscope, 后tag
    set cscopetag                           " 同时搜索cscope数据库和标签文件, 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopequickfix=s-,c-,d-,i-,t-,e-    " 设定可以使用 quickfix 窗口来查看 cscope 结果
    set nocsverb
    if filereadable("cscope.out")           " 在当前目录中添加任何数据库
        cs add ./cscope.out .
    elseif $CSCOPE_DB != ""                 " 否则添加数据库环境中所指出的
        cs add $CSCOPE_DB
    endif
    set csverb
    set cspc=3
    " 将:cs find c|d|e|f|g|i|s|t name 等Cscope查找命令映射为<C-\>c等快捷键（按法是先按Ctrl+\, 然后很快再按下c）
    nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <Leader>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
endif
let g:NERDDefaultNesting = 0        " 不自动循环注释
let g:NERDLPlace = ""
let g:NERDRPlace = ""
let g:NERDCreateDefaultMappings = 0 " 取消默认的映射
map <C-_> <plug>NERDCommenterToggle
map <S-c> <plug>NERDCommenterSexy
map <C-\> <plug>NERDCommenterComment
imap <C-\> <ESC><plug>NERDCommenterComment i
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
set wildmenu                            " 命令行的自动补全, vim自己的功能
set wildignore+=*~,*/tmp/*,*\\tmp\\*,*.swo,*.swp,*.exe,*.dll,*.so,*.o,*.obj,*.pyc,*.pyo,*.zip,*.png,*.jpg,*.gif,*.pdf  " ignore some formats
set completeopt=longest,menu,preview    " 补全设置########## -preview?
