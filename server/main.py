from http.server import BaseHTTPRequestHandler, HTTPServer
import json
from urllib.parse import urlparse
import os
import base64
from edit_orgs import edit_orgs

# import insta
# For instagram API, only activate after configuring session.json(See Starlight)

import search

hostName = "glitchtech.top"
serverPort = 10

#Modern URL-safe strings. See GlitchChat.
def de(input_str):
  a = input_str.replace('~', '=')
  return base64.urlsafe_b64decode(a).decode("utf-8")
  #Kept for legacy. Server will hopefully never need to encode. 

def en(input):
  return base64.urlsafe_b64encode(bytes(input, "utf-8")).replace(b'=', b'~')




def in_index(mylist, target):
    for i in mylist:
        if i == target:
            return True
    return False

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

class CommunityConnectServer(BaseHTTPRequestHandler):
    def do_GET(self):
        print(self.path)
        p = self.path.split("?")[0]
        # Refer to p[0] for get path
        query = urlparse(self.path).query
        query_components = {}
        if len(query) > 0:
            query_components = get_query(query)
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        # Disable CORS security
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "*")
        self.send_header("Access-Control-Allow-Headers", "*")
        self.end_headers()

        if p == "/supersecret":
            self.wfile.write(bytes("Nice work Vincent\n", "utf-8"))

        if p == "/search":
            search_term = de(query_components["term"])
            query_components.pop("term", None)
            search_results = search.lookup(search_term, {key: de(value) for key, value in query_components.items()})
            #search_results = search.lookup(search_term, query_components)
            safe_search_results = {"return": search_results}
            self.wfile.write(bytes(json.dumps(safe_search_results), "utf-8"))

        if p == "/upload":
            num = de(query_components["num"])
            upload_input = de(query_components["input"])
            edit_orgs(num, upload_input)

            self.wfile.write(bytes(json.dumps({"success": upload_input}), "utf-8"))
            
        if p == "/edit":
            pass

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
        
        #if self.path == "/upload":
        #    edit_orgs(post_data)
        #    self.wfile.write(bytes(json.dumps({"success": 1})))


        
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        # Disable CORS security
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "*")
        self.send_header("Access-Control-Allow-Headers", "*")
        self.end_headers()


if __name__ == "__main__":
    webServer = HTTPServer((hostName, serverPort), CommunityConnectServer)
    print("Server started http://%s:%s" % (hostName, serverPort))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")
