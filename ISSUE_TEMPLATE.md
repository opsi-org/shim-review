Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] grub-shim.x64.efi and grub-shim.arm64.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed ) (no vendor_db in use)
 - [x] any extra patches to shim via your own git tree or as files (no extra patches)
 - [x] any extra patches to grub via your own git tree or as files (no extra patches)
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************

`https://github.com/opsi-org/shim-review/releases/tag/opsi-shim-x86_64-aarch64-20250821`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************

1f9dcb9394c5fe3550af9b129ed125f33213b29a3d7a3b91fdd09688d7b1e909  grub-shim.arm64.efi
49717675b8391701fb8d73ed0ac277911ced10f38337d58b9c5a04cb38c5fc10  grub-shim.x64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************

#472
#466
#457
#360
#245
#29

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************

Primary contact verified in #472
Secondary contact verified in #245
