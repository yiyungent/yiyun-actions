
$count = 0

function deleteRunLogs() {
  # List workflow runs for a workflow
  # https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-workflow
  $url = "https://api.github.com/repos/${owner}/${repoName}/actions/workflows/${workflow_id}/runs"
  $res = Invoke-RestMethod -Method Get -Uri $url -Headers @{ "Authorization" = "Bearer ${token}"; "Accept" = "application/vnd.github+json"; "X-GitHub-Api-Version" = "2022-11-28" }
  $count = $res.total_count
  for ($i = 0; $i -lt $res.total_count; $i++) {
    $run_item = $res.workflow_runs[$i]
    $run_id = $run_item.id
    $name = $run_item.name
    $run_number = $run_item.run_number

    Write-Host "name: ${name}"
    Write-Host "run_number: ${run_number}"
    Write-Host "run_id: ${run_id}"

    # Delete workflow run logs
    # https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#delete-workflow-run-logs
    $url = "https://api.github.com/repos/${owner}/${repoName}/actions/runs/${run_id}" 
    $deleteRes = Invoke-RestMethod -Method Delete -Uri $url -Headers @{ "Authorization" = "Bearer ${token}"; "Accept" = "application/vnd.github+json"; "X-GitHub-Api-Version" = "2022-11-28" } 
    
    Write-Host $deleteRes
  }
}

do  {
  Write-Host "count" $count
  deleteRunLogs
} while ($count -gt 0)



Write-Output "Finished !!!"