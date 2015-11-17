set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'easymotion/vim-easymotion'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'gregsexton/gitv'
Plugin 'guns/vim-clojure-static'
Plugin 'honza/vim-snippets'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/vim-easy-align'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'pangloss/vim-javascript'
Plugin 'rizzatti/dash.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'simnalamburt/vim-mundo'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tyru/open-browser.vim'
Plugin 'vim-ruby/vim-ruby'
" Plugin 'vim-scripts/paredit.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'tpope/vim-salve'

call vundle#end()
filetype plugin indent on

"======================================
"
"  GENERAL CONFIGS
"
"======================================

syntax on
autocmd vimenter * NERDTree

" Remap <Leader> to spacebar
let mapleader=" "


"-------------------------------------
" Display
"-------------------------------------
" Font stuff
if has('gui_running')
" set guifont=Sauce\ Code\ Powerline:h13
  set guifont=Office\ Code\ Pro:h13
endif
set tenc=utf8

colors Tomorrow-Night-Eighties

" Show whitespace
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" show line numbers
set number
set relativenumber
set nowrap

" Keep buffers, instead of closing them
set hidden

" Save on window blur
au FocusLost * :wa

" Automatically resize panes when the terminal is resized
autocmd VimResized * :wincmd =

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Long column highlighting
set nowrap

" Set columns at 80 and 120 chars
if exists('+colorcolumn')
  set colorcolumn=80,120
  " hi ColorColumn ctermbg=236
endif


"-------------------------------------
" Cursor
"-------------------------------------
" Redraw quicker
set lazyredraw
set ttyfast

" More context around cursor when scrolling
set scrolloff=6
set cursorline

" Remap J to \ for joining lines, move up and down quicker
nnoremap \ J
nnoremap J 4j
nnoremap K 4k

" Change cursor when in insert mode
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif

" highlight CursorLineNR cterm=NONE ctermbg=236


"-------------------------------------
" Yank/Paste/Registers
"-------------------------------------
" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Delete character should not squash paste buffer
nnoremap <silent> x "_x
vnoremap <silent> x "_x

" Toggle paste mode on and off
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"-------------------------------------
" Searching
"-------------------------------------
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


"-------------------------------------
" Command
"-------------------------------------
" command line
nnoremap ; :
vnoremap ; :

" Autocomplete command mode
set wildmenu
set wildmode=list:longest,full

" Set to auto read when a file is changed from the outside
set autoread

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

" Automatically source vimrc on save.
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC


"-------------------------------------
" Insert Mode
"-------------------------------------
" Remap Esc
imap jk <Esc>

" Delete character should not squash paste buffer
vnoremap <silent> x "_x

" Tab stuff correctly
set tabstop=2
set shiftwidth=2
set expandtab


"-------------------------------------
" Visual Mode
"-------------------------------------
" Remap Esc
vmap <BS><BS> <Esc>

" Shortcut to visual line mode
nmap <Leader><Leader> V

" Delete character should not squash paste buffer
vnoremap <silent> x "_x


"==================================
"
"  PACKAGE CONFIGS
"
"==================================
" NERDTree Git
if !exists('g:NERDTreeIndicatorMap')
    let g:NERDTreeIndicatorMap = {
                \ "Modified"  : "❉",
                \ "Staged"    : "✚",
                \ "Untracked" : "✭",
                \ "Renamed"   : "➜",
                \ "Unmerged"  : "═",
                \ "Deleted"   : "✖",
                \ "Dirty"     : "•",
                \ "Clean"     : "✔︎",
                \ "Unknown"   : "?"
                \ }
endif

" YankRing
map yr :YRShow<CR>

" Indent Guide
autocmd vimenter * IndentGuidesEnable
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size  = 1
highlight IndentGuidesOdd ctermbg=236
highlight IndentGuidesEven ctermbg=236

" Multi Cursor
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_quit_key='<Esc>'

" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" UltiSnips / YouCompleteMe
let g:UltiSnipsExpandTrigger = '<c-j>'
" let g:ycm_key_list_select_completion=['<c-j>']

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
let g:rbpt_colorpairs = [
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

au VimEnter * RainbowParenthesesToggle
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces

" Fireplace
nmap <Leader>We :w<CR>:Eval<CR>

" Test runner mappings
au FileType ruby map <Leader>t :call RunCurrentSpecFile()<CR>
au FileType ruby map <Leader>s :call RunNearestSpec()<CR>
au FileType ruby map <Leader>l :call RunLastSpec()<CR>
au FileType ruby map <Leader>a :call RunAllSpecs()<CR>

au FileType coffee map <Leader>t :call RunSingleEmberTestModule<CR>
au FileType coffee map <Leader>s :call RunSingleEmberTest<CR>
au FileType coffee map <Leader>l :call RunLastEmberTest<CR>
au FileType coffee map <Leader>a :call RunAllEmberTests<CR>

au FileType javascript map <Leader>t :call RunSingleEmberTestModule<CR>
au FileType javascript map <Leader>s :call RunSingleEmberTest<CR>
au FileType javascript map <Leader>l :call RunLastEmberTest<CR>
au FileType javascript map <Leader>a :call RunAllEmberTests<CR>

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

