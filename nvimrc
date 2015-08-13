set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'VundleVim/Vundle.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'mileszs/ack.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'simnalamburt/vim-mundo'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tyru/open-browser.vim'
Plugin 'vim-scripts/paredit.vim'
Plugin 'oblitum/rainbow'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tlib_vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'bling/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-classpath'
Plugin 'guns/vim-clojure-static'
Plugin 'kchmck/vim-coffee-script'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-dispatch'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-endwise'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-sensible'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'

call vundle#end()
filetype plugin indent on

"======================================
"
"  GENERAL CONFIGS
"
"======================================

syntax on
colors Tomorrow-Night-Eighties
autocmd vimenter * NERDTree

" Redraw quicker
set lazyredraw
set ttyfast

" Remap <Leader> to spacebar
let mapleader=" "

" More context around cursor when scrolling
set scrolloff=6
set cursorline

" Change cursor when in insert mode
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif

" highlight CursorLineNR cterm=NONE ctermbg=236

" Autocomplete command mode
set wildmenu
set wildmode=list:longest,full

" Set to auto read when a file is changed from the outside
set autoread

" Remap Esc
imap jk <Esc>
vmap <BS><BS> <Esc>

" Shortcut :w
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>wqa :wqa<CR>

" Shortcut ESC
nnoremap <Leader>wqa :wqa<CR>

" Shortcut to visual line mode
nmap <Leader><Leader> V

" Font stuff
if has('gui_running')
" set guifont=Sauce\ Code\ Powerline:h13
  set guifont=Office\ Code\ Pro:h13
endif
set tenc=utf8

" Column Length Highlighting
highlight OverLength81 ctermbg=yellow ctermfg=gray guibg=#592929
highlight OverLength120 ctermbg=red ctermfg=white guibg=#592929
match OverLength81 /\%81v.\+/
match OverLength120 /\%121v.\+/

" Search stuff
set incsearch
set hlsearch
set smartcase
nmap <Leader>/ :nohl<cr>

" Use 'very magic' search by default
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Tab stuff correctly
set tabstop=2
set shiftwidth=2
set expandtab

" Show whitespace
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" show line numbers
set number
set relativenumber
set nowrap

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" Keep buffers, instead of closing them
set hidden

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Save on window blur
au FocusLost * :wa

" Automatically resize panes when the terminal is resized
autocmd VimResized * :wincmd =

" Automatically source vimrc on save.
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Toggle paste mode on and off
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"==================================
"
"  PACKAGE CONFIGS
"
"==================================

" Easymotion
map <Leader>j <Plug>(easymotion-prefix)

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" NERD Tree
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>

" NERDCommenter
let NERDSpaceDelims = 1

" CtrlP - Fuzzy file finder
nnoremap <Leader>o :CtrlP<CR>

" Syntastic
" let g:syntastic_check_on_open = 1
" let g:syntastic_enable_signs = 1
" let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_coffeescript_checkers = ["coffeelint"]
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_warning_symbol = '❉'
" let g:syntastic_style_warning_symbol = '❉'

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Dash
:nmap <silent> <leader>d <Plug>DashSearch

" Gundo
nnoremap gh :GundoToggle<CR>
set undofile
set undodir=~/.nvim/undo

" Rainbow Parentheses
" au FileType c,cpp,objc,objcpp,go,rust,javascript,java call rainbow#load()
au FileType clojure call rainbow#load()
" au FileType clojure call rainbow#load(
"             \ [['(', ')'], ['\[', '\]'], ['{', '}']],
"            \ '"[-+*/=><%^&$#@!~|:?\\]"')

" Fireplace
nmap <Leader>We :w<CR>:Eval<CR>

" Test runner mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

if has('gui_running')
  let g:rspec_runner = "os_x_iterm"
else
  let g:rspec_command = 'call VimuxRunCommand("clear; RAILS_ENV=test bundle exec rspec {spec}")'
end

" Vim/tmux navigator
let g:tmux_navigator_save_on_switch = 1

" Tmuxline
let g:tmuxline_powerline_separators = 1
let g:tmuxline_preset = {
        \ 'c': '#(rainbarf --remaining --bg=black --width=20)',
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '',
        \ 'y': ['%a %b %d', '%R'],
        \ 'z': '#h'}

" AutoPairs
" let g:AutoPairsFlyMode = 1

"==================================
"
"  SUPPORT FUNCTIONS
"
"==================================

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  en
  return ''
endfunction

function! VisualSelection(direction) range
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

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

