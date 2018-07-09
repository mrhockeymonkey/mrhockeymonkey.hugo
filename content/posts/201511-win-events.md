---
title: "Windows Events in Powershell"
description: "How to read events using Get-WinEvent"
categories: ["powershell"]
date: 2015-11-04
tags: ["none"]
---

Get-WinEvent should be seen as a more powerful version of the Powershell 1.0 commandlet Get-EventLog. Using this you can query both the classic windows event log and the Event Tracing for Windows (ETW) logs.

To find a list of logs you can query ...

[powershell]

Get-WinEvent -ListLog *audio*

[/powershell]


[plain]

LogMode   MaximumSizeInBytes RecordCount LogName
-------   ------------------ ----------- -------
Circular             1052672           0 Microsoft-Windows-Audio/CaptureMonitor
Circular             1052672             Microsoft-Windows-Audio/GlitchDetection
Circular             1052672             Microsoft-Windows-Audio/Informational
Circular             1052672           0 Microsoft-Windows-Audio/Operational
Circular             1052672        2537 Microsoft-Windows-Audio/PlaybackManager

[/plain]

&nbsp;

...Or a list of providers (note here you can see which provider links to which logs)

[powershell]

Get-WinEvent -ListProvider *audio*

[/powershell]


[plain]
Name     : Microsoft-Windows-XAudio2
LogLinks : {Microsoft-Windows-XAudio2/Debug, Microsoft-Windows-XAudio2/Performance}
Opcodes  : {win:Start, win:Stop, Create, PerformanceWarning}
Tasks    : {Initialize, Shutdown, SourceVoice, SubmixVoice...}

Name     : Microsoft-Windows-Audio
LogLinks : {Application, Microsoft-Windows-Audio/Operational, Microsoft-Windows-Audio/CaptureMonitor, Microsoft-Windows-Audio/Performance...}
Opcodes  : {win:Info, win:Start, win: Stop...}
Tasks    : {AudioPerf_Task_LaunchAudioDG, ...}
[/plain]

&nbsp;

To get the entries from a particular log (notice here the provider name is listed)

[powershell]

Get-WinEvent -LogName Microsoft-Windows-Audio/PlaybackManager | Select -First 10

[/powershell]


[plain]
   ProviderName: Microsoft-Windows-Audio

TimeCreated                     Id LevelDisplayName Message
-----------                     -- ---------------- -------
04/11/2015 19:23:53             20 Information      Format: 1...
04/11/2015 19:19:03             21 Information      Sound level for application [Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge] changed to [2]
04/11/2015 19:19:03             21 Information      Sound level for application [Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge] changed to [2]
04/11/2015 19:13:21             21 Information      Sound level for application [Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge] changed to [0]
[/plain]

&nbsp;

To filter further you need to provider a hastable with your filter choices

[powershell]

Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-Audio/PlaybackManager';StartTime='04/11/2015 13:00'} | Select -First 10

[/powershell]

&nbsp;

To see the what valid key-pairs you can use help

[powershell]

Get-WinEvent -Parameter filterhashtable

[/powershell]

&nbsp;

As mentioned you can also user this command to see classic event logs however you will see logs split into groups based on the provided. To see classic logs:

[powershell]

Get-WinEvent -ListLog * | Where {$_.IsClassicLog -eq 'True'}

[/powershell]


[plain]

LogMode   MaximumSizeInBytes RecordCount LogName
-------   ------------------ ----------- -------
Circular            20971520        4552 Application
Circular            20971520           0 HardwareEvents
Circular             1052672           0 Internet Explorer
Circular            20971520           0 Key Management Service
Circular             1052672           8 OAlerts
Circular            20971520       11339 Security
Circular            20971520        8318 System
Circular            15728640         862 Windows PowerShell

[/plain]

&nbsp;