const express = require('express');
const os      = require('os');

const PORT = 8080;
const HOST = '0.0.0.0';
//Web App
const app = express();
app.get('/', (req, res) => {
  res.send('Environment\t'+ os.hostname() + '\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);

//test v0.0.1
