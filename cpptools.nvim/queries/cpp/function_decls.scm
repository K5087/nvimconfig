(function_declarator
  declarator: [
    (identifier) @name
    (field_identifier) @name
    (qualified_identifier) @name
  ]
  parameters: (parameter_list) @param) @func
