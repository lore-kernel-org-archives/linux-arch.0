Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269194AbUIHW5q@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:46292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269193AbUIHW5q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2004 18:57:46 -0400
Date: Wed, 8 Sep 2004 15:57:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: RFC: being more anal about iospace accesses..
Message-ID: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>


In my continual quest to make sparse more useful, and statically check
more stuff, I started looking at verifying correct usage of PCI
memory-mapped accesses. They are nasty because they generally "just work"  
on x86 (and some other architectures), and because we've historically had 
very permissive types for the macros that are supposed to be used. So 
there's been absolutely _tons_ of confusion whether a pointer is a pointer 
to regular kernel memory, or to memory-mapped IO space. Not helped by the 
fact that sometimes it's an integer (which can be 32-bit, and then you 
totally break on 64-bit architectures).

A quick trial patch shows that it doesn't seem to be _too_ painful to use 
the same sparse "address space" mechanism for this as we use for user 
pointers. Just do

	#define __iospace __attribute__((noderef,address_space(2)))

and force all "ioremap()" returns to have type "void __iospace *".  
Together with making "readb/w/l()" take this kind of pointer, it "Just
Makes Sense(tm)".

HOWEVER, some of that spills over even outside of "sparse". Because some 
people have successfully used "unsigned long" instead of a pointer, this 
will actually cause warnings even for normal gcc usage. And while I've 
tried out a compile on my normal x86 setup and could fix all of the 
gcc-visible things, this may be disruptive enough that people object to 
doing something like this.

Comments? I'm appending my "iospace-patch" which is enough to make gcc
happy on my (very limited) x86 driver configuration, and starts annotating
_some_ of the users with the sparse __iospace annotations. A full sparse 
run still will result in a _lot_ of warnings, but this does seem to be the 
right way to go. It not only makes it very obvious whether a pointer 
points to memory or IO space, but sparse will also warn about trying to 
dereference such a thing directly. 

Btw, doing this I was again amazed at the kind of crap we have. Drivers
casting "ioremap()" to "unsigned long" only to then cast it back to a
pointer when actually using it in any way etc etc. That's a sign of some
really bad historical interfaces. I'd blame somebody else, but dammit, I
can't find anybody but myself ;)

			Linus

----
===== arch/i386/mm/ioremap.c 1.21 vs edited =====
--- 1.21/arch/i386/mm/ioremap.c	2004-06-17 23:41:15 -07:00
+++ edited/arch/i386/mm/ioremap.c	2004-09-08 15:22:18 -07:00
@@ -110,9 +110,9 @@
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
-void * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iospace * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
 {
-	void * addr;
+	void __iospace * addr;
 	struct vm_struct * area;
 	unsigned long offset, last_addr;
 
@@ -125,7 +125,7 @@
 	 * Don't remap the low PCI/ISA area, it's always mapped..
 	 */
 	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
-		return phys_to_virt(phys_addr);
+		return (void __iospace *) phys_to_virt(phys_addr);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
@@ -156,12 +156,12 @@
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
-	addr = area->addr;
+	addr = (void __iospace *) area->addr;
 	if (remap_area_pages((unsigned long) addr, phys_addr, size, flags)) {
-		vunmap(addr);
+		vunmap((void __force *) addr);
 		return NULL;
 	}
-	return (void *) (offset + (char *)addr);
+	return (void __iospace *) (offset + (char __iospace *)addr);
 }
 
 
@@ -187,10 +187,10 @@
  * Must be freed with iounmap.
  */
 
-void *ioremap_nocache (unsigned long phys_addr, unsigned long size)
+void __iospace *ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {
 	unsigned long last_addr;
-	void *p = __ioremap(phys_addr, size, _PAGE_PCD);
+	void __iospace *p = __ioremap(phys_addr, size, _PAGE_PCD);
 	if (!p) 
 		return p; 
 
@@ -221,12 +221,12 @@
 	return p;					
 }
 
-void iounmap(void *addr)
+void iounmap(void __iospace *addr)
 {
 	struct vm_struct *p;
-	if (addr <= high_memory) 
+	if ((void __force *) addr <= high_memory) 
 		return; 
-	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long) addr));
+	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
 	if (!p) { 
 		printk("__iounmap: bad address %p\n", addr);
 		return;
===== arch/i386/pci/mmconfig.c 1.1 vs edited =====
--- 1.1/arch/i386/pci/mmconfig.c	2004-02-29 22:20:00 -08:00
+++ edited/arch/i386/pci/mmconfig.c	2004-09-08 15:37:51 -07:00
@@ -9,7 +9,7 @@
 /* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
 u32 pci_mmcfg_base_addr;
 
-#define mmcfg_virt_addr (fix_to_virt(FIX_PCIE_MCFG))
+#define mmcfg_virt_addr ((void __iospace *) fix_to_virt(FIX_PCIE_MCFG))
 
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
===== arch/i386/kernel/pci-dma.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/pci-dma.c	2004-08-22 17:39:03 -07:00
+++ edited/arch/i386/kernel/pci-dma.c	2004-09-08 11:07:13 -07:00
@@ -72,7 +72,7 @@
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 				dma_addr_t device_addr, size_t size, int flags)
 {
-	void *mem_base;
+	void __iospace *mem_base;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = (pages + 31)/32;
 
===== arch/x86_64/kernel/early_printk.c 1.13 vs edited =====
--- 1.13/arch/x86_64/kernel/early_printk.c	2004-08-26 23:59:59 -07:00
+++ edited/arch/x86_64/kernel/early_printk.c	2004-09-08 11:11:32 -07:00
@@ -8,7 +8,7 @@
 /* Simple VGA output */
 
 #ifdef __i386__
-#define VGABASE		__pa((void *)(__PAGE_OFFSET + 0xb8000UL))
+#define VGABASE		(__ISA_IO_base + 0xb8000)
 #else
 #define VGABASE		0xffffffff800b8000UL
 #endif
===== sound/pci/intel8x0.c 1.109 vs edited =====
--- 1.109/sound/pci/intel8x0.c	2004-08-23 21:01:07 -07:00
+++ edited/sound/pci/intel8x0.c	2004-09-08 15:40:07 -07:00
@@ -406,10 +406,10 @@
 
 	unsigned int mmio;
 	unsigned long addr;
-	unsigned long remap_addr;
+	void __iospace * remap_addr;
 	unsigned int bm_mmio;
 	unsigned long bmaddr;
-	unsigned long remap_bmaddr;
+	void __iospace * remap_bmaddr;
 
 	struct pci_dev *pci;
 	snd_card_t *card;
@@ -2227,9 +2227,9 @@
 		snd_dma_free_pages(&chip->bdbars);
 	}
 	if (chip->remap_addr)
-		iounmap((void *) chip->remap_addr);
+		iounmap(chip->remap_addr);
 	if (chip->remap_bmaddr)
-		iounmap((void *) chip->remap_bmaddr);
+		iounmap(chip->remap_bmaddr);
 	pci_release_regions(chip->pci);
 	kfree(chip);
 	return 0;
@@ -2502,9 +2502,8 @@
 	if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) {	/* ICH4 and Nforce */
 		chip->mmio = 1;
 		chip->addr = pci_resource_start(pci, 2);
-		chip->remap_addr = (unsigned long) ioremap_nocache(chip->addr,
-								   pci_resource_len(pci, 2));
-		if (chip->remap_addr == 0) {
+		chip->remap_addr = ioremap_nocache(chip->addr, pci_resource_len(pci, 2));
+		if (!chip->remap_addr) {
 			snd_printk("AC'97 space ioremap problem\n");
 			snd_intel8x0_free(chip);
 			return -EIO;
@@ -2515,9 +2514,8 @@
 	if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) {	/* ICH4 */
 		chip->bm_mmio = 1;
 		chip->bmaddr = pci_resource_start(pci, 3);
-		chip->remap_bmaddr = (unsigned long) ioremap_nocache(chip->bmaddr,
-								     pci_resource_len(pci, 3));
-		if (chip->remap_bmaddr == 0) {
+		chip->remap_bmaddr = ioremap_nocache(chip->bmaddr, pci_resource_len(pci, 3));
+		if (!chip->remap_bmaddr) {
 			snd_printk("Controller space ioremap problem\n");
 			snd_intel8x0_free(chip);
 			return -EIO;
===== drivers/ide/ide-iops.c 1.26 vs edited =====
--- 1.26/drivers/ide/ide-iops.c	2004-05-29 11:30:32 -07:00
+++ edited/drivers/ide/ide-iops.c	2004-09-08 15:02:33 -07:00
@@ -112,57 +112,57 @@
 
 static u8 ide_mm_inb (unsigned long port)
 {
-	return (u8) readb(port);
+	return (u8) readb((void __iospace *) port);
 }
 
 static u16 ide_mm_inw (unsigned long port)
 {
-	return (u16) readw(port);
+	return (u16) readw((void __iospace *) port);
 }
 
 static void ide_mm_insw (unsigned long port, void *addr, u32 count)
 {
-	__ide_mm_insw(port, addr, count);
+	__ide_mm_insw((void __iospace *) port, addr, count);
 }
 
 static u32 ide_mm_inl (unsigned long port)
 {
-	return (u32) readl(port);
+	return (u32) readl((void __iospace *) port);
 }
 
 static void ide_mm_insl (unsigned long port, void *addr, u32 count)
 {
-	__ide_mm_insl(port, addr, count);
+	__ide_mm_insl((void __iospace *) port, addr, count);
 }
 
 static void ide_mm_outb (u8 value, unsigned long port)
 {
-	writeb(value, port);
+	writeb(value, (void __iospace *) port);
 }
 
 static void ide_mm_outbsync (ide_drive_t *drive, u8 value, unsigned long port)
 {
-	writeb(value, port);	
+	writeb(value, (void __iospace *) port);
 }
 
 static void ide_mm_outw (u16 value, unsigned long port)
 {
-	writew(value, port);
+	writew(value, (void __iospace *) port);
 }
 
 static void ide_mm_outsw (unsigned long port, void *addr, u32 count)
 {
-	__ide_mm_outsw(port, addr, count);
+	__ide_mm_outsw((void __iospace *) port, addr, count);
 }
 
 static void ide_mm_outl (u32 value, unsigned long port)
 {
-	writel(value, port);
+	writel(value, (void __iospace *) port);
 }
 
 static void ide_mm_outsl (unsigned long port, void *addr, u32 count)
 {
-	__ide_mm_outsl(port, addr, count);
+	__ide_mm_outsl((void __iospace *) port, addr, count);
 }
 
 void default_hwif_mmiops (ide_hwif_t *hwif)
===== drivers/acpi/osl.c 1.54 vs edited =====
--- 1.54/drivers/acpi/osl.c	2004-08-13 22:10:58 -07:00
+++ edited/drivers/acpi/osl.c	2004-09-08 11:24:41 -07:00
@@ -171,11 +171,11 @@
 }
 
 acpi_status
-acpi_os_map_memory(acpi_physical_address phys, acpi_size size, void **virt)
+acpi_os_map_memory(acpi_physical_address phys, acpi_size size, void __iospace **virt)
 {
 	if (efi_enabled) {
 		if (EFI_MEMORY_WB & efi_mem_attributes(phys)) {
-			*virt = phys_to_virt(phys);
+			*virt = (void __iospace *) phys_to_virt(phys);
 		} else {
 			*virt = ioremap(phys, size);
 		}
@@ -197,7 +197,7 @@
 }
 
 void
-acpi_os_unmap_memory(void *virt, acpi_size size)
+acpi_os_unmap_memory(void __iospace *virt, acpi_size size)
 {
 	iounmap(virt);
 }
@@ -376,30 +376,31 @@
 	u32			width)
 {
 	u32			dummy;
-	void			*virt_addr;
+	void __iospace		*virt_addr;
 	int			iomem = 0;
 
 	if (efi_enabled) {
 		if (EFI_MEMORY_WB & efi_mem_attributes(phys_addr)) {
-			virt_addr = phys_to_virt(phys_addr);
+			/* HACK ALERT! We can use readb/w/l on real memory too.. */
+			virt_addr = (void __iospace *) phys_to_virt(phys_addr);
 		} else {
 			iomem = 1;
 			virt_addr = ioremap(phys_addr, width);
 		}
 	} else
-		virt_addr = phys_to_virt(phys_addr);
+		virt_addr = (void __iospace *) phys_to_virt(phys_addr);
 	if (!value)
 		value = &dummy;
 
 	switch (width) {
 	case 8:
-		*(u8*) value = *(u8*) virt_addr;
+		*(u8*) value = readb(virt_addr);
 		break;
 	case 16:
-		*(u16*) value = *(u16*) virt_addr;
+		*(u16*) value = readw(virt_addr);
 		break;
 	case 32:
-		*(u32*) value = *(u32*) virt_addr;
+		*(u32*) value = readl(virt_addr);
 		break;
 	default:
 		BUG();
@@ -419,28 +420,29 @@
 	u32			value,
 	u32			width)
 {
-	void			*virt_addr;
+	void __iospace		*virt_addr;
 	int			iomem = 0;
 
 	if (efi_enabled) {
 		if (EFI_MEMORY_WB & efi_mem_attributes(phys_addr)) {
-			virt_addr = phys_to_virt(phys_addr);
+			/* HACK ALERT! We can use writeb/w/l on real memory too */
+			virt_addr = (void __iospace *) phys_to_virt(phys_addr);
 		} else {
 			iomem = 1;
 			virt_addr = ioremap(phys_addr, width);
 		}
 	} else
-		virt_addr = phys_to_virt(phys_addr);
+		virt_addr = (void __iospace *) phys_to_virt(phys_addr);
 
 	switch (width) {
 	case 8:
-		*(u8*) virt_addr = value;
+		writeb(value, virt_addr);
 		break;
 	case 16:
-		*(u16*) virt_addr = value;
+		writew(value, virt_addr);
 		break;
 	case 32:
-		*(u32*) virt_addr = value;
+		writel(value, virt_addr);
 		break;
 	default:
 		BUG();
@@ -962,7 +964,7 @@
 {
 #if defined(__i386__) || defined(__x86_64__) 
 	char tmp;
-	return !__get_user(tmp, (char *)ptr) && !__get_user(tmp, (char *)ptr + len - 1);
+	return !__get_user(tmp, (char __user *)ptr) && !__get_user(tmp, (char __user *)ptr + len - 1);
 #endif
 	return 1;
 }
===== drivers/serial/8250_pci.c 1.39 vs edited =====
--- 1.39/drivers/serial/8250_pci.c	2004-08-23 01:15:10 -07:00
+++ edited/drivers/serial/8250_pci.c	2004-09-08 15:35:56 -07:00
@@ -83,7 +83,7 @@
 
 struct serial_private {
 	unsigned int		nr;
-	void			*remapped_bar[PCI_NUM_BAR_RESOURCES];
+	void __iospace		*remapped_bar[PCI_NUM_BAR_RESOURCES];
 	struct pci_serial_quirk	*quirk;
 	int			line[0];
 };
@@ -243,7 +243,8 @@
  */
 static int __devinit pci_plx9050_init(struct pci_dev *dev)
 {
-	u8 *p, irq_config;
+	u8 irq_config;
+	void __iospace *p;
 
 	if ((pci_resource_flags(dev, 0) & IORESOURCE_MEM) == 0) {
 		moan_device("no memory in bar 0", dev);
@@ -272,12 +273,12 @@
 	p = ioremap(pci_resource_start(dev, 0), 0x80);
 	if (p == NULL)
 		return -ENOMEM;
-	writel(irq_config, (unsigned long)p + 0x4c);
+	writel(irq_config, p + 0x4c);
 
 	/*
 	 * Read the register back to ensure that it took effect.
 	 */
-	readl((unsigned long)p + 0x4c);
+	readl(p + 0x4c);
 	iounmap(p);
 
 	return 0;
@@ -397,7 +398,8 @@
 
 static int pci_siig10x_init(struct pci_dev *dev)
 {
-	u16 data, *p;
+	u16 data;
+	void __iospace *p;
 
 	switch (dev->device & 0xfff8) {
 	case PCI_DEVICE_ID_SIIG_1S_10x:	/* 1S */
@@ -415,8 +417,8 @@
 	if (p == NULL)
 		return -ENOMEM;
 
-	writew(readw((unsigned long) p + 0x28) & data, (unsigned long) p + 0x28);
-	readw((unsigned long)p + 0x28);
+	writew(readw(p + 0x28) & data, p + 0x28);
+	readw(p + 0x28);
 	iounmap(p);
 	return 0;
 }
===== include/asm/io.h 1.26 vs edited =====
--- 1.26/include/asm-i386/io.h	2004-03-12 01:30:22 -08:00
+++ edited/include/asm/io.h	2004-09-08 11:17:57 -07:00
@@ -2,6 +2,8 @@
 #define _ASM_IO_H
 
 #include <linux/config.h>
+#include <linux/string.h>
+#include <linux/compiler.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
@@ -86,7 +88,7 @@
  */
 #define page_to_phys(page)    ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+extern void __iospace * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
 /**
  * ioremap     -   map bus memory into CPU space
@@ -100,13 +102,13 @@
  * address. 
  */
 
-static inline void * ioremap (unsigned long offset, unsigned long size)
+static inline void __iospace * ioremap (unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
 
-extern void * ioremap_nocache (unsigned long offset, unsigned long size);
-extern void iounmap(void *addr);
+extern void __iospace * ioremap_nocache (unsigned long offset, unsigned long size);
+extern void iounmap(void __iospace *addr);
 
 /*
  * bt_ioremap() and bt_iounmap() are for temporary early boot-time
@@ -139,9 +141,18 @@
  * memory location directly.
  */
 
-#define readb(addr) (*(volatile unsigned char *) (addr))
-#define readw(addr) (*(volatile unsigned short *) (addr))
-#define readl(addr) (*(volatile unsigned int *) (addr))
+static inline unsigned char readb(volatile void __iospace *addr)
+{
+	return *(volatile unsigned char __force *) addr;
+}
+static inline unsigned short readw(volatile void __iospace *addr)
+{
+	return *(volatile unsigned short __force *) addr;
+}
+static inline unsigned int readl(volatile void __iospace *addr)
+{
+	return *(volatile unsigned int __force *) addr;
+}
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
@@ -149,16 +160,34 @@
 #define __raw_readw readw
 #define __raw_readl readl
 
-#define writeb(b,addr) (*(volatile unsigned char *) (addr) = (b))
-#define writew(b,addr) (*(volatile unsigned short *) (addr) = (b))
-#define writel(b,addr) (*(volatile unsigned int *) (addr) = (b))
+static inline void writeb(unsigned char b, volatile void __iospace *addr)
+{
+	*(volatile unsigned char __force *) addr = b;
+}
+static inline void writew(unsigned short b, volatile void __iospace *addr)
+{
+	*(volatile unsigned short __force *) addr = b;
+}
+static inline void writel(unsigned int b, volatile void __iospace *addr)
+{
+	*(volatile unsigned int __force *) addr = b;
+}
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
 
-#define memset_io(a,b,c)	memset((void *)(a),(b),(c))
-#define memcpy_fromio(a,b,c)	__memcpy((a),(void *)(b),(c))
-#define memcpy_toio(a,b,c)	__memcpy((void *)(a),(b),(c))
+static inline void memset_io(volatile void __iospace *addr, unsigned char val, int count)
+{
+	memset((void __force *) addr, val, count);
+}
+static inline void memcpy_fromio(void *dst, volatile void __iospace *src, int count)
+{
+	__memcpy(dst, (void __force *) src, count);
+}
+static inline void memcpy_toio(volatile void __iospace *dst, void *src, int count)
+{
+	__memcpy((void __force *) dst, src, count);
+}
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
@@ -168,7 +197,7 @@
  * used as the IO-area pointer (it can be iounmapped as well, so the
  * analogy with PCI is quite large):
  */
-#define __ISA_IO_base ((char *)(PAGE_OFFSET))
+#define __ISA_IO_base ((char __iospace *)(PAGE_OFFSET))
 
 #define isa_readb(a) readb(__ISA_IO_base + (a))
 #define isa_readw(a) readw(__ISA_IO_base + (a))
@@ -185,8 +214,8 @@
  * Again, i386 does not require mem IO specific function.
  */
 
-#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void *)(__ISA_IO_base + (b)),(c),(d))
+#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(b),(c),(d))
+#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void __force *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures
@@ -199,7 +228,7 @@
  *	Returns 1 on a match.
  */
  
-static inline int check_signature(unsigned long io_addr,
+static inline int check_signature(volatile void __iospace * io_addr,
 	const unsigned char *signature, int length)
 {
 	int retval = 0;
===== include/acpi/acpiosxf.h 1.34 vs edited =====
--- 1.34/include/acpi/acpiosxf.h	2004-07-16 22:37:53 -07:00
+++ edited/include/acpi/acpiosxf.h	2004-09-08 11:19:20 -07:00
@@ -169,11 +169,11 @@
 acpi_os_map_memory (
 	acpi_physical_address           physical_address,
 	acpi_size                       size,
-	void                            **logical_address);
+	void __iospace                  **logical_address);
 
 void
 acpi_os_unmap_memory (
-	void                            *logical_address,
+	void __iospace                  *logical_address,
 	acpi_size                       size);
 
 acpi_status
===== include/linux/compiler.h 1.29 vs edited =====
--- 1.29/include/linux/compiler.h	2004-08-23 01:14:53 -07:00
+++ edited/include/linux/compiler.h	2004-09-08 10:34:45 -07:00
@@ -6,13 +6,17 @@
 # define __kernel	/* default address space */
 # define __safe		__attribute__((safe))
 # define __force	__attribute__((force))
+# define __iospace	__attribute__((noderef, address_space(2)))
 extern void __chk_user_ptr(void __user *);
+extern void __chk_io_ptr(void __iospace *);
 #else
 # define __user
 # define __kernel
 # define __safe
 # define __force
+# define __iospace
 # define __chk_user_ptr(x) (void)0
+# define __chk_io_ptr(x) (void)0
 #endif
 
 #ifdef __KERNEL__
===== include/asm-i386/io.h 1.26 vs edited =====
--- 1.26/include/asm-i386/io.h	2004-03-12 01:30:22 -08:00
+++ edited/include/asm-i386/io.h	2004-09-08 11:17:57 -07:00
@@ -2,6 +2,8 @@
 #define _ASM_IO_H
 
 #include <linux/config.h>
+#include <linux/string.h>
+#include <linux/compiler.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
@@ -86,7 +88,7 @@
  */
 #define page_to_phys(page)    ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
-extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
+extern void __iospace * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
 /**
  * ioremap     -   map bus memory into CPU space
@@ -100,13 +102,13 @@
  * address. 
  */
 
-static inline void * ioremap (unsigned long offset, unsigned long size)
+static inline void __iospace * ioremap (unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
 
-extern void * ioremap_nocache (unsigned long offset, unsigned long size);
-extern void iounmap(void *addr);
+extern void __iospace * ioremap_nocache (unsigned long offset, unsigned long size);
+extern void iounmap(void __iospace *addr);
 
 /*
  * bt_ioremap() and bt_iounmap() are for temporary early boot-time
@@ -139,9 +141,18 @@
  * memory location directly.
  */
 
-#define readb(addr) (*(volatile unsigned char *) (addr))
-#define readw(addr) (*(volatile unsigned short *) (addr))
-#define readl(addr) (*(volatile unsigned int *) (addr))
+static inline unsigned char readb(volatile void __iospace *addr)
+{
+	return *(volatile unsigned char __force *) addr;
+}
+static inline unsigned short readw(volatile void __iospace *addr)
+{
+	return *(volatile unsigned short __force *) addr;
+}
+static inline unsigned int readl(volatile void __iospace *addr)
+{
+	return *(volatile unsigned int __force *) addr;
+}
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
@@ -149,16 +160,34 @@
 #define __raw_readw readw
 #define __raw_readl readl
 
-#define writeb(b,addr) (*(volatile unsigned char *) (addr) = (b))
-#define writew(b,addr) (*(volatile unsigned short *) (addr) = (b))
-#define writel(b,addr) (*(volatile unsigned int *) (addr) = (b))
+static inline void writeb(unsigned char b, volatile void __iospace *addr)
+{
+	*(volatile unsigned char __force *) addr = b;
+}
+static inline void writew(unsigned short b, volatile void __iospace *addr)
+{
+	*(volatile unsigned short __force *) addr = b;
+}
+static inline void writel(unsigned int b, volatile void __iospace *addr)
+{
+	*(volatile unsigned int __force *) addr = b;
+}
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
 
-#define memset_io(a,b,c)	memset((void *)(a),(b),(c))
-#define memcpy_fromio(a,b,c)	__memcpy((a),(void *)(b),(c))
-#define memcpy_toio(a,b,c)	__memcpy((void *)(a),(b),(c))
+static inline void memset_io(volatile void __iospace *addr, unsigned char val, int count)
+{
+	memset((void __force *) addr, val, count);
+}
+static inline void memcpy_fromio(void *dst, volatile void __iospace *src, int count)
+{
+	__memcpy(dst, (void __force *) src, count);
+}
+static inline void memcpy_toio(volatile void __iospace *dst, void *src, int count)
+{
+	__memcpy((void __force *) dst, src, count);
+}
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
@@ -168,7 +197,7 @@
  * used as the IO-area pointer (it can be iounmapped as well, so the
  * analogy with PCI is quite large):
  */
-#define __ISA_IO_base ((char *)(PAGE_OFFSET))
+#define __ISA_IO_base ((char __iospace *)(PAGE_OFFSET))
 
 #define isa_readb(a) readb(__ISA_IO_base + (a))
 #define isa_readw(a) readw(__ISA_IO_base + (a))
@@ -185,8 +214,8 @@
  * Again, i386 does not require mem IO specific function.
  */
 
-#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void *)(b),(c),(d))
-#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void *)(__ISA_IO_base + (b)),(c),(d))
+#define eth_io_copy_and_sum(a,b,c,d)		eth_copy_and_sum((a),(void __force *)(b),(c),(d))
+#define isa_eth_io_copy_and_sum(a,b,c,d)	eth_copy_and_sum((a),(void __force *)(__ISA_IO_base + (b)),(c),(d))
 
 /**
  *	check_signature		-	find BIOS signatures
@@ -199,7 +228,7 @@
  *	Returns 1 on a match.
  */
  
-static inline int check_signature(unsigned long io_addr,
+static inline int check_signature(volatile void __iospace * io_addr,
 	const unsigned char *signature, int length)
 {
 	int retval = 0;
===== include/asm-generic/ide_iops.h 1.1 vs edited =====
--- 1.1/include/asm-generic/ide_iops.h	2003-02-18 06:31:01 -08:00
+++ edited/include/asm-generic/ide_iops.h	2004-09-08 15:03:14 -07:00
@@ -5,7 +5,7 @@
 #define __ide_outsw	outsw
 #define __ide_outsl	outsl
 
-static __inline__ void __ide_mm_insw(unsigned long port, void *addr, u32 count)
+static __inline__ void __ide_mm_insw(void __iospace *port, void *addr, u32 count)
 {
 	while (count--) {
 		*(u16 *)addr = readw(port);
@@ -13,7 +13,7 @@
 	}
 }
 
-static __inline__ void __ide_mm_insl(unsigned long port, void *addr, u32 count)
+static __inline__ void __ide_mm_insl(void __iospace *port, void *addr, u32 count)
 {
 	while (count--) {
 		*(u32 *)addr = readl(port);
@@ -21,7 +21,7 @@
 	}
 }
 
-static __inline__ void __ide_mm_outsw(unsigned long port, void *addr, u32 count)
+static __inline__ void __ide_mm_outsw(void __iospace *port, void *addr, u32 count)
 {
 	while (count--) {
 		writew(*(u16 *)addr, port);
@@ -29,7 +29,7 @@
 	}
 }
 
-static __inline__ void __ide_mm_outsl(unsigned long port, void *addr, u32 count)
+static __inline__ void __ide_mm_outsl(void __iospace * port, void *addr, u32 count)
 {
 	while (count--) {
 		writel(*(u32 *)addr, port);
