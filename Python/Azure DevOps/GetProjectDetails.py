import argparse
import base64
import json
import requests

argumentsParser = argparse.ArgumentParser(prog="ListProjects.py", description="Lists all projects in a Azure DevOps organization")

argumentsParser.add_argument("-o", "--organization", type=str)
argumentsParser.add_argument("-pid", "--projectid", type=str)
argumentsParser.add_argument("-t", "--token", type=str)
arguments = argumentsParser.parse_args()

authenticationString = '{user}:{pat}'.format(user = '', pat = arguments.token)
b64AuthenticationString = base64.b64encode(authenticationString.encode("ascii"))
url = 'https://dev.azure.com/{organization}/_apis/projects/{projectid}/properties?api-version=7.0-preview.1'.format(organization=arguments.organization, projectid=arguments.projectid)

headers = {
    'Authorization': 'Basic {}'.format(b64AuthenticationString.decode("ascii")),
    'Content-Type': 'application/json-patch+json'
}

try:
    response = requests.get(url=url, headers=headers)
except requests.exceptions.RequestException as e:
    raise SystemExit(e)

if response.json() and 'value' in response.json():
    for value in response.json()['value']:
        print(json.dumps(value, indent=2))