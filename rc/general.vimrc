"
" $Author: Mostafa Shahverdy 
" $URL: http://www.mostafa.info
" $Date: 2013-03-13 15:51:49 +0430 
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"custom Gui
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=e  "remove gui tabs and show builtin 
set guioptions-=r  "remove right-hand scroll bar"
"set guioptions+=b " To enable horisental scroll


" Sample متن فارسی برای آزمایش فونتهای زیر
"set guifont=Courier\ 10\ Pitch\ 10
"set guifont=Courier\ New\ 10 "Good support for Persian, but its thin
set guifont=DejaVu\ Sans\ Mono\ 11 "Good support for Persian
"set guifont=consolas
"set guifont=Andale\ Mono\ 12
"set guifont=Monospace\ 12
"set guifont=Liberation\ Mono\ 12
"set guifont=FreeMono\ 12

"Line numbers
set number

"line wrap
set nowrap

"Mouse activation
set mouse=a

" Start the selection mode with Shift+Arrows/Home/End/PageUp/PageDown, and with
" the mouse
"set selectmode=mouse,key

" Start the Visual/Selection mode with using Shift+Arrows/etc
"set keymodel=startsel


"Highlight the string we searched.
set hlsearch 

" Highlight the searched string, while typing.
set incsearch

" Tab spacing.
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set expandtab

" Use tabs at the start of a line, spaces elsewhere.
"set smarttab 


" To prevent tabs have full path and show only file name
"set guitablabel=%t
set guitablabel=%N\.%t\ %M

"to prevent showing arabic chars merged
set noarabicshape


" This is a very useful option to make + register the default one, so just use
" p to paste instead of "+p
set clipboard=unnamedplus

" Start fullscreen
if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window.
    set lines=100 columns=200
endif

" To prevent filename~ and .swp files in normal directories
"set backupdir=~/tmp
set nobackup
set noswapfile


" To make arline be shown always
" 0: never
" 1: only if there are at least two windows (this one is the default)
" 2: always
" See :h laststatus for more info..
set laststatus=2

" To make cursor stays in the middle of the screen
set scrolloff=300

" To change the leader
let mapleader = ","

" To have relativenumber in normal mode
"autocmd InsertEnter * :set norelativenumber 
"autocmd InsertLeave * :set relativenumber
"autocmd VimEnter * :set relativenumber

" Format Tabline in Vim and NOT GVim
set tabline=%!MyTabLine() "Function defined
"Rename tabs to show tab# and # of viewports


"let g:ycm_global_ycm_extra_conf = '~/openwsn/openwsn-sw/software/openvisualizer/ycm.py'

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" To fix path
set shell=bash

" colorscheme 
colorscheme visualstudio
set t_Co=256
hi Normal ctermbg=NONE
hi nonText ctermbg=NONE
hi Normal guibg=NONE
hi nonText guibg=NONE


syn region markdownItalic start="[^* ]\@<=\*\*\@!\|\*\@<!\*[^* ]\@=" end="[^* ]\@<=\*\|\*\@<!\*[^* ]\@=" keepend contains=markdownLineStart
syn region markdownItalic start="[^_ ]\@<=__\@!\|_\@<!_[^_]\@=" end="[^_ ]\@<=_\|_\@<!_[^_]\@=" keepend contains=markdownLineStart

"Using Nerdtree style for Explorer
let g:netrw_liststyle=3


" to make tabbar background invisable
hi TabLineFill cterm=bold gui=bold

" to enable snipMate
imap <Tab> <Plug>snipMateNextOrTrigger
smap <Tab> <Plug>snipMateNextOrTrigger
filetype plugin on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Transparent editing of gpg encrypted files.
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre      *.gpg set bin
autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPre,FileReadPre      *.gpg let shsave=&sh
autocmd BufReadPre,FileReadPre      *.gpg let &sh='sh'
autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
autocmd BufReadPost,FileReadPost    *.gpg let &sh=shsave
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost    *.gpg set nobin
autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre    *.gpg set bin
autocmd BufWritePre,FileWritePre    *.gpg let shsave=&sh
autocmd BufWritePre,FileWritePre    *.gpg let &sh='sh'
autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg -a --encrypt --default-recipient-self 2>/dev/null
autocmd BufWritePre,FileWritePre    *.gpg let &sh=shsave
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost  *.gpg silent u
autocmd BufWritePost,FileWritePost  *.gpg set nobin
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Transparent editing of gpg encrypted files.
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre      *.asc set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre      *.asc set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre      *.asc set bin
autocmd BufReadPre,FileReadPre      *.asc let ch_save = &ch|set ch=2
autocmd BufReadPre,FileReadPre      *.asc let shsave=&sh
autocmd BufReadPre,FileReadPre      *.asc let &sh='sh'
autocmd BufReadPre,FileReadPre      *.asc let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost    *.asc '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
autocmd BufReadPost,FileReadPost    *.asc let &sh=shsave
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost    *.asc set nobin
autocmd BufReadPost,FileReadPost    *.asc let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost    *.asc execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre    *.asc set bin
autocmd BufWritePre,FileWritePre    *.asc let shsave=&sh
autocmd BufWritePre,FileWritePre    *.asc let &sh='sh'
autocmd BufWritePre,FileWritePre    *.asc '[,']!gpg -a --encrypt --default-recipient-self 2>/dev/null
autocmd BufWritePre,FileWritePre    *.asc let &sh=shsave
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost  *.asc silent u
autocmd BufWritePost,FileWritePost  *.asc set nobin
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
