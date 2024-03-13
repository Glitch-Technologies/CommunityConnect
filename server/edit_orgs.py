import json
import os

def edit_orgs(num, input):
    with open("orgs.json") as f:
        orgs = json.load(f)
    for key in input:
        if key != 'contact':
            orgs["organizations"][num][key] = input[key]
        else:
            for subkey in input[key]:
                orgs["organizations"][num][key][subkey] = input[key][subkey]
    
    json_out = json.dumps(orgs, indent=2)
    
    with open("orgs.json", "w") as outfile:
        outfile.write(json_out)
            
