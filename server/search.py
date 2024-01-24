import json
from main import jload

data = jload("orgs2.json")


# GPT-made search algo for dataset
def search_organization(data, search_term):
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

# Dataset feeder subroutine
def lookup(search_term):
    return search_organization(data, search_term)

# Text output for lookup(NO RETURN VALUE)
def debuglookup(search_term):
    results = lookup(search_term)
    if results:
        print(f"Results found for '{search_term}':")
        for result in results:
            print(json.dumps(result, indent=2))
    else:
        print(f"No results found for '{search_term}'.")
