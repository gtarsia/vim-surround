function! CursorChar()
    return getline('.')[col('.')-1]
endfunction
