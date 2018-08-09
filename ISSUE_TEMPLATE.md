Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [X] completed README.md file with the necessary information
 - [X] shim.efi to be signed
 - [X] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [X] build logs


###### What organization or people are asking to have this signed:
uib gmbh - we are the developers of opsi.

###### Version of shim:
shim 14

###### Sysdev Submission ID:
2336431

###### What product or service is this for:
opsi is an open source operating system provisioning and software deployment framework.
We want to deploy Windows with support for SecureBoot and therefore request a signing of our SHIM. This SHIM contains ourt company key. With this key we will sign the following data and enable an easy to use way to deploy SecureBoot via opsi.

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
opsi is used to deploy operating systems on a large amount of devices. It would be a disadvantage to manually deploy a key on all SecureBoot enabled machines, especially when a customer has a couple hundreds or even more than throusand machines. Therefore we request a signed SHIM to further sign the rets of our deployment with our key, which is included in the shim, to ease the deployment process.
