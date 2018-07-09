---
title: "File System Tunneling"
description: "Strange behaviour when working with files on windows"
categories: ["windows"]
date: 2016-04-19
---

If you were to delete a file and recreate it with the same name you might notice that the creation time is preserved. This is a feature known as file system tunneling and can produce some unexpected behavior if you were not aware of it.

For instance try this:

```powershell
#create a file and write to it, get the creation time
$file = “C:\tmp\hello.txt”
"something" | Out-File $file
gci $file | Select CreationTime

#Now remove that file, wait 5 seconds and recreate it
Remove-Item $file
Start-Sleep -Seconds 5
"somethingelse" | Out-File $file
gci $file | Select CreationTime
```


You should see the creation time has not changed. But if you put in a sleep or 15 seconds instead of 5 the creation time WILL have changed. This, it turns out is actually a feature not a bug. See the links below for more information,
Sources:

<a href="http://blogs.msdn.com/b/oldnewthing/archive/2005/07/15/439261.aspx">http://blogs.msdn.com/b/oldnewthing/archive/2005/07/15/439261.aspx</a>

<a href="https://support.microsoft.com/en-us/kb/172190">https://support.microsoft.com/en-us/kb/172190</a>