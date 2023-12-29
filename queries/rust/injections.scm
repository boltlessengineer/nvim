((raw_string_literal) @injection.content
  ;; TODO: \s pattern on #match? doesn't work for some reason
  (#lua-match? @injection.content "^r#\"%s*;+%s?query")
  (#offset! @injection.content 0 3 0 -2)
  (#set! injection.language "query"))
