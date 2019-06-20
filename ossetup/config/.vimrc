" Kiba Amor<KibaAmor@gmail.com>
" https://github.com/KibaAmor/linuxconfig
" 20190303
" for vim 7.4
" when use tmux(screen always work not properly). use "tmux -2" instead of "tmux" to make colorscheme work fine.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" environment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" is windows
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" is gui
if has("gui_running")
    let g:isgui = 1
else
    let g:isgui = 0
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" environment fix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimdiff fix
if (g:iswindows && g:isgui)
    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let eq = ''
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          let cmd = '""' . $VIMRUNTIME . '\diff"'
          let eq = '"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" backspace fix
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" putty fix
" set 'Terminial->Keyboard->The Function keys and keypad' to 'Xterm R6'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable vim compatible mode
set nocompatible

" set how many lines of history vim has to remember
set history=512

" enable filetype detection
filetype on

" enable filetype plugins
filetype plugin on
filetype indent on

" enable true color
" set termguicolors

" set to auto read when a file is changed from the outside
set autoread
" set to auto write when edit other file
set autowrite

" share clipboard with windows
set clipboard+=unnamed

" enable mouse
if g:isgui
    set mouse=anv
endif

" set map leader
let mapleader = ","
let g:mapleader = ","

" better match
runtime macros/matchit.vim

" auto change directory to current editing file's directory
" autocmd BufRead,BufNewFile,BufEnter * cd %:p:h

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" don't use local version of .(g)vimrc, .exrc
set noexrc

" save the whole buffer for undo when reloading it.  This applies to the ":e!"
" command and reloading for when the buffer buffer changed outside of Vim.
v:vimrc>702 ? set undoreload=10000

" Compatible Options
set cpoptions=aABceFsmq
"             |||||||||
"             ||||||||`---- When joining lines, leave the cursor 
"             ||||||||      between joined lines
"             ||||||||
"             |||||||`----- When a new match is created (showmatch) 
"             |||||||       pause for .5
"             |||||||
"             ||||||`------ Set buffer options when entering the buffer
"             ||||||
"             |||||`------- :write command updates current file name
"             |||||
"             ||||`-------- Automatically add <CR> to the last line 
"             ||||          when using :@r
"             ||||
"             |||`--------- Searching continues at the end of the match 
"             |||           at the cursor position
"             |||
"             ||`---------- A backslash has no special meaning in
"             ||            mappings
"             ||
"             |`----------- :write updates alternative file name
"             |
"             `------------ :read updates alternative file name


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keywordprg(shift+k)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" perl file
autocmd FileType perl set keywordprg=perldoc\ -f
" c/c++ file
autocmd FileType c,cpp set keywordprg=man\ -S\ 2:3


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" useful shotcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fast saving
nmap <leader>w :w!<cr>

" fast fold
" nnoremap <C-space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nmap <leader>z @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" fast clear the space at the end of line
nmap cS :%s/\s\+$//g<cr>:noh<cr>
" fast clear '^M' at the end of line
nmap cM :%s/\r$//g<cr>:noh<cr>

" toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i
" inoremap { {<CR>}<Esc>O
" inoremap { {}<Esc>i

" inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
" inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
" inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

" inoremap <BS> <ESC>:call RemovePairs()<CR>a

function RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        silent execute "normal! l"
    else
        silent execute "normal! a" . a:char . ""
    end
endfunction

function RemovePairs()
    let l:line = getline(".")
    let l:previous_char = l:line[col(".")-1]

    if index(["(", "[", "{"], l:previous_char) == -1
        silent execute "normal! a\<BS>"
    else
        let l:original_pos = getpos(".")
        silent execute "normal %"
        let l:new_pos = getpos(".")

        if l:original_pos == l:new_pos
            silent execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            silent execute "normal! v%xa"
        else
            silent execute "normal! v%xi"
        end
    end
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" encoding, format and language
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the character encoding used inside vim
set encoding=utf-8

" set the character encoding for the current file
set fileencoding=utf-8

" the list of character encodings considered when starting to edit an 
" existing file
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

" end-of-line style
set fileformat=unix

" This gives the end-of-line (<EOL>) formats that will be tried when
" starting to edit a new buffer and when reading a file into an 
" existing buffer
set fileformats=unix,dos,mac

" encoding used for the terminal
set termencoding=utf-8

" gui menu language
if g:isgui
    set langmenu=zh_CN.utf-8
endif

" gui message language
if g:isgui
    language messages zh_CN.UTF-8
endif

" help language
set helplang=Cn


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set 6 lines to the cursor - when moving vertically using j/k
set scrolloff=6

" always show current postion
set ruler

" always show line number
set number

" show title
set title

" highlight search results
set hlsearch
" enable increase search
set incsearch
" try to be smart about cases when searching
set smartcase

" incomplete cmds displayed at bottom
set showcmd

" active mode displayed at bottom
set showmode

" show matching brackets when text indicator is over them
set showmatch
" how many tenths of a second to blink when matching brackets
set matchtime=6

" for regular expressions turn magic on
set magic

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" command window height
set cmdheight=2

" highlighting current line
set cursorline
" highlighting current column
"set cursorcolumn

" hide the welcome screen
set shortmess=atI

" unline charactor if there are to many characters one line(failed if version less or equal 7.0)
" autocmd BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 72 . 'v.\+', -1)

function MaximizeWindow()
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

" maximize window when start
if g:iswindows
  autocmd GUIEnter * simalt ~x
else
  autocmd GUIEnter * call MaximizeWindow()
endif

" show/hide menu, stat bar
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
map <silent> <F11> :if &guioptions =~# 'm' <Bar>
    \set guioptions-=m <Bar>
    \set guioptions-=T <Bar>
    \set guioptions-=r <Bar>
    \set guioptions-=L <Bar>
\else <Bar>
    \set guioptions+=m <Bar>
    \set guioptions+=T <Bar>
    \set guioptions+=r <Bar>
    \set guioptions+=L <Bar>
\endif<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" wild mode
set wildmode=list:longest

" enable the wild menu
" ctrl-n and ctrl-p to scroll through matches
set wildmenu

" stuff to ignore when tab completing
set wildignore=*~,*.pyc
set wildignore+=*.o,*.obj
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" always show status bar
set laststatus=2

" custom status bar
if 1
  let &statusline='%t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* CWD:%r%{getcwd()}%h %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
  " set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
else
  set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color and font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable syntax highlight
syntax on

" font
if g:iswindows
  set guifont=YaHei\ Consolas\ Hybrid:h12
else
  set guifont=YaHei\ Consolas\ Hybrid\ 12
endif

" colorscheme
if g:isgui && g:iswindows
  colorscheme lucius
else
  set t_Co=256
  colorscheme zenburn
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" backup and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make a back before overwriting a file, and delete it after success
set nobackup
set writebackup

" disable swap file
set noswapfile

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use space instead of tab
set expandtab

" 1 tab == 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" enable c style indent
set cindent
" enable auto indent
set autoindent
" enable smart indent
set smartindent

" backspace will delete a 'shiftwidth' worth of space at the start of 
" the line
set smarttab

" disable auto fold
set nofoldenable
" fold by indent
set foldmethod=indent
" deepest fold is 3 levels
set foldlevel=3

" Display tabs and trailing spaces visually
set list listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>
" Don not show default
autocmd BufRead,BufNewFile,BufEnter * exe ":set nolist"

" Don't wrap lines
set nowrap
" Wrap lines at convenient points
set linebreak


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" moving, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
" map <C-space> ?

" disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" opens a new tab with the current buffer's path
" super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" close the current buffer
map <leader>bd :Bclose<cr>

" close all the buffers
map <leader>ba :1,1000 bd!<cr>

" return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" remember info about open buffers on close
set viminfo^=%

" switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remap vim 0 to first non-blank character
map 0 ^

" move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" delete trailing white space on save, useful for Python and CoffeeScript
function DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunction
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

nmap <F7> :cn<cr>
nmap <F8> :cp<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" when you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" do :help cope if you are unsure what cope is. It's super useful!
"
" when you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" to go to the next search result do:
"   <leader>n
"
" to go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function HasPaste()
    if &paste
        return 'PASTE MODE  '
      endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command Bclose call <SID>BufcloseCloseIt()
function <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction






" plugin configuration

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" a.vim
" alternate files quickly (.c --> .h etc)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :A  switches to the header file corresponding to the current file 
"     being edited (or vise versa)
" :AS splits and switches
" :AV vertical splits and switches
" :AT new tab and switches
" :AN cycles through matches
" :IH switches to file under cursor
" :IHS splits and switches
" :IHV vertical splits and switches
" :IHT new tab and switches
" :IHN cycles through matches
" <Leader>ih switches to file under cursor
" <Leader>is switches to the alternate file of file under cursor 
"            (e.g. on  <foo.h> switches to foo.cpp)
" <Leader>ihn cycles through matches


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" press F2 to toggle
nmap <F2> :NERDTreeToggle<CR>

" open nerdtree automatically when vim starts up with no files
" autocmd vimenter * if !argc() | NERDTree | endif

" close vim if the only window left open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" make it beatifull
let NERDChristmasTree=1

" auto center
let NERDTreeAutoCenter=1

" set mouse mode
"   1: double-click open directory and file
"   2: single-click open directory and double-click open file
"   3: single-click open directory and file
let NERDTreeMouseMode=2

" show bookmarks
let NERDTreeShowBookmarks=1

" show files
let NERDTreeShowFiles=1

" show hidden files
"let NERDTreeShowHidden=1

" show line number
let NERDTreeShowLineNumbers=1

" window position 'left' or 'right'
let NERDTreeWinPos='left'

" window width
let NERDTreeWinSize=31

" show status line
let NERDTreeStatusline=1

" set bookmark file
if g:iswindows
  let NERDTreeBookmarksFile=$VIM.'\vimfiles\Data\NerdBookmarks.txt'
else
  let NERDTreeBookmarksFile=$VIM.'\.vim\Data\NerdBookmarks.txt'
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" press F3 to toggle
nmap <F3> :TagbarToggle<cr>

" ctags command
let g:tagbar_ctags_bin='ctags'

" window width
let g:tagbar_width=31

" show at left
let g:tagbar_left=1

" auto enable when open C/C++ file
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1 "在左注释符之后，右注释符之前留有空格


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimtweak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 这里只用于窗口透明与置顶
" 常规模式下 Shift + k 减小透明度，Shift + j 增加透明度，
"   Shift + t 窗口置顶与否切换
if (g:iswindows && g:isgui)
    let g:Current_Alpha = 250
    let g:Top_Most = 0
    function Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll", "SetAlpha", g:Current_Alpha)
    endfunction
    function Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll", "SetAlpha", g:Current_Alpha)
    endfunction
    function Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll", "EnableTopMost", 1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll", "EnableTopMost", 0)
            let g:Top_Most = 0
        endif
    endfunction
	
    " map <s-k> :call Alpha_add()<cr>
    " map <s-j> :call Alpha_sub()<cr>
    " map <s-t> :call Top_window()<cr>
	
    autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", g:Current_Alpha)
endif






" C/C++ development

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" compile, link and run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F5: save, compile and link
map <F5> :call Link()<CR>
imap <F5> <ESC>:call Link()<CR>

" F6: save, compile, link and run
map <F6> :call Run()<CR>
imap <F6> <ESC>:call Run()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -pg\ -O0\ -lc\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -pg\ -O0\ -lc\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -pg\ -O0\ -lc\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -pg\ -O0\ -lc\ %\ -o\ %<.o'

function Compile()
    exe ":ccl"
    exe ":update"
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:Sou_Error = 0
        let s:LastShellReturn_C = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        let v:statusmsg = ''
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunction

function Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    let s:LastShellReturn_L = 0
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
        let Exe_Name = expand("%:p:t:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
        let Exe_Name = expand("%:p:t:r")
    endif
    let v:statusmsg = ''
	if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
        redraw!
        if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " linking..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " linking..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_L = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_L != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " linking failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " linking successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " linking successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Exe_Name"is up to date"
        endif
    endif
    setlocal makeprg=make
endfunction

function Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    let Obj = expand("%:p:r").s:Obj_Extension
    if g:iswindows
        let Exe = expand("%:p:r").s:Exe_Extension
    else
        let Exe = expand("%:p:r")
    endif
    if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
        redraw!
        echohl WarningMsg | echo " running..."
        if g:iswindows
            exe ":!%<.exe"
        else
            if g:isgui
                exe ":!gnome-terminal -e ./%<"
            else
                exe ":!./%<"
            endif
        endif
        " redraw!
        " echohl WarningMsg | echo " running finish"
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  C/C++ file header
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-F4> :call AddCompanyTitle()<CR>
function AddCompanyTitle()
  call append(0, "////////////////////////////////////////////////////////////////////////")
  call append(1, "/// Copyright(C) " . strftime("%Y") . " Shadow Walker Co.,Ltd.")
  call append(2, "/// All rights reserved.")
  call append(3, "///")
  call append(4, "/// Filename: " . expand("%:t"))
  call append(5, "/// Author  : Kiba")
  call append(6, "/// Date    : " . strftime("%Y/%m/%d\ %H:%M:%S"))
  call append(7, "/// Desc    : ")
  call append(8, "////////////////////////////////////////////////////////////////////////")
endfunction

map <F4> :call AddPersonalTitle()<CR>
function AddPersonalTitle()
  call append(0, "////////////////////////////////////////////////////////////////////////")
  call append(1, "/// Copyright(C) " . strftime("%Y") . " Kiba Amor <KibaAmor@gmail.com>")
  call append(2, "/// All rights reserved.")
  call append(3, "///")
  call append(4, "/// Filename: " . expand("%:t"))
  call append(5, "/// Author  : Kiba")
  call append(6, "/// Date    : " . strftime("%Y/%m/%d\ %H:%M:%S"))
  call append(7, "/// Desc    : ")
  call append(8, "////////////////////////////////////////////////////////////////////////")
  " call append(3, " *")
  " call append(4, " * Redistribution and use in source and binary forms, with or without")
  " call append(5, " * modification, are permitted provided that the following conditions")
  " call append(6, " * are met:")
  " call append(7, " *")
  " call append(8, " *  * Redistributions of source code must retain the above copyright")
  " call append(9, " *    notice, this list ofconditions and the following disclaimer.")
  " call append(10," *")
  " call append(11," *  * Redistributions in binary form must reproduce the above copyright")
  " call append(12," *    notice, this list of conditions and the following disclaimer in")
  " call append(13," *    the documentation and/or other materialsprovided with the")
  " call append(14," *    distribution.")
  " call append(15," *")
  " call append(16," * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS")
  " call append(17," * \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT")
  " call append(18," * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS")
  " call append(19," * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE")
  " call append(20," * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,")
  " call append(21," * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,")
  " call append(22," * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;")
  " call append(23," * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER")
  " call append(24," * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT")
  " call append(25," * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN")
  " call append(26," * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE")
  " call append(27," * POSSIBILITY OF SUCH DAMAGE.")
  " call append(28," */")
endfunction
