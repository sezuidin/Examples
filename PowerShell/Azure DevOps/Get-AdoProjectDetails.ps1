Param (
  [string]$Organization = $(throw 'Provide a valid Azure DevOps organization'),
  [string]$ProjectId = $(throw 'Provide a valid Azure DevOps project id'),
  [string]$Token = $(throw 'Provide a valid Personal Access Token')
)

$basicAuthentication = "{0}:{1}" -f '', $Token
$base64Authentication = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($basicAuthentication))
$uri = "https://dev.azure.com/$Organization/_apis/projects/$ProjectId/properties?api-version=7.0-preview.1"

$headers = @{
  'Authorization' = "Basic $base64Authentication"
  'ContentType' = 'application/json'
}

try {
  $results = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers
  $results.value
}
catch {
  Write-Error -Message "The following error occured: $_"
}