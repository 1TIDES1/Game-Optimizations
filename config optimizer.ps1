$arg1=$args[0]
$arg2=$args[1]
$arg3=$args[2]
$arg4=$args[3]
$arg5=$args[4]
$arg6=$args[5]

set-location $env:TEMP
cd 'Apex_Configs'
$content = Get-Content -path 'videoconfig.txt'
$newContent = $content -replace '1920', $arg1
$newContent | Set-Content -Path 'videoconfig.txt'

$content = Get-Content -path 'videoconfig.txt'
$newContent = $content -replace '12', $arg2
$newContent | Set-Content -Path 'videoconfig.txt'

$content = Get-Content -path 'videoconfig.txt'
$newContent = $content -replace 'csm_res', $arg4
$newContent | Set-Content -Path 'videoconfig.txt'

$content = Get-Content -path 'videoconfig.txt'
$newContent = $content -replace 'csm', $arg3
$newContent | Set-Content -Path 'videoconfig.txt'

$content = Get-Content -path 'videoconfig.txt'
$newContent = $content -replace '0000000', $arg5
$newContent | Set-Content -Path 'videoconfig.txt'
