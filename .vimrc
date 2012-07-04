
" autoindent works better if you fix the backspace key.
set backspace=indent,eol,start

set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

set ruler

set ignorecase
set incsearch
set hlsearch
syntax on
hi Comment ctermfg=2

" <Meta-TAB>/<Meta-Shift-TAB>/<F6> find all tabs (few versions)
map ‰ /	
map [Z /	
" map [17~ /	

" <Ctrl -> find 80 col
map  /\%>79c

" <Meta-t> convert first 8 spaces to tab
map ô 0:s/ \{8\}/	/0k/	
" <Meta-T> convert first tab to 8 spaces
map Ô 0:s/	/        /0

" grow and shrink window
map <F7> 10+
map <F6> 10-

" <Shift-F11> <Shift-F12>
map [23;2~ :set noautoindent
map [24;2~ :set autoindent
" <Alt-F11> <Alt-F12>
map [29~ :set noautoindent
map [31~ :set autoindent

" last and next files, respectively
map <F4> :N
map <F5> :n
" (alt)
map [14~ :N
map [15~ :n
" Ctrl-pagup/down
map <C-PageUp> :bprev<CR>
map <C-PageDown> :bnext<CR>
" (alt)
map [5;5~ :bprev<CR>
map [6;5~ :bnext<CR>

" <Ctrl-!> swap ends of highlighting
map ! v`<xP`>Plx`<Plxi

" comment
map <f8> 0i# j
map <f9> 0i;; j
" (alt)
map [19~ 0i# j
map [20~ 0i;; j

" <Meta-Space> like emacs' turn arbitrary space into one space
map   l?[ 	]/[^ 	]mXb/[ 	]ld`X

" <Ctrl-o> next line (like o), over 4
map  o    
" shift this line
map <F2> V<
map <F3> V>
" (alt)
map [12~ V<
map [13~ V>

" <Ctrl-a> beginning of the line, stupid
map  0

" <Ctrl-Arrow> move around by larger parts
map O5C w
map O5D b
map O5A {
map O5B }
" (alt)
map [5C w
map [5D b
" (alt)
map [1;5C w
map [1;5D b
map [1;5A {
map [1;5B }
" (alt)
map [C w
map [D b
map [A {
map [B }

" <Alt-PgUp>,<Alt-PgDown> (mac)
map , {
map - }

" <Ctrl-Shift-Arrow> make spaces out of my way
map O6C i l
map O6D X
map O6A kdd
map O6B 0i
" (alt)
map [1;6C i l
map [1;6D X
map [1;6A kdd
map [1;6B 0i
 
" <Meta-j>/<Meta-J> syntax highlighting off/on
map j :syntax off
map J :syntax on

" <Meta-u>/<Meta-U> highlighting of search term off/on
map õ :noh
map Õ :set hls
" alt-terminal
map u :noh
map U :set hls

" <Meta-f>/<Meta-F> syntax higlighting off/on
map æ :syntax off
map Æ :syntax on
" alt-terminal
map f :syntax off
map F :syntax on

" <Meta-i>/<Meta-I> ignore case on/off
map é :set ignorecase
map É :set noignorecase
" alt-terminal
map i :set ignorecase
map I :set noignorecase

" <Meta-l>/<Meta-L> Lowercase/Uppercase (some vim, attacks next word)
map ì lbvwu
map Ì lbvwU
" alt-terminal
map l lbvwu
map L lbvwU

" <Meta-%> start substitute command
map ¥ :%s///gcODODODOD
" alt-terminal
map % :%s///gcODODODOD

" <Meta-q> quit
" <Meta-Q> quit!
" <Meta-w> write
" <Meta-W> write!
" <Meta-e> edit
" <Meta-E> edit!
" <Meta-x> write  quit
" <Meta-X> write! quit
map ñ :q
map Ñ :q!
map ÷ :w
map × :w!
map å :e 
map Ò :e! 
map ø :x
map Ø :x!
" alt-terminal
map q :q
map Q :q!
map w :w
map W :w!
map e :e 
map E :e! 
map x :x
map X :x!

" <d, Arrow> don't delete, just move
" seems to be slow
"map dOB j
"map dOA k
"map dOD h
"map dOC l

" <Home> <End> <Pg-Up> <Pg-Down> <Delete> <Insert> (these for vt100)
map [1~ 0
map [4~ $
map [5~ 
map [6~ 
map [3~ x
map [2~ i

" <Meta-d> delete line
map ä dd
" alt-terminal
map d dd


map <F12> <esc>:!bash<return>

let python_highlight_all = 1
