const
    http = require("http"),
    os = require("os");

http.createServer((req, res) => {
    const
        dateTime = new Date(),
        load = os.loadavg(),
        doc = `<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hallo, Welt!</title>
</head>
<body>
    <h1>Hallo, Welt: node</h1>
    <p>
        Serverzeit: ${dateTime}<br>
        Serverauslastung: ${load[0]}
    </p>
</body>
</html>`;
    res.setHeader('Content-Type', 'text/html');
    res.end(doc);
}).listen(80);