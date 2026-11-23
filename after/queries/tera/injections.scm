; extends

; inject the templated (host) language into the raw text between tera tags
((content) @injection.content
  (#set-tera-host-lang!)
  (#set! injection.combined))
