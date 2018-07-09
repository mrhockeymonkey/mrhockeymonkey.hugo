---
title: "Using Powershell to Manage Network Settings"
description: "description"
categories: ["powershell"]
date: 2016-06-03
tags: ["none"]
---

When administering Server 2012 without the GUI these come in very handy to know:

[powershell]

#Set an IPAddress
New-NetIPAddress -InterfaceAlias 'vEthernet' -IPAddress '172.16.1.1' -PrefixLength 24 -Verbose

#Set DNS Information
Set-DnsClientServerAddress -InterfaceAlias 'vEthernet' -ServerAddresses 172.16.1.2

#Change Network Profile
Get-NetConnectionProfile -Name 'Unidentified network' | Set-NetConnectionProfile -NetworkCategory Private -Verbose

[/powershell]
