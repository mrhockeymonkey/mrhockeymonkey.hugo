---
title: "Encoding and Decoding Base64 Strings"
description: "description"
categories: ["powershell"]
date: 2015-10-26
tags: ["none"]
---

Using Get-Content you can convert a file such as .pdf or .jpeg into a stream of bytes. Here the '-raw' switch tell Get-Content to read the file as one long string, keeping the line endings exactly as they were. Without this switch the file would be read line by line.

[powershell] $doc = Get-Content -Path C:\tmp\file.pdf -Raw -Encoding Byte [/powershell]

Now you have the file content as Bytes saved as a variable (from the console you will see a decimal representation of a byte on each line). You can convert these bytes to binary or you can convert this entire variable into a Base64 string that can be sent in a file or copy-pasted.

Base64 makes a better transport option than binary (https://en.wikipedia.org/wiki/Base64)

[powershell]
#Just for fun really
$DocAsBin = $a | %{[System.Convert]::ToString($_,2)}

#Converts to a single transportable string
$DocAsStr = [Convert]::ToBase64String($doc)
[/powershell]

To reassemble the file you will need to convert back from Base64 string and use the Set-Content cmdlet.

[powershell] 
[System.Convert]::FromBase64String($DocAsStr) | Set-Content -Path C:\tmp\file.pdf​ 
[/powershell]


You can also encode and run a script block in much the same way



[powershell]

$string = {(Get-WindowsFeature).Where{$PSItem.Installed}}.ToString()

$encodedcommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($string))

powershell.exe -EncodedCommand $encodedcommand

[/powershell]
