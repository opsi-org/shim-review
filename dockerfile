FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y --no-install-recommends dos2unix build-essential binutils gcc gnu-efi bsdmainutils \
        # for `git clone`
        ca-certificates git \
        # for `wget`
	wget

# Print installed packages and versions
RUN dpkg -l

RUN wget https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2
RUN tar -xvf shim-15.7.tar.bz2
RUN git clone https://github.com/opsi-org/shim-review.git
WORKDIR /shim-15.7

RUN patch < /shim-review/opsi-netboot.patch
RUN patch < /shim-review/NX.patch

RUN cp /shim-review/data/sbat.opsi.csv /shim-15.7/data/sbat.csv

RUN make VENDOR_CERT_FILE=/shim-review/opsi-uefi-ca.der VENDOR_DBX_FILE=/shim-review/vendor_dbx.esl

RUN sha256sum /shim-review/shimx64.efi /shim-15.7/shimx64.efi

RUN objdump -j .sbat -s /shim-review/shimx64.efi
RUN objdump -j .sbat -s /shim-15.7/shimx64.efi

RUN hexdump -Cv /shim-review/shimx64.efi > shim-review.hexdump
RUN hexdump -Cv /shim-15.7/shimx64.efi > shim-build.hexdump
RUN diff -u shim-review.hexdump shim-build.hexdump
