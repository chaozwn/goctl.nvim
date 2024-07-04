if exists('b:current_syntax') | finish | endif

syn case match

" set up keywords
syn keyword apiVersion        syntax
syn keyword apiImport         import 
syn keyword apiTypeDelaration type   
syn keyword apiService        service
syn keyword apiInfo           info   

hi def link apiVersion        Statement
hi def link apiImport         Statement
hi def link apiTypeDelaration Keyword
hi def link apiService        Keyword
hi def link apiInfo           Keyword

" ----------------------------------

syn keyword apiStatement get post delete put returns
syn region apiExplainServer  start="@server"  end=")"
syn region apiExplainHandler start="@handler" end="\n"
syn region apiExplainDoc     start="@doc"     end="\n"

hi def link apiStatement      Statement
hi def link apiExplainServer  Normal
hi def link apiExplainHandler Normal
hi def link apiExplainDoc     Normal 

syn match apiServer "@server"
syn match apiHandler "@handler"
syn match apiDoc "@doc"
hi def link apiServer Keyword
hi def link apiHandler Keyword
hi def link apiDoc Keyword

"-----------------------------------

syn keyword apiType bool int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 uintptr  float32 float64 complex64 complex128 string byte rune
hi def link     apiType              Function

" Strings and their contents
syn match apiTypeName "\w\+\(-\w\+\)*\s*{" 
hi def link apiTypeName Type

" syn match serviceName "\w\+\s*{" contains=apiService
" hi def link serviceName Type

syn region      apiVaiable           start=+(+ end=+)+
hi def link apiVaiable Type

syn region      apiString            start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region      apiRawString         start=+`+ end=+`+

hi def link     apiString            String
hi def link     apiRawString         String

syn region      apiCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+
hi def link     apiCharacter         Character

syn match apiSingleLineComment "//.*" contains=@Spell
hi def link apiSingleLineComment Comment

syn region apiMultiLineComment start="/\*" end="\*/" contains=@Spell
hi def link apiMultiLineComment Comment

let b:current_syntax = 'goctl'
