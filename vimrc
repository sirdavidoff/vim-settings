" Include user's local pre .vimrc config
if filereadable(expand("~/.vimrc.pre"))
  source ~/.vimrc.pre
endif

call pathogen#infect()
call pathogen#helptags()

" Stuff added by David
" Change the leader to comma and show it in the bottom-right when it's pressed
color kellys
set guifont=Menlo:h17

let mapleader = ","

" Visually select the last changed text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]''`]`'
" Use this alternative to just select the last pasted text
"nnoremap gp `[v`]

nmap <leader>w :bw<CR>

nmap R <Plug>yankstack_substitute_older_paste
nmap <M-p> <Plug>yankstack_substitute_newer_paste

nmap <silent> <c-n> :NERDTreeToggle<CR>
nmap <silent> <c-b> :TagbarToggle<CR>
" Actionscript syntax highlighting
au BufRead,BufNewFile *.as set filetype=actionscript
" End stuff

" Pressing space inserts one char only
nmap <Space> i_<Esc>r
" Ctrl-L moves to the end of the line in insert mode
inoremap <C-l> <C-o>A
" ;; inserts a semicolon at the end of the line in insert mode
inoremap ;; <C-o>A;
" ,, closes the current buffer
nmap <Leader>, :bw
" Return opens a new line, even when in command mode
map <S-Enter> O<Esc>
map <CR> o<Esc>

let delimitMate_expand_cr = 1
autocmd FileType html,htmldjango,jinjahtml,eruby,mako,tpl let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako,tpl source ~/.vim/bundle/closetag/plugin/closetag.vim

set nocompatible

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=10

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Gundo configuration
nmap <F5> :GundoToggle<CR>
imap <F5> <ESC>:GundoToggle<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd


if has("gui_running")
  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =
endif

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
