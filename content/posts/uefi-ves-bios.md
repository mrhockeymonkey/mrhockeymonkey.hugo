---
title: "UEFI Vs Bios"
date: 2016-04-15
---

UEFI is a firmware written by a manufacturer, thus they are all different but follow the same Spec. UEFI replaces BIOS as a more sophisticated approach to low-level system management. UEFI can access all of the system memory, can use a segment of disk space (The EFI Partition), and fully supports GPT disks (BIOS can only support MBR). UEFI allows for better integration between hardware and the OS such as Windows 8's ability to choose boot options from the OS (Shift + Restart). One important feature is Secure Boot. This is a method of stopping unauthorized OS's (or Malware/Root Kits) from booting up. When secure boot is turned on only OS's that match an internal "key" are allowed to execute.

**BIOS Booting** is very simple:
* Power up the system
* POST completes
* BIOS will attempt to boot from the first item on the boot order list
* If booting from a local disk the BIOS will look at the MBR (First Sector), which contains the Partitioning, File Systems and Boot Loader
*The Boot Loader takes over and may run additional code depending on the OS

**UEFI Booting** is completely different but follows a similar pattern...
* Power up System
* UEFI Boot Manager loads and consults its list of boot devices (See below definitions). For Example:

```plain

Boot0002* Fedora HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)File(\EFI\fedora\grubx64.efi)

```

This tells the system exactly which partition of which disk should be chosen to boot. The UEFI Boot Loader (.efi file) is then executed to

So when installing an OS on UEFI hardware the OS must create an EFI partition (Based on the FAT File system) for the .efi to live in and add its entry to the UEFI Boot Manager

UEFI Boot Manager provides a list of Bootable devices, These can be partitions on a GPT disk, MBR disks, PXE entries etc.

```plain

[root@system directory]# efibootmgr -v
BootCurrent: 0002
Timeout: 3 seconds
BootOrder: 0003,0002,0000,0004
Boot0000* CD/DVD Drive BIOS(3,0,00)
Boot0001* Hard Drive HD(2,0,00)
Boot0002* Fedora HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)File(\EFI\fedora\grubx64.efi)
Boot0003* opensuse HD(1,800,61800,6d98f360-cb3e-4727-8fed-5ce0c040365d)File(\EFI\opensuse\grubx64.efi)
Boot0004* Hard Drive BIOS(2,0,00)P0: ST1500DM003-9YN16G .
[root@system directory]#

```

Helpful Sources:

<a href="https://www.happyassassin.net/2014/01/25/uefi-boot-how-does-that-actually-work-then/">https://www.happyassassin.net/2014/01/25/uefi-boot-how-does-that-actually-work-then/</a>