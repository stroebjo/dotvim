set smartindent
set number
set guioptions-=T  " Remove toolbar
syntax on " Enable syntax highlighting

" use .vim direcotry on windows machines
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Start pathogen https://github.com/tpope/vim-pathogen
call pathogen#infect()

" Set working directory to the current file (may interfere with some plugins?)
"set autochdir
autocmd BufEnter * silent! lcd %:p:h

" Allow backspace in INSERT mode
set backspace=indent,eol,start

" Actiate omniautocomplete for available filetypes
filetype plugin on
set ofu=syntaxcomplete#Complete

" disable FilteType matching in Open-File Dialog
autocmd FileType * let b:browsefilter = ''

" show only file name and modified bit in tabname
set guitablabel=%t\ %M 

" mute vim
set visualbell t_vb=

" unindent with Shift-Tab for command mode
nmap <S-Tab> <<
" for insert mode
imap <S-Tab> <Esc><<i

" always utf8
" see http://stackoverflow.com/a/5795441/723769
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

" Save temporary files in a central directory.
" the // will automatically use the full path to the file
" http://news.ycombinator.com/item?id=360748
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

map <F2> :mksession! ~/.vim_session <cr> " Quick write session with F2
map <F3> :source ~/.vim_session <cr>     " And load session with F3

" Resize splits when the window is resized
au VimResized * :wincmd =

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Tabwidth is four columns, indention level is one tab
set tabstop=4 
set softtabstop=4
set shiftwidth=4

colorscheme zenburn

" Special Windows settings
if has("gui_running")
  if has("gui_win32")
    set guifont=Consolas\ for\ Powerline\ FixedD:h10:cANSI
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
  endif

  if has("gui_macvim")
	set guifont=Menlo\ for\ Powerline:h12
  endif

endif

" Special OS X settings
" SHIFT + Arrow Keys for vertical select
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

" Make <C-c> and <C-v> work like they should...
source $VIMRUNTIME/mswin.vim
behave mswin



let g:user_zen_expandabbr_key = '<C-e>' 
let g:use_zen_complete_tag = 1


" add custom filetypes
au BufNewFile,BufRead *.phtml set filetype=php
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.scss set filetype=css

autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" CtrlP file finder
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
	\ },
    \ 'fallback': 'find %s -type f'
\ }


" set wildignore+=*\\.sass-cache\\*        " Linux/MacOSX
set wildignore+=*\\.sass-cache\\*  " Windows ('noshellslash')

" Always show the statusline
set laststatus=2


set fileformats=unix,dos

" Powerline setup.
let g:Powerline_symbols = 'fancy' " requieres a patched font
let g:Powerline_symbols_override = {
    \ 'LINE': 'LN',
    \ }

" Only check for syntax errors manually. Expect for Ruby and PHP
let g:syntastic_mode_map = { 'mode': 'passive',
	\ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

" Remove trailing whitespaces at the end of lines
" http://stackoverflow.com/a/1618401/723769
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType scss,css,html,c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces() 
