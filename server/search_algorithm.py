import base64
#input = {'search': "environmental", 'organizations': []}

def de(input_str):
  return base64.urlsafe_b64decode(input_str.replace('~', '=')).decode("utf-8")

def search(input):
  output = {'matches': []}
  terms = input['search'].split(" ")

  # Message from greenturtle537, DEL when complete
  # Todo for Tar, implement search_parameters
  # Keyword dictionary stored in input['parameters']
  # Backend-wise, all non-specificied query parameters are treated as search parameters
  # So you get to invent the keywords
  # I.e. http://glitchtech.top/search?term=tech&location=california
  # NO FILTRATION is done to ensure the validity of keywords, but the keys must be URL compliant strings
  # I will provide an UTF-8 encoding algorithm for protecting the values, but cannot wrap the keys
  if input['search'].length() == 0 or "laremy" in terms:
    output['matches'] = input['organizations']
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
    # TODO: later implement general check for all parameters, not just genre
    if org['genre'] != input['parameters']['genre']:
      output.remove(org)
  return output  # code below is for testing, should be removed on final revision  for match in output['matches']:  	print(match['name'])  # code above is for testing, should be removed on final revision
