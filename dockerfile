FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y --no-install-recommends dos2unix build-essential binutils gcc gnu-efi bsdmainutils \
        # for `git clone`
        ca-certificates git \
        # for `wget`
	wget

# Print installed packages and versions
RUN dpkg -l

RUN wget https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2
RUN tar -xvf shim-15.8.tar.bz2
RUN git clone https://github.com/opsi-org/shim-review.git
WORKDIR /shim-15.8

RUN cp /shim-review/data/sbat.opsi.csv /shim-15.8/data/sbat.csv

RUN make 'DEFAULT_LOADER=\\\\opsi-netboot.efi' VENDOR_CERT_FILE=/shim-review/opsi-uefi-ca.der

RUN sha256sum /shim-review/shimx64.efi /shim-15.8/shimx64.efi

RUN objdump -j .sbat -s /shim-review/shimx64.efi
RUN objdump -j .sbat -s /shim-15.8/shimx64.efi

RUN hexdump -Cv /shim-review/shimx64.efi > shim-review.hexdump
RUN hexdump -Cv /shim-15.8/shimx64.efi > shim-build.hexdump
RUN diff -u shim-review.hexdump shim-build.hexdump
