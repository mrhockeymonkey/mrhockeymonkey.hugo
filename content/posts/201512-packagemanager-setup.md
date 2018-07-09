---
title: "Using PackageManagement"
description: "description"
categories: ["powershell"]
date: 2015-12-14
tags: ["none"]
---

<strong>Install the NuGet/Chocolatey Provider</strong>

With Windows 10 Package Manager almost runs out of the box. If you run Get-PackageProvider from powershell on a fresh Windows 10 instance you will see the out of box providers. There are two more important providers that we will want to setup
<ul>
	<li><strong>Nuget</strong> - Mainly used to pull code such as Modules from the PSGallery</li>
	<li><strong>Chocolatey</strong> - Build on top of Nuget to pull and install binaries</li>
</ul>
I expect in the future other plugins will be available as well as being able to create custom providers as explained <a href="http://blog-yannis.azurewebsites.net/2014/04/12/chocolatey-in-the-powershell-core/">here</a>

[powershell]

#Install NuGet Provider

Get-Package -ProviderName Nuget -ForceBootstrap

#Install Chocolatey Provider

Get-Package -ProviderName Chocolatey -ForceBootstrap

[/powershell]

&nbsp;

For me, since I have my own internal Repo, I would like a way to install these providers offline. At time of writing it doesn't appear this is possible so I may have to fall-back to using the chocolatey client until WMF 5.0 and the Chocolatey Provider are officially released.

&nbsp;

<strong>Configure a Package Source</strong>

[powershell]

Register-PackageSource -Name InternalRepo `
                       -Location http://svr1/packagemanagerrepo/nuget `
                       -ProviderName chocolatey `
                       -Trusted

[/powershell]

&nbsp;

You should now be able to query your Local Repo for your custom packages. Note for the below I have merely copied some existing packages from Chocolatey.org pending me crafting my own.

<a href="http://scottsan.co.uk/wp-content/uploads/2015/12/PackageManager_2.png"><img class="alignnone size-full wp-image-287" src="http://scottsan.co.uk/wp-content/uploads/2015/12/PackageManager_2.png" alt="PackageManager_2" width="997" height="292" /></a>

&nbsp;