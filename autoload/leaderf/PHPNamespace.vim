if leaderf#versionCheck() == 0
    finish
endif

if !exists('g:Lf_PHPNamespaceExpandToAbsolute')
    let g:Lf_PHPNamespaceExpandToAbsolute=1
endif

exec g:Lf_py "import vim, sys, os.path"
exec g:Lf_py "cwd = vim.eval('expand(\"<sfile>:p:h\")')"
exec g:Lf_py "sys.path.insert(0, os.path.join(cwd, 'python'))"
exec g:Lf_py "from phpnamespaceExpl import *"

function! leaderf#PHPNamespace#Maps()
    nmapclear <buffer>
    nnoremap <buffer> <silent> <CR>          :exec g:Lf_py "phpnamespaceExplManager.accept()"<CR>
    nnoremap <buffer> <silent> o             :exec g:Lf_py "phpnamespaceExplManager.accept()"<CR>
    nnoremap <buffer> <silent> t             :exec g:Lf_py "phpnamespaceExplManager.accept('t')"<CR>
    nnoremap <buffer> <silent> <2-LeftMouse> :exec g:Lf_py "phpnamespaceExplManager.accept()"<CR>
    nnoremap <buffer> <silent> q             :exec g:Lf_py "phpnamespaceExplManager.quit()"<CR>
    nnoremap <buffer> <silent> i             :exec g:Lf_py "phpnamespaceExplManager.input()"<CR>
    nnoremap <buffer> <silent> <F1>          :exec g:Lf_py "phpnamespaceExplManager.toggleHelp()"<CR>

    if has_key(g:Lf_NormalMap, "PHPNamespace")
        for i in g:Lf_NormalMap["PHPNamespace"]
            exec 'nnoremap <buffer> <silent> '.i[0].' '.i[1]
        endfor
    endif
endfunction

function! leaderf#PHPNamespace#GenerateManagerID()
    " pyxeval() has bug
    if g:Lf_PythonVersion == 2
        return pyeval("id(phpnamespaceExplManager)")
    else
        return py3eval("id(phpnamespaceExplManager)")
    endif
endfunction

function! leaderf#PHPNamespace#ImportFQCN(fqcn)
    if search('^use\s\+' . escape(a:fqcn, '\\') . ';', 'nb') > 0
        echomsg 'The FQCN has already been imported!'
        return
    endif

    let l:append_lnum = 1 " Append after the first line if no proper line is found
    let l:append_empty_line = v:true

    if search('^use\s', 'nb') > 0 " Append after the last use statement
        let l:append_lnum = search('^use\s', 'nb')
        let l:append_empty_line = v:false
    elseif search('^namespace\s', 'nb') > 0 " or append after the namespace line
        let l:append_lnum = search('^namespace\s', 'nb')
    elseif search('^<?', 'nb') > 0 " or append after the <?php tag
        let l:append_lnum = search('^<?', 'nb')
    endif

    if l:append_empty_line == v:true
        call append(l:append_lnum, '')
        let l:append_lnum += 1
    endif

    call append(l:append_lnum, "use " . a:fqcn . ';')
endfunction

function leaderf#PHPNamespace#ExpandFQCN(fqcn)
    let l:fqcn = a:fqcn
    if g:Lf_PHPNamespaceExpandToAbsolute == 1
        let l:fqcn = '\' . l:fqcn
    endif

    exec 'normal! viws' . l:fqcn
endfunction
