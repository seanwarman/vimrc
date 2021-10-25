const fs = require('fs')
const cword = process.argv[2]
const thisProps = logProperties(this)

function logProperties(obj) {
  var props = [];

  do {
    Object.getOwnPropertyNames(obj).forEach(function (prop) {
      console.log('@FILTER prop: ', prop)
      if (props.indexOf(prop) === -1 ) {
        props.push( prop );
      }
    });
  } while (obj = Object.getPrototypeOf(obj));

  return props;
}
