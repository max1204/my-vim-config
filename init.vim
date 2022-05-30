call plug#begin('~/.local/share/nvim/plugged')

	Plug 'davidhalter/jedi-vim'

	Plug 'arcticicestudio/nord-vim'

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

	Plug 'scrooloose/nerdtree'

	Plug 'majutsushi/tagbar'

	Plug 'zchee/deoplete-jedi'

	Plug 'vim-airline/vim-airline'

	Plug 'jiangmiao/auto-pairs'

	Plug 'sbdchd/neoformat'

	Plug 'neomake/neomake'
	
	Plug 'terryma/vim-multiple-cursors'

	Plug 'morhetz/gruvbox'

	Plug 'nvim-lua/plenary.nvim'

	Plug 'nvim-telescope/telescope.nvim'

	Plug 'nvim-lua/popup.nvim'

	Plug 'ryanoasis/vim-devicons'

	Plug 'tpope/vim-fugitive'

	Plug 'mhinz/vim-startify'
	
	Plug 'mhinz/vim-signify'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set complete+=kspell
let g:deoplete#enable_at_startup = 1
let g:airline#extensions#tabline#enabled = 1
let NERDTreeShowHidden=1
let g:airline_powerline_fonts = 1
let g:neomake_python_enabled_makers = ['flake8']

set completeopt-=preview
set wildmenu
set title
set wildignore+=**/venv/**
set foldmethod=indent
set foldlevel=99
set clipboard=unnamed
set mouse=a
set completeopt=noinsert,menuone,noselect
set background=dark " use dark mode
"set background=light " uncomment to use light mode
set number relativenumber
" default updatetime 4000ms is not good for async update
set updatetime=100

" Color Scheme 
colorscheme gruvbox
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
syntax on

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

hi Normal guibg=NONE ctermbg=NONE

" Key Mappings for different shortcuts that I want to use
nnoremap ,<space> :nohlsearch<CR>
nnoremap <space>F :%!python -m json.tool<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>cc :Telescope commands<CR>
nnoremap <leader>ll : Telescope live_grep<CR>
nnoremap 22 :NERDTreeToggle <CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" TODO need to work on this to give an accurate data.
"noremap <> :%!python3.8 -m json.tool


" Configuration for tab number and separator 
fu! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
	return empty(string) ? '[unnamed]' : string
endfu

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

fu! MyTabLine()
let s = ''
for i in range(tabpagenr('$'))
" select the highlighting
    if i + 1 == tabpagenr()
    let s .= '%#TabLineSel#'
    else
    let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    "let s .= '%' . (i + 1) . 'T'
    " display tabnumber (for use with <count>gt, etc)
    let s .= ' '. (i+1) . ' ' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    if i+1 < tabpagenr('$')
        let s .= ' |'
    endif
endfor
return s
endfu
set tabline=%!MyTabLine()
