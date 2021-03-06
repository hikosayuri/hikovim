
" Hiko Customized {

"======================
" vundle scope
"======================
" Vundle
set nocompatible             " not compatible with the old-fashion vi mode

filetype off                 " required!

""
"" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
"" Setting up Vundle - the vim plugin bundler
"let iCanHazVundle=1
"let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
"if !filereadable(vundle_readme)
"  echo "Installing Vundle.."
"  echo ""
"  silent !mkdir -p ~/.vim/bundle
"  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
"  let iCanHazVundle=0
"endif
"
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"
"" let Vundle manage Vundle
"" " required!
"Bundle 'gmarik/vundle'
""
"" My Bundles here:
""
"" original repos on github
"Bundle 'Lokaltog/vim-easymotion'
""Bundle 'Lokaltog/vim-powerline'
""Bundle 'airblade/vim-gitgutter'
""Bundle "MarcWeber/vim-addon-mw-utils"
""Bundle "tomtom/tlib_vim"
""Bundle 'Townk/vim-autoclose'
""Bundle 'kien/ctrlp.vim'
""Bundle 'scrooloose/nerdtree'
""Bundle 'majutsushi/tagbar'
""Bundle 'tomtom/tcomment_vim'
""Bundle 'tpope/vim-fugitive'
""Bundle 'honza/vim-snippets'
""Bundle 'garbas/vim-snipmate'





"======================
" others than vundle
"======================

"======================
" Checking the OS
"======================
function! IsGvim()
    if has("gui_running")
        return 1
    else
        return 0
    endif
endfunction
function! IsWindows()
    if has("win32")
        return 1
    else
        return 0
    endif
endfunction

"=============================
" the color printing relative
"=============================
syntax enable

set encoding=utf-8 "set this encoding for macOS or NERDTree will fail to open folder
"set fileencoding=utf-8

set backspace=indent,eol,start "this can be using back key normally in which the terminal didn't have it

"color scheme theme
"colo evening
"colorscheme darkblue
"colorscheme ir_black
"colorscheme macvim
colorscheme hiko_color

highlight StatusLine cterm=bold ctermfg=darkred ctermbg=white guifg=darkblue guibg=olivedrab

"has been set in back of the script
set background=dark
set hlsearch
set tabstop=4
set expandtab
"set noexpandtab "inverse of expandtab
"the auto indent width
set shiftwidth=4
syntax on
"set nocompatible

"cursor
set cursorline
"set cursorcolumn

set ignorecase
set history=400
set number
set nowrap
set incsearch
set hidden
if IsWindows()
    "set guifont=Fixedsys:h11 "for windows
    set guifont=Monaco:h10 "if Monaco font installed
endif
if IsGvim()
    "set guifont=Fixedsys:h11 "for windows
    set guifont=Monaco:h10 "if Monaco font installed
endif


"set mouse=a/i/n
"a: all
"i: insert
"n: normal
"set mouse-=n
set mouse=n

"setting up the line folding fucntion
"set foldenable
set nofoldenable
"the line folding depens on which method
set foldmethod=syntax

"highlight the bracket symbol
set showmatch

"about more info, check :help fold.txt out

"the auto indent function like folding
set autoindent

"set the default vim-airline-themes color"
"see doc/airline.txt
let g:airline_theme = 'cool'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_splits = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_sep = '▶'
if IsGvim()
    let g:airline_left_sep='>'
    let g:airline_right_sep='<'
else
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    "let g:airline_symbols.branch = ''
    "let g:airline_symbols.readonly = ''
    "let g:airline_symbols.linenr = '☰'
    "let g:airline_symbols.maxlinenr = ''
endif


" Show trailing whitespace and spaces before a tab
" and show tabs that are not at the start of a line:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t\| [^\t]\zs\t\+/

" show tab in file
set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«
set list

"" functio block
""checking the current operation environmens
"function! IsGvim()
"    if has("gui_running")
"        return 1
"    else
"        return 0
"    endif
"endfunction
"function! IsWindows()
"    if has("win32")
"        return 1
"    else
"        return 0
"    endif
"endfunction
"
"filetype plugin on
"if IsWindows()
"    set fileencodings=gb2312,utf8,latin1
"else
"    set fileencodings=utf8,gb2312,latin1
"endif

"set backup
"set backupext=.bak


"set the leading keyword
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"the sessionoption can deside which session can be saved
"ie: blank,buffers,curdir,folds,help,options,tabpages,winsize
"set sessionoptions+=

"Save Project
nmap <leader>sp :call SaveProject()<CR>
"Save Project and exit
nmap <leader>spe :call SaveProject_Exit()<CR>
"Load Project
nmap <leader>lp :call LoadProject()<CR>
function! LoadProject()
    cd %:h
    let g:prj_dir=expand("%:p:h")
    so session.vim
    rviminfo viminfo.vim
    exe 'syntax enable'
    "TODO taglist window not restored properly(set background=dark caused "this)
endfunction
au VimEnter 0_0_project call LoadProject()

function! SaveProject()
    "TODO switch back the the root dir of the project
    mksession! session.vim
    wviminfo! viminfo.vim
    echo "Write session done!"
endfunction

function! SaveProject_Exit()
    "TODO switch back the the root dir of the project
    mksession! session.vim
    wviminfo! viminfo.vim
    echo "Write session done!"
    exe "qall"
endfunction

" the status bar setting
set laststatus=2
set statusline=#%n\|\%f%m%r%h\|\%{CurDir()}\|\%p%%\|\%c.%l/%L\|\%=%<\|\Ascii=%b,Hex=0x%B%{((&fenc==\"\")?\"\":\"\|\".&fenc)}\|ts=%{&ts}:sw=%{&sw}:et=%{&et}
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction

"using 4 char item distance for source code indent initially
function! CodingStyleInit()
    "turn on the c language auto indent
    setl cindent
    "turn on/off the tab expandtab/noexpandtab (et/noet)
    "setl expandtab
    "4 stop position for the tab key
    "setl tabstop=4
endfunction
autocmd! filetype c,cpp call CodingStyleInit()

"=============================
" shortcut mapping
"=============================
"page up/down
map <space> <C-F>
map <backspace> <C-B>

"using F12 to switch the window
"map <F12> <C-w>w
"map <S-F12> <C-w>W


"map <C-right> :bn<CR>
"map <C-left> :bp<CR>

"nmap <silent> <leader>qq :q<CR>
"nmap <silent> <leader>qa :qall<CR>

"nmap <silent> <leader>wm 100<C-W>+
"nmap <silent> <leader>wn 100<C-W>-

"using the +/- key of number keypad to fold/unfold thesource code
"map <kPlus> zo
"map <kMinus> zc

"if IsWindows()
"    map <silent> <leader>sv :source $HOME/_vimrc<CR>
"    map <silent> <leader>snp :split $HOME/_vim/snippets/c.snippets<CR>
"    map <silent> <leader>ex :!notepad %<CR>
"    autocmd! bufwritepost *vimrc source $HOME/_vimrc
"else
"    map <silent> <leader>sv :source $HOME/.vimrc<CR>
"    map <silent> <leader>snp :split $HOME/.vim/snippets/c.snippets<CR>
"    map <silent> <leader>ex :!gedit %<CR>
"    autocmd! bufwritepost *vimrc source $HOME/.vimrc
"endif

"the esc key remapping
"inoremap ,, <esc>

"simulate the indent shortcut from Source Insight
"imap <F9> <ESC><<i
"map <silent> <F9> <<

" in ubuntu 10.10, the system F10 is poping up the medu key, so we ignore this
" function
"imap <F10> <ESC>>>i
"map <silent> <F10> >>

"auto indent the whole document (the disadvantage is change the jump list
"map <leader>ff <esc>gg=G<C-O><C-O>

"reduce some input to substitude
nmap <C-h> :%s/<C-R>=expand("<cword>")<CR>/

"vmap <C-h> :normal! gv"ry<CR>:%s/<C-R>=@r<CR>/
"vmap <C-h> :normal! gvy<CR>:%s/<C-R>=@<CR>/

"insert the current date time
"inoremap $rq <C-R>=strftime("%Y-%m-%d")<CR>

"insert the file name from buffer
"inoremap $fn <C-R>=bufname("%")<CR>


"highlight the current light bar for ls
"map <F2> :set cul<CR>:sleep 500m<CR>:set nocul<CR>

"turn on the Toggles NERD Tree view (file viewer)
"map <F5> <ESC>:NERDTreeToggle<CR>

"=================
"Tlist setup
"=================
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File=1
let Tlist_WinWidth = 60
set updatetime=500

"=================
"TagBar
"================
map <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_sort=0 "sorting by sequence, but name


"switch in between of current window and Taglist window
"map <F4> :call JumpToTagList()<CR>
"map <S-F4> :TlistToggle<CR>
"function! JumpToTagList()
"    if g:TagList_title==bufname("%")
"        exe 'wincmd p'
"    else
"        exe 'TlistOpen'
"    endif
"endfunction

"hiko: there would let the mouse mode be abnormally {
""OmniCppComplete setting need to using the ctags command
""ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
"let OmniCpp_SelectFirstItem = 2
"inoremap <expr> <CR> pumvisible()?"\<C-Y>":"\<CR>"
"inoremap <expr> <ESC> pumvisible()?"\<C-E>":"\<ESC>"
"inoremap <expr> <C-J> pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
"inoremap <expr> <C-K> pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
"hiko: there would let the mouse mode be abnormally }

"retreat the input in the input mode
inoremap <C-Z> <esc>ui

"ctags
if filereadable("/usr/include/tags")
    set tags=./tags,./TAGS,tags,TAGS,/usr/include/tags
endif

"cscope setting
if has("cscope")
	if has("unix")
		let s:uname = system("uname")
		if s:uname == "Darwin\n"
			set csprg=/usr/local/bin/cscope
		else
			set csprg=/usr/bin/cscope
		endif
	endif
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    if filereadable("/usr/include/cscope.out")
        cs add /usr/include/cscope.out /usr/include
    endif
    set csverb
    "nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>
endif

"=======================
"highlight searching
"http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
"=======================
"function! ToggleHlsearch()
"    let pattern="\\<".expand("<cword>")."\\>"
"    if pattern==@/
"        if &hls
"            set nohls
"        else
"            set hls
"        endif
"    else
"        let @/=pattern
"        set hls
"    endif
"endfunction
"map <silent>  <F8>  :call ToggleHlsearch()<CR>

function! ToggleIgnoreCase()
    if &ic
        set noic
        echo "Case Sensetive OFF"
    else
        set ic
        echo "Case Sensetive ON"
    endif
endfunction
"switch the search size sensitivity
map <silent> <leader>ic :call ToggleIgnoreCase()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <F3> <C-W>}
"go check and highlight the tag of cursor on preview window
"http://vimcdoc.sourceforge.net/doc/windows.html#windows.txt

"map <F3> :call PreviewWord()<CR>
"function! GoToWindow(winnr)
"    for a:i in range(bufnr("$"))  "return to the original window
"        silent! wincmd w
"        if a:winnr==winnr()
"            return
"        endif
"    endfor
"endfunction
"function! PreviewWord()
"    if &previewwindow                  "not to execute in preview window
"        return
"    endif
"    if exists("g:TagList_title") && g:TagList_title==bufname("%")
"        return
"    endif
"    let w = expand("<cword>")          "grap the word from current highlight
"    if w =~ '\a'                       "if contains one alphabet
"
"    let a:current_winnr=winnr()
"    "delete the grammer of current highlight before the next tag coming
"    silent! wincmd P                   "jump to the preview window
"    if &previewwindow                  "if the preview window hits
"      match none                       "delete the grammer of original highlight
"      call GoToWindow(a:current_winnr) "return to the original window
"    endif
"
"    try to show light bar in current position
"    try
"       "exe "ptag " . w
"       exe "ptag " w
"    catch
"      return
"    endtry
"    silent! wincmd P                 "jump to the preview window
"    if &previewwindow                "if the preview window hits
"      if has("folding")
"        silent! .foldopen            "unfold the current line
"      endif
"      call search("$", "b")          "go back to the end of previous line
"      let w = substitute(w, '\\', '\\\\', "")
"      call search('\<\V' . w . '\>') "set position to the matched word
"
"      "give the highlight match to the current position word
"      hi previewWord term=bold ctermbg=blue guibg=green
"      exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
"      call GoToWindow(a:current_winnr)
"    endif
"  endif
"endfunction


" vim:ts=4:sw=4:et

" Hiko Customized }
