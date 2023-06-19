Param (
  [string]$Organization = $(throw 'Provide a valid Azure DevOps organization'),
  [string]$Project = $(throw 'Provide a valid Azure DevOps project'),
  [string]$Token = $(throw 'Provide a valid Personal Access Token'),
  [string]$WorkItemId = $(throw 'Provide a valid Azure DevOps work item id')
)

$basicAuthentication = "{0}:{1}" -f '', $Token
$base64Authentication = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($basicAuthentication))
$getUri = "https://dev.azure.com/$Organization/$Project/_apis/wit/workitems?ids=$WorkItemId&api-version=6.0"
$patchUri = "https://dev.azure.com/$Organization/$Project/_apis/wit/workitems/$($WorkItemId)?api-version=6.0"

$headers = @{
  'Authorization' = "Basic $base64Authentication"
  'ContentType' = 'application/json'
}

try {
  $results = Invoke-RestMethod -Method Get -Uri $getUri -Headers $headers
  foreach($item in $results.value) {
    $item
  }
}
catch {
  Write-Error -Message "The following error occured: $_"
}

$patchedContent = @'
[
  {
    'op': 'add',
    'path': '/fields/System.Tags',
    'value': "Updated from PowerShell script at $(Get-Date)"
  }
]
'@

try {
  $results = Invoke-RestMethod -Method Patch -Uri $patchUri -Headers $headers -Body $patchedContent -ContentType 'application/json-patch+json'
  $results
}
catch {
  Write-Error -Message "The following error occured: $_"
}