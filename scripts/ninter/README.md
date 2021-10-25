# Vim Node AutoComplete

Should look up a params items by list the params through node itself.

Extend the syntax by adding your deps just like you would in the project. This
project will install them and you'll be able to look up the params because
they're there!

- Understand AST and tools that can parse it (acorn)
  - You can use the acorn cli to parse a given file or you can import the module and parse a string

The rules look like they're as follows:

Object: 'ObjectExpression'
String, Number, Boolean: 'Literal' <-- Can check the "value" prop to find the actual type and protos
Array: 'ArrayExpression'
Function: 'ArrowFunctionExpression', 'FunctionDeclaration'
const, let, var: 'VariableDeclaration'
(): 'ExpressionStatement'

And there's a ton more, depending on whether you're asigning something, what you're expressing etc.

Acorn also has a module called acorn-walk that can walk through the trees and will probably help 
deciphering all this jazz.

- Understand how to call server endpoints with vimscript and whether it can interpret json.
- Parse the code for the current file and use node to suggest items from the constructor of the given definition type.
