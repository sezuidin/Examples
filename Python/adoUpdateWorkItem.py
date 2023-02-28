import base64
import datetime
import requests

authenticationString = '{user}:{pat}'.format(user = '', pat = 'PROVIDE_A_VALID_PAT_HERE')
b64AuthenticationString = base64.b64encode(authenticationString.encode("ascii"))

# Please note: using the .decode("ascii") bit to remove the leading "b'" and the trailing "'" that get introduced with .encode("ascii")
# Uncomment the next two lines to see the difference
#print(b64AuthenticationString)
#print(b64AuthenticationString.decode("ascii"))

headers = {
    'Authorization': 'Basic {}'.format(b64AuthenticationString.decode("ascii")),
    'Content-Type': 'application/json-patch+json'
}

# Please note: using a different url for the patching part!
# The patching url doesn't contain the "ids=" bit

getUrl = 'https://dev.azure.com/sezuidin/Azure/_apis/wit/workitems?ids=67&api-version=6.0'
patchUrl = 'https://dev.azure.com/sezuidin/Azure/_apis/wit/workitems/67?api-version=6.0'

response = requests.get(url=getUrl, headers=headers)
print(response.text)

patchedContent = [
    {
        'op': 'add',
        'path': '/fields/System.Tags',
        'value': 'Updated from python script at {}'.format(datetime.datetime.now())
    }
]

# Please note: json.dumps isn't used in combination with data but instead we just use json=patchedContent
response = requests.patch(url=patchUrl, json=patchedContent, headers=headers)

if response.status_code == 200:
    print('Yes, succeeded!')
else:
    print('Status code {} with message {}'.format(response.status_code, response.json()['value']['Message']))