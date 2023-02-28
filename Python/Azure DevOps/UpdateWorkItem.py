import argparse
import base64
import datetime
import requests

argumentsParser = argparse.ArgumentParser(prog="ListProjects.py", description="Lists all projects in a Azure DevOps organization")

argumentsParser.add_argument("-o", "--organization", type=str)
argumentsParser.add_argument("-pn", "--projectname", type=str)
argumentsParser.add_argument("-t", "--token", type=str)
argumentsParser.add_argument("-wid", "--workitemid", type=str)
arguments = argumentsParser.parse_args()

authenticationString = '{user}:{pat}'.format(user = '', pat = arguments.token)
b64AuthenticationString = base64.b64encode(authenticationString.encode("ascii"))
getUrl = 'https://dev.azure.com/{organization}/{projectname}/_apis/wit/workitems?ids={workitemid}&api-version=6.0'.format(organization=arguments.organization,projectname=arguments.projectname,workitemid=arguments.workitemid)
patchUrl = 'https://dev.azure.com/{organization}/{projectname}/_apis/wit/workitems/{workitemid}?api-version=6.0'.format(organization=arguments.organization,projectname=arguments.projectname,workitemid=arguments.workitemid)

headers = {
    'Authorization': 'Basic {}'.format(b64AuthenticationString.decode("ascii")),
    'Content-Type': 'application/json-patch+json'
}

try:
    response = requests.get(url=getUrl, headers=headers)
except requests.exceptions.RequestException as e:
    raise SystemExit(e)

print(response.text)

patchedContent = [
    {
        'op': 'add',
        'path': '/fields/System.Tags',
        'value': 'Updated from python script at {}'.format(datetime.datetime.now())
    }
]

try:
    response = requests.patch(url=patchUrl, json=patchedContent, headers=headers)
except requests.exceptions.RequestException as e:
    raise SystemExit(e)

print(response.text)