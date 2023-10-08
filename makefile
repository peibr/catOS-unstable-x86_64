GCCPARAMS = -m32
ASPARAMS = --32
LDPARAMS = -melf_i386

GEAR = gear
HEADERS = gear/headers
LOAD = loader

SRC_DIR = gear
BIN_DIR = bin

objects = $(BIN_DIR)/boot.o $(BIN_DIR)/kernel.o

.PHONY: all clean

all: $(BIN_DIR) mykernel.iso

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BIN_DIR)/%.o: $(SRC_DIR)/%.c
	gcc $(GCCPARAMS) -o $@ -c $<

$(BIN_DIR)/%.o: $(GEAR)/%.c
	gcc $(GCCPARAMS) -o $@ -c $<

$(BIN_DIR)/%.o: $(LOAD)/%.s
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

clean:
	rm -rf $(BIN_DIR) mykernel.bin isodir mykernel.iso

run: mykernel.iso
	qemu-system-i386 -cdrom mykernel.iso
