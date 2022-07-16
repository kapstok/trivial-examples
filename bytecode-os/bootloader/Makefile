SOURCE = main.asm
BIN = allersmaboot.bin
IMG = myos
VOLUMELABEL = MYOS
BUILDDIR = build

all:
	mkdir ${BUILDDIR}
	nasm -f bin -o ${BIN} ${SOURCE}
	dd bs=1024 if=/dev/zero of=${IMG}.img count=1440
	dd if=${BIN} of=${IMG}.img seek=0 count=1 conv=notrunc
	cp ${IMG}.img ${BUILDDIR}
	genisoimage -quiet -V \'${VOLUMELABEL}\' -input-charset iso8859-1 -o ${IMG}.iso -b ${IMG}.img -hide ${IMG}.img ${BUILDDIR}

clean:
	rm -R ${BUILDDIR}
