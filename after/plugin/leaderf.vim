" Definition of 'arguments' can be similar as
" https://github.com/Yggdroot/LeaderF/blob/master/autoload/leaderf/Any.vim#L85-L140
let s:extension = {
      \   "name": "phpns",
      \   "help": "PHP namespace resolver",
      \   "manager_id": "leaderf#PHPNamespace#GenerateManagerID",
      \   "arguments": [
      \       {"name": ["--expand"], "nargs": "0", "help": "expand the class name under cursor to its FQCN."},
      \   ]
      \ }

" In order that `Leaderf phpns` is available
call g:LfRegisterPythonExtension(s:extension.name, s:extension)

command! -bar -nargs=0 LeaderfPhpns Leaderf phpns
command! -bar -nargs=0 PHPNamespaceInsert call leaderf#PHPNamespace#InsertNamespace()

" In order to be listed by :LeaderfSelf
call g:LfRegisterSelf("LeaderfPhpns", "perform PHP namespace related tasks")

