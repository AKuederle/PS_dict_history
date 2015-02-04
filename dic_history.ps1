# get the current process id and format it respectively
$id = [System.Diagnostics.Process]::GetCurrentProcess() | Format-Wide -Property id | Out-String
$id = $id.replace("`n","").replace("`r","").replace(" ", "")

# overwrite function for the cd alias. cd + write the new dic to file together with id
function log_cd()
    {
        param(
                $dic
             )
        push-location $dic
        $path = $pwd.path.replace("`n","").replace("`r","")
        "$id,$path" | out-file -filepath $env:temp\ps_sync -append -width 200
    }

function recover_d
    {
        $d = import-csv $env:temp\ps_sync -header ID,dic
        write-host $d
        $f = $d | Where-Object -FilterScript { $_.ID -ne $id } | Select-Object -last 1
        push-location $f.dic
    }

Remove-Item alias:\cd
New-Alias cd log_cd
Remove-Item alias:\rec
New-Alias rec recover_d