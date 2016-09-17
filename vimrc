set nocompatible
filetype off
" make sure to add vim-plug to the autoload dir
call plug#begin('~/.vim/bundle')

Plug 'Numkil/ag.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'carlitux/deoplete-ternjs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cloudhead/neovim-fuzzy'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'flazz/vim-colorschemes'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-sexp'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/rainbow_parentheses.vim'
Plug 'kshenoy/vim-signature'
Plug 'lambdatoast/elm.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'simnalamburt/vim-mundo'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'ternjs/tern_for_vim'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'thoughtbot/vim-rspec'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'elixir-lang/vim-elixir'

call plug#end()
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
  " set guifont=Office\ Code\ Pro:h13
  set guifont=Fira\ Code:h13
endif
set tenc=utf8

colors Tomorrow-Night-Eighties

" Show whitespace
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" show line numbers
set number
" set relativenumber
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
set scrolloff=999 " Hack to set cursor in the middle of the screen
set cursorline


"-------------------------------------
" Yank/Paste/Registers
"-------------------------------------
" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Delete character should not squash paste buffer
nnoremap <silent> x "xx
vnoremap <silent> x "xx

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

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Ignore .git et al from results
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/bower_components/*,*/node_modules/*,*/tmp/*

"-------------------------------------
" Command
"-------------------------------------
" Remap the default leader to next character, since I use <Space> for leader
nnoremap \ ;
nnoremap \ ;
" Remap command to not have to use <Shift>
nnoremap ; :
vnoremap ; :

" Autocomplete command mode
set wildmenu
set wildmode=list:longest,full

" Set to auto read when a file is changed from the outside
set autoread

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set noswapfile " swapfiles don't really do anything for me

"-------------------------------------
" Insert Mode
"-------------------------------------
" Remap Esc
imap jk <Esc>

" Tab stuff correctly
set tabstop=2
set shiftwidth=2
set expandtab


"-------------------------------------
" Visual Mode
"-------------------------------------
" Remap Esc
vmap <Leader><Leader> <Esc>

" Shortcut to visual line mode
nmap <Leader><Leader> V

" Delete character should not squash paste buffer
vnoremap <silent> x "xx


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

" Fixes problem with GitGutter: ihttps://github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_realtime = 0

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

" Easymotion
nmap <Enter> <Plug>(easymotion-prefix)

" Neosnippet / Deoplete
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:deoplete#enable_at_startup = 1

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" NERD Tree
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>

" NERDCommenter
let NERDSpaceDelims = 1

" NeoFuzzy - Fuzzy file finder
nnoremap <Leader>o :FuzzyOpen<CR>

" Neomake
autocmd! BufWritePost * Neomake

let g:neomake_warning_sign = {
  \ 'text': '❉',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '✗',
  \ 'texthl': 'ErrorMsg',
  \ }

" Airline
let g:airline_theme='tomorrow'
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
nnoremap gh :MundoToggle<CR>
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
au FileType clojure nmap <Leader>t :w<CR>:Require<CR>:Eval<CR>
au FileType clojure nmap <Leader>s :w<CR>:Eval<CR>

" Test runner mappings
au FileType ruby map <Leader>t :w<CR> :call RunCurrentSpecFile()<CR>
au FileType ruby map <Leader>s :w<CR> :call RunNearestSpec()<CR>
au FileType ruby map <Leader>l :w<CR> :call RunLastSpec()<CR>
au FileType ruby map <Leader>a :w<CR> :call RunAllSpecs()<CR>

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
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '',
        \ 'y': ['%a %b %d', '%R'],
        \ 'z': '#h'}


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

