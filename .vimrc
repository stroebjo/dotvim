" vim:fdm=marker

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'Lokaltog/vim-powerline'
Bundle "mattn/emmet-vim"
Bundle 'myusuf3/numbers.vim'
"Bundle 'Valloric/YouCompleteMe'"
"Bundle 'shawncplus/phpcomplete.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'mileszs/ack.vim'
Bundle 'gregsexton/MatchTag'

"Bundle 'Shougo/neocomplcache.vim'
Bundle 'Shougo/neocomplete.vim'
"Bundle 'Shougo/neosnippet'
"Bundle 'Shougo/neosnippet-snippets'

Bundle 'editorconfig/editorconfig-vim'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'captbaritone/better-indent-support-for-php-with-html'

Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'

Bundle 'mbbill/undotree'

filetype plugin on


" GUI {{{

set wildmenu " visual autocomplete for command menu
" disable FilteType matching in Open-File Dialog
autocmd FileType * let b:browsefilter = ''

set guitablabel=%t\ %M " show only file name and modified bit in tabname
set visualbell t_vb= " mute vim

" Resize splits when the window is resized
au VimResized * :wincmd =

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


" }}}


set autoindent
set smartindent
set number        " show line Numbers
set guioptions-=T " Remove toolbar

set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/dist/*


" Syntax highlighting {{{

syntax on " Enable syntax highlighting

" vim painfully slow when really long lines are matched
" against syntax highlighting.
set synmaxcol=176

set background=dark
colorscheme solarized " zenburn

" }}}


" Tabwidth is four columns, indention level is one tab
set tabstop=4 
set softtabstop=4
set shiftwidth=4


"set hlsearch   " highlight matches, there is no easy way to disable highlighting again
"set incsearch  " search as characters are entered
set ignorecase " search is case insensitive



augroup gneral
	autocmd!
	
	" Set working directory to the current file (may interfere with some plugins?)
	" set autochdir
	autocmd BufEnter * silent! lcd %:p:h

augroup END	


" Allow backspace in INSERT mode
set backspace=indent,eol,start

" unindent with Shift-Tab for command mode
nmap <S-Tab> <<
" for insert mode
imap <S-Tab> <Esc><<i


" Always show the statusline
set laststatus=2


set fileformats=unix,dos

" always utf8, see http://stackoverflow.com/a/5795441/723769
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8 nobomb " better default than latin1, utf8 without BOM
  setglobal fileencoding=utf-8 " change default file encoding when writing new files
endif

" Local direcotries {{{

" Save temporary files in a central directory.
" the // will automatically use the full path to the file
" http://news.ycombinator.com/item?id=360748
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

if has("persistent_undo")
    set undodir='~/.vim/undodir/'
    set undofile
endif

" }}}


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

" use .vim direcotry on windows machines
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Special OS X settings
" SHIFT + Arrow Keys for vertical select
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

" Make <C-c> and <C-v> work like they should...
source $VIMRUNTIME/mswin.vim
behave mswin



" Filetypes -------------------------------------------------------------

" PHP {{{
augroup filetype_php
	autocmd!
	
	au BufRead,BufNewFile *.phtml set ft=php syntax=php

augroup END	
" }}}

" Ruby {{{
augroup filetype_ruby
	autocmd!
	
	au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

augroup END	
" }}}


" Plugins -------------------------------------------------------------


" CtrlP.vim {{{
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

" }}}

" Powerline {{{
	let g:Powerline_symbols = 'fancy' " requieres a patched font
	
	let g:Powerline_symbols_override = {
		\ 'LINE': 'LN',
		\ }

" }}}

" Syntastic.vim {{{

	" Only check for syntax errors manually. Expect for Ruby and PHP
	"let g:syntastic_mode_map = { 'mode': 'passive',
	"	\ 'active_filetypes': [],
	"   \ 'passive_filetypes': [] }

	let g:syntastic_scss_checkers = ['scss_lint']
	
	let g:syntastic_error_symbol = '✗'
	let g:syntastic_warning_symbol = '⚠'

	let g:syntastic_style_error_symbol = 'S⚠'
	let g:syntastic_style_warning_symbol = 'S⚠'

" }}}


let g:neocomplete#enable_at_startup = 1

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: "\<TAB>"

" For conceal markers.
"if has('conceal')
""  set conceallevel=2 concealcursor=niv
"endif



let g:mustache_abbreviations = 1


