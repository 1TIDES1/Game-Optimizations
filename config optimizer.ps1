$arg1=$args[0]
$arg2=$args[1]
$arg3=$args[2]
$arg4=$args[3]
$arg5=$args[4]
$arg6=$args[5]
$arg7=$args[6]

#---------[FRAME CAP FUNCTION]---------#

Function Accurate_Frame_Cap
{
 if ($arg6 -eq 'yes')
 {
  set-location $env:USERPROFILE
  cd 'Documents'
  $fps_line = Get-Content 'Benchmark.txt' | Select -Index 4
  $fps_count = $fps_line -replace "[^0-9]" , ''
  $fps_total = $fps_count / 10
  $fps_round = [math]::Round($fps_total)
  $fps_correct = $fps_round - 1000
  Set-Variable -scope 1 -Name "fps_accurate" -Value $fps_correct
 }
 else {
   Set-Variable -scope 1 -Name "fps_accurate" -Value '0'
 }
}

#---------[CONFIG EDITOR FUNCTION]---------#

function Config_Edit
{
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
 
 $content = Get-Content -path 'videoconfig.txt'
 $newContent = $content -replace 'FS', $arg7
 $newContent | Set-Content -Path 'videoconfig.txt'
 
 Accurate_Frame_Cap
 
 set-location $env:TEMP
 cd 'Apex_Configs'
 $content = Get-Content -path 'autoexec.cfg'
 $newContent = $content -replace 'fps_cap', $fps_accurate
 $newContent | Set-Content -Path 'autoexec.cfg'

 $content = Get-Content -path 'superglide3.cfg'
 $newContent = $content -replace 'fps_cap', $fps_accurate
 $newContent | Set-Content -Path 'superglide3.cfg'
}

#---------[CALL THE CONFIG EDITOR FUNCTION]---------#

Config_Edit
