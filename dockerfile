FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y --no-install-recommends dos2unix build-essential binutils gcc gnu-efi bsdmainutils \
        # for `git clone`
        ca-certificates git \
        # for `wget`
	wget

# Print installed packages and versions
RUN dpkg -l

RUN wget https://github.com/rhboot/shim/releases/download/15.4/shim-15.6.tar.bz2
RUN tar -xvf shim-15.6.tar.bz2
RUN git clone https://github.com/opsi-org/shim-review.git
WORKDIR /shim-15.6

RUN patch < /shim-review/opsi-netboot.patch

RUN cp /shim-review/data/sbat.opsi.csv /shim-15.6/data/

RUN make VENDOR_CERT_FILE=/shim-review/opsi-uefi-ca.der

RUN hexdump -Cv /shim-review/shimx64.efi > shim-review.hexdump
RUN hexdump -Cv /shim-15.4/shimx64.efi > shim-build.hexdump
RUN diff -u shim-review.hexdump shim-build.hexdump
RUN sha256sum /shim-review/shimx64.efi /shim-15.6/shimx64.efi
