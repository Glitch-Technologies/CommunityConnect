import json

def edit_orgs(num, input):
    with open("orgs.json") as f:
        orgs = json.load(f)['organizations']
    
    print(f"orgs: {orgs[num-1]}")

    for key in input:
        if key != 'contact':

            orgs[num-1][key] = input[key]
        else:
            for subkey in input[key]:
                orgs[num-1][key][subkey] = input[key][subkey]
    
    out = {'organizations': orgs}
    
    json_out = json.dumps(out, indent=2)
    
    with open("orgs.json", "w") as outfile:
        outfile.write(json_out)

# example function usage below
"""
num = 1
input = {'name': "TechSquare Incorprayted", 'type': "Tech Firm",
        'description': "TechSphere Inc. sure does some stuff.",
        'resources': "Cutting-edge hardware development tools and a team of 50,000 engineers",
        'contact': {'email': "laremy@techsphere.com"}}

edit_orgs(num, input)

with open("server/orgs.json") as f:
    orgs = json.load(f)['organizations']
    
    print(f"orgs: {orgs[num-1]}")
"""
