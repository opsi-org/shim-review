FROM ubuntu:22.04

RUN apt-get update -y && apt-get install -y --no-install-recommends dos2unix build-essential binutils gcc gnu-efi bsdmainutils \
        # for `git clone`
        ca-certificates git \
        # for `wget`
	wget

# Print installed packages and versions
RUN dpkg -l

RUN wget https://github.com/rhboot/shim/releases/download/16.0/shim-16.0.tar.bz2
RUN tar -xvf shim-16.0.tar.bz2
RUN git clone https://github.com/opsi-org/shim-review.git
WORKDIR /shim-16.0

RUN cp /shim-review/data/sbat.opsi.csv /shim-16.0/data/sbat.csv

RUN make 'DEFAULT_LOADER=\\\\opsi-netboot.efi' VENDOR_CERT_FILE=/shim-review/opsi-uefi-ca.der

RUN sha256sum /shim-review/shimx64.efi /shim-16.0/shimx64.efi

RUN objdump -j .sbat -s /shim-review/shimx64.efi
RUN objdump -j .sbat -s /shim-16.0/shimx64.efi

RUN hexdump -Cv /shim-review/shimx64.efi > shim-review.hexdump
RUN hexdump -Cv /shim-16.0/shimx64.efi > shim-build.hexdump
RUN diff -u shim-review.hexdump shim-build.hexdump
