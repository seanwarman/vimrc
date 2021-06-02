func ActionCreator()
  let action_creator = input('Action Creator Function Name: ')
  let payload_type = input('Payload Type: ')

  let type_const = toupper(substitute(action_creator, '\(\u\)', '_\1', 'g'))
  let action_type = toupper(action_creator[0]) . slice(action_creator, 1) . 'Action'

  call execute("norm iexport const " . type_const . " = '" . type_const .  "';\n\n")
  call execute("norm iexport const " . action_creator . " = (payload: " .  payload_type . "): " . action_type . " => {\nreturn {\ntype: " . type_const .  ",\npayload,\n};\n};\n\n")
  call execute("norm iexport interface " . action_type . " {\ntype: typeof " .  type_const . ";\npayload: " . payload_type . ";\n}\n")
   
endfunc

func PlainAC(funcName, payload, type)
  let l:typeName = toupper(substitute(a:funcName, '\(\u\)', '_\1', 'g'))
  call execute("norm iexport const " . l:typeName . " = '" . l:typeName .  "';\n\nexport function " . a:funcName . "(" . a:payload . ": " . a:type . ") {\nreturn {\ntype: " .  l:typeName . ",\npayload: {" . a:payload . "},\n};\n}")
  call execute("norm ='[/payload\nf{cs{{")
endfunc
