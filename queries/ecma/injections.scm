; extends
((template_string) @injection.content
  ;; TODO: \s pattern on #match? doesn't work for some reason
  (#lua-match? @injection.content "^`%s*;+%s?query")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "query"))
