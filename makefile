GCCPARAMS = -m32
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = boot.o kernel.o

%.o: %.c
	gcc $(GCCPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

mykernel.iso: mykernel.bin
	mkdir -p isodir/boot/grub
	cp mykernel.bin isodir/boot/mykernel.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o mykernel.iso isodir
	rm -rf iso
run: mykernel.iso
	qemu-system-i386 -cdrom mykernel.iso