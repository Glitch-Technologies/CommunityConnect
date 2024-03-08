input = {'search': "environmental", 'organizations': [
    {
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
    }]}
# ^^^ GT's job 2 fix ^^^ (just an example input)
output = {'matches': []}

terms = input['search'].split(" ")

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


for match in output['matches']:
	print(match['name'])
