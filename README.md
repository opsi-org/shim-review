-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
uib gmbh - we are the developers of opsi.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
opsi is an open source operating system provisioning and software deployment framework.
We want to deploy Windows with support for SecureBoot and therefore request a signing of our SHIM. This SHIM contains ourt company key. With this key we will sign the following data and enable an easy to use way to deploy SecureBoot via opsi.

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
opsi is used to deploy operating systems on a large amount of devices. It would be a disadvantage to manually deploy a key on all SecureBoot enabled machines, especially when a customer has a couple hundreds or even more than throusand machines. Therefore we request a signed SHIM to further sign the rets of our deployment with our key, which is included in the shim, to ease the deployment process.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Mathias Radtke
- Position: Developer
- Email address: m.radtke@uib.de
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: C7F764E01AEEDC73

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Erol Ülükmen
- Position: CEO
- Email address: e.ueluekmen@uib.de
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: 328EFAD0AE3A9FF2

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/tag/14

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/opsi-org/shim-review/tree/uib-shim-submission
Key is not included

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
lib directory needed to be changed, as it didn't build on Ubuntu 16.04

diff -r shim-14/Makefile uibshim/Makefile
76c76
< 	LIBDIR			?= $(prefix)/lib64
---

> 	LIBDIR			?= $(prefix)/lib


-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
Ubuntu16-04 with:
    gcc                                   4:5.3.1-1ubuntu1
    binutils                              2.26.1-1ubuntu1~16.04.6
    gnu-efi                               3.0.2-1ubuntu1
    make                                  4.1-6

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
uib-shim.log
above mentioned patch has been adapted manually

-------------------------------------------------------------------------------
Put info about what bootloader you're using, including which patches it includes to enforce Secure Boot here:
-------------------------------------------------------------------------------
grub 2.02~beta2-36ubuntu3

-------------------------------------------------------------------------------
Put info about what kernel you're using, including which patches it includes to enforce Secure Boot here:
-------------------------------------------------------------------------------
Currently kernel 4.17.6, with no additional patches

