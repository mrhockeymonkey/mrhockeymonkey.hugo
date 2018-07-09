---
title: "Working with .NET Types, Assemblies, Etc"
date: 2016-03-08
categories: ['powershell']
---

Here are some tricks and snippets that I find quite useful when dealing with objects, types and using .NET assemblies, etc.

<strong>Find all loaded Assemblies</strong>

[powershell]
[AppDomain]::CurrentDomain.GetAssemblies()
[/powershell]

&nbsp;

<strong>Adding Assemblies</strong>

[powershell]

Add-Type -AssemblyName Windows.Forms

Add-Type -AssemblyName "Microsoft.SqlServer.SMO, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"

#With Partial Name (deprecated) 
[Reflection.Assembly]::LoadWithPartialName('Microsoft.UpdateServices.Administration') 

#Targeted version by file(Much better in terms of reliability) 
[Reflection.assembly]::LoadFile('C:\Windows\Microsoft.Net\assembly\GAC_MSIL\Microsoft.UpdateServices.Administration\v4.0_4.0.0.0__31bf3856ad364e35\Microsoft.UpdateServices.Administration.dll') 

#Targeted version by Assembly String 
[Reflection.Assembly]::Load('Microsoft.UpdateServices.Administration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35') 
[/powershell]

Note: You cannot unload assemblies from the application domain so once they're in, they're in. Note also to find the Assembly Strings use:

[powershell]
[AppDomain]::CurrentDomain.GetAssemblies() | Select FullName
[/powershell]

&nbsp;

<strong>Find Method Overloads</strong>

If you call a method without the brackets powershell will show you a list of all the different overload options available

[powershell]

[String]::Compare

OverloadDefinitions
-------------------
static int Compare(string strA, string strB)
static int Compare(string strA, string strB, bool ignoreCase)

[/powershell]

&nbsp;

<strong>Find Hidden Properties</strong>
There's often more than get-member will normally show, hidden properties and methods:

[powershell]
$p | GM -Force
[/powershell]

&nbsp;

<strong>Get a List of TypeNames</strong>

[powershell]
$p.PSObject.TypeNames
[/powershell]
