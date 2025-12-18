" Vim syntax file for DBML (Database Markup Language)
" Language: DBML
" Maintainer: Custom

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword dbmlKeyword Table Project Enum Ref TableGroup Note Indexes
syn keyword dbmlKeyword as nextgroup=dbmlAlias skipwhite

" Settings/Attributes (inside brackets)
syn keyword dbmlAttribute pk primary key increment unique
syn keyword dbmlAttribute not null default ref name type
syn match dbmlAttribute /\<note\>/ contained

" Types
syn match dbmlType /\<\(int\|varchar\|text\|longtext\|boolean\|float\|double\|decimal\|date\|datetime\|timestamp\|json\|blob\)\>/
syn match dbmlType /\<\(int\|varchar\)(\d\+)/

" Strings (single and double quoted)
syn region dbmlString start=/"/ skip=/\\"/ end=/"/
syn region dbmlString start=/'/ skip=/\\'/ end=/'/
syn region dbmlString start=/'''/ end=/'''/

" Numbers
syn match dbmlNumber /\<\d\+\>/

" Comments
syn match dbmlComment /\/\/.*$/
syn region dbmlComment start=/\/\*/ end=/\*\//

" Brackets and delimiters
syn match dbmlBracket /[{}\[\]()]/
syn match dbmlDelimiter /[,:\.]/

" Reference operators
syn match dbmlOperator /<\|>\|-/

" Identifiers (quoted)
syn match dbmlIdentifier /"[^"]*"/

" Highlighting links
hi def link dbmlKeyword Keyword
hi def link dbmlAttribute Type
hi def link dbmlType Type
hi def link dbmlString String
hi def link dbmlNumber Number
hi def link dbmlComment Comment
hi def link dbmlBracket Delimiter
hi def link dbmlDelimiter Delimiter
hi def link dbmlOperator Operator
hi def link dbmlIdentifier Identifier

let b:current_syntax = "dbml"
