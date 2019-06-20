" Kiba Amor<KibaAmor@gmail.com>
" https://github.com/KibaAmor/linuxconfig
" 20160818
"
" vim compile options
" ./configure --prefix=$HOME --with-features=huge --enable-luainterp=yes --enable-pythoninterp=yes --enable-cscope --enable-multibyte --enable-fontset --enable-gui=auto --with-luajit --with-modified-by=k --with-compiledby=k --with-python-config-dir=/usr/lib64/python2.6/config
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shotcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set map leader
let mapleader = ","
let g:mapleader = ","

nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<cr>
map <F4> :call AddPersonalTitle()<CR>
map <C-F4> :call AddCompanyTitle()<CR>

" F5: save, compile and link
map <F5> :call Link()<CR>
imap <F5> <ESC>:call Link()<CR>

" F6: save, compile, link and run
map <F6> :call Run()<CR>
imap <F6> <ESC>:call Run()<CR>

nmap <F7> :cn<cr>
nmap <F8> :cp<cr>

nmap <F9> :GundoToggle<CR>

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

map <F12> :call Do_CsTag()<CR>

" fast saving
nmap <leader>w :w!<cr>

" show all marks
nmap <leader>m :marks<cr>

" fast fold
" nnoremap <C-space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nmap <leader>z @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" fast clear the space at the end of line
nmap cS :%s/\s\+$//g<cr>:noh<cr>
" fast clear '^M' at the end of line
nmap cM :%s/\r$//g<cr>:noh<cr>

" toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" display tabs and trailing spaces visually
nmap <silent> <leader>s :set nolist!<CR>

" treat long lines as break lines (useful when moving around in them)
" map j gj
" map k gk

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
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" opens a new tab with the current buffer's path
" super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" close all except this
map <leader>bo :call DeleteAllBuffersInWindow()<CR>

" close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>

" switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

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

" spell checking
" pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" vim-signify
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nnoremap <leader>gr :SignifyRefresh<CR>
nnoremap <leader>gd :SignifyDebug<CR>

" unite
nnoremap <silent> <c-p> :Unite -no-split -auto-resize file file_rec buffer<cr>
nnoremap <silent> <c-o> :Unite -no-split -auto-resize outline<cr>

" cscope
" find this C symbol
nmap ccs :cs find s <C-R>=expand("<cword>")<CR><CR>
" find this definition
nmap ccg :cs find g <C-R>=expand("<cword>")<CR><CR>
" find functions calling this function
nmap ccc :cs find c <C-R>=expand("<cword>")<CR><CR>
" find assignments to
nmap cct :cs find t <C-R>=expand("<cword>")<CR><CR>
" find this egrep pattern
nmap cce :cs find e <C-R>=expand("<cword>")<CR><CR>
" find this file
nmap ccf :cs find f <C-R>=expand("<cfile>")<CR><CR>
" find files #including this file
nmap cci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" find functions called by this function
"nmap ccd :cs find d <C-R>=expand("<cword>")<CR><CR>

" EasyGrep
" <Leader>vv Grep for the word under the cursor, match all occurences, like |gstar|
" <Leader>vV Grep for the word under the cursor, match whole word, like |star|
" <Leader>va Like vv, but add to existing list
" <Leader>vA Like vV, but add to existing list
" <Leader>vr Perform a global search search on the word under the cursor and prompt for a pattern with which to replace it.
" <Leader>vo Select the files to search in and set grep options

" The-NERD-Commenter
" Most of the following mappings are for normal/visual mode only. The |NERDComInsertComment| mapping is for insert mode only
" [count]<leader>cc |NERDComComment|
" Comment out the current line or text selected in visual mode.
" 
" [count]<leader>cn |NERDComNestedComment|
" Same as <leader>cc but forces nesting. 
" 
" [count]<leader>c<space> |NERDComToggleComment|
" Toggles the comment state of the selected line(s). If the topmost selected 
" line is commented, all selected lines are uncommented and vice versa. 
" 
" [count]<leader>cm |NERDComMinimalComment|
" Comments the given lines using only one set of multipart delimiters. 
" 
" [count]<leader>ci |NERDComInvertComment|
" Toggles the comment state of the selected line(s) individually. 
" 
" [count]<leader>cs |NERDComSexyComment|
" Comments out the selected lines ``sexily'' 
" 
" [count]<leader>cy |NERDComYankComment|
" Same as <leader>cc except that the commented line(s) are yanked first. 
" 
" <leader>c$ |NERDComEOLComment|
" Comments the current line from the cursor to the end of line. 
" 
" <leader>cA |NERDComAppendComment|
" Adds comment delimiters to the end of line and goes into insert mode between 
" them. 
" 
" |NERDComInsertComment|
" Adds comment delimiters at the current cursor position and inserts between. 
" Disabled by default. 
" 
" <leader>ca |NERDComAltDelim|
" Switches to the alternative set of delimiters. 
" 
" [count]<leader>cl
" [count]<leader>cb    |NERDComAlignedComment|
" Same as |NERDComComment| except that the delimiters are aligned down the 
" left side (<leader>cl) or both sides (<leader>cb). 
"
" [count]<leader>cu |NERDComUncommentLine|
" Uncomments the selected line(s).



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
set termguicolors

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

" run command ':verbose set timeoutlen?' in vim to see change history
set timeoutlen=2000
set ttimeout



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keywordprg(shift+k)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" perl file
autocmd FileType perl set keywordprg=perldoc\ -f
" c/c++ file
autocmd FileType c,cpp set keywordprg=man\ -S\ 2:3



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

if g:iswindows
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim 
endif



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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe



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
    set guifont=YaHei\ Consolas:h12
else
    set guifont=YaHei\ Consolas\ 12
endif

" colorscheme
" if g:isgui && g:iswindows
"   colorscheme lucius
" else
"   set t_Co=256
"   colorscheme zenburn
" endif



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
    set undolevels=1024
    set undoreload=10240
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

" display tabs and trailing spaces visually
set list listchars=tab:>-,trail:.,eol:$
" don not show default
autocmd BufRead,BufNewFile,BufEnter * exe ":set nolist"

" Don't wrap lines
set nowrap
" Wrap lines at convenient points
set linebreak



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" moving, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
" remember info about open buffers on close
set viminfo^=%

" specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delete trailing white space on save, useful for Python and CoffeeScript
function DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()



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



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
if g:iswindows
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'altercation/vim-colors-solarized'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'luochen1990/rainbow'
Plugin 'majutsushi/tagbar'
Plugin 'mbbill/fencview'
Plugin 'mhinz/vim-signify'
Plugin 'mhinz/vim-startify'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/unite-help'
Plugin 'Shougo/unite-outline'
Plugin 'Shougo/unite.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'a.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'EasyGrep'
Plugin 'L9'
Plugin 'matchit.zip'
Plugin 'The-NERD-Commenter'
Plugin 'xml.vim'
Plugin 'fencview.vim'
if !g:iswindows
    Plugin 'The-NERD-tree'
    Plugin 'Yggdroot/indentLine'
    Plugin 'Rip-Rip/clang_complete'
endif
" Bundle 'OmniCppComplete' 
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-colors-solarized'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme solarized



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags command
let g:tagbar_ctags_bin='ctags'

" window width
let g:tagbar_width=31

" show at left
let g:tagbar_left=1

" auto enable when open C/C++ file
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-signify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_disable_by_default    = 1
let g:signify_vcs_list              = [ 'git', 'hg' ]



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neosnippet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('file_rec/async','sorters','sorter_rank', )
" replacing unite with ctrl-p
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='? '
let g:unite_split_rule = 'botright'
if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
let g:gundo_preview_bottom = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-speeddating
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <C-A> to increase date
" <C-X> to decrease date



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_enabled = 1
" Vim
let g:indentLine_color_term = 239
" GVim
let g:indentLine_color_gui = '#A4E57E'

" none X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

let g:indentLine_char = '┆'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" a.vim
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
" cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use both cscope and ctag
set cscopetag

" Show msg when cscope db added
set cscopeverbose

" Use tags for definition search first
set cscopetagorder=1

" Use quickfix window to show cscope results
" set cscopequickfix=s-,c-,d-,i-,t-,e-

if has("cscope")
    " add any database in current directory
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    elseif filereadable("../cscope.out")
        cs add ../cscope.out
    elseif filereadable("../../cscope.out")
        cs add ../../cscope.out
    elseif filereadable("../../../cscope.out")
        cs add ../../../cscope.out
    elseif filereadable("../../../../cscope.out")
        cs add ../../../../cscope.out
    elseif filereadable("../../../../../cscope.out")
        cs add ../../../../../cscope.out
    elseif filereadable("../../../../../../cscope.out")
        cs add ../../../../../../cscope.out
    endif
    set csverb
endif

function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if g:iswindows
            let tagsdeleted = delete(dir."\\"."tags")
        else
            let tagsdeleted = delete("./"."tags")
        endif
        if tagsdeleted
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if g:iswindows
            let csfilesdeleted = delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted = delete("./"."cscope.files")
        endif
        if csfilesdeleted
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if g:iswindows
            let csoutdeleted = delete(dir."\\"."cscope.out")
        else
            let csoutdeleted = delete("./"."cscope.out")
        endif
        if csoutdeleted
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if executable('ctags')
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        " silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $(pwd)"
        silent! execute "!ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q $(pwd)"
    endif
    if executable('cscope') && has("cscope")
        if g:iswindows
            silent! execute "!dir /s/b *.h,*.hh,*.hpp,*.inl,*.c,*.cc,*.cpp,*.cxx,*.cs > cscope.files"
        else
            silent! execute "!find $(pwd) -regextype 'egrep' -regex '.*\.[h|hh|hpp|inl|c|cc|cpp|cxx|cs]$' -type f -print > cscope.files"
        endif
        silent! execute "!cscope -Rbkq"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DoxygenToolkit.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:doxygen_enhanced_color               = 1
let g:DoxygenToolkit_authorName            = "KibaAmor <KibaAmor@gmail.com>"
let g:DoxygenToolkit_authorTag             = "@Author  : "
let g:DoxygenToolkit_blockFooter           = "-----------------------------------------------------------------------"
let g:DoxygenToolkit_blockHeader           = "-----------------------------------------------------------------------"
let g:DoxygenToolkit_briefTag_funcName     = "yes"
let g:DoxygenToolkit_briefTag_pre          = "@Desc    : "
let g:DoxygenToolkit_commentType           = "C++"
let g:DoxygenToolkit_dateTag               = "@Date    : "
let g:DoxygenToolkit_fileTag               = "@Filename: "
let g:DoxygenToolkit_licenseTag            = "Copyright(C) \<enter>"
let g:DoxygenToolkit_licenseTag            = g:DoxygenToolkit_licenseTag . "All rights reserved.\<enter>"
let g:DoxygenToolkit_maxFunctionProtoLines = 30
let g:DoxygenToolkit_paramTag_pre          = "@Param   : "
let g:DoxygenToolkit_returnTag             = "@Return  : "
let g:DoxygenToolkit_undocTag              = "DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_versionTag            = "@Version : "



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyGrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyGrepMode           = 3 " all:0, open buffers:1, trackext:2, usermode:3
let g:EasyGrepCommand        = 1 " use vimgrep:0, grepprg:1
if g:iswindows
    let g:EasyGrepCommand = 0
endif
let g:EasyGrepRecursive      = 1 " recursive searching
let g:EasyGrepHidden         = 1 " searching hidden file
let g:EasyGrepIgnoreCase     = 1 " not ignorecase:0
let g:EasyGrepAllOptionsInExplorer = 1 " show all options
let g:EasyGrepFilesToExclude = "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak"
let g:EasyGrepDefaultUserPattern = "*.h *.hh *.hpp *.inl *.c *.cc *.cpp *.cxx *.cs *.lua *.conf *.cf *.cfg *.config *.ini *.diff *.rej *.patch *.php *.pl *.PL  *.py *.pyw *.sql *.sqlj *.msql *.mysql *.pls *.plsql *.zsql *.sh *.bash *.ksh *.tcsh *.cmd *.bat *.txt *.inf *.INF *.vim .vimrc .gvimrc *.vba .exrc _exrc *.module *.pkg *.xml"



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The-NERD-Commenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDSpaceDelims = 1 "在左注释符之后，右注释符之前留有空格



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The-NERD-Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" vimtweak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 这里只用于窗口透明与置顶
" 常规模式下 Shift + k 减小透明度，Shift + j 增加透明度，
"   Shift + t 窗口置顶与否切换
if (g:iswindows && g:isgui && 0)
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



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

let g:rainbow_operators = 2
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}


    
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fencview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !g:iswindows
    let g:fencview_autodetect = 1
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufexplorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function DeleteAllBuffersInWindow() 
    let s:curWinNr = winnr()
    if winbufnr(s:curWinNr) == 1
        ret
    endif
    let s:curBufNr = bufnr("%")
    exe "bn"
    let s:nextBufNr = bufnr("%")
    while s:nextBufNr != s:curBufNr
        exe "bn"
        exe "bdel ".s:nextBufNr
        let s:nextBufNr = bufnr("%")
    endwhile
endfunction



" C/C++ development
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" compile, link and run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
