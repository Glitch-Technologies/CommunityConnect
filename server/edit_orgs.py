import json
import os

def edit_orgs(input):
    with open("orgs.json") as f:
        orgs = json.load(f)
    for key in input:
        if key != 'contact':
            orgs[key] = input[key]
        else:
            for subkey in input[key]:
                orgs[key][subkey] = input[key][subkey]
    
    json_out = json.dumps(orgs, indent=2)
    
    with open("orgs.json", "w") as outfile:
        outfile.write(json_out)
            
