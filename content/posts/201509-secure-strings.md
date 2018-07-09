---
title: "Using Secure String"
description: "description"
categories: ["powershell"]
date: 2015-09-11
tags: ["none"]
---

There are three ways you can store a password in Powershell.
<ul>
	<li><strong>String</strong>: stored as plain text</li>
	<li><strong>System.Security.SecureString</strong>: encrypted in memory, can be reversed only by the principle that encrypted it.</li>
	<li><strong>System.Management.Automation.PSCredential</strong>: a Powershell class composed of username and password</li>
</ul>

[powershell]
#To prompt for a Secure Password
$SecurePassword = Read-Host -Prompt "Enter password" -AsSecureString

#To convert a string to a Secure Password:
"Pa$$w0rd" | ConvertTo-SecureString -AsPlainText -Force

#To create a PSCredential for use in some cmdlet
$UserName = "Domain\User"
$Credentials = New-Object System.Management.Automation.PSCredential `
-ArgumentList $UserName, $SecurePassword

#Same again but using the New() method.
$PSCred = [System.management.automation.PSCredential]::new('username',$SecurePassword)
[/powershell]

&nbsp;

You can also retrieve the encrypted password as a string again so that it can be used for unattended use. If you save an encrypted password as a string you will need to convert it back to a secure string for use in the unattended script. Its worth noting here that only the user that encrypted the cleartext first can convert the ciphertext back into a secure string correctly.

[powershell]
"password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
$password = "01000000d08c9ddf0115d1118c7a00c04fc297eb010b9fe0ca1...."
$SecureString = $pass | Convertto-SecureString
[/powershell]

&nbsp;

You can retrieve the cleartext password from a secure string in one of two ways

[powershell]
#Create a PSCredential and call the GetNetworkCredentials method
$secstr = 'pa$$w0rd' | ConvertTo-SecureString -AsPlainText -Force
$PSCred = [System.management.automation.PSCredential]::new('scottsan',$secstr)
$PSCred.GetNetworkCredential() | fl *

#Convert the SecureString into a BinaryString and then back to cleartext
$BStr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secstr)
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BStr)
[/powershell]
