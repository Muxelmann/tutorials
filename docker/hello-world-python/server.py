from http.server import BaseHTTPRequestHandler, HTTPServer
import os, datetime

class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        load = os.getloadavg()
        html = """<!DOCTYPE html>
<html lang="de">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hallo, Welt!</title>
    </head>
    <body>
        <h1>Hallo, Welt: python</h1>
        <p>
            Serverzeit: {now}<br>
            Serverauslastung: {load}
        </p>
    </body>
</html>""".format(
    now = datetime.datetime.now().astimezone(),
    load = load[0])

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes(html, "utf-8"))
        return

if __name__ == "__main__":
    addr = ("", 80)
    httpd = HTTPServer(addr, MyServer)
    httpd.serve_forever()