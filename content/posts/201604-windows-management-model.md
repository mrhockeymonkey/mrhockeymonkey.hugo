---
title: "Windows Management Model"
description: "description"
categories: ["windows"]
date: 2016-04-19
tags: ["none"]
---

<div><strong>Glossary of Terms</strong></div>
<ul>
 	<li><strong>CIM</strong>: Common Information Model (CIM) is the DMTF standard [DSP0004] for describing the structure and behavior of managed resources such as storage, network, or software components.</li>
</ul>
<ul>
 	<li><strong>WMI</strong>: Windows Management Instrumentation (WMI) is a CIM server that implements the CIM standard on Windows.</li>
</ul>
<ul>
 	<li><strong>WS-Man</strong>: WS-Management (WS-Man) protocol is a SOAP-based, firewall-friendly protocol for management clients to communicate with CIM servers.</li>
</ul>
<ul>
 	<li><strong>WinRM</strong>: Windows Remote Management (WinRM) is the Microsoft implementation of the WS-Man protocol on Windows.</li>
</ul>
&nbsp;

<strong>CIM (Common Information Model) </strong>

The "New" WMI Stack. CIM is a vendor neutral way of representing management information, In Win2012, Microsoft pivoted a bit, and brought WMI in line with the newest and finalized CIM standards, CIMv2. They implemented a standardized, HTTP-based protocol for communicating with remote machines. That protocol is WS-MAN, or Web Services for Management; more formally, it’s WS-Management. This is the same protocol used by PowerShell Remoting (Windows Remote Management, or WinRM). WinRM and CIM aren’t the same thing, but they do use the same underlying communication protocol. At this point, Microsoft started using “CIM” to refer to this newer, standards-compliant version of WMI

<strong>WMI (Windows Management Instrumentation)</strong>

This is a Microsoft implementation of early CIM standards. Lacking a protocol definition, Microsoft used DCOM, or Distributed COM, which was based on RPCs, or Remote Procedure Calls. Both were prevalent in Windows NT 4.0, which is where WMI was first introduced.

WMI is build around a repository, which is where all of its management information lives. The repository isn’t exactly a database, but you can think of it that way. The information gets into the repository by means of many different providers. A provider is a chunk of code, usually written in C++, that goes out and gets whatever information, and then makes that information available in the repository. So, the more providers you have, the more information WMI can offer.

<strong>OMI (Open Management Instrumentation)</strong>

This is a much lighter management system that can be run on hardware such as switches, etc. It is written in C which makes it easy to port to almost any device ass this is a lowest common denominator of code. In theory this could replace the CIM ("New" WMI stack) but would require a lot of rewriting of providers which will be too expensive a consideration for now.

<strong>SNMP (Simple Network Management Protocol)</strong>

-

<strong>WBEM</strong>

-