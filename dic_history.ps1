function numInstances([string]$process)
{
    @(get-process -ea silentlycontinue $process).count
}

$test_shell_number = Test-Path variable:global:shell_number
$test_sync_dir = Test-Path $env:temp\ps_sync
if($test_shell_number -eq $FALSE)
    {
      $shell_number = numInstances PowerShell
    }

if($test_sync_dir -eq $FALSE)
    {
        mkdir $env:temp\ps_sync;
    }

function log_cd()
    {
        param(
                $path
             )
        Write-Host Test
        Set-Location $path
        $pwd.path > $env:temp\ps_sync\[string]$shell_number
    }

function recover_d
    {
        param(
                $number
             )
        $d = Get-Content $env:temp\ps_sync\$number
        pushd $d
    }

Remove-Item alias:\cd
New-Alias cd log_cd
Remove-Item alias:\rec
New-Alias rec recover_d