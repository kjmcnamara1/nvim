; extends

; r,f,b,u prefixes before strings
((string_start) @string.prefix
  (#lua-match? @string.prefix "^[rfbuRFBU]+[\"']$")
  (#offset! @string.prefix 0 0 0 -1)
  (#set! @string.prefix priority 110))

((string_start) @string.prefix
  (#match? @string.prefix "^[rfbuRFBU]+[\"']{3}$")
  (#offset! @string.prefix 0 0 0 -3)
  (#set! @string.prefix priority 110))

; String quotes
; [(string_start)(string_end)] @punctuation.quote
; doc-strings
; (expression_statement
;   (string) @string.documentation
;   (#set! @string.documentation priority 110))
; ((comment) @comment.todo
; (#match? @comment.todo "^# ?\\[ ?\\]: ?")
; (#set! priority 105))
; ((comment) @comment.deprecated
; (#match? @comment.deprecated "^##")
; (#set! priority 110))
