$resolution=$args[0]
$antiAliasMode=$args[1]
$shadows=$args[2]
$shadowRes=$args[3]
$streamBudget=$args[4]
$fpsCapChoice=$args[5]
$fullscreen=$args[6]
$superglideChoice=$args[7]

#---------[FRAME CAP FUNCTION]---------#

Function Accurate_Frame_Cap
{
 if ($fpsCapChoice -eq 'yes')
 {
  set-location $env:USERPROFILE
  cd 'Documents'
  $fps_line = Get-Content 'Benchmark.txt' | Select -Index 4
  $fps_count = $fps_line -replace "[^0-9]" , ''
  $fps_total = $fps_count / 10
  $fps_correct = $fps_total - 1000
  $fps_round = [math]::Round($fps_correct)
  Set-Variable -scope 1 -Name "fps_accurate" -Value $fps_round
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
 $newContent = $content -replace '1920', $resolution
 $newContent | Set-Content -Path 'videoconfig.txt'

 $content = Get-Content -path 'videoconfig.txt'
 $newContent = $content -replace '12', $antiAliasMode
 $newContent | Set-Content -Path 'videoconfig.txt'

 $content = Get-Content -path 'videoconfig.txt'
 $newContent = $content -replace 'csm', $shadows
 $newContent | Set-Content -Path 'videoconfig.txt'
 
 $content = Get-Content -path 'videoconfig.txt'
 $newContent = $content -replace 'csm_res', $shadowRes
 $newContent | Set-Content -Path 'videoconfig.txt'

 $content = Get-Content -path 'videoconfig.txt'
 $newContent = $content -replace '0000000', $streamBudget
 $newContent | Set-Content -Path 'videoconfig.txt'
 
 $content = Get-Content -path 'videoconfig.txt'
 $newContent = $content -replace 'FS', $fullscreen
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
 
 if ($superglideChoice -eq 'no')
	$content = Get-Content -path 'autoexec.cfg'
	$newContent = $content -replace 'exec superglide1.cfg                                                    // Activate superglide script (Read more about it in superglide.cfg, superglide1.cfg and superglide2.cfg) (Works)', ""
	$newContent | Set-Content -Path 'autoexec.cfg'
	
}

#---------[CALL THE CONFIG EDITOR FUNCTION]---------#

Config_Edit
