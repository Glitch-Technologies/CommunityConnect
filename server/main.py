from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import base62
from urllib.parse import urlparse
import os

import insta
import search

hostName = "glitchtech.top"
serverPort = 10


def handle_image(img):
    out_image = open("upload.jpg", "wb")
    out_image.write(img)
    out_image.close()
    os.system('cp upload.jpg /var/www/isvincent.gay/public_html/upload.jpg')


def in_index(mylist, target):
    for i in mylist:
        if i == target:
            return True
    return False


def de(input_str):
    return base62.decodebytes(input_str).decode("utf-8")


def jwrite(file, out_json):
    outfile = open(file, "w")
    json.dump(out_json, outfile, indent=2)
    outfile.close()


def jload(file):
    jfile = open(file)
    jdict = json.load(jfile)
    jfile.close()
    return jdict


def get_query(query):
    keys = []
    values = []
    for qc in query.split("&"):
        pair = qc.split("=")
        keys.append(pair[0])
        values.append(pair[1])
    return dict(zip(keys, values))


def login(username, password):
    logins = jload("creds.json")
    ret = {"res": 0, "name": "noname"}
    if username in logins['users']:
        ret["res"] = 1
        if password == logins['users'][username]['Password']:
            ret["name"] = logins['users'][username]['Name']
            ret["res"] = 2
            if logins['users'][username]['Admin']:
                ret["res"] = 3
    return ret


class CommunityConnectServer(BaseHTTPRequestHandler):
    def do_GET(self):
        p = self.path.split("?")[0]
        # Refer to p[0] for get path
        query = urlparse(self.path).query
        query_components = {}
        if len(query) > 0:
            query_components = get_query(query)
        self.send_response(200)
        self.send_header("Content-type", "text/json")
        self.end_headers()

        if p == "/login":
            username = de(query_components["username"])
            password = de(query_components["password"])
            output = login(username, password)
            self.wfile.write(bytes(json.dumps(output), "utf-8"))

        if p == "/signup":
            username = de(query_components["username"])
            password = de(query_components["password"])
            new_user = {"Password": "NOT FOUND", "Name": "NOT FOUND", "Admin": False}
            privilege = login(username, password)["res"]
            if privilege < 1:
                name = de(query_components["name"])
                logins = jload("creds.json")
                new_user = {"Password": password, "Name": name, "Admin": False}
                logins["users"][username] = new_user
                jwrite("creds.json", logins)
            self.wfile.write(bytes(json.dumps({"new user": new_user, "error": privilege}), "utf-8"))

        if p == "/supersecret":
            self.wfile.write(bytes("Nice work Vincent\n", "utf-8"))

        if p == "/search":
            search_term = query_components(term)
            search_results = search.lookup(search_term)
            safe_search_results = {"return": str(search_results)}
            self.wfile.write(bytes(json.dumps(safe_search_results), "utf-8"))


    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        # POST requests requiring decode should be put here
        decode = []
        if in_index(decode, self.path):
            query = post_data.decode("utf-8")
            query_components = {}
            if len(query) > 0:
                query_components = get_query(query)
        self.send_response(200)
        self.send_header("Content-type", "text/json")
        self.end_headers()
        if self.path == "/addpost":
            handle_image(post_data)
            self.wfile.write(bytes(json.dumps({"success": 1}), "utf-8"))


if __name__ == "__main__":
    webServer = HTTPServer((hostName, serverPort), CommunityConnectServer)
    print("Server started http://%s:%s" % (hostName, serverPort))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")