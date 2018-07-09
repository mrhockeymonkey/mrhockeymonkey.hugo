---
title: "Setting Up an Internal PSGallery Repo"
description: "description"
categories: ["powershell"]
date: 2015-12-12
tags: ["none"]
---

<strong>Overview</strong>

With Powershell 5 comes Package Management which has the potential for becoming the number one tool used when it comes to application deployment. Rather than relying on community written packages from say, Chocolatey, I want to be able to set up my own internal repo to have full control over packages and how they work.

<strong>Setting up the NuGet Server</strong>

Firstly get a up to date instance of 2012 R2 running and install IIS and ASP .NET 4.5

[powershell]

Install-WindowsFeature -Name Web-Server,Web-Asp-Net45 -Verbose

[/powershell]

&nbsp;

Next get Visual Studio installed and up to date and create a new empty ASP.NET Web Application. For this I will be using Visual Studio 2015 Community Edition which can be downloaded <a href="https://www.visualstudio.com/downloads/download-visual-studio-vs">here</a>
<ul>
	<li>Start &gt; New Project &gt; ASP.NET Web Application Empty</li>
</ul>
Now we need to install Nuget.Server via NugetPackage Manager.
<ul>
	<li>Right Click References &gt; Manage NuGet Packages &gt; Search for Nuget.Server &gt; Install</li>
</ul>
If you have trouble finding the package you might want to check your settings. In Options under NuGet Package Manager under Package Sources you should have the link <strong>https://api.nuget.org/v3/index.json</strong>. (This may vary on between Visual Studio versions)

Once installed you can edit Web.Config to point to a specific directory for Package

[xml]

<add key="packagePath" value="" />

[/xml]

&nbsp;

<strong>Building the Solution</strong>

Now we Need to configure Visual Studio to use IIS instead of its internal IIS Express. To do this:
<ul>
	<li>Right Click Project Name &gt; Properties</li>
	<li>Click Web &gt; Under Servers Select "Local IIS" &gt; Click Create Virtual Directory</li>
</ul>
Finally the Solution is ready to Build:
<ul>
	<li>Right Click Project Name &gt; Build</li>
</ul>
You should now see your application in IIS and be able to browse to the website.

<a href="http://scottsan.co.uk/wp-content/uploads/2015/12/PackageManager_1.jpg"><img class="alignnone size-full wp-image-273" src="http://scottsan.co.uk/wp-content/uploads/2015/12/PackageManager_1.jpg" alt="PackageManager_1" width="1200" height="676" /></a>

Your Nuget Server is now setup and running. To Test you can drop some previously downloaded .nupkg files into your package path defined in Web.Config. You should be able to browse these at http://localhost/&lt;ProjectName&gt;/nuget.

&nbsp;

&nbsp;