Return-Path: <rusty@rustcorp.com.au>
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:56704 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261610AbUDHFAm
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Apr 2004 01:00:42 -0400
Subject: early_param patches.
From: Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain
Message-Id: <1081400400.10367.322.camel@bach>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 15:00:01 +1000
Content-Transfer-Encoding: 7bit
To: trini@kernel.crashing.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Much less ambitious patches.  First one only drags saved_command_line
into init/main.c, declaration in linux/init.h, and COMMAND_LINE_SIZE def
in asm/setup.h.

Second one adds early_param() (semantics like module_param), and the
arch can call parse_early_param() to parse them.  If it doesn't,
parse_early_param() gets called just before normal param parsing.

I'd love to remove the char ** arg from setup_arch and make all parsers
copy saved_command_line, but that's a job for another day.

Small testcase at the end...

Feedback welcome,
Rusty.

Name: Move saved_command_line to init/main.c.
Status: Booted on 2.6.5

Currently every arch declares its own char saved_command_line[].  Make
sure every arch defines COMMAND_LINE_SIZE in asm/setup.h, and declare
saved_command_line in linux/init.h (init/main.c contains the definition).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15638-linux-2.6.5/arch/alpha/kernel/setup.c .15638-linux-2.6.5.updated/arch/alpha/kernel/setup.c
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/alpha/kernel/setup.c .20920-linux-2.6.5.updated/arch/alpha/kernel/setup.c
--- .20920-linux-2.6.5/arch/alpha/kernel/setup.c	2004-04-05 09:04:10.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/alpha/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -122,7 +122,6 @@ static void get_sysnames(unsigned long, 
 static void determine_cpu_caches (unsigned int);
 
 static char command_line[COMMAND_LINE_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/arm/kernel/setup.c .20920-linux-2.6.5.updated/arch/arm/kernel/setup.c
--- .20920-linux-2.6.5/arch/arm/kernel/setup.c	2004-03-12 07:56:35.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/arm/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -81,7 +81,6 @@ struct cpu_cache_fns cpu_cache;
 
 unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 unsigned long phys_initrd_start __initdata = 0;
 unsigned long phys_initrd_size __initdata = 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/arm26/kernel/setup.c .20920-linux-2.6.5.updated/arch/arm26/kernel/setup.c
--- .20920-linux-2.6.5/arch/arm26/kernel/setup.c	2003-09-29 10:25:15.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/arm26/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -76,7 +76,6 @@ struct processor processor;
 
 unsigned char aux_device_present;
 char elf_platform[ELF_PLATFORM_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 
 unsigned long phys_initrd_start __initdata = 0;
 unsigned long phys_initrd_size __initdata = 0;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/cris/kernel/setup.c .20920-linux-2.6.5.updated/arch/cris/kernel/setup.c
--- .20920-linux-2.6.5/arch/cris/kernel/setup.c	2003-09-22 10:23:07.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/cris/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -28,10 +28,7 @@ unsigned char aux_device_present;
 extern int root_mountflags;
 extern char _etext, _edata, _end;
 
-#define COMMAND_LINE_SIZE 256
-
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 extern const unsigned long text_start, edata; /* set by the linker script */
 extern unsigned long dram_start, dram_end;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/h8300/kernel/setup.c .20920-linux-2.6.5.updated/arch/h8300/kernel/setup.c
--- .20920-linux-2.6.5/arch/h8300/kernel/setup.c	2004-04-05 09:04:11.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/h8300/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -30,6 +30,7 @@
 #include <linux/major.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
+#include <linux/init.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -60,8 +61,7 @@ unsigned long memory_end;
 
 struct task_struct *_current_task;
 
-char command_line[512];
-char saved_command_line[512];
+char command_line[COMMAND_LINE_SIZE];
 
 extern int _stext, _etext, _sdata, _edata, _sbss, _ebss, _end;
 extern int _ramstart, _ramend;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/i386/kernel/setup.c .20920-linux-2.6.5.updated/arch/i386/kernel/setup.c
--- .20920-linux-2.6.5/arch/i386/kernel/setup.c	2004-04-05 09:04:11.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/i386/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -128,7 +128,6 @@ unsigned long saved_videomode;
 #define RAMDISK_LOAD_FLAG		0x4000	
 
 static char command_line[COMMAND_LINE_SIZE];
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 unsigned char __initdata boot_params[PARAM_SIZE];
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ia64/kernel/setup.c .20920-linux-2.6.5.updated/arch/ia64/kernel/setup.c
--- .20920-linux-2.6.5/arch/ia64/kernel/setup.c	2004-04-05 09:04:12.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/ia64/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -88,10 +88,6 @@ unsigned char aux_device_present = 0xaa;
 unsigned long ia64_max_iommu_merge_mask = ~0UL;
 EXPORT_SYMBOL(ia64_max_iommu_merge_mask);
 
-#define COMMAND_LINE_SIZE	512
-
-char saved_command_line[COMMAND_LINE_SIZE]; /* used in proc filesystem */
-
 /*
  * We use a special marker for the end of memory and it uses the extra (+1) slot
  */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/m68k/kernel/setup.c .20920-linux-2.6.5.updated/arch/m68k/kernel/setup.c
--- .20920-linux-2.6.5/arch/m68k/kernel/setup.c	2004-03-12 07:56:39.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/m68k/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -62,7 +62,6 @@ struct mem_info m68k_memory[NUM_MEMINFO]
 static struct mem_info m68k_ramdisk = { 0, 0 };
 
 static char m68k_command_line[CL_SIZE];
-char saved_command_line[CL_SIZE];
 
 char m68k_debug_device[6] = "";
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/m68k/q40/config.c .20920-linux-2.6.5.updated/arch/m68k/q40/config.c
--- .20920-linux-2.6.5/arch/m68k/q40/config.c	2004-04-05 09:04:12.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/m68k/q40/config.c	2004-04-08 13:01:22.000000000 +1000
@@ -64,7 +64,6 @@ void q40_set_vectors (void);
 
 extern void q40_mksound(unsigned int /*freq*/, unsigned int /*ticks*/ );
 
-extern char *saved_command_line;
 extern char m68k_debug_device[];
 static void q40_mem_console_write(struct console *co, const char *b,
 				    unsigned int count);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/m68knommu/kernel/setup.c .20920-linux-2.6.5.updated/arch/m68knommu/kernel/setup.c
--- .20920-linux-2.6.5/arch/m68knommu/kernel/setup.c	2003-09-22 10:26:05.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/m68knommu/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -31,6 +31,7 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/init.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -51,8 +52,7 @@ unsigned long rom_length;
 unsigned long memory_start;
 unsigned long memory_end;
 
-char command_line[512];
-char saved_command_line[512];
+char command_line[COMMAND_LINE_SIZE];
 
 /* setup some dummy routines */
 static void dummy_waitbut(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/mips/kernel/setup.c .20920-linux-2.6.5.updated/arch/mips/kernel/setup.c
--- .20920-linux-2.6.5/arch/mips/kernel/setup.c	2004-03-12 07:56:40.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/mips/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -71,7 +71,6 @@ EXPORT_SYMBOL(mips_machgroup);
 struct boot_mem_map boot_mem_map;
 
 static char command_line[CL_SIZE];
-       char saved_command_line[CL_SIZE];
        char arcs_cmdline[CL_SIZE]=CONFIG_CMDLINE;
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/parisc/kernel/setup.c .20920-linux-2.6.5.updated/arch/parisc/kernel/setup.c
--- .20920-linux-2.6.5/arch/parisc/kernel/setup.c	2003-10-09 18:02:49.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/parisc/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -45,8 +45,6 @@
 #include <asm/pdc_chassis.h>
 #include <asm/io.h>
 
-#define COMMAND_LINE_SIZE 1024
-char	saved_command_line[COMMAND_LINE_SIZE];
 char	command_line[COMMAND_LINE_SIZE];
 
 /* Intended for ccio/sba/cpu statistics under /proc/bus/{runway|gsc} */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc/kernel/setup.c .20920-linux-2.6.5.updated/arch/ppc/kernel/setup.c
--- .20920-linux-2.6.5/arch/ppc/kernel/setup.c	2004-03-12 07:56:44.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/ppc/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -53,7 +54,6 @@ extern void ppc6xx_idle(void);
 extern void power4_idle(void);
 
 extern boot_infos_t *boot_infos;
-char saved_command_line[COMMAND_LINE_SIZE];
 unsigned char aux_device_present;
 struct ide_machdep_calls ppc_ide_md;
 char *sysmap;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc/platforms/lopec_setup.c .20920-linux-2.6.5.updated/arch/ppc/platforms/lopec_setup.c
--- .20920-linux-2.6.5/arch/ppc/platforms/lopec_setup.c	2003-09-29 10:25:20.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/ppc/platforms/lopec_setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -33,7 +33,6 @@
 #include <asm/hw_irq.h>
 #include <asm/prep_nvram.h>
 
-extern char saved_command_line[];
 extern void lopec_find_bridges(void);
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc/platforms/pmac_setup.c .20920-linux-2.6.5.updated/arch/ppc/platforms/pmac_setup.c
--- .20920-linux-2.6.5/arch/ppc/platforms/pmac_setup.c	2004-02-18 23:54:14.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/ppc/platforms/pmac_setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -103,8 +103,6 @@ int has_l2cache = 0;
 
 static int current_root_goodness = -1;
 
-extern char saved_command_line[];
-
 extern int pmac_newworld;
 
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc/platforms/pplus.c .20920-linux-2.6.5.updated/arch/ppc/platforms/pplus.c
--- .20920-linux-2.6.5/arch/ppc/platforms/pplus.c	2004-04-05 09:04:15.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/ppc/platforms/pplus.c	2004-04-08 13:01:22.000000000 +1000
@@ -48,8 +48,6 @@
 
 TODC_ALLOC();
 
-extern char saved_command_line[];
-
 extern void pplus_setup_hose(void);
 extern void pplus_set_VIA_IDE_native(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc/platforms/prep_setup.c .20920-linux-2.6.5.updated/arch/ppc/platforms/prep_setup.c
--- .20920-linux-2.6.5/arch/ppc/platforms/prep_setup.c	2004-04-05 09:04:16.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/ppc/platforms/prep_setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -76,7 +76,6 @@ extern void rs_nvram_write_val(int addr,
 extern void ibm_prep_init(void);
 
 extern void prep_find_bridges(void);
-extern char saved_command_line[];
 
 int _prep_type;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc64/kernel/head.S .20920-linux-2.6.5.updated/arch/ppc64/kernel/head.S
--- .20920-linux-2.6.5/arch/ppc64/kernel/head.S	2004-04-05 09:04:16.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/ppc64/kernel/head.S	2004-04-08 13:01:22.000000000 +1000
@@ -35,6 +35,7 @@
 #include <asm/offsets.h>
 #include <asm/bug.h>
 #include <asm/cputable.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_PPC_ISERIES
 #define DO_SOFT_DISABLE
@@ -2278,4 +2279,4 @@ stab_array:
  */
 	.globl	cmd_line
 cmd_line:
-	.space	512	/* COMMAND_LINE_SIZE */
+	.space	COMMAND_LINE_SIZE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/ppc64/kernel/setup.c .20920-linux-2.6.5.updated/arch/ppc64/kernel/setup.c
--- .20920-linux-2.6.5/arch/ppc64/kernel/setup.c	2004-04-05 09:04:16.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/ppc64/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -80,7 +80,6 @@ unsigned long decr_overclock_proc0_set =
 
 int powersave_nap;
 
-char saved_command_line[COMMAND_LINE_SIZE];
 unsigned char aux_device_present;
 
 void parse_cmd_line(unsigned long r3, unsigned long r4, unsigned long r5,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/s390/kernel/setup.c .20920-linux-2.6.5.updated/arch/s390/kernel/setup.c
--- .20920-linux-2.6.5/arch/s390/kernel/setup.c	2004-04-05 09:04:16.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/s390/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -74,7 +74,6 @@ extern int _text,_etext, _edata, _end;
 #include <asm/setup.h>
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/sh/kernel/setup.c .20920-linux-2.6.5.updated/arch/sh/kernel/setup.c
--- .20920-linux-2.6.5/arch/sh/kernel/setup.c	2004-02-04 15:38:41.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/sh/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -85,14 +85,12 @@ static struct sh_machine_vector* __init 
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x014))
 /* ... */
 #define COMMAND_LINE ((char *) (PARAM+0x100))
-#define COMMAND_LINE_SIZE 256
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
-       char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f },
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/sparc/kernel/setup.c .20920-linux-2.6.5.updated/arch/sparc/kernel/setup.c
--- .20920-linux-2.6.5/arch/sparc/kernel/setup.c	2004-04-05 09:04:17.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/sparc/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -244,8 +244,7 @@ extern unsigned short ram_flags;
 
 extern int root_mountflags;
 
-char saved_command_line[256];
-char reboot_command[256];
+char reboot_command[COMMAND_LINE_SIZE];
 enum sparc_cpu sparc_cpu_model;
 
 struct tt_entry *sparc_ttable;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/sparc/kernel/sparc_ksyms.c .20920-linux-2.6.5.updated/arch/sparc/kernel/sparc_ksyms.c
--- .20920-linux-2.6.5/arch/sparc/kernel/sparc_ksyms.c	2004-04-05 09:04:17.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/sparc/kernel/sparc_ksyms.c	2004-04-08 13:01:22.000000000 +1000
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -74,7 +75,6 @@ extern void *__memscan_zero(void *, size
 extern void *__memscan_generic(void *, int, size_t);
 extern int __memcmp(const void *, const void *, __kernel_size_t);
 extern int __strncmp(const char *, const char *, __kernel_size_t);
-extern char saved_command_line[];
 
 extern void bcopy (const char *, char *, int);
 extern int __ashrdi3(int, int);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/sparc64/kernel/setup.c .20920-linux-2.6.5.updated/arch/sparc64/kernel/setup.c
--- .20920-linux-2.6.5/arch/sparc64/kernel/setup.c	2004-04-05 09:04:17.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/sparc64/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -451,8 +451,7 @@ extern unsigned short ram_flags;
 
 extern int root_mountflags;
 
-char saved_command_line[256];
-char reboot_command[256];
+char reboot_command[COMMAND_LINE_SIZE];
 
 static struct pt_regs fake_swapper_regs = { { 0, }, 0, 0, 0, 0 };
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/sparc64/kernel/sparc64_ksyms.c .20920-linux-2.6.5.updated/arch/sparc64/kernel/sparc64_ksyms.c
--- .20920-linux-2.6.5/arch/sparc64/kernel/sparc64_ksyms.c	2004-04-05 09:04:17.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/sparc64/kernel/sparc64_ksyms.c	2004-04-08 13:01:22.000000000 +1000
@@ -24,6 +24,7 @@
 #include <linux/socket.h>
 #include <linux/syscalls.h>
 #include <linux/percpu.h>
+#include <linux/init.h>
 #include <net/compat.h>
 
 #include <asm/oplib.h>
@@ -76,7 +77,6 @@ extern int __memcmp(const void *, const 
 extern int __strncmp(const char *, const char *, __kernel_size_t);
 extern __kernel_size_t __strlen(const char *);
 extern __kernel_size_t strlen(const char *);
-extern char saved_command_line[];
 extern void linux_sparc_syscall(void);
 extern void rtrap(void);
 extern void show_regs(struct pt_regs *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/um/kernel/user_util.c .20920-linux-2.6.5.updated/arch/um/kernel/user_util.c
--- .20920-linux-2.6.5/arch/um/kernel/user_util.c	2003-09-22 09:48:05.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/um/kernel/user_util.c	2004-04-08 13:01:22.000000000 +1000
@@ -34,7 +34,6 @@
 #define COMMAND_LINE_SIZE _POSIX_ARG_MAX
 
 /* Changed in linux_main and setup_arch, which run before SMP is started */
-char saved_command_line[COMMAND_LINE_SIZE] = { 0 };
 char command_line[COMMAND_LINE_SIZE] = { 0 };
 
 void add_arg(char *cmd_line, char *arg)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/v850/kernel/setup.c .20920-linux-2.6.5.updated/arch/v850/kernel/setup.c
--- .20920-linux-2.6.5/arch/v850/kernel/setup.c	2004-02-18 23:54:15.000000000 +1100
+++ .20920-linux-2.6.5.updated/arch/v850/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -20,6 +20,7 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/mtd/mtd.h>
+#include <linux/init.h>
 
 #include <asm/irq.h>
 
@@ -40,8 +41,7 @@ extern char _root_fs_image_start __attri
 extern char _root_fs_image_end __attribute__ ((__weak__));
 
 
-char command_line[512];
-char saved_command_line[512];
+char command_line[COMMAND_LINE_SIZE];
 
 /* Memory not used by the kernel.  */
 static unsigned long total_ram_pages;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/arch/x86_64/kernel/setup.c .20920-linux-2.6.5.updated/arch/x86_64/kernel/setup.c
--- .20920-linux-2.6.5/arch/x86_64/kernel/setup.c	2004-04-05 09:04:20.000000000 +1000
+++ .20920-linux-2.6.5.updated/arch/x86_64/kernel/setup.c	2004-04-08 13:01:22.000000000 +1000
@@ -99,7 +99,6 @@ extern int root_mountflags;
 extern char _text, _etext, _edata, _end;
 
 char command_line[COMMAND_LINE_SIZE];
-char saved_command_line[COMMAND_LINE_SIZE];
 
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/drivers/sbus/char/openprom.c .20920-linux-2.6.5.updated/drivers/sbus/char/openprom.c
--- .20920-linux-2.6.5/drivers/sbus/char/openprom.c	2003-09-22 10:07:37.000000000 +1000
+++ .20920-linux-2.6.5.updated/drivers/sbus/char/openprom.c	2004-04-08 13:01:22.000000000 +1000
@@ -149,7 +149,6 @@ static int openprom_sunos_ioctl(struct i
 	char buffer[OPROMMAXPARAM+1], *buf;
 	struct openpromio *opp;
 	int bufsize, len, error = 0;
-	extern char saved_command_line[];
 	static int cnt;
 
 	if (cmd == OPROMSETOPT)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/fs/proc/kcore.c .20920-linux-2.6.5.updated/fs/proc/kcore.c
--- .20920-linux-2.6.5/fs/proc/kcore.c	2003-09-29 10:25:53.000000000 +1000
+++ .20920-linux-2.6.5.updated/fs/proc/kcore.c	2004-04-08 13:01:22.000000000 +1000
@@ -18,6 +18,7 @@
 #include <linux/elfcore.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -84,8 +85,6 @@ kclist_del(void *addr)
 	return 0;
 }
 
-extern char saved_command_line[];
-
 static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
 {
 	size_t try, size;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/fs/proc/proc_misc.c .20920-linux-2.6.5.updated/fs/proc/proc_misc.c
--- .20920-linux-2.6.5/fs/proc/proc_misc.c	2004-04-05 09:04:41.000000000 +1000
+++ .20920-linux-2.6.5.updated/fs/proc/proc_misc.c	2004-04-08 13:01:22.000000000 +1000
@@ -522,7 +522,6 @@ static int filesystems_read_proc(char *p
 static int cmdline_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	extern char saved_command_line[];
 	int len;
 
 	len = sprintf(page, "%s\n", saved_command_line);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-alpha/setup.h .20920-linux-2.6.5.updated/include/asm-alpha/setup.h
--- .20920-linux-2.6.5/include/asm-alpha/setup.h	1970-01-01 10:00:00.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-alpha/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -0,0 +1,6 @@
+#ifndef __ALPHA_SETUP_H
+#define __ALPHA_SETUP_H
+
+#define COMMAND_LINE_SIZE	256
+
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-alpha/system.h .20920-linux-2.6.5.updated/include/asm-alpha/system.h
--- .20920-linux-2.6.5/include/asm-alpha/system.h	2003-09-22 10:05:04.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-alpha/system.h	2004-04-08 13:01:22.000000000 +1000
@@ -43,7 +43,6 @@
  */
 #define PARAM			ZERO_PGE
 #define COMMAND_LINE		((char*)(PARAM + 0x0000))
-#define COMMAND_LINE_SIZE	256
 #define INITRD_START		(*(unsigned long *) (PARAM+0x100))
 #define INITRD_SIZE		(*(unsigned long *) (PARAM+0x108))
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-cris/setup.h .20920-linux-2.6.5.updated/include/asm-cris/setup.h
--- .20920-linux-2.6.5/include/asm-cris/setup.h	2003-09-22 10:23:13.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-cris/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -1,3 +1,6 @@
 #ifndef _CRIS_SETUP_H
 #define _CRIS_SETUP_H
+
+#define COMMAND_LINE_SIZE	256
+
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-h8300/setup.h .20920-linux-2.6.5.updated/include/asm-h8300/setup.h
--- .20920-linux-2.6.5/include/asm-h8300/setup.h	2003-09-22 10:07:04.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-h8300/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -1 +1,6 @@
-/* Nothing do */
+#ifndef __H8300_SETUP_H
+#define __H8300_SETUP_H
+
+#define COMMAND_LINE_SIZE	512
+
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-i386/param.h .20920-linux-2.6.5.updated/include/asm-i386/param.h
--- .20920-linux-2.6.5/include/asm-i386/param.h	2004-03-12 07:57:19.000000000 +1100
+++ .20920-linux-2.6.5.updated/include/asm-i386/param.h	2004-04-08 13:01:22.000000000 +1000
@@ -18,5 +18,6 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
+#define COMMAND_LINE_SIZE 256
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-ia64/setup.h .20920-linux-2.6.5.updated/include/asm-ia64/setup.h
--- .20920-linux-2.6.5/include/asm-ia64/setup.h	1970-01-01 10:00:00.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-ia64/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -0,0 +1,6 @@
+#ifndef __IA64_SETUP_H
+#define __IA64_SETUP_H
+
+#define COMMAND_LINE_SIZE	512
+
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-m68k/setup.h .20920-linux-2.6.5.updated/include/asm-m68k/setup.h
--- .20920-linux-2.6.5/include/asm-m68k/setup.h	2000-01-27 07:44:21.000000000 +1100
+++ .20920-linux-2.6.5.updated/include/asm-m68k/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -357,6 +357,7 @@ extern int m68k_is040or060;
 
 #define NUM_MEMINFO	4
 #define CL_SIZE		256
+#define COMMAND_LINE_SIZE	CL_SIZE
 
 #ifndef __ASSEMBLY__
 extern int m68k_num_memory;		/* # of memory blocks found (and used) */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-m68knommu/setup.h .20920-linux-2.6.5.updated/include/asm-m68knommu/setup.h
--- .20920-linux-2.6.5/include/asm-m68knommu/setup.h	2003-09-21 17:31:31.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-m68knommu/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -1 +1,5 @@
 #include <asm-m68k/setup.h>
+
+/* We have a bigger command line buffer. */
+#undef COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	512
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-mips/bootinfo.h .20920-linux-2.6.5.updated/include/asm-mips/bootinfo.h
--- .20920-linux-2.6.5/include/asm-mips/bootinfo.h	2004-03-12 07:57:20.000000000 +1100
+++ .20920-linux-2.6.5.updated/include/asm-mips/bootinfo.h	2004-04-08 13:01:22.000000000 +1000
@@ -12,6 +12,7 @@
 #define _ASM_BOOTINFO_H
 
 #include <linux/types.h>
+#include <asm/setup.h>
 
 /*
  * The MACH_GROUP_ IDs are the equivalent to PCI vendor IDs; the remaining
@@ -208,7 +209,7 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
-#define CL_SIZE			(256)
+#define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-mips/setup.h .20920-linux-2.6.5.updated/include/asm-mips/setup.h
--- .20920-linux-2.6.5/include/asm-mips/setup.h	1970-01-01 10:00:00.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-mips/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -0,0 +1,8 @@
+#ifdef __KERNEL__
+#ifndef _MIPS_SETUP_H
+#define _MIPS_SETUP_H
+
+#define COMMAND_LINE_SIZE	256
+
+#endif /* __SETUP_H */
+#endif /* __KERNEL__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-parisc/setup.h .20920-linux-2.6.5.updated/include/asm-parisc/setup.h
--- .20920-linux-2.6.5/include/asm-parisc/setup.h	2000-12-06 07:29:39.000000000 +1100
+++ .20920-linux-2.6.5.updated/include/asm-parisc/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -1,10 +1,6 @@
-/*
- *	Just a place holder. We don't want to have to test x86 before
- *	we include stuff
- */
-
-#ifndef _i386_SETUP_H
-#define _i386_SETUP_H
+#ifndef _PARISC_SETUP_H
+#define _PARISC_SETUP_H
 
+#define COMMAND_LINE_SIZE	1024
 
-#endif /* _i386_SETUP_H */
+#endif /* _PARISC_SETUP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-ppc/machdep.h .20920-linux-2.6.5.updated/include/asm-ppc/machdep.h
--- .20920-linux-2.6.5/include/asm-ppc/machdep.h	2004-04-05 09:04:45.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-ppc/machdep.h	2004-04-08 13:01:22.000000000 +1000
@@ -106,7 +106,6 @@ struct machdep_calls {
 };
 
 extern struct machdep_calls ppc_md;
-#define COMMAND_LINE_SIZE 512
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 extern void setup_pci_ptrs(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-ppc/setup.h .20920-linux-2.6.5.updated/include/asm-ppc/setup.h
--- .20920-linux-2.6.5/include/asm-ppc/setup.h	2003-09-21 17:28:42.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-ppc/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -6,6 +6,9 @@
 #define m68k_memory memory
 
 #include <asm-m68k/setup.h>
+/* We have a bigger command line buffer. */
+#undef COMMAND_LINE_SIZE
+#define COMMAND_LINE_SIZE	512
 
 #endif /* _PPC_SETUP_H */
 #endif /* __KERNEL__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-ppc64/machdep.h .20920-linux-2.6.5.updated/include/asm-ppc64/machdep.h
--- .20920-linux-2.6.5/include/asm-ppc64/machdep.h	2004-04-05 09:04:45.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-ppc64/machdep.h	2004-04-08 13:01:22.000000000 +1000
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/seq_file.h>
+#include <linux/init.h>
 
 struct pt_regs;
 struct pci_bus;	
@@ -110,9 +111,7 @@ struct machdep_calls {
 };
 
 extern struct machdep_calls ppc_md;
-#define COMMAND_LINE_SIZE 512
 extern char cmd_line[COMMAND_LINE_SIZE];
-extern char saved_command_line[COMMAND_LINE_SIZE];
 
 /* Functions to produce codes on the leds.
  * The SRC code should be unique for the message category and should
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-ppc64/setup.h .20920-linux-2.6.5.updated/include/asm-ppc64/setup.h
--- .20920-linux-2.6.5/include/asm-ppc64/setup.h	2003-09-21 17:22:16.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-ppc64/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -1,6 +1,6 @@
 #ifndef _PPC_SETUP_H
 #define _PPC_SETUP_H
 
-/* This is a place holder include */
+#define COMMAND_LINE_SIZE 512
 
 #endif /* _PPC_SETUP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-sh/setup.h .20920-linux-2.6.5.updated/include/asm-sh/setup.h
--- .20920-linux-2.6.5/include/asm-sh/setup.h	1970-01-01 10:00:00.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-sh/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -0,0 +1,8 @@
+#ifdef __KERNEL__
+#ifndef _SH_SETUP_H
+#define _SH_SETUP_H
+
+#define COMMAND_LINE_SIZE 256
+
+#endif /* _SH_SETUP_H */
+#endif /* __KERNEL__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-sparc/setup.h .20920-linux-2.6.5.updated/include/asm-sparc/setup.h
--- .20920-linux-2.6.5/include/asm-sparc/setup.h	2004-01-10 13:59:37.000000000 +1100
+++ .20920-linux-2.6.5.updated/include/asm-sparc/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -5,5 +5,6 @@
 #ifndef _SPARC_SETUP_H
 #define _SPARC_SETUP_H
 
+#define COMMAND_LINE_SIZE	256
 
 #endif /* _SPARC_SETUP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-sparc64/setup.h .20920-linux-2.6.5.updated/include/asm-sparc64/setup.h
--- .20920-linux-2.6.5/include/asm-sparc64/setup.h	2004-01-10 13:59:37.000000000 +1100
+++ .20920-linux-2.6.5.updated/include/asm-sparc64/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -5,5 +5,6 @@
 #ifndef _SPARC64_SETUP_H
 #define _SPARC64_SETUP_H
 
+#define COMMAND_LINE_SIZE	256
 
 #endif /* _SPARC64_SETUP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-um/setup.h .20920-linux-2.6.5.updated/include/asm-um/setup.h
--- .20920-linux-2.6.5/include/asm-um/setup.h	1970-01-01 10:00:00.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-um/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -0,0 +1,6 @@
+#ifndef SETUP_H_INCLUDED
+#define SETUP_H_INCLUDED
+
+#define COMMAND_LINE_SIZE 512
+
+#endif		/* SETUP_H_INCLUDED */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-v850/setup.h .20920-linux-2.6.5.updated/include/asm-v850/setup.h
--- .20920-linux-2.6.5/include/asm-v850/setup.h	1970-01-01 10:00:00.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-v850/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -0,0 +1,6 @@
+#ifndef _V850_SETUP_H
+#define _V850_SETUP_H
+
+#define COMMAND_LINE_SIZE	512
+
+#endif /* __SETUP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-x86_64/bootsetup.h .20920-linux-2.6.5.updated/include/asm-x86_64/bootsetup.h
--- .20920-linux-2.6.5/include/asm-x86_64/bootsetup.h	2003-09-22 10:09:13.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-x86_64/bootsetup.h	2004-04-08 13:01:22.000000000 +1000
@@ -27,7 +27,6 @@ extern char x86_boot_params[2048];
 #define INITRD_SIZE (*(unsigned int *) (PARAM+0x21c))
 #define EDID_INFO (*(struct edid_info *) (PARAM+0x440))
 #define COMMAND_LINE saved_command_line
-#define COMMAND_LINE_SIZE 256
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/asm-x86_64/setup.h .20920-linux-2.6.5.updated/include/asm-x86_64/setup.h
--- .20920-linux-2.6.5/include/asm-x86_64/setup.h	2003-09-21 17:22:16.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/asm-x86_64/setup.h	2004-04-08 13:01:22.000000000 +1000
@@ -1,10 +1,6 @@
-/*
- *	Just a place holder. We don't want to have to test x86 before
- *	we include stuff
- */
-
 #ifndef _x8664_SETUP_H
 #define _x8664_SETUP_H
 
+#define COMMAND_LINE_SIZE	256
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/include/linux/init.h .20920-linux-2.6.5.updated/include/linux/init.h
--- .20920-linux-2.6.5/include/linux/init.h	2004-04-05 09:04:46.000000000 +1000
+++ .20920-linux-2.6.5.updated/include/linux/init.h	2004-04-08 13:02:15.000000000 +1000
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <asm/setup.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -66,6 +67,9 @@ typedef void (*exitcall_t)(void);
 
 extern initcall_t __con_initcall_start, __con_initcall_end;
 extern initcall_t __security_initcall_start, __security_initcall_end;
+
+/* Defined in init/main.c */
+extern char saved_command_line[COMMAND_LINE_SIZE];
 #endif
   
 #ifndef MODULE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .20920-linux-2.6.5/init/main.c .20920-linux-2.6.5.updated/init/main.c
--- .20920-linux-2.6.5/init/main.c	2004-04-05 09:04:48.000000000 +1000
+++ .20920-linux-2.6.5.updated/init/main.c	2004-04-08 13:01:22.000000000 +1000
@@ -111,6 +111,9 @@ extern void time_init(void);
 void (*late_time_init)(void);
 extern void softirq_init(void);
 
+/* Untouched command line (eg. for /proc) saved by arch-specific code. */
+char saved_command_line[COMMAND_LINE_SIZE];
+
 static char *execute_command;
 
 /* Setup configured maximum number of CPUs to activate */
@@ -402,7 +405,6 @@ static void noinline rest_init(void)
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
-	extern char saved_command_line[];
 	extern struct kernel_param __start___param[], __stop___param[];
 /*
  * Interrupts are still disabled. Do necessary setups, then


Name: early_param Patch
Status: Tested on 2.6.5
Depends: EarlyParam/saved_command_line-in-main.c.patch.gz

This patch adds early_param() which is like module_param(), only it is
for core kernel only, and has no prefix.

Archs which want to use it can call "parse_early_param()" once they
have saved the commandline into saved_command_line.  If archs do not
call parse_early_param(), it will be called immediately before the
normal parameter parsing.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30204-linux-2.6.5/include/linux/init.h .30204-linux-2.6.5.updated/include/linux/init.h
--- .30204-linux-2.6.5/include/linux/init.h	2004-04-08 13:27:24.000000000 +1000
+++ .30204-linux-2.6.5.updated/include/linux/init.h	2004-04-08 14:08:05.000000000 +1000
@@ -111,25 +111,33 @@ extern char saved_command_line[COMMAND_L
 struct obs_kernel_param {
 	const char *str;
 	int (*setup_func)(char *);
+	int early;
 };
 
-/* OBSOLETE: see moduleparam.h for the right way. */
-#define __setup_param(str, unique_id, fn)			\
+/* Only for really core code.  See moduleparam.h for the normal way. */
+#define __setup_param(str, unique_id, fn, early)			\
 	static char __setup_str_##unique_id[] __initdata = str;	\
 	static struct obs_kernel_param __setup_##unique_id	\
 		 __attribute_used__				\
 		 __attribute__((__section__(".init.setup")))	\
-		= { __setup_str_##unique_id, fn }
+		= { __setup_str_##unique_id, fn, early }
 
 #define __setup_null_param(str, unique_id)			\
-	__setup_param(str, unique_id, NULL)
+	__setup_param(str, unique_id, NULL, 0)
 
 #define __setup(str, fn)					\
-	__setup_param(str, fn, fn)
+	__setup_param(str, fn, fn, 0)
 
 #define __obsolete_setup(str)					\
 	__setup_null_param(str, __LINE__)
 
+/* NOTE: fn is as per module_param, not __setup!  Emits warning if fn
+ * returns non-zero. */
+#define early_param(str, fn)					\
+	__setup_param(str, fn, fn, 1)
+
+/* Relies on saved_command_line being set */
+void __init parse_early_param(void);
 #endif /* __ASSEMBLY__ */
 
 /**
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .30204-linux-2.6.5/init/main.c .30204-linux-2.6.5.updated/init/main.c
--- .30204-linux-2.6.5/init/main.c	2004-04-08 13:27:24.000000000 +1000
+++ .30204-linux-2.6.5.updated/init/main.c	2004-04-08 14:07:07.000000000 +1000
@@ -160,6 +160,9 @@ static int __init obsolete_checksetup(ch
 	do {
 		int n = strlen(p->str);
 		if (!strncmp(line, p->str, n)) {
+			/* Already done in parse_early_param? */
+			if (p->early)
+				return 1;
 			if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is obsolete, ignored\n", p->str);
 				return 1;
@@ -398,6 +401,38 @@ static void noinline rest_init(void)
  	cpu_idle();
 } 
 
+/* Check for early params. */
+static int __init do_early_param(char *param, char *val)
+{
+	struct obs_kernel_param *p;
+	extern struct obs_kernel_param __setup_start, __setup_end;
+
+	for (p = &__setup_start; p < &__setup_end; p++) {
+		if (p->early && strcmp(param, p->str) == 0) {
+			if (p->setup_func(val) != 0)
+				printk(KERN_WARNING
+				       "Malformed early option '%s'\n", param);
+		}
+	}
+	/* We accept everything at this stage. */
+	return 0;
+}
+
+/* Arch code calls this early on, or if not, just before other parsing. */
+void __init parse_early_param(void)
+{
+	static __initdata int done = 0;
+	static __initdata char tmp_cmdline[COMMAND_LINE_SIZE];
+
+	if (done)
+		return;
+
+	/* All fall through to do_early_param. */
+	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
+	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
+	done = 1;
+}
+
 /*
  *	Activate the first processor.
  */
@@ -425,6 +461,7 @@ asmlinkage void __init start_kernel(void
 	build_all_zonelists();
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
+	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
@@ -640,3 +677,10 @@ static int init(void * unused)
 
 	panic("No init found.  Try passing init= option to kernel.");
 }
+
+static int early_param_test(char *rest)
+{
+	printk("early_parm_test: %s\n", rest ?: "(null)");
+	return rest ? 0 : -EINVAL;
+}
+early_param("testsetup", early_param_test);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell
