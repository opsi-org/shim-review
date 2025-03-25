This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************

uib gmbh - we are the developers of opsi.
uib gmbh
Bonifaziusplatz 1b
55118 Mainz
https://www.uib.de

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)  

Tax id: DE 203394450
jurisdication registry: Amtsgericht Mainz HRB 6942

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.  
(**not** the CA certificate embedded in your shim binary)

```
Serial Number:
    04:01:c0:41:be:c1:3b:28:5f:11:4a:d4
Signature Algorithm: sha256WithRSAEncryption
Issuer: C = BE, O = GlobalSign nv-sa, CN = GlobalSign GCC R45 EV CodeSigning CA 2020
Validity
    Not Before: Feb 29 14:43:10 2024 GMT
    Not After : Mar  1 14:43:10 2027 GMT
Subject: businessCategory = Private Organization, serialNumber = HRB 6942, jurisdictionC = DE, jurisdictionST = Rheinland-Pfalz, jurisdictionL = Mainz, C = DE, ST = Rheinland-Pfalz, L = Mainz, street = Bonifatiusplatz 1B, O = uib gmbh, CN = uib gmbh, emailAddress = e.ueluekmen@uib.de
```

*******************************************************************************
### What product or service is this for?
*******************************************************************************

opsi is an open source operating system provisioning and software deployment framework.
We want to deploy Windows and various Linux Distros with support for SecureBoot and therefore request a signing of our SHIM. This SHIM contains our company key. With this key we will sign the following data and enable an easy to use way to deploy SecureBoot via opsi.

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************

opsi is used to deploy operating systems on a large amount of devices. It would be a disadvantage to manually deploy a key on all SecureBoot enabled machines, especially when a customer has a couple hundreds or even more than throusand machines. Therefore we request a signed SHIM to further sign the rets of our deployment with our key, which is included in the shim, to ease the deployment process.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************

We are using a self compiled Linux Kernel and Miniroot. To boot with secure boot enabled, shim needs to know the certificate of the CA used to sign the kernel image.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************

- Name: Erol Ülükmen
- Position: CEO
- Email address: e.ueluekmen@uib.de
- PGP key fingerprint: 9083B7BB221D5E6578E3450D06DA6B5DFD200AAE
- PGP key id: 0x06DA6B5DFD200AAE

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************

- Name: Mathias Radtke
- Position: Developer
- Email address: m.radtke@uib.de
- PGP key fingerprint: D905656EDA12972F39FD9EB64719E3A9F93C6B3C
- PGP key id: 0x4719E3A9F93C6B3C

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 16.0 shim release tar?
Please create your shim binaries starting with the 16.0 shim release tar file: https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.0 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum with the following ones:

```
7b518edd63eb840081912f095ed1487a  shim-16.0.tar.bz2
c2453b9b3c02bc01eea248e9cf634a179ff8828c  shim-16.0.tar.bz2
d503f778dc75895d3130da07e2ff23d2393862f95b6cd3d24b10cbd4af847217  shim-16.0.tar.bz2
b4367f3b1e0716d093f4230902e392d3228bd346e2e07a9377c498d8b3b08a5c0ad25c31aa03af66f54648618074a29b55a3e51925e5cfe5c7ac97257bd25880  shim-16.0.tar.bz2
```

Make sure that you've verified that your build process uses that file as a source of truth (excluding external patches) and its checksum matches. Furthermore, there's [a detached signature as well](https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2.asc) - check with the public key that has the fingerprint `8107B101A432AAC9FE8E547CA348D61BC2713E9F` that the tarball is authentic. Once you're sure, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************

We can confirm that all of our shim binaries are built from the referenced tarball.

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************

https://github.com/opsi-org/shim-review

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************

No patches have been applied to SHIM

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************

NX Compatibility flag is not set

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************

Upstream GRUB2 shim_lock verifier

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
*******************************************************************************

Yes, all fixed for the above CVEs have been applied

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 4?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,4,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************

Yes

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************

Old shim hashes have been provided to microsoft
Chain of trust disallows booting old GRUB2 builds affected by mentioned CVEs
SBAT Version has been incremented to prevent booting old version Shims

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************

All of the above mentiones commits are present in our current used Kernel 6.13.X

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs
### with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************

All of the above commits are implemented in our linux kernel.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************

No

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************

Yes

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************

no vendor_db functionality in use

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************

no vendor_db functionality in use as SBAT version has been increased with review #360

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.1 LTS
Release:	22.04
Codename:	jammy
```

```
ii  binutils                              2.38-4ubuntu2.6                         amd64        GNU assembler, linker and binary utilities
ii  gcc                                   4:11.2.0-1ubuntu1                       amd64        GNU C compiler
ii  gcc-10-base:amd64                     10.5.0-1ubuntu1~22.04                   amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-11                                11.4.0-1ubuntu1~22.04                   amd64        GNU C compiler
ii  gcc-11-base:amd64                     11.4.0-1ubuntu1~22.04                   amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-11-multilib                       11.4.0-1ubuntu1~22.04                   amd64        GNU C compiler (multilib support)
ii  gcc-12-base:amd64                     12.3.0-1ubuntu1~22.04                   amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-9                                 9.5.0-1ubuntu1~22.04                    amd64        GNU C compiler
ii  gcc-9-base:amd64                      9.5.0-1ubuntu1~22.04                    amd64        GCC, the GNU Compiler Collection (base package)
ii  gcc-multilib                          4:11.2.0-1ubuntu1                       amd64        GNU C compiler (multilib files)
ii  lib32gcc-11-dev                       11.4.0-1ubuntu1~22.04                   amd64        GCC support library (32 bit development files)
ii  lib32gcc-s1                           12.3.0-1ubuntu1~22.04                   amd64        GCC support library (32 bit Version)
ii  libgcc-11-dev:amd64                   11.4.0-1ubuntu1~22.04                   amd64        GCC support library (development files)
ii  libgcc-9-dev:amd64                    9.5.0-1ubuntu1~22.04                    amd64        GCC support library (development files)
ii  libgcc-s1:amd64                       12.3.0-1ubuntu1~22.04                   amd64        GCC support library
ii  libx32gcc-11-dev                      11.4.0-1ubuntu1~22.04                   amd64        GCC support library (x32 development files)
ii  libx32gcc-s1                          12.3.0-1ubuntu1~22.04                   amd64        GCC support library (x32)
ii  gnu-efi                               3.0.13+git20210716.269ef9d-2ubuntu1     amd64        Library for developing EFI applications
```

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************

https://github.com/opsi-org/shim-review/blob/master/build.log

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

*******************************************************************************

Updated Shim, updated Kernel

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************

6f39a94695cc98ad31d09ef7e0261b6a61be535cfa5ac12135f7af9c738e0f0f

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************

The token we use is a Hardware Token provided by our EV Certificate Issuer (Globalsign). Our signing key for the Secure Boot binaries is stored on this token, next to our EV certificate. The EV certificate itself was used to initially sign the testfile for Microsoft when joining the Microsoft Developers Program for the UEFI submissions and is NOT used to sign Kernel or Grub2 images. The Secure Boot keys are used to sign our Kernel and Grub2 images. Those Secure Boot keys match the embedded CA Cert in our shim submission.
This token is only used on this one machine. We run automated build processes for Grub2 binaries and Linux Kernel builds. After the automated build is complete the artifacts are published on an internal only file server.
We then download those files on the sign machine, enter the token password and sign the files with the aforementioned Secure Boot keys. Those signed files are then uploaded to the file server again. Afterwards an automated process takes over to create a package with those signed files, along with other files.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************

No

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************

Yes

*******************************************************************************


### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --only-section .sbat -O binary YOUR_EFI_BINARY /dev/stdout` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************

```
shim
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.opsi,4,opsi,shim,16.0,https://opsi.org
```

```
grub
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,4,Free Software Foundation,grub,2.12,https://www.gnu.org/software/grub/
grub.opsi,4,opsi,grub2,2.12,https://opsi.org`
```
*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************

all_video cat chain configfile echo exfat ext2 fat font gfxmenu gfxterm_background gfxterm halt http iso9660 lvm memdisk minicmd msdospart normal part_apple part_gpt part_msdos password password_pbkdf2 pbkdf2 png read reboot regexp scsi search serial sleep smbios tftp time tar test true video efifwsetup efinet linuxefi biosdisk gzio search_fs_file linux net pxe

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************

We are not using arm64 builds

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************

[grub2-2.12](https://git.savannah.gnu.org/cgit/grub.git/snapshot/grub-2.12.tar.gz)

*******************************************************************************
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
Hint: The most common case here will be a firmware updater like fwupd.
*******************************************************************************

It doesn't

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************

It doesn't

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************

grub2 verifies signatures on booted kernels via shim.

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************

No

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************

linux, various versions. Starting with 6.13.X. They include lockdown patches & ACPI patches, lockdown is enforced when booted with SecureBoot, config enforces kernel module signatures under lockdown.

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours. 

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************

Our grub uses the current OpenSUSE Tumbleweed patchset for Grub 2.12
