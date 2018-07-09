---
title: "Install & Configure MDT"
description: "description"
categories: ["windows"]
date: 2015-08-29
tags: ["none"]
---

<strong>Overview</strong>

Creating OS images saves time when deploying new Server and Workstations by cutting out the need for installing updates and software every single time. The key thing with MDT is that by using Tasklists you can ensure the OS is built in the same way every iteration rather  missing things like drivers and config tweaks.

<strong>Installing</strong>
<ol>
	<li>Install MDT (MicrosoftDeploymentToolkit2013_x64.msi)
<ul>
	<li><a href="https://www.microsoft.com/en-us/download/confirmation.aspx?id=40796" target="_blank">https://www.microsoft.com/en-us/download/confirmation.aspx?id=40796</a></li>
	<li>This is a pretty easy Next, Next, OK install</li>
</ul>
</li>
	<li>Install Windows ADK
<ul>
	<li><a href="http://www.microsoft.com/en-gb/download/details.aspx?id=39982" target="_blank">http://www.microsoft.com/en-gb/download/details.aspx?id=39982</a></li>
	<li>You only need to select Deployment Tools, Windows PE and User State Migration</li>
</ul>
</li>
</ol>
<b>Basic Configuration</b>

Open up the Deployment Workbench mmc snap-in (Can be found in Program Files).
<ol>
	<li>Create a New Deployment Share
<ul>
	<li>Deployment Workbench &gt; Deployment &gt; Right Click &gt; New Deployment Share</li>
</ul>
</li>
	<li>Add OS Files
<ul>
	<li>Right click Operating Systems under your new Deployment Share</li>
</ul>
</li>
	<li>Add Device Drivers if required</li>
	<li>Create Tasklist
<ul>
	<li>Select "Standard Client Task Sequence"</li>
	<li>Select the OS</li>
	<li>Set an Admin Password</li>
</ul>
</li>
</ol>
This in theory is all you need to deploy a vanilla OS. Now you can create a bootable image to carry out the deployment. Right click on the Deployment Share on the left hand pane and click Update Deployment Share. This will create a LightTouchPE .wim and .iso file in the Deployment Share \Boot folder.

If you place one of these .wim files in WDS you can PXE boot your test machine into the MDT WinPE where you will be asked a series of installation options before actually installing the OS.

This is the most basic of setup tasks and lets you delpoy a fresh OS with no customisation. In my next post I will cover some of the custom setup steps I have taken for my deployment.