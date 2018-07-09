---
title: "Parsing Command Line Output with Powershell"
description: "description"
categories: ["powershell"]
date: 2016-04-19
tags: ["none"]
---

Here is a useful way to parse text based output into an object for powershell to consume using the Switch statement with the -Regex parameter.

<strong>Sample Output:</strong>

[plain language="text"]
Deployment Image Servicing and Management tool
Version: 10.0.10240.16384

Image Version: 10.0.10240.16384
Obtaining list of 3rd party drivers from the driver store...

Driver packages listing:

Published Name : oem0.inf
Original File Name : msdokub.inf
Inbox : No
Class Name : MEDIA
Provider Name : Microsoft
Date : 24/10/2014
Version : 1.31.35.7

Published Name : oem1.inf
Original File Name : intcdaud.inf
Inbox : No
Class Name : MEDIA
Provider Name : Intel(R) Corporation
Date : 23/02/2015
Version : 6.16.0.3172

...

[/plain]

<div></div>
<div></div>
<div><strong>Parsing with Powershell</strong></div>
<div>Here we use the -Regex switch to test the different regex cases against each line fed into the switch statement. The first case is important as it defines all of the properties you want to pick out. It will also act as a sort of delimiter, creating a NEW object each time the match is valid. Because of this it also outputs $obj BEFORE creating a new one.</div>
<div></div>
<div>

[powershell]

#Get the output to be parsed into a variable
$DismOutput = dism /Online /Get-Drivers | %{$_.Trim()}

$obj = $null

Switch -Regex ($DismOutput){
   '^Published Name : (?<pub>.+)' {
      $obj
      $obj = [PSCustomObject]@{
         PublishedName = $Matches.pub
         ProviderName = $null
         Date = $null
         Version = $null
      }
   }
   '^Provider Name : (?<prov>.+)' {$obj.providername = $Matches.prov}
   '^Date : (?<date>.+)' {$obj.date = $Matches.date}
   'Version : (?<ver>.+)' {$obj.version = $Matches.ver}
}
#Last $obj wont be output by the Switch so we output it here.
$obj
[/powershell]

&nbsp;

&nbsp;

&nbsp;
<pre></pre>
&nbsp;

</div>