" Package Manager (Vundle) {{{

set nocompatible                    " be iMproved, required
set shell=/bin/zsh
filetype off                        " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'       " let Vundle manage Vundle, required
Plugin 'dracula/vim'                    " Dracula theme
Plugin 'croaker/mustang-vim'            " Mustang theme
Plugin 'bcicen/vim-vice'                " Vice theme
Plugin 'vim-airline/vim-airline'        " Status line and text
Plugin 'vim-airline/vim-airline-themes' " Status line themes
Plugin 'edkolev/tmuxline.vim'           " Sync TMUX theme with airline
Plugin 'CursorLineCurrentWindow'        " Hide cursor line in inactive splits
Plugin 'scrooloose/nerdtree'            " NERDTree (Navigation bar)
Plugin 'Xuyuanp/nerdtree-git-plugin'    " NERDTree git integration
Plugin 'sjl/gundo.vim'                  " GUndo (Undo tree)
Plugin 'wincent/terminus'               " Better terminal integration (paste, cursor shape, mouse integration)
Plugin 'tpope/vim-fugitive'             " Git integration
Plugin 'vim-ctrlspace/vim-ctrlspace'    " Navigation and fuzzy search
Plugin 'editorconfig/editorconfig-vim'	" EditorConfig
Plugin 'valloric/youcompleteme'         " Autocomplete solution
Plugin 'flowtype/vim-flow'              " Flow-type autocomplete
Plugin 'cohama/lexima.vim'              " Autoclose parens, quotes etc
Plugin 'jelera/vim-javascript-syntax'   " VIM Javascript syntax with ES2015 template strings support
Plugin 'w0rp/ale'                       " Async linter for vim 8 (https://github.com/w0rp/ale)
" Plugin 'plasticboy/vim-markdown'
" Plugin 'mattly/vim-markdown-enhancements' " MultiMarkdown and CriticMarkup extensions
" Plugin 'reedes/vim-pencil'              " Working with prose-oriented filetypes (wrapping, formatting etc)
Plugin 'terryma/vim-multiple-cursors'   " Multiple cursorn on Ctrl+n (skip via Ctrl+x)
Plugin 'SirVer/ultisnips'               " Snippets engine
Plugin 'honza/vim-snippets'             " Snippets
Plugin 'elmcast/elm-vim'                " Elm support
Plugin 'ternjs/tern_for_vim'            " Tern for Vim
Plugin 'AlessandroYorba/Sierra'         " Sierra color theme
Plugin 'scrooloose/nerdcommenter'       " Orgasmic comments
Plugin 'slashmili/alchemist.vim'        " Support for Elixir
Plugin 'elixir-editors/vim-elixir'      " Elixir syntax highlight
Plugin 'carlosgaldino/elixir-snippets'  " Elixir snippets
Plugin 'epmatsw/ag.vim'
Plugin 'prettier/vim-prettier'
Plugin 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plugin 'reasonml-editor/vim-reason-plus'
Plugin 'jeffkreeftmeijer/vim-numbertoggle' " Smart line number toggling
Plugin 'sonph/onehalf'                  " Color theme

call vundle#end()                       " required
filetype plugin indent on               " required

" }}}



" Essentials {{{

set hidden                          " allow unsaved buffers
set showtabline=0
set timeoutlen=250                  " tune shortcut timeout
set ttimeoutlen=10                  " tune keycode timeout
" set t_ut=                           " prevent backgound glitches in TMUX

" }}}


" Markdown {{{

let g:vim_markdown_conceal = 0

" }}}



" Terminus {{{

let g:TerminusFocusReporting=0
let g:TerminusAssumeITerm=1
let g:TerminusMouse=1
let g:TerminusInsertCursorShape=1

" }}}



" Nerd Commenter {{{

let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign='left'
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1

" }}}



" Colors and UI {{{
set termguicolors                   " enable true color
set background=dark
set t_Co=256
silent! colorscheme onehalfdark " theme (silent because plugins might not be installed)
let g:airline_theme='onehalfdark'
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
let g:airline_powerline_fonts=1     " use powerline fonts in status line (Airline)
let g:airline_skip_empty_sections=1 " do not show empty sections in Airline
set statusline=2                    " show custom statusline (Airline)
set laststatus=2                    " show custom statusline (Airline) with no splits
set noshowmode                      " disable default mode indication
syntax enable                       " syntax highlignting
set number relativenumber
" set cursorline                      " highlight current line
set wildmenu                        " visual autocomplete for command menu
set visualbell                      " visual bell instead of beeping
set showcmd                         " show command in bottom bar
set cmdheight=1                     " command line height
set shortmess=a                     " abbreviate vim messages in cmd line
set history=1000                    " command line history levels
set scrolloff=10                    " lines around cursor
" overflow background
execute "set colorcolumn=" . join(range(81,335), ',')

set textwidth=120
set colorcolumn=+1

set synmaxcol=128
syntax sync minlines=256
set lazyredraw


" }}}


" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String


" Splits {{{

set splitbelow
set splitright

" }}}


" Tabs navigation (via Airline) {{{

let g:airline#extensions#tabline#enabled=1          " enhanced tabline
let g:airline#extensions#tabline#fnamemod=':t'      " format filename (show only name)
let g:airline#extensions#tabline#fnamecollapse=0    " do not abbreviate path
let g:airline#extensions#tabline#formatter='unique_tail_improved' " handle similar filenames
let g:airline#extensions#tabline#show_buffers=0     " always show tabs (not buffers)
" shortcuts to switch tabs
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

"}}}



" Keymap and Keyboard Layout Switching {{{

" Allow VIM shortcuts while working in Russian
" See: https://habrahabr.ru/post/98393/
" TODO: https://github.com/lyokha/vim-xkbswitch

"set keymap=russian-jcukenmac        " use custom keymap (Ctrl + 6 or Ctrl + ^ to switch)
set iminsert=0
set imsearch=0

" }}}



" Whitespace (Tabs and Spaces) {{{

set expandtab                       " tabs to spaces
set tabstop=2                       " spaces per tab
set softtabstop=2                   " same for editing
set shiftwidth=2                    " same for identing (...doh!)
set smarttab
set nowrap                          " don't wrap lines
set linebreak                       " wrap lines at convenient points
set autoindent                      " automatically set ident of a new line
set backspace=indent,eol,start      " what is backspase
set list listchars=tab:\ \ ,trail:· " show whitespace at eol
autocmd FileType c,cpp,java,php,javascript,js,css,scss autocmd BufWritePre <buffer> :%s/\s\+$//e  " remove whitespace at eol on save

" }}}



" Searching {{{

set incsearch                       " set search to incremental
set hlsearch                        " highlight matches
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>   " cancel search on ESC
set ignorecase                      " ignore search case...
set smartcase                       " ...but only if pattern has no capitals

" }}}



" Folding {{{

set foldenable                      " enable folding
set foldlevelstart=10               " open most folds by default
set foldnestmax=10                  " 10 nested fold max
set foldmethod=indent               " fold based on indent level

" }}}



" Leader key {{{

map <Space> <Leader>

" }}}



" Mouse {{{

set mouse=a                         " enable mouse an a(ll) modes

" }}}



" Edit history (and Gundo) {{{

set undolevels=1000                 " max undo levels
nnoremap <leader>u :GundoToggle<CR> " map undo history to SPACE + u

" }}}



" Saving, Backup and History {{{

set autoread                        " auto reload file
set noswapfile
set nobackup
set nowb

" }}}



" Clipboard {{{

" See: http://www.markcampbell.me/2016/04/12/setting-up-yank-to-clipboard-on-a-mac-with-vim.html

if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" }}}



" NERDTree {{{

let NERDTreeIgnore=['\~$', 'node_modules[[dir]]', 'deps[[dir]]', '.DS_Store']
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1           " show hidden files
let NERDTreeMouseMode=2            " toggle dirs vith single click
" open in sidebar
nmap <Leader>n :let NERDTreeQuitOnOpen=0<bar>NERDTreeToggle<CR>
" open and reveal file (and close on file select)
nmap <Leader>o :let NERDTreeQuitOnOpen=1<bar>:e .<CR>
nmap <Leader>r :NERDTreeFind<CR>
" quit on q
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" }}}



" CtrlSpace {{{

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceSearchTiming = 150
let g:airline_exclude_preview = 1
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceIgnoredFiles = '\(node_modules\|ios\|android\)[\/]'

nnoremap <silent><Tab> :CtrlSpace<CR>
nnoremap <silent><Leader>p :CtrlSpace O<CR>

"}}}



" EditorConfig {{{

" Play nice with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*', '*.jade']

" }}}

" YouCompleteMe {{{

set shortmess+=c                    " disable annoying auotocompletion messages
let g:ycm_complete_in_comments=1    " completion in comments
let g:ycm_min_num_of_chars_for_completion=3
let g:ycm_semantic_triggers = {
    \ 'elm' : ['.'],
    \}
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}



" Vim-Flow {{{

let g:flow#enable = 0               " let Ale do the checking

" }}}



" Prettier {{{

nnoremap <leader>cf :Prettier<CR>

" }}}


" Ale {{{
"
let g:ale_linters = { 'javascript': ['eslint'] }

" }}}



" Vim-Javascript {{{

let g:javascript_plugin_jsdoc=1
let g:javascript_plugin_ngdoc=1
let g:javascript_plugin_flow=0

" }}}



" Elm-Vim {{{

let g:elm_setup_keybindings = 0

" }}}


" OCaml / ReasonML {{{

let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

" }}}



" Snippets {{{

let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsEditSplit='vertical'

" }}}



" Markown and alike (Pencil plugin) {{{

" let g:pencil#textwidth = 120
" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd,text call pencil#init({'wrap': 'hard'})
"   autocmd Filetype git,gitsendemail,*commit*,*COMMIT* call pencil#init({'wrap': 'hard'})
" augroup END
"
"}}}



" Pane navigation & seamless TMUX integration {{{

" See http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits

let g:tmux_navigator_no_mappings = 1

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" }}}



" Autofixing common typos {{{

iabbrev funciton function
iabbrev conosle console
iabbrev retrun return

" }}}



" Fix arrow keys behavior in vim in tmux in docker in iTerm
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>


" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader>f :Ag<SPACE>



" Autoreload vimrc {{{

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" }}}


" TODO: перейти на Plug и lazy плагины:
"   https://jordaneldredge.com/blog/why-i-switched-from-vundle-to-plug/
" TODO: http://javascriptplayground.com/blog/2017/01/vim-for-javascript/
" TODO: https://github.com/xolox/vim-notes или https://github.com/vimwiki/vimwiki
" TODO: настроить https://github.com/edkolev/tmuxline.vim
" TODO: настроить, что бы скролл мышкой оставлял курсор на месте, даже когда тот уходит с видимого экрана
" TODO: Подумать про http://vim.wikia.com/wiki/Quick_command_in_insert_mode
" TODO: Настроить перемещение строк https://dockyard.com/blog/2013/09/26/vim-moving-lines-aint-hard
"  скорее всего по ctrl + alt + стрелка

