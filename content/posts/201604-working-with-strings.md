---
title: "Working with Strings in Powershell"
description: "description"
categories: ["powershell"]
date: 2016-04-16
tags: ["none"]
---

<strong>Replace</strong>

.NET operators are case sensitive and do not use regex. Powershell operators are not case sensitive and do use regex

[powershell]
$str.replace('something','something')
$str -replace '\w+', 'something'
[/powershell]

You can also replace captures and named captures. Note that single quotes are used, otherwise the variables will be expanded too soon by the shell. You could also use "'$2 '$1"

[powershell]
'Doe, John' -ireplace '(\w+), (\w+)', '$2 $1'
John Doe

'First Bob Last' -match '(\w+)\s(?<Named>\w+)\s(\w+)'; $matches

Name Value
---- -----
Named Bob
2 Last
1 First
0 First Bob Last

[/powershell]

&nbsp;

<strong>Split</strong>

This can be called as $String -split or $String.split(). This lets you split the string into parts based on some value/regex. the .NET split is part of the [Regex] class.

[powershell]
#Splits data by 2 or more whitespaces
$Data -split "\s{2,}"
#Splits data by a tab
$Data -split "\t"

#Splits "hello world" by the space
[Regex]::split('hello world', ' ')
[/powershell]

So if you take a line from some cmd output you can split it, then place each value in an object by picking out the element of the array you just created by splitting. For Example:

[powershell]
$Data = netsh int ipv4 show sub | sls 1500 | Select -First 1
$Parts = $Data -split "\s{2,}"
$Parts[1]

[/powershell]

A very useful way to use split is to split a here string, for instance containing a list of computers, into an array.

[powershell]

$Things = @"
one
two
three
four
"@.Split("`n`r",[System.StringSplitOptions]::RemoveEmptyEntries)

#You could also use:
"@ -split "\r?\n"
[/powershell]
