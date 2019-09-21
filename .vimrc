source ~/.vim/plugins.vim

" configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1

" set global clipboard
set clipboard=unnamedplus

" set indenting to 4 spaces
set shiftwidth=4
set tabstop=4

" disable autoindent on paste from global clipboard

function! BuildYCM(info)
      " info is a dictionary with 3 fields
      "   " - name:   name of the plugin
      "     " - status: 'installed', 'updated', or 'unchanged'
      "       " - force:  set on PlugInstall! or PlugUpdate!
      if a:info.status == 'installed' || a:info.force
      	!./install.py
      endif
endfunction


" Show NERDTree on vim startup
autocmd vimenter * NERDTree
" Show dotfiles in NERDTree
let NERDTreeShowHidden=1

" Styling
syntax enable
set background=dark
" let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_bold = 0
let g:solarized_termtrans = 1
" let g:solarized_termcolors = 16
colorscheme solarized


let g:airline_solarized_bg='dark'

" Automatically show line numbers
set nu
syntax on

" Allow Markdown previewing
let vim_markdown_preview_github=1
