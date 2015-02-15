Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:18137 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbbBOHtz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 02:49:55 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 04/15] h8300: kernel booting
Date: Sun, 15 Feb 2015 16:49:22 +0900
Message-ID: <1423986573-2329-5-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150215074922.lPg_wSiBT3DQeF5JGISrfKMgBTIDiWv7qxKf40isKNk@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/boot/Makefile               |  27 +++++
 arch/h8300/boot/compressed/Makefile    |  37 +++++++
 arch/h8300/boot/compressed/head.S      |  48 +++++++++
 arch/h8300/boot/compressed/misc.c      |  74 ++++++++++++++
 arch/h8300/boot/compressed/vmlinux.lds |  32 ++++++
 arch/h8300/boot/compressed/vmlinux.scr |   9 ++
 arch/h8300/kernel/head_ram.S           |  60 ++++++++++++
 arch/h8300/kernel/head_rom.S           | 108 ++++++++++++++++++++
 arch/h8300/kernel/setup.c              | 174 +++++++++++++++++++++++++++++++++
 9 files changed, 569 insertions(+)
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
index 0000000..5072b36
--- /dev/null
+++ b/arch/h8300/boot/Makefile
@@ -0,0 +1,27 @@
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
+
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
index 0000000..f64b3d9
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
+	sub.l	er1,er1
+1:
+	mov.l	er1,@er5
+	adds	#4,er5
+	dec.l	#1,er4
+	bne	1b
+	jsr	@parse_bootparam
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
index 0000000..60ca8fa
--- /dev/null
+++ b/arch/h8300/kernel/head_rom.S
@@ -0,0 +1,108 @@
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
index 0000000..812a55f
--- /dev/null
+++ b/arch/h8300/kernel/setup.c
@@ -0,0 +1,174 @@
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
+
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+#include <asm/bootparams.h>
+
+#if defined(CONFIG_CPU_H8300H)
+#define CPU "H8/300H"
+#elif defined(CONFIG_CPU_H8S)
+#define CPU "H8S"
+#else
+#define CPU "Unknown"
+#endif
+
+struct bootparams bootparams;
+unsigned long rom_length;
+unsigned long memory_start;
+unsigned long memory_end;
+EXPORT_SYMBOL(memory_end);
+
+char __initdata command_line[COMMAND_LINE_SIZE];
+
+extern unsigned long _ramend;
+void sim_console_register(void);
+int h8300_clk_init(unsigned long hz);
+
+void __init __attribute__((weak)) early_device_init(void)
+{
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	int bootmap_size;
+
+#if defined(CONFIG_ROMKERNEL)
+	bootparams.ram_end = CONFIG_RAMBASE + CONFIG_RAMSIZE;
+	bootparams.clock_freq = CONFIG_CPU_CLOCK;
+#endif
+
+	memory_start = (unsigned long) &_ramend;
+
+	memory_start = PAGE_ALIGN(memory_start);
+	memory_end = bootparams.ram_end;
+
+	init_mm.start_code = (unsigned long) _stext;
+	init_mm.end_code = (unsigned long) _etext;
+	init_mm.end_data = (unsigned long) _edata;
+	init_mm.brk = (unsigned long) 0;
+
+	pr_notice("\r\n\nuClinux " CPU "\n");
+	pr_notice("Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne\n");
+
+	strcpy(boot_command_line, command_line);
+	*cmdline_p = command_line;
+
+	parse_early_param();
+
+	/*
+	 * give all the memory to the bootmap allocator,  tell it to put the
+	 * boot mem_map at the start of memory
+	 */
+	bootmap_size = init_bootmem_node(
+			NODE_DATA(0),
+			memory_start >> PAGE_SHIFT, /* map goes here */
+			PAGE_OFFSET >> PAGE_SHIFT,	/* 0 on coldfire */
+			memory_end >> PAGE_SHIFT);
+	/*
+	 * free the usable memory,  we have to make sure we do not free
+	 * the bootmem bitmap so we then reserve it after freeing it :-)
+	 */
+	free_bootmem(memory_start, memory_end - memory_start);
+	reserve_bootmem(memory_start, bootmap_size, BOOTMEM_DEFAULT);
+#if defined(CONFIG_H8300H_SIM) || defined(CONFIG_H8S_SIM)
+	sim_console_register();
+#endif
+
+	early_device_init();
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
+	u_long clockfreq;
+
+	cpu = CPU;
+	clockfreq = bootparams.clock_freq;
+
+	seq_printf(m,  "CPU:\t\t%s\n"
+		   "Clock:\t\t%lu.%1luMHz\n"
+		   "BogoMips:\t%lu.%02lu\n"
+		   "Calibration:\t%lu loops\n",
+		   cpu,
+		   clockfreq/1000, clockfreq%1000,
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
+void __init parse_bootparam(struct bootparams *bp)
+{
+	memcpy(&bootparams, bp, bp->size);
+	strncpy(command_line, bootparams.command_line, sizeof(command_line));
+}
+
+static void __init timer_setup(void)
+{
+	early_platform_driver_register_all("earlytimer");
+	early_platform_driver_probe("earlytimer", 1, 0);
+}
+
+void __init time_init(void)
+{
+	h8300_clk_init(bootparams.clock_freq);
+	late_time_init = timer_setup;
+}
-- 
2.1.4

