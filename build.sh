#!/bin/sh

export SHIM_VERSION="16.1"

set -ex
apt update
apt -y install curl cpio unar sbsigntool libtasn1-6-dev gawk
apt install -y --no-install-recommends dos2unix build-essential binutils gcc gnu-efi bsdmainutils wget git ca-certificates

wget "https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2"
tar -xvf "shim-${SHIM_VERSION}.tar.bz2"
git clone https://github.com/opsi-org/shim-review.git
cp shim-review/data/sbat.opsi.csv "shim-${SHIM_VERSION}/data/sbat.csv"
cd "shim-${SHIM_VERSION}"
make DEFAULT_LOADER=\\\\grub.${ARCHITECTURE}.efi VENDOR_CERT_FILE=../shim-review/opsi-uefi-ca.der 2>&1 | tee build.log

mv shim*.efi "grub-shim.${ARCHITECTURE}.efi"
sha256sum "grub-shim.${ARCHITECTURE}.efi"
objdump -j .sbat -s "grub-shim.${ARCHITECTURE}.efi"
cd ..
