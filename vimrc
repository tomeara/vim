execute pathogen#infect()
syntax on
filetype plugin indent on
colors Tomorrow-Night-Eighties
autocmd vimenter * NERDTree


"======================================
"
"  GENERAL CONFIGS
"
"======================================

" Remap <Leader> to spacebar
let mapleader=" "

" More context around cursor when scrolling
set scrolloff=6
set cursorline

" Autocomplete command mode
set wildmenu
set wildmode=list:longest,full

" Set to auto read when a file is changed from the outside
set autoread

" Remap Esc
imap jk <Esc>

" Font stuff
if has('gui_running')
  set guifont=Sauce\ Code\ Powerline:h13
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
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Toggle paste mode on and off
map <leader>v :setlocal paste!<cr>

"==================================
"
"  PACKAGE CONFIGS
"
"==================================

" NERD Tree
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>

" NERDCommenter
let NERDSpaceDelims = 1

" CtrlP - Fuzzy file finder
let g:ctrlp_map = '<c-p>'

" Syntastic
" let g:syntastic_check_on_open = 0
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
  let g:rspec_command = 'call VimuxRunCommand("clear; bundle exec rspec {spec}")'
end

" Vim/tmux navigator
let g:tmux_navigator_save_on_switch = 1

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

