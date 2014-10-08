scriptencoding utf-8
set encoding=utf-8
" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

syntax enable                    " Turn on Syntax highlighting

" auto indenting
set et
set sw=4                         " shift width is four, yes four
set softtabstop=4                " four!
set nosmarttab                   " no tabs!
"set autoindent                   " It's easier than doing it myself.
"set smartindent                  " Don't be stupid about it.
set expandtab                    " all tabs are actually spaces

" Backup/Undo settings
execute "set directory=" . g:vim_home_path . "/swap"
execute "set backupdir=" . g:vim_home_path . "/backup"
execute "set undodir=" . g:vim_home_path . "/undo"
set backup
set undofile
set writebackup

" ----------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------
set ruler                        " show me the line,column my cursor is on
set noshowcmd                    " Don't display incomplete commands
set nolazyredraw                 " If we're going to redraw, lets not be lazy about it.
syntax sync minlines=1000        " Look for synchronization points 1000 lines before the current position in the file.
set number                       " show line numbers
set wildmenu                     " Turn on wild menu. Sounds fun.
set wildmode=longest:list,full   " make tab completion act like bash, but even better!
set ch=2                         " Command line height
set backspace=indent,eol,start   " Fixes a problem where I cannot delete text that is existing in the file
set whichwrap=b,s,h,l,<,>,[,]    " Wrap on other things
set report=0                     " Tell us about changes
set nostartofline                " don't jump to the start of a line when scrolling
" I'm in a hurry. I want anything up near esc to be esc so I can just mash the keyboard.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ----------------------------------------------------------------------------
" Visual stoof
" ----------------------------------------------------------------------------
set background=dark              " We use a dark terminal so we can play nethack
set mat=5                        " show matching brackets for 1/10 of a second
set laststatus=2                 " always have a file status line at the bottom, even when theres only one file
set novisualbell                 " Stop flashing at me and trying to give me seizures.
set virtualedit=block            " Allow virtual edit in just block mode.
highlight SpellBad term=reverse ctermbg=1

" ----------------------------------------------------------------------------
" Searching and replacing
" ---------------------------------------------------------------------------
set showmatch                    " brackets/brace matching
set incsearch                    " show me whats matching as I type my search
set hlsearch                     " Highlight search results
set ignorecase                   " Ignore case while searching
set smartcase                    " psych on that whole ignore case while searching thing! This will match case if you use any uppercase characters.
set gdefault                     " Always do search and replace globally
" prepend all searches with \v to get rid of vim's 'crazy default regex characters'
nnoremap / /\v
" make tab % in normal mode. This allows us to jump between brackets.
nnoremap <tab> %
" make tab % in visual mode. this allows us to jump between brackets.
vnoremap <tab> %

" ----------------------------------------------------------------------------
" Moving around
" ---------------------------------------------------------------------------
" disabling the up key in normal mode. LEARN TO USE k
"nnoremap <up> <nop>
" disabling the down key in normal mode. LEARN TO USE j
"nnoremap <down> <nop>
" disabling the left key in normal mode. LEARN TO USE h
"nnoremap <left> <nop>
" disabling the right key in normal mode. LEARN TO USE l
"nnoremap <right> <nop>
" disabling the up key in normal mode. LEARN TO USE k
"inoremap <up> <nop>
" disabling the down key in normal mode. LEARN TO USE j
"inoremap <down> <nop>
" disabling the left key in normal mode. LEARN TO USE h
"inoremap <left> <nop>
" disabling the right key in normal mode. LEARN TO USE l!!!
"inoremap <right> <nop>

" ---------------------------------------------------------------------------
" Strip all trailing whitespace in file
" ---------------------------------------------------------------------------
function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

" ---------------------------------------------------------------------------
" Convert two space tabs at the beginning of lines to four
" ---------------------------------------------------------------------------S
function! TwoSpaceTabsToFour ()
    exec ':%s/^\s*/&&/gc'
endfunction
map ,p :call TwoSpaceTabsToFour ()<CR>

" ---------------------------------------------------------------------------
" Python Stuff
" ---------------------------------------------------------------------------
autocmd FileType python setl sw=4                    " shift width is four, yes four
autocmd FileType python set softtabstop=4            " four!

" ---------------------------------------------------------------------------
" HTML Stuff
" ---------------------------------------------------------------------------
autocmd FileType html setl sw=2
autocmd FileType html set softtabstop=2

autocmd FileType htmldjango setl sw=2
autocmd FileType htmldjango set softtabstop=2

autocmd FileType css setl sw=2
autocmd FileType css set softtabstop=2

autocmd FileType less setl sw=2
autocmd FileType less set softtabstop=2
" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------
filetype on                      " Turn on filetype
filetype plugin on               " Turn on the filetype plugin so we can get specific
filetype plugin indent on
let g:pylint_onwrite=0           " I don't want pylint to change things for me automatically


"
"Extras
"Maps alt and an arrow to the split
"
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


" Lets use all the colors
set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
colorscheme lucius

" Hack to help map colors
if &term =~ "xterm"
  "256 color --
  let &t_Co=256
  " restore screen after quitting
  set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
  if has("terminfo")
    let &t_Sf="\ESC[3%p1%dm"
    let &t_Sb="\ESC[4%p1%dm"
  else
    let &t_Sf="\ESC[3%dm"
    let &t_Sb="\ESC[4%dm"
  endif
endif

" Stop deleting words with ctrl+w and ctrl+u
" Let us use undo
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"Configure syntastic to use pyflakes
let g:syntastic_python_checker = 'flake8'
let g:syntastic_check_on_open=1

"Configure syntastic to do perl checking
let g:syntastic_enable_perl_checker=1
let g:syntastic_perl_checker = 'perl'
