---
title: "Where-Object Versus .Where()"
description: "description"
categories: ["powershell"]
date: 2017-05-18
tags: ["none"]
---

As of powershell 4 there is an alternative way of filtering collections using Where() method. This has some more advanced options that can be quite useful. This method will only be available on collections.

[powershell]

#Comparison of the two types

Get-Service | Where-Object {$_.Status -eq 'Running'}

(Get-Service).Where({$_.Status -eq 'Running'})

[/powershell]

The Where() method has some extra arguments it can take that make it able to do more dynamic filtering. You call the method as below:

[powershell]

Where({ expression } [, mode [, numberToReturn]])

[/powershell]

The modes available are:
<ul>
 	<li><strong>Default</strong> - Returns all objects that resolved $true</li>
 	<li><strong>First</strong> - Returns only the first object that resolved $true</li>
 	<li><strong>Last</strong> - Returns only the last object that resolved $true</li>
 	<li><strong>Until</strong> - Will return all objects until the first that resolve $true</li>
 	<li><strong>SkipUntil</strong> - Will not return any objects until one resolve $true</li>
 	<li><strong>Split</strong> - Out puts filtered groups one after the other</li>
</ul>
Which allow us to do things such as:

[powershell]
#Filter a group and split results into separate variables for later use
PS C:\&gt; $Up,$Down = (Get-NetAdapter).Where({$_.Status -eq 'Up'}, 'Split')

#Filter and return all objects that have a status of okay until you hit the first error.
#This might be helpful for tracing up to what point something has succeeded.
PS C:\&gt; ('ok','ok','ok','error','ok').Where({$_ -eq 'error'}, 'Until')
ok
ok
ok

#The reverse of until could potentiall be used to show you events took place after an error had occurred.
PS C:\&gt;&nbsp;('ok','ok','ok','error','ok').Where({$_ -eq 'error'}, 'SkipUntil')
error
ok
[/powershell]

It is worth noting also what the Where() method is significantly faster than the traditional Where-Object

[powershell]
#Find all numbers that are divisible by 3 in 1 to 1000000
Measure-Command { 1..1000000 | Where-Object {$_ % 3 -eq 0}} | Select TotalSeconds
TotalSeconds
------------
 13.7322894

Measure-Command {(1..1000000).Where({$_ % 3 -eq 0})} | Select TotalSeconds
TotalSeconds
------------
 2.7389855
[/powershell]

&nbsp;