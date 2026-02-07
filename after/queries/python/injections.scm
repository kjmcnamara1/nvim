; extends

; Support for the 'regex' library (if you use it)
(call
  function: (attribute
    object: (identifier) @_re
    (#eq? @_re "regex")
    attribute: (identifier))
  arguments: (argument_list
    (string
      (string_content) @injection.content))
  (#set! injection.language "regex"))

; All (raw) r-strings
(string
  (string_start) @_start
  (#lua-match? @_start "^r")
  (string_content) @injection.content
  (#set! injection.language "regex"))
