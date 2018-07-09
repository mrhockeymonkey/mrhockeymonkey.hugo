& hugo
Push-Location $PSScriptRoot\public
& git add -A
& git commit -m "content update"
& git push origin master
Pop-Location