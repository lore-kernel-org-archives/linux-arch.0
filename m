From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 09/19] h8300: kernel booting
Date: Sat,  9 May 2015 00:04:29 +0900
Message-ID: <1431097479-21101-10-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

zImage startup / kernel entry point / arch depend startup

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/boot/Makefile               |  26 ++++
 arch/h8300/boot/compressed/Makefile    |  37 ++++++
 arch/h8300/boot/compressed/head.S      |  48 +++++++
 arch/h8300/boot/compressed/misc.c      |  74 +++++++++++
 arch/h8300/boot/compressed/vmlinux.lds |  32 +++++
 arch/h8300/boot/compressed/vmlinux.scr |   9 ++
 arch/h8300/kernel/head_ram.S           |  60 +++++++++
 arch/h8300/kernel/head_rom.S           | 110 ++++++++++++++++
 arch/h8300/kernel/setup.c              | 230 +++++++++++++++++++++++++++++++++
 9 files changed, 626 insertions(+)
 create mode 100644 arch/h8300/boot/Makefile
 create mode 100644 arch/h8300/boot/compressed/Makefile
 create mode 100644 arch/h8300/boot/compressed/head.S
 create mode 100644 arch/h8300/boot/compressed/misc.c
 create mode 100644 arch/h8300/boot/compressed/vmlinux.lds
 create mode 100644 arch/h8300/boot/compressed/vmlinux.scr
 create mode 100644 arch/h8300/kernel/head_ram.S
 create mode 100644 arch/h8300/kernel/head_rom.S
 create mode 100644 arch/h8300/kernel/setup.c

diff --git a/arch/h8300/boot/Makefile b/arch/h8300/boot/Makefile
new file mode 100644
index 0000000..2f6393a
--- /dev/null
+++ b/arch/h8300/boot/Makefile
@@ -0,0 +1,26 @@
+# arch/h8300/boot/Makefile
+
+targets := vmlinux.srec vmlinux.bin zImage
+subdir- := compressed
+
+OBJCOPYFLAGS_vmlinux.srec := -Osrec
+OBJCOPYFLAGS_vmlinux.bin  := -Obinary
+OBJCOPYFLAGS_zImage := -O binary -R .note -R .comment -R .stab -R .stabstr -S
+
+UIMAGE_LOADADDR = $(CONFIG_RAMBASE)
+UIMAGE_ENTRYADDR = $(shell /bin/bash -c 'printf "0x%08x" \
+	$$[$(CONFIG_RAMBASE) + $(CONFIG_OFFSET)]')
+
+$(obj)/vmlinux.srec $(obj)/vmlinux.bin:  vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/zImage: $(obj)/compressed/vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/compressed/vmlinux: FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
+
+$(obj)/uImage.bin: $(obj)/vmlinux.bin
+	$(call if_changed,uimage,none)
+
+CLEAN_FILES += arch/$(ARCH)/vmlinux.bin arch/$(ARCH)/vmlinux.srec arch/$(ARCH)/uImage.bin
diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
new file mode 100644
index 0000000..87d03b7
--- /dev/null
+++ b/arch/h8300/boot/compressed/Makefile
@@ -0,0 +1,37 @@
+#
+# linux/arch/sh/boot/compressed/Makefile
+#
+# create a compressed vmlinux image from the original vmlinux
+#
+
+targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
+
+OBJECTS = $(obj)/head.o $(obj)/misc.o
+
+#
+# IMAGE_OFFSET is the load offset of the compression loader
+# Assign dummy values if these 2 variables are not defined,
+# in order to suppress error message.
+#
+CONFIG_MEMORY_START     ?= 0x00400000
+CONFIG_BOOT_LINK_OFFSET ?= 0x00140000
+IMAGE_OFFSET := $(shell printf "0x%08x" $$(($(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET))))
+
+LIBGCC := $(shell $(CROSS-COMPILE)$(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -estartup $(obj)/vmlinux.lds
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(LIBGCC) FORCE
+	$(call if_changed,ld)
+	@:
+
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+LDFLAGS_piggy.o := -r --format binary --oformat elf32-h8300-linux -T
+OBJCOPYFLAGS := -O binary
+
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,ld)
diff --git a/arch/h8300/boot/compressed/head.S b/arch/h8300/boot/compressed/head.S
new file mode 100644
index 0000000..74c0d8cc
--- /dev/null
+++ b/arch/h8300/boot/compressed/head.S
@@ -0,0 +1,48 @@
+/*
+ *  linux/arch/h8300/boot/compressed/head.S
+ *
+ *  Copyright (C) 2006 Yoshinori Sato
+ */
+
+#include <linux/linkage.h>
+
+	.section	.text..startup,"ax"
+	.global	startup
+startup:
+	mov.l	er0, er4
+	mov.l	er0, sp
+	mov.l	#__sbss, er0
+	mov.l	#__ebss, er1
+	sub.l	er0, er1
+	shlr	er1
+	shlr	er1
+	sub.l	er2, er2
+1:
+	mov.l	er2, @er0
+	adds	#4, er0
+	dec.l	#1, er1
+	bne	1b
+	jsr	@decompress_kernel
+	mov.l	er4, er0
+	jmp	@0x400000
+
+	.align	9
+fake_headers_as_bzImage:
+	.word	0
+	.ascii	"HdrS"		; header signature
+	.word	0x0202		; header version number (>= 0x0105)
+				; or else old loadlin-1.5 will fail)
+	.word	0		; default_switch
+	.word	0		; SETUPSEG
+	.word	0x1000
+	.word	0		; pointing to kernel version string
+	.byte	0		; = 0, old one (LILO, Loadlin,
+				; 0xTV: T=0 for LILO
+				;       V = version
+	.byte	1		; Load flags bzImage=1
+	.word	0x8000		; size to move, when setup is not
+	.long	0x100000	; 0x100000 = default for big kernel
+	.long	0		; address of loaded ramdisk image
+	.long	0		; its size in bytes
+
+	.end
diff --git a/arch/h8300/boot/compressed/misc.c b/arch/h8300/boot/compressed/misc.c
new file mode 100644
index 0000000..7042741
--- /dev/null
+++ b/arch/h8300/boot/compressed/misc.c
@@ -0,0 +1,74 @@
+/*
+ * arch/h8300/boot/compressed/misc.c
+ *
+ * This is a collection of several routines from gzip-1.0.3
+ * adapted for Linux.
+ *
+ * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ *
+ * Adapted for h8300 by Yoshinori Sato 2006
+ */
+
+#include <asm/uaccess.h>
+
+/*
+ * gzip declarations
+ */
+
+#define OF(args)  args
+#define STATIC static
+
+#undef memset
+#undef memcpy
+#define memzero(s, n)     memset((s), (0), (n))
+
+extern int _end;
+static unsigned long free_mem_ptr;
+static unsigned long free_mem_end_ptr;
+
+extern char input_data[];
+extern int input_len;
+static unsigned char *output;
+
+#define HEAP_SIZE             0x10000
+
+#include "../../../../lib/decompress_inflate.c"
+
+void *memset(void *s, int c, size_t n)
+{
+	int i;
+	char *ss = (char *)s;
+
+	for (i = 0; i < n; i++)
+		ss[i] = c;
+	return s;
+}
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	int i;
+	char *d = (char *)dest, *s = (char *)src;
+
+	for (i = 0; i < n; i++)
+		d[i] = s[i];
+	return dest;
+}
+
+static void error(char *x)
+{
+
+	while (1)
+		;	/* Halt */
+}
+
+#define STACK_SIZE (4096)
+long user_stack[STACK_SIZE];
+long *stack_start = &user_stack[STACK_SIZE];
+
+void decompress_kernel(void)
+{
+	free_mem_ptr = (unsigned long)&_end;
+	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
+
+	decompress(input_data, input_len, NULL, NULL, output, NULL, error);
+}
diff --git a/arch/h8300/boot/compressed/vmlinux.lds b/arch/h8300/boot/compressed/vmlinux.lds
new file mode 100644
index 0000000..a0a3a0e
--- /dev/null
+++ b/arch/h8300/boot/compressed/vmlinux.lds
@@ -0,0 +1,32 @@
+SECTIONS
+{
+        .text :
+        {
+        __stext = . ;
+	__text = .;
+	       *(.text..startup)
+	       *(.text)
+        __etext = . ;
+        }
+
+	.rodata :
+	{
+		*(.rodata)
+	}
+        .data :
+
+        {
+        __sdata = . ;
+        ___data_start = . ;
+                *(.data.*)
+	}
+        .bss :
+        {
+        . = ALIGN(0x4) ;
+        __sbss = . ;
+                *(.bss*)
+        . = ALIGN(0x4) ;
+        __ebss = . ;
+        __end = . ;
+        }
+}
diff --git a/arch/h8300/boot/compressed/vmlinux.scr b/arch/h8300/boot/compressed/vmlinux.scr
new file mode 100644
index 0000000..a0849036
--- /dev/null
+++ b/arch/h8300/boot/compressed/vmlinux.scr
@@ -0,0 +1,9 @@
+SECTIONS
+{
+  .data : {
+	input_len = .;
+	LONG(input_data_end - input_data) input_data = .;
+	*(.data)
+	input_data_end = .;
+	}
+}
diff --git a/arch/h8300/kernel/head_ram.S b/arch/h8300/kernel/head_ram.S
new file mode 100644
index 0000000..84ac5c3
--- /dev/null
+++ b/arch/h8300/kernel/head_ram.S
@@ -0,0 +1,60 @@
+
+#include <linux/sys.h>
+#include <linux/init.h>
+#include <asm/unistd.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/errno.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#define SYSCR 0xfee012
+#define IRAMTOP 0xffff20
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#define INTCR 0xffff31
+#define IRAMTOP 0xffc000
+#endif
+
+	__HEAD
+	.global	_start
+_start:
+	mov.l	#IRAMTOP,sp
+	/* .bss clear */
+	mov.l	#_sbss,er5
+	mov.l	#_ebss,er4
+	sub.l	er5,er4
+	shlr	er4
+	shlr	er4
+	sub.l	er2,er2
+1:
+	mov.l	er2,@er5
+	adds	#4,er5
+	dec.l	#1,er4
+	bne	1b
+	jsr	@h8300_fdt_init
+
+	/* linux kernel start */
+#if defined(CONFIG_CPU_H8300H)
+	ldc	#0xd0,ccr	/* running kernel */
+	mov.l	#SYSCR,er0
+	bclr	#3,@er0
+#endif
+#if defined(CONFIG_CPU_H8S)
+	ldc	#0x07,exr
+	bclr	#4,@INTCR:8
+	bset	#5,@INTCR:8	/* Interrupt mode 2 */
+	ldc	#0x90,ccr	/* running kernel */
+#endif
+	mov.l	#init_thread_union,sp
+	add.l	#0x2000,sp
+	jsr	@start_kernel
+
+1:
+	bra	1b
+
+	.end
diff --git a/arch/h8300/kernel/head_rom.S b/arch/h8300/kernel/head_rom.S
new file mode 100644
index 0000000..9868a41
--- /dev/null
+++ b/arch/h8300/kernel/head_rom.S
@@ -0,0 +1,110 @@
+#include <linux/init.h>
+#include <asm/thread_info.h>
+
+#if defined(CONFIG_CPU_H8300H)
+	.h8300h
+#define SYSCR 0xfee012
+#define IRAMTOP 0xffff20
+#define NR_INT 64
+#endif
+#if defined(CONFIG_CPU_H8S)
+	.h8300s
+#define INTCR 0xffff31
+#define IRAMTOP 0xffc000
+#define NR_INT 128
+#endif
+
+	__HEAD
+	.global	_start
+_start:
+	mov.l	#IRAMTOP,sp
+#if !defined(CONFIG_H8300H_SIM) && \
+    !defined(CONFIG_H8S_SIM)
+	jsr	@lowlevel_init
+
+	/* copy .data */
+	mov.l	#_begin_data,er5
+	mov.l	#_sdata,er6
+	mov.l	#_edata,er4
+	sub.l	er6,er4
+	shlr.l	er4
+	shlr.l	er4
+1:
+	mov.l	@er5+,er0
+	mov.l	er0,@er6
+	adds	#4,er6
+	dec.l	#1,er4
+	bne	1b
+	/* .bss clear */
+	mov.l	#_sbss,er5
+	mov.l	#_ebss,er4
+	sub.l	er5,er4
+	shlr	er4
+	shlr	er4
+	sub.l	er0,er0
+1:
+	mov.l	er0,@er5
+	adds	#4,er5
+	dec.l	#1,er4
+	bne	1b
+#else
+	/* get cmdline from gdb */
+	jsr	@0xcc
+	;; er0 - argc
+	;; er1 - argv
+	mov.l	#command_line,er3
+	adds	#4,er1
+	dec.l	#1,er0
+	beq	4f
+1:
+	mov.l	@er1+,er2
+2:
+	mov.b	@er2+,r4l
+	beq	3f
+	mov.b	r4l,@er3
+	adds	#1,er3
+	bra	2b
+3:
+	mov.b	#' ',r4l
+	mov.b	r4l,@er3
+	adds	#1,er3
+	dec.l	#1,er0
+	bne	1b
+	subs	#1,er3
+	mov.b	#0,r4l
+	mov.b	r4l,@er3
+4:
+#endif
+	sub.l	er0,er0
+	jsr	@h8300_fdt_init
+	/* linux kernel start */
+#if defined(CONFIG_CPU_H8300H)
+	ldc	#0xd0,ccr	/* running kernel */
+	mov.l	#SYSCR,er0
+	bclr	#3,@er0
+#endif
+#if defined(CONFIG_CPU_H8S)
+	ldc	#0x07,exr
+	bclr	#4,@INTCR:8
+	bset	#5,@INTCR:8	/* Interrupt mode 2 */
+	ldc	#0x90,ccr	/* running kernel */
+#endif
+	mov.l	#init_thread_union,sp
+	add.l	#0x2000,sp
+	jsr	@start_kernel
+
+1:
+	bra	1b
+
+#if defined(CONFIG_ROMKERNEL)
+	/* interrupt vector */
+	.section .vectors,"ax"
+	.long	_start
+	.long	_start
+vector	=	2
+	.rept	NR_INT - 2
+	.long	_interrupt_redirect_table+vector*4
+vector	=	vector + 1
+	.endr
+#endif
+	.end
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
new file mode 100644
index 0000000..93e410a
--- /dev/null
+++ b/arch/h8300/kernel/setup.c
@@ -0,0 +1,230 @@
+/*
+ *  linux/arch/h8300/kernel/setup.c
+ *
+ *  Copyright (C) 2001-2014 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+/*
+ * This file handles the architecture-dependent parts of system setup
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/console.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/bootmem.h>
+#include <linux/seq_file.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/clk-provider.h>
+#include <linux/memblock.h>
+#include <linux/screen_info.h>
+
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+#include <asm/page.h>
+
+#if defined(CONFIG_CPU_H8300H)
+#define CPU "H8/300H"
+#elif defined(CONFIG_CPU_H8S)
+#define CPU "H8S"
+#else
+#define CPU "Unknown"
+#endif
+
+unsigned long memory_start;
+unsigned long memory_end;
+EXPORT_SYMBOL(memory_end);
+static unsigned long freq;
+extern char __dtb_start[];
+
+#ifdef CONFIG_VT
+struct screen_info screen_info;
+#endif
+
+char __initdata command_line[COMMAND_LINE_SIZE];
+
+void sim_console_register(void);
+
+void __init h8300_fdt_init(void *fdt, char *bootargs)
+{
+	if (!fdt)
+		fdt = __dtb_start;
+	else
+		strcpy(command_line, bootargs);
+
+	early_init_dt_scan(fdt);
+	memblock_allow_resize();
+}
+
+static void __init bootmem_init(void)
+{
+	int bootmap_size;
+	unsigned long ram_start_pfn;
+	unsigned long free_ram_start_pfn;
+	unsigned long ram_end_pfn;
+	struct memblock_region *region;
+
+	memory_end = memory_start = 0;
+
+	/* Find main memory where is the kernel */
+	for_each_memblock(memory, region) {
+		memory_start = region->base;
+		memory_end = region->base + region->size;
+	}
+
+	if (!memory_end)
+		panic("No memory!");
+
+	ram_start_pfn = PFN_UP(memory_start);
+	/* free_ram_start_pfn is first page after kernel */
+	free_ram_start_pfn = PFN_UP(__pa(_end));
+	ram_end_pfn = PFN_DOWN(memblock_end_of_DRAM());
+
+	max_pfn = ram_end_pfn;
+
+	/*
+	 * give all the memory to the bootmap allocator,  tell it to put the
+	 * boot mem_map at the start of memory
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0),
+					 free_ram_start_pfn,
+					 0,
+					 ram_end_pfn);
+	/*
+	 * free the usable memory,  we have to make sure we do not free
+	 * the bootmem bitmap so we then reserve it after freeing it :-)
+	 */
+	free_bootmem(PFN_PHYS(free_ram_start_pfn),
+		     (ram_end_pfn - free_ram_start_pfn) << PAGE_SHIFT);
+	reserve_bootmem(PFN_PHYS(free_ram_start_pfn), bootmap_size,
+			BOOTMEM_DEFAULT);
+
+	for_each_memblock(reserved, region) {
+		reserve_bootmem(region->base, region->size, BOOTMEM_DEFAULT);
+	}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	unflatten_and_copy_device_tree();
+
+	init_mm.start_code = (unsigned long) _stext;
+	init_mm.end_code = (unsigned long) _etext;
+	init_mm.end_data = (unsigned long) _edata;
+	init_mm.brk = (unsigned long) 0;
+
+	pr_notice("\r\n\nuClinux " CPU "\n");
+	pr_notice("Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne\n");
+
+	if (*command_line)
+		strcpy(boot_command_line, command_line);
+	*cmdline_p = boot_command_line;
+
+	parse_early_param();
+
+	bootmem_init();
+#if defined(CONFIG_H8300H_SIM) || defined(CONFIG_H8S_SIM)
+	sim_console_register();
+#endif
+
+	early_platform_driver_probe("earlyprintk", 1, 0);
+	/*
+	 * get kmalloc into gear
+	 */
+	paging_init();
+}
+
+/*
+ *	Get CPU information for use by the procfs.
+ */
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	char *cpu;
+
+	cpu = CPU;
+
+	seq_printf(m,  "CPU:\t\t%s\n"
+		   "Clock:\t\t%lu.%1luMHz\n"
+		   "BogoMips:\t%lu.%02lu\n"
+		   "Calibration:\t%lu loops\n",
+		   cpu,
+		   freq/1000, freq%1000,
+		   (loops_per_jiffy*HZ)/500000,
+		   ((loops_per_jiffy*HZ)/5000)%100,
+		   (loops_per_jiffy*HZ));
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < num_possible_cpus() ?
+		((void *) 0x12345678) : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
+};
+
+static int __init device_probe(void)
+{
+	of_platform_populate(NULL, NULL, NULL, NULL);
+
+	return 0;
+}
+
+device_initcall(device_probe);
+
+void __init calibrate_delay(void)
+{
+	struct device_node *cpu;
+	const int *val;
+	int freq;
+	int bus;
+
+	cpu = of_find_compatible_node(NULL, NULL, "renesas,h8300");
+	val = of_get_property(cpu, "clock-frequency", NULL);
+	if (!val)
+		panic("no cpu 'clock-frequency' parameter in device tree");
+	freq = *val;
+	val = of_get_property(cpu, "renesas,bus-width", NULL);
+	if (!val)
+		panic("no cpu 'renesas,bus-width' parameter in device tree");
+	bus = *val / 8;
+	loops_per_jiffy = freq / HZ / 6 / (3 - bus);
+	pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+		loops_per_jiffy / (500000 / HZ),
+		(loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
+}
+
+
+void __init time_init(void)
+{
+	of_clk_init(NULL);
+}
-- 
2.1.4
