" automatically clears trailing whitespace after saving
autocmd BufWritePre * :%s/\s\+$//e
