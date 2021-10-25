const http = require('http')
const acorn = require('acorn-loose')
const walk = require('acorn-walk')

function logProto(obj) {
  var props = [];

  do {
    Object.getOwnPropertyNames(obj).forEach(function (prop) {
      if (props.indexOf(prop) === -1 ) {
        props.push( prop );
      }
    });
  } while (obj = Object.getPrototypeOf(obj));

  return props;
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

function suggest(source, res) {
  const parse = () => acorn.parse(source, { ecmaVersion: 2020 })

  walk.simple(parse(), {
    Literal(node) {
      console.log({
        node,
        suggestions: [...logProto(node.value)]
      })
    }
  })

  res.writeHead(200)
  res.end()
}

const server = http.createServer(requestListener)
server.listen(8080)
