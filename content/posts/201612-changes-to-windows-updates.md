---
title: "Changes to Winodws 10 Updates"
description: "description"
categories: ["powershell"]
date: 2016-12-29
tags: ["none"]
---

A lot has changed coming from Windows 7 to Windows 10. One such thing is the way in which Windows Updates now works. This has been a bit of a hiccup for me in getting the OS deployable so here are some of my notes on what I have learned so far:

<strong>Windows Update Log</strong>

Historically WindowsUpdate.log has been located in pain text in C:\Windows\. Now however all windows update logs go through event log tracing. to get a human readable format of this you will need to do the following

[powershell]
#Nice and simple
Get-WindowsUpdateLog

#Specify a symbol server to use
Get-WindowsUpdateLog -Symbol Server "\\someserver\symbol"

[/powershell]

Note here that this function will use and cache symbols from the internet to decode the etl logs. If you dont have access to the internet such as on a domain then you can specify a symbol server. In theory you wouldn't need to do this if you setup _NT_SYMBOL_PATH correctly but i have yet to get that working.

Upon running the above the symbol cache and etl files are all now stored in $env:TEMP\WindowsUpdateLog. If for some reason you need to clear the logs (for a fresh view of whats happening) you can do so by running:

[powershell]
#Flush all windows update logs
Get-WindowsupdateLog -ForceFlush

[/powershell]

&nbsp;

<strong>Delivery Optimization</strong>

Windows update now downloads updates in a different way. A great article that explains the differences in detail is below:

<a href="https://blogs.technet.microsoft.com/mniehaus/2016/08/16/windows-10-delivery-optimization-and-wsus-take-2/">Windows 10, Delivery Optimization, and WSUS: Take #2</a>

To simplify things I am only interested in behaviors in version 1607. To my understanding the download modes I want to pick from are:
<ul>
 	<li><strong>Simple</strong> - No peering. Delivery Optimazation will not contact the internet and instead use HTTP to the configure WUServer (WSUS or internet) This is a good setting for enterprise to limit intenret traffice (In my case its blocked by a proxy anyway)</li>
 	<li><strong>Bypass</strong> - Do not use Delivery Optimization and use BITS instead</li>
</ul>
You can configure these and other settings in Group Policy  Computer Configuration &gt; Administrative Templates &gt; Windows Components &gt; Delivery Optimization. Settings applied via group policy will appear here in the registry.

HKLM:\Software\Policies\Microsoft\Windows\DeliveryOptimization

&nbsp;

<strong>Using Internal WSUS Server</strong>

This is proving a problem. In lieu oh actually getting this working here is an article I will be working through

<a href="https://technet.microsoft.com/en-gb/itpro/windows/manage/waas-manage-updates-wsus">Manage Windows 10 Update Using WSUS</a>

&nbsp;

<strong>Automation using PSWindowsUpdate</strong>

Luckily (for now at least) Windows Update looks to still use the same old com objects as it always has done. I have a few scripts that utilize these so this helps. However moving forward however I am trying to use a newly found module form PSGallery that works nicely so far with packer.

For instance to install Windows updates using powershell:

[powershell]

#Install the module form PSGallery
Install-Package -Name PSWindowsUpdate

#Import and Install any available updates
Import-Module PSWindowsUpdate
Get-WUInstall -AcceptAll -IgnoreReboot -Verbose

[/powershell]
