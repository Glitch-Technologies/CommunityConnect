import base64
#input = {'search': "environmental", 'parameters': {'location': "california", 'genre': "Technology", }, 'organizations': []}

def de(input_str):
  return base64.urlsafe_b64decode(input_str.replace('~', '=')).decode("utf-8")

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
  else:
    for org in input['organizations']:  # for each organization
      org_matches = False
      for key in org:
        for term in terms:
          if term in str(org[key]).lower():  # if a term is found in any of the dict values
            org_matches = True
            break
        if org_matches:
          break
      if org_matches:
        output['matches'].append(org)  # add it to the 'matches' list
        continue
    
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
  return output  # code below is for testing, should be removed on final revision  for match in output['matches']:

# below is an example of a call to the search function
"""
orgs = [{
      "number": 1,
      "name": "TechSphere Inc.",
      "type": "Technology Consultancy Firm",
      "genre": "Technology",
      "resources": "Cutting-edge software development tools and a team of 50 engineers",
      "contact": {
        "name": "John Smith",
        "position": "CTO",
        "email": "john@techsphere.com"
      },
      "description": "TechSphere Inc. specializes in providing innovative technology solutions through cutting-edge software development tools and a talented team of 50 engineers."
    },
    {
      "number": 2,
      "name": "GreenScape Alliance",
      "type": "Environmental NGO",
      "genre": "Technology",
      "resources": "Network of 500 volunteers, environmental research lab",
      "contact": {
        "name": "Emily Green",
        "position": "Director",
        "email": "emily@greenscape.org"
      },
      "description": "GreenScape Alliance is an Environmental NGO committed to environmental conservation, supported by a network of 500 volunteers and an environmental research lab."
    },
    {
      "number": 3,
      "name": "GlobalHealth Innovations",
      "type": "Healthcare Solutions Provider",
      "genre": "Health",
      "resources": "Medical research facilities, 24/7 medical helpline",
      "contact": {
        "name": "Dr. Mark Johnson",
        "position": "CEO",
        "email": "mark@globalhealth.com"
      },
      "description": "GlobalHealth Innovations focuses on providing healthcare solutions, utilizing medical research facilities and a 24/7 medical helpline under the leadership of Dr. Mark Johnson, the CEO."
    },
    {
      "number": 4,
      "name": "FutureWorks Academy",
      "type": "Education & Training Institute",
      "genre": "Education",
      "resources": "Online learning platform, expert instructors",
      "contact": {
        "name": "Sarah Lee",
        "position": "Head of Partnerships",
        "email": "sarah@futureworks.org"
      },
      "description": "FutureWorks Academy is an Education & Training Institute offering an online learning platform and expert instructors, with Sarah Lee leading partnerships as the Head of Partnerships."
    },
    {
      "number": 5,
      "name": "UrbanBuilders Consortium",
      "type": "Construction and Development Company",
      "genre": "Technology",
      "resources": "Skilled labor force, state-of-the-art equipment",
      "contact": {
        "name": "David Thompson",
        "position": "Project Manager",
        "email": "david@urbanbuilders.net"
      },
      "description": "UrbanBuilders Consortium specializes in construction and development, boasting a skilled labor force and state-of-the-art equipment, managed by Project Manager David Thompson."
    },
    {
      "number": 6,
      "name": "ArtsFusion Collective",
      "type": "Arts and Culture Organization",
      "genre": "Technology",
      "resources": "Artist residency program, exhibition spaces",
      "contact": {
        "name": "Rachel Adams",
        "position": "Creative Director",
        "email": "rachel@artsfusion.org"
      },
      "description": "ArtsFusion Collective promotes arts and culture through an artist residency program and exhibition spaces, with Rachel Adams serving as the Creative Director."
    }]

thingy = {'search': "", 'organizations': orgs, 'parameters': {'genre': "health"}}

print("\n\n\n")

out = search(thingy)

for org in out['matches']:
  print(org['number'])
print("\n\n")

print(orgs)"""