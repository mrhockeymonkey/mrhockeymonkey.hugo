---
title: "IP Address Comparison"
description: "description"
categories: ["powershell"]
date: 2015-12-01
tags: ["none"]
---

Working with IP address in the dotted format can become quite challenging. You can use regex in some cases to identify IP addresses but this is limited.

Simple:

[plain]

^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$

[/plain]

Accurate:

[plain]

^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$

[/plain]

You can do more, such as deciding is an IP address falls within a given network, by converting the IP addresses into Decimal. This allows you an easy way to compare.

[powershell]

#Define the Networks you wish to check
$Networks = @(
   '192.168.1.0/8'
   '172.16.1.0/16'
)

#Create Objects for each network that define the IP range as a decimal
$PossibleSubnets = $Networks | ForEach-Object {
   $NetworkAddress = [IPAddress]($_ -split '/')[0]
   $MaskLength = [Byte]($_ -split '/')[1]

   $NetworkAddressBytes = $NetworkAddress.GetAddressBytes()
   [Array]::Reverse($NetworkAddressBytes)
   $RangeLower = [BitConverter]::ToUInt32($NetworkAddressBytes, 0)

   $DecimalMask = [Convert]::ToUInt32(("1" * $MaskLength).PadRight(32, "0"), 2)
   $RangeUpper = $RangeLower -bor -bnot $DecimalMask

   [PSCustomObject]@{
      Network = $_
      NetworkAddress = $NetworkAddress
      MaskLength = $MaskLength
      RangeLower = $RangeLower
      RangeUpper = $RangeUpper
   }
}

[/powershell]

&nbsp;

Given this information you can find which interfaces on your machine are part of which networks.

[powershell]

'localhost' | ForEach-Object {
   Write-Host "Checking $_" -ForegroundColor Yellow
   $ComputerName = $_
   $Interfaces = [Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces()
   $Interfaces | ForEach-Object {
      $Interface = $_
      $IpAddresses = $_.GetIPProperties().UnicastAddresses | Where-Object { $_.Address.ToString() -notin '127.0.0.1', '::1' } | Select-Object -ExpandProperty Address
      $IPAddresses | ForEach-Object {
         #Here we convert the IP addresses found to Decimal for comparison
         $IPAddressBytes = $_.GetAddressBytes()
         [Array]::Reverse($IPAddressBytes)
         $DecimalIPAddress = [BitConverter]::ToUInt32($IPAddressBytes, 0)

         $MySubnets = $PossibleSubnets| Where-Object {$DecimalIPAddress -ge $_.RangeLower -and $DecimalIPAddress -le $_.RangeUpper}

         [PSCustomObject]@{
            ComputerName = $ComputerName
            Interface = $Interface.Name
            Network = $MySubnets.Network
         }
      }
   }
}

[/powershell]

&nbsp;