if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "sood"

let s:cpo_save = &cpo
set cpo&vim

syn keyword SoodBoolean     true false
syn keyword SoodStatement   is a an and called of with
syn keyword SoodKeyword     value type default return arguments
syn keyword SoodConditional if while until else equal less more
syn keyword SoodSpecial     not negative than to 
syn keyword SoodOperator    plus minus multiplied divided by
syn keyword SoodType        integer boolean string float function

syn match SoodGrammatic "[,.;:]"

syn keyword SoodTodo    FIXME NOTE NOTES TODO XXX contained
syn keyword SoodTodo    fixme note notes todo contained
syn match   SoodComment	"#.*$" contains=SoodTodo,@Spell

syn match  SoodEscape +\\[abfnrtv'"\\]+ contained
syn region SoodString start=+"+ skip=+\\\\\|\\"\|\n\|\r+ end=+"\|$+ contains=SoodEscape
syn region SoodString start=+'+ skip=+\\\\\|\\'\|\n\|\r+ end=+'\|$+ contains=SoodEscape

hi def link SoodBoolean     Boolean
hi def link SoodKeyword     Keyword
hi def link SoodGrammatic   Special
hi def link SoodStatement   Statement
hi def link SoodSpecial     Special
hi def link SoodConstant    Constant
hi def link SoodConditional Conditional
hi def link SoodOperator    Operator
hi def link SoodType        Type
hi def link SoodTodo        Todo
hi def link SoodComment     Comment
hi def link SoodEscape      Escape
hi def link SoodString      String

let &cpo = s:cpo_save
unlet s:cpo_save
