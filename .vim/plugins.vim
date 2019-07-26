
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
Plug 'lifepillar/vim-solarized8'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Configure language syntax
Plug 'pangloss/vim-javascript'

" Configure Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LSP Configuration - https://github.com/prabirshrestha/vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" LSP Snippets https://github.com/thomasfaingnaert/vim-lsp-ultisnips
Plug 'SirVer/ultisnips'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

" You Complete Me
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()
