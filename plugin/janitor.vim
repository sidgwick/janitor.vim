" janitor.vim
"
" plugin created just for remove extra whitespaces at
" end of each line
"
"                                         by Aleksandr Koss (http://nocorp.me)

if !exists('g:janitor_enable_highlight')
    let g:janitor_enable_highlight = 1
endif

if !exists('g:janitor_auto_clean_up_on_write')
    let g:janitor_auto_clean_up_on_write = 0
endif

if !exists('g:janitor_exclude_on_trailing_spaces')
    let g:janitor_exclude_on_trailing_spaces = []
endif

" Remove all spaces from end in each line
fun! RemoveSpaces()
    if &bin | return | endif
    if search('\s\+$', 'n')
        let line = line('.')
        let col = col('.')
        sil %s/\s\+$//ge
        call cursor(line, col)
    endif
endf

function! JanitorHighlightAll()
    let g:janitor_is_highlight = 1
    " highlight trailing space
    highlight TrailingSpaces ctermbg=red guibg=red
    let g:match_id_trailing_spaces = matchadd('TrailingSpaces', '\s\+$')
endfunction

function! JanitorClearHighlight()
    let g:janitor_is_highlight = 0
    call matchdelete(g:match_id_trailing_spaces)
endfunc

function! JanitorToggleHighlight()
    if g:janitor_is_highlight
        call JanitorClearHighlight()
    else
        call JanitorHighlightAll()
    endif
endfunc


" if index(g:janitor_exclude_on_trailing_spaces, &filetype) == -1
"     return
" endif

if g:janitor_enable_highlight
    call JanitorHighlightAll()
endif

" Bind RemoveSpaces to autocommand
autocmd BufWritePre * call RemoveSpaces()

command! JanitorHighlightAll                call JanitorHighlightAll()
command! JanitorClearHighlight              call JanitorClearHighlight()
command! JanitorToggleHighlight             call JanitorToggleHighlight()
