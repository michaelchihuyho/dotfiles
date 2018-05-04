" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

call vundle#end()

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

" Enable syntax highlighting
syntax on

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
noremap gh <C-w>h
noremap gj <C-w>j
noremap gk <C-w>k
noremap gl <C-w>l
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
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1

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

let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ [ 'x', 'z', 'warning' ]
  \ ]
