---
title: "Advanced Sort-Object"
description: "description"
categories: ["powershell"]
date: 2016-06-20
tags: ["none"]
---

Sort-Object can be used in a few ways which allow a very powerful methods for sorting objects in weird and wonderful ways. Here is a simple example:

[powershell]

$Data = Get-Service

#First Alphabetically by Status, Then by Name
$Data | Sort-Object -Property Status,Name

[/powershell]

&nbsp;

The Property parameter accepts an String or an Object. If we use a Hashtable as input here Sort-Object will look for <strong>Expression</strong> (A Script Block) and <strong>Ascending</strong> and <strong>Descending</strong> (Both Boolean) which can be used to make customize sorting logic. Here some more complex:

&nbsp;

[powershell]

#First Where Name Matches ^win, Next by Name Matches ^SQL, The rest Alphabeticaly by name
$Data | Sort-Object -Property @{Expression = {$_.Name -match '^Win'}; Descending = $true}, @{Expression = {$_.Name -match '^SQL'}; Descending = $true},Name

[/powershell]


[plain]

Status Name DisplayName 
------ ---- ----------- 
Running WinDefend Windows Defender Service 
Running WinHttpAutoProx... WinHTTP Web Proxy Auto-Discovery Se...
Running Winmgmt Windows Management Instrumentation 
Running WinRM Windows Remote Management (WS-Manag...
Stopped SQLAgent$SQLEXP... SQL Server Agent (SQLEXPRESS) 
Running SQLBrowser SQL Server Browser 
Running SQLWriter SQL Server VSS Writer 
Stopped AJRouter AllJoyn Router Service 
Stopped ALG Application Layer Gateway Service 
Stopped Apache2.4 Apache2.4 
Running AppHostSvc Application Host Helper Service 

[/plain]

&nbsp;

[powershell]

#Conditional Logic to Update an object as part of the sort.
$Data | Sort-Object -Property @{Expression = {If($_.Name -match '^Win'){$_.Name = 'HIDDEN'}}; Descending = $true}

[/powershell]


[plain]

Stopped WerSvc Windows Error Reporting Service 
Stopped WiaRpc Still Image Acquisition Events 
 HIDDEN 
 HIDDEN 
 HIDDEN 
 HIDDEN 
Running WlanSvc WLAN AutoConfig 
Stopped wlidsvc Microsoft Account Sign-in Assistant 
Stopped WebClient WebClient 

[/plain]
