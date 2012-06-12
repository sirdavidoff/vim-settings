" Include user's local pre .vimrc config if filereadable(expand("~/.vimrc.pre")) source ~/.vimrc.pre endif

call pathogen#infect()
call pathogen#helptags()

" Need to call this to make sure any keymaps override yankstack's craziness
call yankstack#setup()

color kellys
set guifont=Menlo:h17

let mapleader = ","

" Swap colon and semicolon
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" When pasting, auto-indent to match surroundings 
nnoremap p ]p
nnoremap P ]P
" Would be nice to use '] to move to end of paste too, but this breaks
" Yankstack

"" Y yanks to the end of the line, rather than yanking the whole line
nnoremap Y y$
"" yl yanks the line, but without preceding whitespace or the line break
nnoremap yl ^y$
"" 'j and 'k go to the beginning and end of just-selected or just-pasted text
nnoremap 'j '[
nnoremap 'k ']
"" 0 goes to the first non-whitespace part of the line, rather than the very
"" beginning
nnoremap 0 ^
nnoremap ^ 0
"" Uppercase U is redo
nnoremap U <C-r>

"" Only have to press <> once to change line indent
nnoremap < <<
nnoremap > >>
" Stay in visual mode when indenting
vnoremap > >gv
vnoremap < <gv

" Tab toggles comments
nmap <Tab> <plug>NERDCommenterToggle<bar>j
" To get this to work you need to comment out the 'xnor' line in
" snipmate/after/plugin/snipMate.vim
xmap <Tab> <plug>NERDCommenterToggle
" ,d comments out the current line and puts a copy below
nmap <leader>d yy<plug>NERDCommenterToggle<bar>]p
vmap <leader>d y]Pgp<plug>NERDCommenterToggle<bar>']j

" Indent the file, keeping cursor in the same place
nnoremap <leader>f mqgg=G'q

"" Join lines above and below with ,j and ,k (with no extra spaces)
"nnoremap <leader>j gJ
"nnoremap <leader>k kgJ
nnoremap <leader>j $mqj^v$yk$pj2dd`ql
nnoremap <leader>k k$mqj^v$yk$pj2dd`ql

"" Move up and down a screen with J and K
nnoremap J <C-f>zz
nnoremap K <C-b>zz
vnoremap J <C-f>zz
vnoremap K <C-b>zz
nnoremap <C-k> <C-u><C-u>zz
nnoremap <C-j> <C-d><C-d>zz

"" Help key is ,h
nnoremap <leader>h K

"" Visually select the last changed text
nnoremap <expr> gp '`[' . getregtype()[0] . '`]'

"" // clears last search
nnoremap // :let @/ = ""<CR>

"" Unimpaired configuration
"" Bubble single lines
nmap <c-up> [e
nmap <C-Down> ]e
"" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

"Close current buffer
nnoremap <leader>w :bw<CR>
"Close current buffer
nnoremap <leader>a :%bdelete<CR>

"" R replaces the last pasted text with whatever was previously in the yank
"" buffer
nmap R <Plug>yankstack_substitute_older_paste
nmap <M-p> <Plug>yankstack_substitute_newer_paste

noremap <silent> <leader>t :TagbarToggle<cr><c-w>l

"" ctrl-l moves to the end of the line in insert mode
inoremap <C-l> <C-o>A
"" ;; inserts a semicolon at the end of the line in insert mode
inoremap ;; <C-o>A;

"" Return opens a new line, even when in command mode
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>

"" s does opens the substitution thing in visual mode
vnoremap s :s/

"" LustyJuggler configuration
let g:LustyExplorerSuppressRubyWarning = 1
let g:LustyJugglerAltTabMode = 1
nnoremap s :LustyJuggler<CR>
set hidden

"" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
noremap <Leader>s :NERDTreeToggle<CR>

"" Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=10
nnoremap t :CommandT<CR>

" EasyMotion configuration
"nnoremap f :call EasyMotion#WB(0, 0)<CR>
"nnoremap F :call EasyMotion#WB(0, 1)<CR>
nnoremap <space> :call EasyMotion#WB(0, 0)<CR>
nnoremap <S-space> :call EasyMotion#WB(0, 1)<CR>
nnoremap gf f
nnoremap gF F
nnoremap gt t
nnoremap gT T
let g:EasyMotion_keys = 'abcdeghiklmnopqrstuvwxyzjf;'

" Pressing <esc> when the omnicomplete menu is shown doesn't exit insert mode
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

"" ZoomWin configuration
""map <Leader><Leader> :ZoomWin<CR>

"" CTags
"map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
"map <C-\> :tnext<CR>

"" Gundo configuration
"nmap <F5> :GundoToggle<CR>
"imap <F5> <ESC>:GundoToggle<CR>

"" Opens an edit command with the path of the currently edited file filled in
"" Normal mode: <Leader>e
"map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled in
"" Normal mode: <Leader>t
"map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" Inserts the path of the currently edited file into a command
"" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

let delimitMate_expand_cr = 1
"autocmd FileType html,htmldjango,jinjahtml,eruby,mako,tpl let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako,tpl source ~/.vim/bundle/closetag/plugin/closetag.vim

" If seems the default is <Tab>, and if you leave it at that then it jumps
" around like crazy in certain insert modes
let g:sparkupNextMapping = '<c-x>'
set nocompatible

set number
set ruler
syntax on

set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Show (partial) command in the status line
set showcmd

"" Tab completion
"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

"" Status bar
set laststatus=2

"" Without setting this, ZoomWin restores windows in a way that causes
"" equalalways behavior to be triggered the next time CommandT is used.
"" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

"" Remember last location in file
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

"" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

"" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

"" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

"" Actionscript syntax highlighting
au BufRead,BufNewFile *.as set filetype=actionscript

"" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"" load the plugin and indent settings for the detected filetype
filetype plugin indent on



"" Enable syntastic syntax checking
"let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=1

"" gist-vim defaults
"if has("mac")
  "let g:gist_clip_command = 'pbcopy'
"elseif has("unix")
  "let g:gist_clip_command = 'xclip -selection clipboard'
"endif
"let g:gist_detect_filetype = 1
"let g:gist_open_browser_after_post = 1

"" Use modeline overrides
set modeline
set modelines=10

"" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

"" Turn off jslint errors by default
"let g:JSLintHighlightErrorLine = 0

"" MacVIM shift+arrow-keys behavior (required in .vimrc)
" THIS BREAKS Shift-j to move down in visual mode
"let macvim_hig_shift_movement = 1

"" % to bounce from do to end etc.
"runtime! macros/matchit.vim

"noremap <leader>ev e $MYVIMRC
"noremap <leader>eg e $MYGVIMRC
command RC e $MYVIMRC
command GRC e $MYGVIMRC
" Automatically reload .vimrc, etc every time it is saved
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

if has("gui_running")
  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =
endif

fu! HL_Search_Cword()
  let s:old_cpo = &cpo
  set cpo&vim

  if exists('b:search_cword_item')
    try
      call matchdelete(b:search_cword_item)
    catch /^Vim\%((\a\+\)\=:E/ " ignore E802,E803
    endtry
  endif

  " :silent !printf '\e]12;\#242424\a'
  "hi Search       ctermfg=233 ctermfg=106 cterm=bold
  hi search_cword ctermfg=085 ctermbg=234 cterm=bold
  "hi Search		guifg=#2a2b2f	guibg=#878689	gui=none
  hi search_cword  guifg=#000000	guibg=#fffabc	gui=none

  let b:search_cword_item = matchadd('search_cword', (&ic ? '\c' : '') . '\%#' . @/, 1)

  let &cpo = s:old_cpo
endfu

nnoremap <silent> ! *:call HL_Search_Cword()<CR>
nnoremap <silent> # #:call HL_Search_Cword()<CR>
nnoremap <silent> * *:call HL_Search_Cword()<CR>
nnoremap <silent> N N:call HL_Search_Cword()<CR>
nnoremap <silent> n n:call HL_Search_Cword()<CR>

" Some handy shortcuts
command FO cd ~/dev/fo/code/FundingOptions/fundingoptions
command FOweb cd ~/dev/fo/design/foweb

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
