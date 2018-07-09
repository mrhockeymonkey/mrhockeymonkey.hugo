---
title: "Powershell Runspaces"
description: "description"
categories: ["powershell"]
date: 2016-09-17
tags: ["none"]
---

The below is an example of running Powershell tasks Asynchronously using a Runspace Pool. Runspaces are a bit more complex but a lot faster than Powershell jobs. I have saved this framework as a snippet so that I can insert and edit very easily.

This and more examples can be found on my <a href="https://github.com/mrhockeymonkey/PowershellPlayground/tree/master/Runspaces">Github</a>

First you want to setup your runspace pool. A useful thing to remember here is that you can create a custom session state that has all the required modules imported to save on importing for each task!

[powershell]

#Create an Array List to Track Jobs
$Runspaces = [System.Collections.ArrayList]::new()

#Create the Runspace Pool
$SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
$RunspacePool = [runspacefactory]::CreateRunspacePool(
   1, #Min Runspaces
   10, #Max Runspaces
   $SessionState, #Initial Session State
   $host #System.Management.Automation.Host.PSHost
)
$RunspacePool.Open()
[/powershell]

Now you can populate the runspace with tasks. here i just add 20 instances of a script that will wait a random amount of time and inform you when it started and ended

[powershell]

1..20 | ForEach-Object {
   #Define the Script and Params
   $Params = @{
      Seconds = Get-Random -Minimum 1 -Maximum 11
   }
   $Script = {
      [CmdletBinding()]
      Param(
         $Seconds
      )
      $ThreadID = [System.AppDomain]::GetCurrentThreadId()
      Write-Output "Starting ThreadId $ThreadID"
      Start-Sleep -Seconds $Seconds
      Write-Output "Ending ThreadId $ThreadID after $Seconds seconds"
   }

   #Create Powershell Instance for your job
   $PowerShell = [System.Management.Automation.PowerShell]::Create()
   $PowerShell.RunspacePool = $RunspacePool
   [Void]$PowerShell.AddScript($Script).AddParameters($Params)

   #Invoke Async and Track
   [Void]$Runspaces.Add([PSCustomObject]@{
      Runspace = $PowerShell.BeginInvoke()
      PowerShell = $PowerShell
   })
}

[/powershell]

You will want to track the progress and output of the tasks. To do so you can query the runspace foir completed jobs. Any completed jobs you can EndInvoke() and Dispose() to get the output and cleanup as you go

[powershell]

#Retreive output and cleanup as jobs complete
Do {
   $More = $false
   $CompletedRunspaces = [System.Collections.ArrayList]::new()
   $Runspaces | Where-Object -FilterScript {$_.Runspace.isCompleted} | ForEach-Object {
      $_.Powershell.EndInvoke($_.Runspace)
      $_.Powershell.Dispose()
      [Void]$CompletedRunspaces.Add($_)
   }
   $CompletedRunspaces | ForEach-Object {
      [Void]$Runspaces.Remove($_)
   }
   If ($Runspaces.Count -gt 0) {
      $More = $True
      Start-Sleep -Milliseconds 100
   }
}
While ($More)

[/powershell]
