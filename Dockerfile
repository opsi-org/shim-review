FROM ubuntu:22.04

COPY build.sh /build.sh

RUN if [ "$(uname -p)" = "x86_64" ]; then ARCHITECTURE="x64"; elif [ "$(uname -m)" = "aarch64" ]; then ARCHITECTURE="arm64"; else echo "Unsupported architecture: $(uname -m)"; exit 1; fi \
	&& . /build.sh \
	&& if [ -e /shim-review/grub-shim.$ARCHITECTURE.efi ]; then objdump -j .sbat -s /shim-review/grub-shim.$ARCHITECTURE.efi; fi \
	&& objdump -j .sbat -s /shim-$SHIM_VERSION/grub-shim.$ARCHITECTURE.efi \
	&& if [ -e /shim-review/grub-shim.$ARCHITECTURE.efi ]; then hexdump -Cv /shim-review/grub-shim.$ARCHITECTURE.efi > shim-review.hexdump; fi \
	&& hexdump -Cv /shim-$SHIM_VERSION/grub-shim.$ARCHITECTURE.efi > shim-build.hexdump \
	&& if [ -e /shim-review/grub-shim.$ARCHITECTURE.efi ]; then diff -u shim-review.hexdump shim-build.hexdump; fi
