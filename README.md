This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
### What organization or people are asking to have this signed?
-------------------------------------------------------------------------------
uib gmbh - we are the developers of opsi.
uib gmbh
Bonifaziusplatz 1b
55118 Mainz
https://www.uib.de

-------------------------------------------------------------------------------
### What product or service is this for?
-------------------------------------------------------------------------------
opsi is an open source operating system provisioning and software deployment framework.
We want to deploy Windows with support for SecureBoot and therefore request a signing of our SHIM. This SHIM contains ourt company key. With this key we will sign the following data and enable an easy to use way to deploy SecureBoot via opsi.

-------------------------------------------------------------------------------
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
-------------------------------------------------------------------------------
opsi is used to deploy operating systems on a large amount of devices. It would be a disadvantage to manually deploy a key on all SecureBoot enabled machines, especially when a customer has a couple hundreds or even more than throusand machines. Therefore we request a signed SHIM to further sign the rets of our deployment with our key, which is included in the shim, to ease the deployment process.

-------------------------------------------------------------------------------
### Who is the primary contact for security updates, etc.?
-------------------------------------------------------------------------------
- Name: Erol Ülükmen
- Position: CEO
- Email address: e.ueluekmen@uib.de
- PGP key fingerprint: 9083B7BB221D5E6578E3450D06DA6B5DFD200AAE
- PGP key id: 0x06DA6B5DFD200AAE

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
### Who is the secondary contact for security updates, etc.?
-------------------------------------------------------------------------------
- Name: Mathias Radtke
- Position: Developer
- Email address: m.radtke@uib.de
- PGP key fingerprint: D905656EDA12972F39FD9EB64719E3A9F93C6B3C
- PGP key id: 0x4719E3A9F93C6B3C

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
### Were these binaries created from the 15.6 shim release tar?
Please create your shim binaries starting with the 15.6 shim release tar file: https://github.com/rhboot/shim/releases/download/15.6/shim-15.6.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.6 and contains the appropriate gnu-efi source.

-------------------------------------------------------------------------------
We can confirm that all of our shim binaries are built from the referenced tarball.

-------------------------------------------------------------------------------
### URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/opsi-org/shim-review

-------------------------------------------------------------------------------
### What patches are being applied and why:
-------------------------------------------------------------------------------
Applied a patch to rename the bootloader to opsi-netboot.efi. This is now GRUB2.06 but may change in the future as we want to support HTTPS boot and therefore switch the underlying bootloader. Renaming it up front will prevent any confusion by customers who will see grubx64.efi getting loaded but not booted as it might change.
Patch is commited as opsi-netboot.patch

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
-------------------------------------------------------------------------------
Upstream GRUB2 shim_lock verifier

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list, the March 2021 grub2 CVE list, or the June 7th 2022 grub2 CVE list:
* CVE-2020-14372
* CVE-2020-25632
* CVE-2020-25647
* CVE-2020-27749
* CVE-2020-27779
* CVE-2021-20225
* CVE-2021-20233
* CVE-2020-10713
* CVE-2020-14308
* CVE-2020-14309
* CVE-2020-14310
* CVE-2020-14311
* CVE-2020-15705
* CVE-2021-3418 (if you are shipping the shim_lock module)

* CVE-2021-3695
* CVE-2021-3696
* CVE-2021-3697
* CVE-2022-28733
* CVE-2022-28734
* CVE-2022-28735
* CVE-2022-28736
* CVE-2022-28737

### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
-------------------------------------------------------------------------------
Old shim hashes have been provided to microsoft
Chain of trust disallows booting old GRUB2 builds affected by mentioned CVEs

-------------------------------------------------------------------------------
### If your boot chain of trust includes a Linux kernel:
### Is commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?

-------------------------------------------------------------------------------
All of the above commits are implemented in our linux kernel.

-------------------------------------------------------------------------------
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
-------------------------------------------------------------------------------
no vendor_db in use

-------------------------------------------------------------------------------
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
-------------------------------------------------------------------------------
New CA has been created

-------------------------------------------------------------------------------
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
-------------------------------------------------------------------------------
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.4 LTS
Release:	20.04
Codename:	focal

ii  binutils                              2.34-6ubuntu1.3                   amd64        GNU assembler, linker and binary utilities
ii  gcc                                   4:9.3.0-1ubuntu2                  amd64        GNU C compiler
ii  gcc-10-base:amd64                     10.3.0-1ubuntu1~20.04             amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-9                                 9.4.0-1ubuntu1~20.04.1            amd64        GNU C compiler
ii  gcc-9-base:amd64                      9.4.0-1ubuntu1~20.04.1            amd64        GCC, the GNU Compiler Collection (base package)
ii  libgcc-9-dev:amd64                    9.4.0-1ubuntu1~20.04.1            amd64        GCC support library (development files)
ii  libgcc-s1:amd64                       10.3.0-1ubuntu1~20.04             amd64        GCC support library
ii  gnu-efi                               3.0.9-1                           amd64        Library for developing EFI applications

-------------------------------------------------------------------------------
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.

-------------------------------------------------------------------------------
https://github.com/opsi-org/shim-review/blob/master/build.log

-------------------------------------------------------------------------------
### What changes were made since your SHIM was last signed?
-------------------------------------------------------------------------------
Updated to shim-15.6

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
03d6dab2afd15b969af65e3d33416032382bec6d03ea952e0fc37f82830ac2ee

-------------------------------------------------------------------------------
### How do you manage and protect the keys used in your SHIM?
-------------------------------------------------------------------------------
The keys are storen on a separate machine with an encrypted harddrive. Only authorized members with a specified Hardware Token have access to this machine.

-------------------------------------------------------------------------------
### Do you use EV certificates as embedded certificates in the SHIM?
-------------------------------------------------------------------------------
No

-------------------------------------------------------------------------------
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
-------------------------------------------------------------------------------

shim
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,2,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.opsi,2,opsi,shim,15.6,https://opsi.org

grub
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,2,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.opsi,2,opsi,grub2,2.06,https://opsi.org`

-------------------------------------------------------------------------------
### Which modules are built into your signed grub image?
-------------------------------------------------------------------------------
smbios fat normal tftp part_gpt part_msdos scsi linux search regexp help configfile font chain minicmd gfxterm video video_bochs video_cirrus video_colors video_fb videoinfo all_video loadbios efinet efi_gop efi_uga linuxefi efifwsetup pxe

-------------------------------------------------------------------------------
### What is the origin and full version number of your bootloader (GRUB or other)?
-------------------------------------------------------------------------------
[grub2-2.06-3](https://salsa.debian.org/grub-team/grub/-/tree/debian/2.06-3)

-------------------------------------------------------------------------------
### If your SHIM launches any other components, please provide further details on what is launched.
-------------------------------------------------------------------------------
It doesn't

-------------------------------------------------------------------------------
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
-------------------------------------------------------------------------------
It doesn't

-------------------------------------------------------------------------------
### How do the launched components prevent execution of unauthenticated code?
-------------------------------------------------------------------------------
grub2 verifies signatures on booted kernels via shim.

-------------------------------------------------------------------------------
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
-------------------------------------------------------------------------------
No

-------------------------------------------------------------------------------
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
-------------------------------------------------------------------------------
linux, various versions. Satrting with 5.17.14. They include lockdown patches & ACPI patches, lockdown is enforced when booted with SecureBoot, config enforces kernel module signatures under lockdown.

-------------------------------------------------------------------------------
### Add any additional information you think we may need to validate this shim.
-------------------------------------------------------------------------------

