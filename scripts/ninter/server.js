const http = require('http')
const acorn = require('acorn-loose')
const walk = require('acorn-walk')

function logLiteral(node, ancestors) {
  if (!node.value) return []
  return log(node, Object.getOwnPropertyNames(node.value));
}

function logFunctionProperties(node, ancestors) {
  return log(node, Object.getOwnPropertyNames(function(){}))
}

function logIdentifier(node, ancestors) {
  if (global[node.name]) {
    return log(node, Object.getOwnPropertyNames(global[node.name]))
  }
  console.log('not on global...', node)
}




function suggest(source, res) {
  const parse = () => acorn.parse(source, { ecmaVersion: 2020 })

  walk.ancestor(parse(), {
    FunctionExpression: logFunctionProperties,
    FunctionDeclaration: logFunctionProperties,
    Literal: logLiteral,
    Identifier: logIdentifier,
  })

  res.writeHead(200)
  res.end()
}








const requestListener = function (req, res) {
  let data = ''
  req.on('data', chunk => {
    data += chunk
  })
  req.on('end', () => {
    suggest(JSON.parse(data).source, res)
  })
}

function log(node, props) {
  console.log({
    node,
    suggestions: props
  })
}

const server = http.createServer(requestListener)
server.listen(8080)
