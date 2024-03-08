#input = {'search': "environmental", 'organizations': []}
def search(input):
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
  return output  # code below is for testing, should be removed on final revision  for match in output['matches']:  	print(match['name'])  # code above is for testing, should be removed on final revision