
function deleteRunLogs() {
  # List workflow runs for a workflow
  # https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#list-workflow-runs-for-a-workflow
  $per_page = 30
  $page = 1
  # $count = 0
  do {
    $url = "https://api.github.com/repos/${owner}/${repoName}/actions/workflows/${workflow_id}/runs?per_page=${per_page}&page=${page}"
    $res = Invoke-RestMethod -Method Get -Uri $url -Headers @{ "Authorization" = "Bearer ${token}"; "Accept" = "application/vnd.github+json"; "X-GitHub-Api-Version" = "2022-11-28" }
    # Write-Host "page: ${page}/${per_page}"
    $total_count = $res.total_count
    for ($i = 0; $i -lt $res.workflow_runs.Count; $i++) {
      $run_item = $res.workflow_runs[$i]
      $run_id = $run_item.id
      $name = $run_item.name
      $run_number = $run_item.run_number
      
      # $count = ($page - 1) * $per_page + $res.workflow_runs.Count
      # $count = $count + 1
      # Write-Host "total_count: ${count}/${total_count}"

      Write-Host "total_count: ${total_count}"

      Write-Host "name: ${name}"
      Write-Host "run_number: ${run_number}"
      Write-Host "run_id: ${run_id}"
  
      if ("in_progress queued waiting".Contains($run_item.status)) {
        # 这些状态 无法删除
        continue
      }
  
      try {
        # Delete workflow run logs
        # https://docs.github.com/en/rest/actions/workflow-runs?apiVersion=2022-11-28#delete-workflow-run-logs
        $url = "https://api.github.com/repos/${owner}/${repoName}/actions/runs/${run_id}" 
        $deleteRes = Invoke-RestMethod -Method Delete -Uri $url -Headers @{ "Authorization" = "Bearer ${token}"; "Accept" = "application/vnd.github+json"; "X-GitHub-Api-Version" = "2022-11-28" } 
        Write-Host $deleteRes
      }
      catch {
        <#Do this if a terminating exception happens#>
      }

    }
    # 注意: 不要增加页数, 因为总数会因为删除减少, 从而导致 分页列表分布 也会改变
    # $page = $page + 1
  } while ($res.workflow_runs.Count -ge $per_page)

}

deleteRunLogs

Write-Output "Finished !!!"
