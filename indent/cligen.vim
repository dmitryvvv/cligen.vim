" indent/cligen.vim

setlocal indentexpr=CligenIndent()

function! CligenIndent()
  let line = getline(v:lnum)
  let prevNum = prevnonblank(v:lnum-1)
  let prev = getline(prevNum)

  if (prev =~ "{" && prev !~ "}" && line !~ "}")
    return indent(prevNum) + &tabstop
  endif

  if (prev =~ "," && prev !~ ";" && line =~ ";")
    return indent(prevNum) + &tabstop
  endif

  if (prev =~ "," && prev !~ ";" && line =~ ",")
    return indent(prevNum) + &tabstop
  endif

endfunction
