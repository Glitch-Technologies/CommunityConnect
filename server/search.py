import json
from search_algorithm import search
import base64

def de(input_str):
  return base64.urlsafe_b64decode(input_str.replace('~', '=')).decode("utf-8")


def jload(file):
    jfile = open(file)
    jdict = json.load(jfile)
    jfile.close()
    return jdict

data = jload("orgs.json")


# GPT-made search algo for dataset
def old_search_organization(data, search_term):
    organizations = data.get("organizations", [])
    
    results = []
    for org in organizations:
        for key, value in org.items():
            if isinstance(value, dict):
                for sub_key, sub_value in value.items():
                    if search_term.lower() in str(sub_value).lower():
                        results.append(org)
                        break
            elif search_term.lower() in str(value).lower():
                results.append(org)
                break

    return results

def search_organization(data, search_term, search_parameters):

    #for key, value in search_parameters.items():
    #    search_parameters[key] = de(value)
    
    input = {'search': search_term, 'organizations': data['organizations'], 'parameters': search_parameters}
    return search(input)

# Dataset feeder subroutine
def lookup(search_term, search_parameters):
    return search_organization(data, search_term, search_parameters)

# Text output for lookup(NO RETURN VALUE)
def debuglookup(search_term):
    results = lookup(search_term)
    if results:
        print(f"Results found for '{search_term}':")
        for result in results:
            print(json.dumps(result, indent=2))
    else:
        print(f"No results found for '{search_term}'.")
