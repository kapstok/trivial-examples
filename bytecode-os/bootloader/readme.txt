cd bootloader
nasm -f bin -o allersmaboot.bin main.asm
dd bs=1024 if=/dev/zero of=myos.img count=1440 # Creating 1024B*1440B=1440KB image..
dd if=allersmaboot.bin of=myos.img seek=0 count=1 conv=notrunc
mkdir iso
cp myos.img iso
genisoimage -quiet -V 'MYOS' -input-charset iso8859-1 \
-o myos.iso -b myos.img -hide myos.img iso
rm iso # evt
