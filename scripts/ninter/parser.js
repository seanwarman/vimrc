const axios = require('axios')

const source = `
  function nice () {};
  const thins = { 
    sutff: "cool", 
    number: 1,
    bool: true,
    arr: [ nice, () => {}, "yhing", 2, {}, [] ]
  }
`

axios.post('http://localhost:8080', { source })
