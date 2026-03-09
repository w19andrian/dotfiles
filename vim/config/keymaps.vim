" remap leader
let mapleader = " "

" Add new line below/above cursor without entering Insert mode
nnoremap o o<esc>
nnoremap O O<esc>

" Open file explorer
nnoremap <leader>e :Explore<CR>

" Fu[Git]ive bindings
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gP :Git push<CR>
