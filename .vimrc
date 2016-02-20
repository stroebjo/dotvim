" vim:fdm=marker

" Documentaion of .vimrc ----------------------------
"
" augroup
" http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
"
"


" The presence of a ~/.[g]vimrc allready disables compatible mode.
" Nevertheless, a systemwwide .vimrc wouldn't, calling vim with -C flag 
" would set compatible, but `set nocompatible` disables ist again.
" > "better safe than sorry"
"
set nocompatible " be iMproved

let mapleader=","

" Load plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline' " improved status line
Plug 'vim-airline/vim-airline-themes'

Plug 'chriskempson/base16-vim'

Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'mileszs/ack.vim'
Plug 'gregsexton/MatchTag'

Plug 'Shougo/neocomplete.vim'
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'

Plug 'editorconfig/editorconfig-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'joonty/vdebug'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }


Plug 'mbbill/undotree'

Plug 'junegunn/goyo.vim'

Plug 'mhinz/vim-startify'

Plug 'jiangmiao/auto-pairs'


" Add plugins to &runtimepath
call plug#end()
" }}}


filetype plugin on



" GUI {{{

	set laststatus=2 " Always show the statusline
	set wildmenu " visual autocomplete for command menu
	set number " show line Numbers

	set guioptions-=T " Remove toolbar
	set guitablabel=%t\ %M " show only file name and modified bit in tabname

	set visualbell t_vb= " mute vim

	" Easy buffer navigation
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l

	if has("gui_running")
		if has("gui_win32")
			set guifont=Consolas\ for\ Powerline\ FixedD:h10:cANSI
		endif

		if has("gui_macvim")
			set guifont=Menlo\ for\ Powerline:h12
		endif
	endif


augroup gneral
	autocmd!

	" Set working directory to the current file (may interfere with some plugins?)
	" set autochdir
	autocmd BufEnter * silent! lcd %:p:h

	" disable FilteType matching in Open-File Dialog
	autocmd FileType * let b:browsefilter = ''

	" Resize splits when the window is resized
	au VimResized * :wincmd =

augroup END

" }}}



" Make <C-c> and <C-v> work like they should...
"source $VIMRUNTIME/mswin.vim
"behave mswin
set whichwrap+=<,>,h,l,[,] " wrap arrow keys around lines. <, > (normal mode), [,] (insert mode)



set fileformats=unix,dos

" always utf8, see http://stackoverflow.com/a/5795441/723769
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8 nobomb " better default than latin1, utf8 without BOM
	setglobal fileencoding=utf-8 " change default file encoding when writing new files
endif

set cursorline " Highlight current line

set autoindent " Copy indent from last line when starting new line
set smartindent

set lazyredraw " Don't redraw when we don't have to

" Tabwidth is four columns, indention level is one tab
set tabstop=4
set softtabstop=4
set shiftwidth=4


" un/indent multi line selections in different modes
" http://vim.wikia.com/wiki/Shifting_blocks_visually#Mappings
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/dist/*

set hlsearch   " highlight matches, there is no easy way to disable highlighting again
set incsearch  " search as characters are entered
set ignorecase " search is case insensitive
nmap <silent> <leader>. :nohlsearch<CR>


" Allow backspace in INSERT mode
set backspace=indent,eol,start

" Syntax highlighting {{{

syntax on " Enable syntax highlighting

" vim painfully slow when really long lines are matched
" against syntax highlighting.
set synmaxcol=176

if has("gui_running")
	set background=dark
	silent! colorscheme solarized " zenburn
endif

" }}}

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


" Special Windows settings {{{

	if has('win32') || has('win64')

		" use .vim direcotry on windows machines
		set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after

		if has("gui_running")
			map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
		endif
	endif

" }}}

" Special OS X settings {{{
	" SHIFT + Arrow Keys for vertical select
	if has("gui_macvim")
		let macvim_hig_shift_movement = 1
	endif
" }}}


" Word Processor Mode {{{
augroup word_processor_mode
  autocmd!

  function! WordProcessorMode()
    setlocal formatoptions=t1
    setlocal smartindent
    setlocal spell spelllang=en,de
    setlocal noexpandtab
    setlocal wrap " wrap line
    setlocal linebreak " wrap on word boundaries
	setlocal linespace=3 " higher lineheight
    Goyo 100
	NumbersToggle
	NumbersOnOff
	nnoremap j gj " j, k move accrose wrapped lines
    nnoremap k gk " j, k move accrose wrapped lines
  endfunction
  com! WP call WordProcessorMode()
augroup END
" }}}

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

" Handlebars {{{
augroup filetype_hbs
	autocmd!
	"au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb setl ft=mustache syntax=mustache
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

" Airline {{{


	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	"let g:airline_powerline_fonts = 1

	let g:airline_left_sep = '⮀'
	let g:airline_left_alt_sep = '⮁'
	let g:airline_right_sep = '⮂'
	let g:airline_right_alt_sep = '⮃'
	let g:airline_symbols.branch = '⭠'
	let g:airline_symbols.readonly = '⭤'
	let g:airline_symbols.linenr = '⭡'

	" don't warn about spaces after tabs when using this comment style:
	"
	" /*
	"  * <- space before the *
	"  */
	let g:airline#extensions#whitespace#mixed_indent_algo = 1

" }}}


	let g:airline#extensions#csv#enabled = 1
	let g:airline#extensions#csv#column_display = 'Number'
	let g:airline#extensions#csv#column_display = 'Name'

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

" Necomplete.vim {{{
augroup neocomplete_config

	let g:neocomplete#enable_at_startup = 1

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

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
" }}}

" Neosnippet.vim {{{

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

" }}}

let g:mustache_abbreviations = 1

" auto-pairs {{{

	" look for closing pair only on the same line
	let g:AutoPairsMultilineClose = 0

" }}}

" vim-startify {{{

	let g:startify_bookmarks = [ '~/.vimrc' ]

    let g:startify_list_order = [
            \ ['   My most recently', '   used files'],
            \ 'files',
            \ ['   These are my sessions:'],
            \ 'sessions',
            \ ['   These are my bookmarks:'],
            \ 'bookmarks',
            \ ]

    function! s:filter_header(lines) abort
        let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
        let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
        return centered_lines
    endfunction

    let g:startify_custom_header = s:filter_header([
\ '                            _o_                                            ',
\ '                        _,-=(_)=-,_                      ,_o_,             ',
\ '     .-=-.              ''         ''                     =======            ',
\ '                                               _____----(_o_)----_____     ',
\ '                //-n-\\                       /    ''-------------''    \    ',
\ '        _____---=======---_____              [''                        '']  ',
\ '    ====____\   /.. ..\   /____====                                        ',
\ '  //         ---\__O__/---         \\                                      ',
\ '  \_\                             /_/                                      ',
\ '                                    _                                      ',
\ '                                  _|_|_                                    ',
\ '                                ^/ . ..\^                                  ',
\ '                            ___[=========]___                              ',
\ '                 ___-==++""" .  /. . .  \ .  """++==-___                   ',
\ '           __-+"" __\   .. . .  | ..  . |  . .  .   /__ ""+-__             ',
\ '          /\__+-""   `-----=====\_  _/=====-----''   ""-+__/\               ',
\ '        _/_/                      ""=""                      \_\_          ',
\ '       /_/                                                     \_\         ',
\ '      //                                                         \\        ',
\ '     /")                                                         ("\       ',
\ '     \o\                                                         /o/       ',
\ '      \_)                                                       (_/        ',
\ '',
\ '',
\ ]) " http://www.chris.com/ascii/index.php?art=television/star%20trek

" }}}
