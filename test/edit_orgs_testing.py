import json

def edit_orgs(num, input):
    with open("test/orgs_testing.json") as f:
        orgs = json.load(f)['organizations']
    
    for key in input:
        if key != 'contact':

            orgs[num-1][key] = input[key]
        else:
            for subkey in input[key]:
                orgs[num-1][key][subkey] = input[key][subkey]
    
    out = {'organizations': orgs}
        
    with open("test/orgs_testing.json", "w") as outfile:
        outfile.write(json_out)

# example function usage below
"""
num = 15
input = {'name': "HealthcareLast Clinics", 'contact': {'name': "Bro Bro XXIV"}}

edit_orgs(num, input)

with open("test/orgs_testing.json") as f:
    orgs = json.load(f)['organizations']
    
    print(f"orgs: {orgs[14]}")
"""
