---
title: "Notes on Windows Software Install/Uninstall"
description: "description"
categories: ["windows"]
date: 2016-04-19
tags: ["none"]
---

When installing by .msi a registry key is created below with a unique GUID for the app.

[plain]
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\[ProductId GUID]
[/plain]

removing keys from here will remove the app from the control panel but windows will still think its installed which could cause issues when installing the same app with a higher version. This is because Windows copies the .msi into ''C:\Windows\Installer'' (Renamed Randomly). You can find out which of these .msi files relates to the app by checking this registry key:

[plain]
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\[InternalUserId]\Products\[some random guid-like sequence of chars identifying to windows your installation]\InstallProperties
[/plain]
