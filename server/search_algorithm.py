#input = {'search': "environmental", 'organizations': []}

def search(input):
  output = {'matches': []}
  terms = input['search'].split(" ")
  
  # return every organization if empty search
  if input['search'].length() == 0 or "laremy" in terms:
    output['matches'] = input['organizations']
  
  # checking for organization search by number
  elif terms.length() == 1 and terms[0].isdigit():
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
  
  for org in output['matches']:
    # TODO: update below function when more parameters are added
    if org['genre'] != input['parameters']['genre']:
      output.remove(org)
  return {"I hate this": "L"}
  #return output  # code below is for testing, should be removed on final revision  for match in output['matches']:  	print(match['name'])  # code above is for testing, should be removed on final revision
