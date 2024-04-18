; extends
((template_string) @injection.content
  ;; TODO: \s pattern on #match? doesn't work for some reason
  (#lua-match? @injection.content "^`%s*;+%s?query")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "query"))

( (comment) @comment
  . (template_string) @injection.content
  (#match? comment "/\/\* html \*\//")
  (#offset! @comment 0 3 0 -3)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "html"))
  ; (#set-lang-from-info-string! @comment))
