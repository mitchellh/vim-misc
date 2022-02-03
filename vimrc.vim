scriptencoding utf-8
set encoding=utf-8

"----------------------------------------------------------------------
" Basic Options
"----------------------------------------------------------------------
let mapleader=";"         " The <leader> key
set autoread              " Reload files that have not been modified
set backspace=2           " Makes backspace behave like you'd expect
set colorcolumn=80        " Highlight 80 character limit
set hidden                " Allow buffers to be backgrounded without being saved
set laststatus=2          " Always show the status bar
set list                  " Show invisible characters
set listchars=tab:›\ ,eol:¬,trail:⋅ "Set the characters for the invisibles
set number
set ruler                 " Show the line number and column in the status bar
set t_Co=256              " Use 256 colors
set scrolloff=999         " Keep the cursor centered in the screen
set showmatch             " Highlight matching braces
set showmode              " Show the current mode on the open buffer
set splitbelow            " Splits show up below by default
set splitright            " Splits go to the right by default
set title                 " Set the title for gvim
set visualbell            " Use a visual bell to notify us

" Customize session options. Namely, I don't want to save hidden and
" unloaded buffers or empty windows.
set sessionoptions="curdir,folds,help,options,tabpages,winsize"

if !has("win32")
    set showbreak=↪           " The character to put to show a line has been wrapped
end

syntax on                 " Enable filetype detection by syntax

" Backup settings
execute "set directory=" . g:vim_home_path . "/swap"
execute "set backupdir=" . g:vim_home_path . "/backup"
execute "set undodir=" . g:vim_home_path . "/undo"
set backup
set undofile
set writebackup

" Search settings
set hlsearch   " Highlight results
set ignorecase " Ignore casing of searches
set incsearch  " Start showing results as you type
set smartcase  " Be smart about case sensitivity when searching

" Tab settings
set expandtab     " Expand tabs to the proper type and size
set tabstop=4     " Tabs width in spaces
set softtabstop=4 " Soft tab width in spaces
set shiftwidth=4  " Amount of spaces when shifting

" Tab completion settings
set wildmode=list:longest     " Wildcard matches show a list, matching the longest first
set wildignore+=.git,.hg,.svn " Ignore version control repos
set wildignore+=*.6           " Ignore Go compiled files
set wildignore+=*.pyc         " Ignore Python compiled files
set wildignore+=*.rbc         " Ignore Rubinius compiled files
set wildignore+=*.swp         " Ignore vim backups

" GUI settings
colorscheme onehalfdark

" This is required to force 24-bit color since I use a modern terminal.
set termguicolors

if !has("gui_running")
    " vim hardcodes background color erase even if the terminfo file does
    " not contain bce (not to mention that libvte based terminals
    " incorrectly contain bce in their terminfo files). This causes
    " incorrect background rendering when using a color theme with a
    " background color.
    "
    " see: https://github.com/kovidgoyal/kitty/issues/108
    let &t_ut=''
endif

set guioptions=cegmt
if has("win32")
    set guifont=Inconsolata:h11
else
    set guifont=Monaco\ for\ Powerline:h12
endif

if exists("&fuopt")
    set fuopt+=maxhorz
endif

"----------------------------------------------------------------------
" Key Mappings
"----------------------------------------------------------------------
" Remap a key sequence in insert mode to kick me out to normal
" mode. This makes it so this key sequence can never be typed
" again in insert mode, so it has to be unique.
inoremap jj <esc>
inoremap jJ <esc>
inoremap Jj <esc>
inoremap JJ <esc>
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>

" Make j/k visual down and up instead of whole lines. This makes word
" wrapping a lot more pleasent.
map j gj
map k gk

" cd to the directory containing the file in the buffer. Both the local
" and global flavors.
nmap <leader>cd :cd %:h<CR>
nmap <leader>lcd :lcd %:h<CR>

" Shortcut to edit the vimrc
if has("nvim")
    nmap <silent> <leader>vimrc :e ~/nvim/init.vim<CR>
else
    nmap <silent> <leader>vimrc :e ~/.vimrc<CR>
endif

" Shortcut to edit the vimmisc
nmap <silent> <leader>vimmisc :execute "e " . g:vim_home_path . "/plugged/vim-misc/vimrc.vim"<CR>

" Make navigating around splits easier
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
if has('nvim')
  " We have to do this to fix a bug with Neovim on OS X where C-h
  " is sent as backspace for some reason.
  nnoremap <BS> <C-W>h
endif

" Navigating tabs easier
map <D-S-{> :tabprevious
map <D-S-}> :tabprevious

" Shortcut to yanking to the system clipboard
map <leader>y "+y
map <leader>p "+p

" Get rid of search highlights
noremap <silent><leader>/ :nohlsearch<cr>

" Command to write as root if we dont' have permission
cmap w!! %!sudo tee > /dev/null %

" Expand in command mode to the path of the currently open file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Buffer management
nnoremap <leader>d   :bd<cr>

" Terminal mode
if has("nvim")
    tnoremap <esc> <C-\><C-n>
    tnoremap jj <C-\><C-n>
    tnoremap jJ <C-\><C-n>
    tnoremap Jj <C-\><C-n>
    tnoremap JJ <C-\><C-n>
    tnoremap jk <C-\><C-n>
    tnoremap jK <C-\><C-n>
    tnoremap Jk <C-\><C-n>
    tnoremap JK <C-\><C-n>
    nnoremap <Leader>c :terminal <CR>
endif

" Tabs
nnoremap <C-t> :tabnew<CR>
nnoremap <C-c> :tabclose<CR>
nnoremap <C-[> :tabprevious<CR>
nnoremap <C-]> :tabnext<CR>

" CtrlP
nnoremap <leader>t :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>l :CtrlPLine<cr>

"----------------------------------------------------------------------
" Autocommands
"----------------------------------------------------------------------
" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" Don't fold anything.
autocmd BufWinEnter * set foldlevel=999999

"----------------------------------------------------------------------
" Helpers
"----------------------------------------------------------------------

" SyncStack shows the current syntax highlight group stack.
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif

    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')
endfunc

"----------------------------------------------------------------------
" Plugin settings
"----------------------------------------------------------------------
" Airline
let g:airline_powerline_fonts = 1
" Don't need to set this since Dracula includes a powerline theme
" let g:airline_theme = "powerlineish"

" CtrlP
let g:ctrlp_max_files = 10000
if has("unix")
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
    \ }
endif

let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
  let line = getline('.')
  let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
  exec "bd" bufid
  exec "norm \<F5>"
endfunc<D-j>

" JavaScript & JSX
let g:jsx_ext_required = 0

" JSON
let g:vim_json_syntax_conceal = 0

" Default SQL type to PostgreSQL
let g:sql_type_default = 'pgsql'

"----------------------------------------------------------------------
" Neovim
"----------------------------------------------------------------------
if has("nvim")
  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>

  " In neovim, we configure more things via Lua
  lua require("vim-misc")
endif
