import base64
import re
# input = {'search': "john environmental", 'parameters': {'location': "california", 'genre': "Technology", }, 'organizations': []}

def search(input):

    output = {'matches': []}
    terms = input['search'].split(" ")
    
    # return every organization if empty search
    if len(input['search']) == 0 or "laremy" in terms:
        output['matches'] = input['organizations']
    
    # checking for organization search by number
    elif len(terms) == 1 and terms[0].isdigit():
        number = int(terms[0])
        for org in input['organizations']:
            if org['number'] == number:
                output['matches'].append(org)

    # adding organizations matching key terms to output
    # TODO: following code doubles some orgs on server side search (doesnt on tar's end)
    else:
        for org in input['organizations']:  # for each organization
            org_text = str(org).lower()
            for term in terms:
                if term in org_text:
                    output['matches'].append(org)  # add it to the 'matches' list
                    break
        
    # applying filters
    i = 0
    while i < len(output['matches']):
        org = output['matches'][i]

        # for each parameter, check if org parameter matches, if not -> remove the org
        for key in input['parameters']:
            if key in org:
                if str(org[key]).lower() != str(input['parameters'][key]).lower():
                    del output['matches'][i]
                    i -= 1
            else:
                del output['matches'][i]
                i -= 1
        i += 1
    return output  # code below is for testing, should be removed on final revision for match in output['matches']:


# below is an example of a call to the search function
"""
import json

with open("server/orgs.json") as f:
	orgs = json.loads(f.read())['organizations']


thingy = {'search': "john solar", 'organizations': orgs, 'parameters': {'genre': "Technology"}}

print("\n\n\n")

out = search(thingy)

for org in out['matches']:
    print(org['number'])
print("\n\n")

for org in out['matches']:
    print(org)
    print()
print("\n\n")
"""
