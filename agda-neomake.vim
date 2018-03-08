function! neomake#makers#ft#agda#EnabledMakers() abort
    return ['agda']
endfunction

function! neomake#makers#ft#agda#Postprocess(entry) abort
    call neomake#postprocess#compress_whitespace(a:entry)
    if a:entry.text == ''
        let a:entry.type = 'M'
        let a:entry.text = 'Unsolved meta'
    endif
    let a:entry.text = substitute(a:entry.text, 'the following constraints:', 'constraints', '')
endfunction

function! neomake#makers#ft#agda#agda() abort
    return {
        \ 'exe': 'agda',
        \ 'args': ['--vim'],
        \ 'errorformat':
        \   '  /%\&%f:%l\,%c-%.%#,'.
        \   '%E/%\&%f:%l\,%c-%.%#,%C%m,'.
        \   '%+E%>The name of the top level module %.%#,%+Cmodule %f%.%#,'.
        \   '%+GUnsolved metas%.%#,%+GUnsolved interaction metas%.%#,'.
        \   '%+G%>Failed%.%#,'.
        \   '%-G%.%#',
        \ 'postprocess': function('neomake#makers#ft#agda#Postprocess'),
        \ }
endfunction
