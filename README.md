# Leaderf-phpnamespace

This plugin uses the power of [LeaderF](https://github.com/Yggdroot/LeaderF) to perform PHP namespace related tasks.

## Features

- Insert `use` statements for FQCNs.
- Sort `use` statements alphabetically.
- Expand class names to FQCNs.
- Insert namespace for the current file.
- All the above features support the fuzzy searching function and all the three modes (nameonly, fullpath and regex) provided by LeaderF.

## Requirements

- [LeaderF](https://github.com/Yggdroot/LeaderF)
- ctags is properly configured in Vim/Neovim.

## Install

### vim-plug

```vim
Plug 'xbot/Leaderf-phpnamespace'
```

## Setup

```vim
" Import the current class under cursor
noremap <leader>iu :<C-U><C-R>=printf("Leaderf phpns --input %s", expand("<cword>"))<CR><CR>
" Expand the classname under cursor to its FQCN form.
noremap <leader>ec :<C-U><C-R>=printf("Leaderf phpns --input %s --expand", expand("<cword>"))<CR><CR>
```

## Commands

| Command            | Description                            |
| ---                | ---                                    |
| LeaderfPhpns       | Choose an FQCN to import.              |
| PHPNamespaceInsert | Insert namespace for the current file. |

Press `F1` to get more help

## Options

| Option                            | Default | Description                                                             |
| ---                               | ---     | ---                                                                     |
| g:Lf_PHPNamespaceExpandToAbsolute | 1       | Expand the classname under cursor to absolute FQCN.                     |
| g:Lf_PHPNamespaceSortAfterImport  | 1       | Sort the `use` statements block alphabetically after importing a class. |

## Credits

- [arnaud-lb/vim-php-namespace](https://github.com/arnaud-lb/vim-php-namespace)

## LICENSE

MIT
