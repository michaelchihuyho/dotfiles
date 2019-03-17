" Vim plug setup
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'           " Git stuff in the gutter
Plug 'michaeljsmith/vim-indent-object'  " select indent blocks
Plug 'ctrlpvim/ctrlp.vim'               " fuzzy file search
Plug 'majutsushi/tagbar'                " ctag stuff
Plug 'mileszs/ack.vim'                  " Global search
Plug 'MarcWeber/vim-addon-mw-utils'     " necesary for vim snipmate
Plug 'garbas/vim-snipmate'              " snippets
Plug 'tomtom/tlib_vim'                  " misc utils used by other plugins?
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'w0rp/ale'                         " Linting
Plug 'tpope/vim-commentary'             " Commenting code
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'               " Git
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'               " Surrounding characters
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/greplace.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'groenewege/vim-less'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'          " Status bar stuff
Plug 'vim-airline/vim-airline-themes'
Plug 'mxw/vim-jsx'
Plug 'junegunn/vim-peekaboo'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Go utils
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocompletion
" Plugin 'zchee/deoplete-go'

" Initialize plugin system
call plug#end()


" Enable syntax highlighting
" syntax on

" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" change cursor depending on mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

if !has('nvim')
  set autoindent                                  " Enable auto indent
  set autoread                                    " reload files when changed on disk
  set backspace=indent,eol,start                  " Allow backspace in insert mode
  set esckeys                                     " Allow cursor keys in insert mode
  set incsearch                                   " Highlight dynamically as pattern is typed
  set laststatus=2                                " Always show status line
  set nocompatible                                " Make Vim more useful
  set ruler                                       " Show the cursor position
  set showcmd                                     " Show the (partial) command as it’s being typed
  set ttyfast                                     " Optimize for fast terminal connections
  set wildmenu                                    " Enhance command-line completion
endif

if has('nvim')
  set nohlsearch
endif

set backupdir=~/.vim/backups                    " Centralize backups
set backupskip=/tmp/*,/private/tmp/*            " Don’t create backups when editing files in certain directories
set binary
set clipboard=unnamed                           " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set cursorline                                  " Highlight current line
set directory=~/.vim/swaps                      " Centralize swapfiles
set encoding=utf-8 nobomb                       " Use UTF-8 without BOM
set expandtab                                   " expand tabs to spaces
set exrc                                        " Enable per-directory .vimrc files and disable unsafe commands in them
set gdefault                                    " Add the g flag to search/replace by default
set ignorecase                                  " Ignore case of searches
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_            " Show “invisible” characters
set list                                        " Show “invisible” characters
set modeline                                    " Respect modeline in files
set modelines=4
set mouse=a                                     " Enable mouse in all modes
set noeol                                       " Don’t add empty newlines at the end of files
set noerrorbells                                " Disable error bells
set nostartofline                               " Don’t reset cursor to start of line when moving around.
set number                                      " Enable line numbers
if exists("&relativenumber")                    " Use relative line numbers
  set relativenumber
  au BufReadPost * set relativenumber
endif
set scrolloff=3                                 " Start scrolling three lines before the horizontal window border
set secure                                      " Enable per-directory .vimrc files and disable unsafe commands in them
set shiftwidth=2                                " normal mode indentation commands use 2 spaces
set shortmess=atI                               " Don’t show the intro message when starting Vim
set showmode                                    " Show the current mode
set smartcase                                   " case-sensitive search if any caps
set softtabstop=2                               " insert mode tab and backspace uses 2 spaces
set splitbelow
set splitright
set statusline+=%#warningmsg#                   " Syntastic status settings
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set tabstop=8                                   " actual tabs occupy 8 characters
set title                                       " Show the filename in the window titlebar
if exists("&undodir")                           " Centralize undo history
  set undodir=~/.vim/undo
endif
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmode=longest,list,full

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" keyboard shortcuts
let mapleader=","
inoremap jj <ESC>
noremap <leader>ss :call StripWhitespace()<CR>
noremap <leader>W :w !sudo tee % > /dev/null<CR> " Save a file as root (,W)
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>l :Align
nnoremap <leader>a :Ack!<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nnoremap gu <C-u>
nnoremap gy <C-d>
nnoremap <leader>+ :exe "vertical resize +10"<CR>
nnoremap <leader>- :exe "vertical resize -10"<CR>
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
endif

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  " fdoc is yaml
  autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
  " md is markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.md set spell
endif

" Plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:NERDTreeShowHidden=1
let g:jsx_ext_required = 0
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_linters_explicit = 1

" Use ripgrep
if executable('rg')
  set grepprg=rg\ --no-heading\ -S
  let g:ackprg = 'rg --vimgrep --no-heading -S'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg -l --color never "" %s'
  let g:gitgutter_grep=''
endif

" Disambiguate ,a & ,t from the Align plugin, making them fast again.
"
" This section is here to prevent AlignMaps from adding a bunch of mappings
" that interfere with the very-common ,a and ,t mappings. This will get run
" at every startup to remove the AlignMaps for the *next* vim startup.
"
" If you do want the AlignMaps mappings, remove this section, remove
" ~/.vim/bundle/Align, and re-run rake in maximum-awesome.
function! s:RemoveConflictingAlignMaps()
  if exists("g:loaded_AlignMapsPlugin")
    AlignMapsClean
  endif
endfunction
command! -nargs=0 RemoveConflictingAlignMaps call s:RemoveConflictingAlignMaps()
silent! autocmd VimEnter * RemoveConflictingAlignMaps

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap <Leader>s <Plug>(easymotion-s)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" Airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline#extensions#ale#enabled = 1

" Deoplete config
let g:deoplete#enable_at_startup = 1

" Go config
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
au FileType go nmap <F10> :GoTest -short<cr>
au FileType go nmap <F12> <Plug>(go-def)

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_addtags_transform = "snakecase"
