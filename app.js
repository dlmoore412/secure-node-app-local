const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello, secure world!');
});

app.listen(port, () => {
  console.log(`Secure Node app listening at http://localhost:${port}`);
});
