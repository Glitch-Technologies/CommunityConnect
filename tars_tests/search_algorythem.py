import json

arg = "tech"
print(f"argument: {arg}\n\n\n")

out = []

with open("tars_tests/orgs_test.json") as f:
	orgs = json.load(f)

for org in orgs["organizations"]:
	org_matches = False
	for key in org:
		if arg in str(org[key]).lower():
			org_matches = True
			break
	if org_matches:
		out.append(org["name"])
		continue


print(out)
