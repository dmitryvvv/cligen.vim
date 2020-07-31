" Vim syntax file
" Language:     cligen
" Maintainer:   Dmitry Vakhrushev <dmitry@netgate.com>
" Last Change:  Jul 30, 2020

syn keyword cligenKeyword
    \ show
    \ range
    \ length
    \ fraction-digits
    \ choice
    \ keyword
    \ regexp
    \ translate

syn match cligenOperators /[\{\}\(\)\<\>]/

syn keyword cligenType
    \ string macaddr
    \ int8 int16 int32 int64
    \ uint8 uint16 uint32 uint64
    \ decimal64
    \ ipv4addr ipv4prefix
    \ ipv6addr ipv6prefix
    \ bool on off true false
    \ url uuid time
    \ rest

syn match cligenSeparators /[:|;,]/

syn match   cligenComment /#.*/
syn match   cligenIdentifier /\h\(\w\|-\)\+/ contained
syn match   cligenNumber /[-+]?[0-9]\+/ contained
syn match   cligenDecimal /[-+]?[0-9]\+\.[0-9]\+/ contained 
syn region  cligenPreprocLine start=/\u/ end=/;/ contains=cligenPreproc,cligenString,cligenSeparators
syn region  cligenPreproc  start=/\u/ end=/=/me=e-1 containedin=cligenPreprocLine

syn region cligenString matchgroup=cligenQuote start=/"/ skip=/\\"/ end=/"/

syn region  cligenParams   start='('ms=s+1 end=')'me=e-1 contained contains=cligenString,cligenSeparators
syn region  cligenCommand  start=/\h\(\w\|-\)\+(/ end=/)/ oneline contains=cligenParams
syn region  cligenExpand   start=/\h\(\w\|-\)\+(/ end=/)/ oneline contained contains=cligenParams
syn region  cligenFunction start=/\h\(\w\|-\)\+(/ end=/)/ oneline contained contains=cligenParams
syn region  cligenCallback start=/,/ skip=/\n/ end=/,\|;/me=e-1 contains=cligenFunction

syn region  cligenVariableFractionDigits start=/fraction-digits:/ end=/[0-9]+/ contains=cligenKeyword,cligenNumber,cligenSeparators
syn region  cligenVariableLength start=/length\[/ end=/\]/ contains=cligenKeyword,cligenNumber,cligenDecimal,cligenSeparators
syn region  cligenVariableRange start=/range\[/ end=/\]/ contains=cligenKeyword,cligenNumber,cligenDecimal,cligenSeparators
syn region  cligenVariableChoice start=/choice:/ end=/>\|\s/me=e-1 contains=cligenKeyword,cligenIdentifier,cligenNumber,cligenDecimal,cligenSeparators
syn region  cligenVariableName start=/<\h/ms=s+1 end=/>\|:\|\s/me=e-1 contained
syn match   cligenVariableType /:\w\+>\|:\w\+\s/ms=s+1,me=e-1 contained

syn cluster cligenVariableCluster contains=cligenVariableName,cligenVariableType
syn cluster cligenVariableCluster add=cligenExpand
syn cluster cligenVariableCluster add=cligenVariableFractionDigits
" syn cluster cligenVariableCluster add=cligenVariableNumber
syn cluster cligenVariableCluster add=cligenVariableLength
syn cluster cligenVariableCluster add=cligenVariableRange
syn cluster cligenVariableCluster add=cligenVariableChoice
syn region  cligenVariable start='<' skip='\n' end='>' oneline contains=@cligenVariableCluster

syn region  cligenVariableFull start=/</ end=/)/ oneline contains=cligenVariable,cligenParams	

syn cluster cligenRegionCluster contains=cligenVariableFull,cligenCommand,cligenCallback
syn region  cligenRegion start='{' end='}' contains=@cligenRegionCluster

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "cligen"

highlight default link cligenComment Comment
highlight default link cligenPreproc PreProc
" highlight default link cligenIdentifier Identifier
highlight default link cligenString String
highlight default link cligenKeyword Keyword
highlight default link cligenNumber Number
highlight default link cligenDecimal Number
highlight default link cligenOperators Operator
highlight default link cligenVariableName Tag
highlight default link cligenVariableType Type
highlight default link cligenParams Todo
highlight default link cligenCallback Function
highlight default link cligenFunction Function
highlight default link cligenExpand Function
highlight default link cligenCommand Label
highlight default link cligenSeparators Label

" vim: set et sw=4 sts=4 ts=8:
