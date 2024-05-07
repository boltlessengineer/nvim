; extends
((raw_string_literal) @injection.content
  ;; TODO: \s pattern on #match? doesn't work for some reason
  (#lua-match? @injection.content "^r#\"%s*;+%s?query")
  (#offset! @injection.content 0 3 0 -2)
  (#set! injection.include-children)
  (#set! injection.language "query"))

(call_expression
  function: (scoped_identifier
    path: (identifier) @_path
    name: (identifier) @_name)
  arguments: (arguments
    (string_literal
    (string_content) @injection.content))
  (#eq? @_path "sqlx")
  (#eq? @_name "query")
  (#set! injection.language "sql"))
