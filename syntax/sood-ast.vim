if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "sood-ast"

let s:cpo_save = &cpo
set cpo&vim

syn keyword SoodAstBoolean     true false
syn keyword SoodAstStatement   args func_call read write return
syn keyword SoodAstKeyword     assignment block func_decl var_decl
syn keyword SoodAstConditional if_stmt while_stmt until_stmt else binary_expression unary_expression
syn keyword SoodAstSpecial     lhs rhs op id cond type name from to exp
syn keyword SoodAstType        ident int str float

syn match SoodAstGrammatic "[{}(),.;:]"

syn match SoodAstComment	"#.*$" contains=SoodTodo,@Spell

syn match  SoodAstEscape +\\[abfnrtv'"\\]+ contained
syn region SoodAstString start=+"+ skip=+\\\\\|\\"\|\n\|\r+ end=+"\|$+ contains=SoodEscape
syn region SoodAstString start=+'+ skip=+\\\\\|\\'\|\n\|\r+ end=+'\|$+ contains=SoodEscape

hi def link SoodAstBoolean     Boolean
hi def link SoodAstComment     Comment
hi def link SoodAstConditional Conditional
hi def link SoodAstEscape      Escape
hi def link SoodAstGrammatic   Special
hi def link SoodAstKeyword     Keyword
hi def link SoodAstSpecial     Special
hi def link SoodAstStatement   Statement
hi def link SoodAstString      String
hi def link SoodAstType        Type

let &cpo = s:cpo_save
unlet s:cpo_save
