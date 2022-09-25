# LeaderF-phpnamespace

This plugin uses the power of [LeaderF](https://github.com/Yggdroot/LeaderF) to perform PHP namespace related tasks.

## Features

- Insert `use` statements for FQCNs.
- [ ] Expand class names to FQCNs.
- [ ] Insert namespace for the current file.
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
noremap <leader><leader>iu :<C-U><C-R>=printf("Leaderf phpns --input %s", expand("<cword>"))<CR><CR>
```

## Commands

```vim
:LeaderfPhpns
```

Press `F1` to get more help

## LICENSE

MIT
