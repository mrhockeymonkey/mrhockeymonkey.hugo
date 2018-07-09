---
title: "Class-Based DSC Resources"
description: "description"
categories: ["powershell"]
date: 2016-05-25
tags: ["dsc"]
---

<strong>Folder Structure</strong>

Class based resources are quite simple compare to MOF based and only need two files
<ul>
	<li>ResourceName
<ul>
	<li>ResourceName.psm1</li>
	<li>ResourceName.psd1</li>
</ul>
</li>
</ul>
&nbsp;

<strong>Declare the DscClass and DscProperties</strong>

As with PSClasses you need to define your class. For DSC Resource you mustuse [DscResource()] attribute for the class and the [DscProperty()] attribute for class properies. Not here also we have used an Enum as the type for one of these properties

[powershell]

Enum Ensure {
   Present
   Absent
}
[DscResource()]
Class ResourceName {
   [DscProperty(Key)]
   [String]$Param1

   [DscProperty(Mandatory)]
   [Bool]$Param2

   [DscProperty()] #This Means Options
   [Ensure]$Param3 #Here we use the Enum declared above

   [DscProperty(NotConfigurable)] #This means Read-Only
   [Bool]$Param4
}

[/powershell]

&nbsp;

<strong>Declare Get, Set, Test &amp; Custom Methods</strong>

Instead of Get/Set/Test-TargetResource Class based Resource use Get(), Set() and Test() methods. This are slightly stricter in that they MUST use the return keyword and can only return what they are cast as, i.e. a boolean for Test()

[powershell]

[DscResource()]
Class ResourceName {
   [ResourceName]Get() {
      Return $this
   }
   
   [Void]Set() {

   }

   [Bool]Test() {
      Return $True/$False
   }
}

[/powershell]

&nbsp;

<strong>Create a Manifest File</strong>

Here is the minimum you info you need to provide for a class based DSC resource. Note here you can choose which DSC Resource to export. It is also a good Idea to set the minimum powershell version to 5.0

[powershell]

# Script module or binary module file associated with this manifest. 
RootModule = 'ResourceName.psm1'

DscResourcesToExport = @(
   'ResourceName'
)

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '81624038-5e71-40f8-8905-b1a87afe22d7' 

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0' 
[/powershell]

&nbsp;

<strong>Help &amp; Examples</strong>

<a href="https://msdn.microsoft.com/en-us/powershell/dsc/authoringresourceclass">Microsoft Documentation</a>
<a href="https://github.com/mrhockeymonkey/Powershell/tree/master/Modules/xMyTestDSCResource">My GitHub</a>