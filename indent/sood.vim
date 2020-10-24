if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal nolisp
setlocal autoindent

setlocal indentkeys+=else,=..
setlocal cinwords=if,else,while,function
setlocal indentexpr=GetSoodIndent()

if exists("*GetSoodIndent")
  finish
endif

let s:keepcpo = &cpo
set cpo&vim

function! s:skip_blanks_and_comments(lnum)
  let lnum = a:lnum
  while lnum > 1
    let lnum = prevnonblank(lnum)
    if getline(lnum) =~ '^\s*#'
      let lnum = lnum - 1
    else
      break
    endif
  endwhile
  return lnum
endfunction

function! s:last_different_indent(lnum)
  let lnum = a:lnum
  let oind = indent(lnum)
  while lnum > 1
    let lnum -= 1
    if indent(lnum) != oind
      return lnum
    endif
  endwhile
  return lnum
endfunction

func GetSoodIndent()
  let sw1 = shiftwidth()
  let sw2 = 2 * sw1

  " A `!` will break this, qq
  silent if has('syntax_items') && synIDattr(synID(
        \   v:lnum - 1,
        \   len(getline(v:lnum - 1)), 1
        \ ), "name") =~ "String$"
    return -1
  endif

  let plnum = s:skip_blanks_and_comments(v:lnum - 1)
  if plnum == 0 | return 0 | endif

  let pli = indent(plnum)

  " Yes, I'm aware this will skip strings with '#' in them
  let pline = substitute(getline(plnum), '\s*#.*', '', '')

  if pline =~ ',\s*$'
    let pplnum = s:last_different_indent(plnum)
    if pli > (indent(pplnum) + sw2)
      return pli - sw2
    else
      return pli + sw1
    endif
  endif

  if pline =~ '[^\.]\.\s*$'
    return pli
  endif

  if pline =~ '\.\.\s*$'
    return pli - sw1
  endif

  if pline =~ ':\s*$'
    return pli + sw3
  endif

  return pli + sw2
endfunc

let &cpo = s:keepcpo
unlet s:keepcpo
