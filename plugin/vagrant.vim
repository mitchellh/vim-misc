" Teach Vim to syntax highlight Vagrantfiles properly.
augroup vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
