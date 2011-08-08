From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 05/24] C6X: early boot code
Date: Mon,  8 Aug 2011 17:44:20 -0400
Message-ID: <1312839879-13592-6-git-send-email-msalter@redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab1HHVor (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:47 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78LilaX027207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:47 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78LiinO010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:47 -0400
In-Reply-To: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/kernel/head.S    |   83 ++++++++
 arch/c6x/kernel/setup.c   |  464 +++++++++++++++++++++++++++++++++++++++++++++
 arch/c6x/kernel/vectors.S |   81 ++++++++
 3 files changed, 628 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/kernel/head.S
 create mode 100644 arch/c6x/kernel/setup.c
 create mode 100644 arch/c6x/kernel/vectors.S

diff --git a/arch/c6x/kernel/head.S b/arch/c6x/kernel/head.S
new file mode 100644
index 0000000..c9327dd
--- /dev/null
+++ b/arch/c6x/kernel/head.S
@@ -0,0 +1,83 @@
+;
+;  Port on Texas Instruments TMS320C6x architecture
+;
+;  Copyright (C) 2004, 2009, 2010, 2011 Texas Instruments Incorporated
+;  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
+;
+;  This program is free software; you can redistribute it and/or modify
+;  it under the terms of the GNU General Public License version 2 as
+;  published by the Free Software Foundation.
+;
+#include <linux/linkage.h>
+#include <linux/of_fdt.h>
+#include <asm/asm-offsets.h>
+
+ENTRY(_c_int00)
+	;; Save magic and pointer
+	MV	.S1	A4,A10
+	MV	.S2	B4,B10
+	MVKL	.S2	__bss_start,B5
+	MVKH	.S2	__bss_start,B5
+	MVKL	.S2	__bss_stop,B6
+	MVKH	.S2	__bss_stop,B6
+	SUB	.L2	B6,B5,B6 ; bss size
+
+	;; Set the stack pointer
+	MVKL	.S2	current_ksp,B0
+	MVKH	.S2	current_ksp,B0
+	LDW	.D2T2	*B0,B15
+
+	;; clear bss
+	SHR	.S2	B6,3,B0	  ; number of dwords to clear
+	ZERO	.L2	B13
+	ZERO	.L2	B12
+bss_loop:
+	BDEC	.S2	bss_loop,B0
+	NOP	3
+	CMPLT	.L2	B0,0,B1
+ [!B1]	STDW	.D2T2	B13:B12,*B5++[1]
+
+	NOP	4
+	AND	.D2	~7,B15,B15
+
+	;; Clear GIE and PGIE
+	MVC	.S2	CSR,B2
+	CLR	.S2	B2,0,1,B2
+	MVC	.S2	B2,CSR
+	MVC	.S2	TSR,B2
+	CLR	.S2	B2,0,1,B2
+	MVC	.S2	B2,TSR
+	MVC	.S2	ITSR,B2
+	CLR	.S2	B2,0,1,B2
+	MVC	.S2	B2,ITSR
+	MVC	.S2	NTSR,B2
+	CLR	.S2	B2,0,1,B2
+	MVC	.S2	B2,NTSR
+
+	;; pass DTB pointer to machine_init (or zero if none)
+	MVKL	.S1	OF_DT_HEADER,A0
+	MVKH	.S1	OF_DT_HEADER,A0
+	CMPEQ	.L1	A10,A0,A0
+  [A0]	MV	.S1X	B10,A4
+  [!A0] MVK	.S1	0,A4
+
+#ifdef CONFIG_BIG_KERNEL
+	MVKL	.S1	machine_init,A0
+	MVKH	.S1	machine_init,A0
+	B	.S2X	A0
+	ADDKPC  .S2     0f,B3,4
+0:
+#else
+	CALLP	.S2	machine_init,B3
+#endif
+
+	;; Jump to Linux init
+#ifdef CONFIG_BIG_KERNEL
+	MVKL	.S1	start_kernel,A0
+	MVKH	.S1	start_kernel,A0
+	B	.S2X	A0
+#else
+	B	.S2	start_kernel
+#endif
+	NOP	5
+L1:	BNOP	.S2	L1,5
diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
new file mode 100644
index 0000000..522a128
--- /dev/null
+++ b/arch/c6x/kernel/setup.c
@@ -0,0 +1,464 @@
+/*
+ *  Port on Texas Instruments TMS320C6x architecture
+ *
+ *  Copyright (C) 2004, 2006, 2009, 2010, 2011 Texas Instruments Incorporated
+ *  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/errno.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/bootmem.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/cache.h>
+#include <linux/dma-mapping.h>
+#include <linux/memblock.h>
+
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/machdep.h>
+#include <asm/sections.h>
+#include <asm/soc.h>
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#include <linux/initrd.h>
+#include <asm/pgtable.h>
+#endif
+
+#ifdef DEBUG
+#define DBG(fmt...) printk(KERN_ERR fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+/* The main machine-dep calls structure
+ */
+struct machdep_calls c6x_md;
+EXPORT_SYMBOL(c6x_md);
+struct machdep_calls *machine_id;
+EXPORT_SYMBOL(machine_id);
+
+int c6x_num_cores;
+EXPORT_SYMBOL(c6x_num_cores);
+
+unsigned long memory_start;
+unsigned long memory_end;
+
+unsigned long ram_start;
+unsigned long ram_end;
+
+char c6x_command_line[COMMAND_LINE_SIZE];
+
+#if defined(CONFIG_CMDLINE_BOOL)
+static const char default_command_line[COMMAND_LINE_SIZE] __section(.cmdline) =
+	CONFIG_CMDLINE;
+#endif
+static const char *cpu_name, *cpu_voltage, *mmu, *fpu;
+static char *soc_rev;
+static char __cpu_rev[5], *cpu_rev;
+static size_t initrd_size = CONFIG_BLK_DEV_RAM_SIZE*1024;
+static unsigned int core_id;
+
+unsigned int ticks_per_ns_scaled;
+EXPORT_SYMBOL(ticks_per_ns_scaled);
+
+unsigned int c6x_core_freq;
+EXPORT_SYMBOL(c6x_core_freq);
+
+static void __init get_cpuinfo(void)
+{
+	unsigned cpu_id, rev_id, csr;
+	struct clk *coreclk = clk_get_sys(NULL, "core");
+	unsigned long core_khz;
+
+	if (!IS_ERR(coreclk))
+		c6x_core_freq = clk_get_rate(coreclk);
+	else {
+		printk(KERN_WARNING
+		       "Cannot find core clock frequency. Using 700MHz\n");
+		c6x_core_freq = 700000000;
+	}
+
+	core_khz = c6x_core_freq / 1000;
+
+	ticks_per_ns_scaled =
+		((uint64_t)core_khz << C6X_NDELAY_SCALE) / 1000000;
+
+	csr = get_creg(CSR);
+	cpu_id = csr >> 24;
+	rev_id = (csr >> 16) & 0xff;
+
+	mmu         = "none";
+	cpu_voltage = "unknown";
+
+	switch (cpu_id) {
+	case 0:
+		cpu_name = "C67x";
+		fpu = "yes";
+		break;
+	case 2:
+		cpu_name = "C62x";
+		fpu = "none";
+		break;
+	case 8:
+		cpu_name = "C64x";
+		fpu = "none";
+		break;
+	case 12:
+		cpu_name = "C64x";
+		fpu = "none";
+		break;
+	case 16:
+		cpu_name = "C64x+";
+		cpu_voltage = "1.2";
+		fpu = "none";
+		break;
+	default:
+		cpu_name = "unknown";
+		fpu = "none";
+	}
+
+	if (cpu_id < 16) {
+		switch (rev_id) {
+		case 0x1:
+			if (cpu_id > 8) {
+				cpu_rev = "DM640/DM641/DM642/DM643";
+				cpu_voltage = "1.2 - 1.4";
+			} else {
+				cpu_rev = "C6201";
+				cpu_voltage = "2.5";
+			}
+			break;
+		case 0x2:
+			cpu_rev = "C6201B/C6202/C6211";
+			cpu_voltage = "1.8";
+			break;
+		case 0x3:
+			cpu_rev = "C6202B/C6203/C6204/C6205";
+			cpu_voltage = "1.5";
+			break;
+		case 0x201:
+			cpu_rev = "C6701 revision 0 (early CPU)";
+			cpu_voltage = "1.8";
+			break;
+		case 0x202:
+			cpu_rev = "C6701/C6711/C6712";
+			cpu_voltage = "1.8";
+			break;
+		case 0x801:
+			cpu_rev = "C64x";
+			cpu_voltage = "1.5";
+			break;
+		default:
+			cpu_rev = "unknown";
+		}
+	} else {
+		cpu_rev = __cpu_rev;
+		snprintf(__cpu_rev, sizeof(__cpu_rev), "0x%x", cpu_id);
+	}
+
+	core_id = get_coreid();
+
+	printk(KERN_INFO "CPU%d: %s rev %s, %s volts, %uMHz\n",
+	       core_id, cpu_name, cpu_rev,
+	       cpu_voltage, c6x_core_freq / 1000000);
+	soc_silicon_rev(&soc_rev);
+}
+
+/*
+ * Early parsing of the command line
+ */
+static u32 mem_size __initdata;
+
+/* "mem=" parsing. */
+static int __init early_mem(char *p)
+{
+	if (!p)
+		return -EINVAL;
+
+	mem_size = memparse(p, &p);
+	/* don't remove all of memory when handling "mem={invalid}" */
+	if (mem_size == 0)
+		return -EINVAL;
+
+	return 0;
+}
+early_param("mem", early_mem);
+
+/* "memdma=" parsing. */
+static int __init early_memdma(char *p)
+{
+	if (!p)
+		return -EINVAL;
+
+	dma_memory_size = memparse(p, &p);
+	if (*p == '@')
+		dma_memory_start = memparse(p, &p);
+
+	return 0;
+}
+early_param("memdma", early_memdma);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+/* "initrd=" parsing. */
+static int __init early_initrd(char *p)
+{
+	if (!p)
+		return -EINVAL;
+
+	initrd_start = memparse(p, &p);
+	if (*p == ',')
+		initrd_size = memparse(p + 1, &p);
+	return 0;
+}
+early_param("initrd", early_initrd);
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+int __init c6x_add_memory(phys_addr_t start, unsigned long size)
+{
+	static int ram_found __initdata;
+
+	/* We only handle one bank (the one with PAGE_OFFSET) for now */
+	if (ram_found)
+		return -EINVAL;
+
+	if (start > PAGE_OFFSET || PAGE_OFFSET >= (start + size))
+		return 0;
+
+	ram_start = start;
+	ram_end = start + size;
+
+	ram_found = 1;
+	return 0;
+}
+
+static void __init probe_machine(void)
+{
+	/*
+	 * Iterate all c6x_md structures until we find the proper
+	 * one for the current machine type
+	 */
+	for (machine_id = &__machine_desc_start;
+	     machine_id < &__machine_desc_end;
+	     machine_id++) {
+		memcpy(&c6x_md, machine_id, sizeof(struct machdep_calls));
+		if (c6x_md.probe())
+			break;
+	}
+	/* What can we do if we didn't find ? */
+	if (machine_id >= &__machine_desc_end) {
+		DBG("No suitable machine found !\n");
+		for (;;)
+			;
+	}
+
+	printk(KERN_INFO "Using %s machine description\n", c6x_md.name);
+}
+
+/*
+ * Find out what kind of machine we're on and save any data we need
+ * from the early boot process. This is called very early on the
+ * boot process.
+ */
+notrace void __init machine_init(unsigned long dt_ptr)
+{
+	struct boot_param_header *dtb = __va(dt_ptr);
+	struct boot_param_header *fdt = (struct boot_param_header *)_fdt_start;
+
+	/* interrupts must be masked */
+	set_creg(IER, 2);
+
+	/*
+	 * Set the Interrupt Service Table (IST) to the beginning of the
+	 * vector table.
+	 */
+	set_ist(_vectors_start);
+
+	lockdep_init();
+
+	/*
+	 * dtb is passed in from bootloader.
+	 * fdt is linked in blob.
+	 */
+	if (dtb && dtb != fdt)
+		fdt = dtb;
+
+	/* Do some early initialization based on the flat device tree */
+	early_init_devtree(fdt);
+
+	/* parse_early_param needs a boot_command_line */
+	strlcpy(boot_command_line, c6x_command_line, COMMAND_LINE_SIZE);
+	parse_early_param();
+
+	probe_machine();
+
+	c6x_cache_init();
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	int bootmap_size;
+	struct memblock_region *reg;
+
+	printk(KERN_INFO "Initializing kernel\n");
+
+	/* Initialize command line */
+	*cmdline_p = c6x_command_line;
+
+	memblock_init();
+
+	memory_end = ram_end;
+	memory_end &= ~(PAGE_SIZE - 1);
+
+	if (mem_size && (PAGE_OFFSET + PAGE_ALIGN(mem_size)) < memory_end)
+		memory_end = PAGE_OFFSET + PAGE_ALIGN(mem_size);
+
+	/* add block that this kernel can use */
+	memblock_add(PAGE_OFFSET, memory_end - PAGE_OFFSET);
+
+	/* reserve kernel text/data/bss */
+	memblock_reserve(PAGE_OFFSET,
+			 PAGE_ALIGN((unsigned long)&_end - PAGE_OFFSET));
+
+	memory_start = PAGE_ALIGN((unsigned int) &_end);
+
+	printk(KERN_INFO "Memory Start=%08lx, Memory End=%08lx\n",
+	       memory_start, memory_end);
+
+	/* Set the whole external memory as non-cacheable */
+	disable_caching(ram_start, ram_end - 1);
+
+	/* Set caching of external RAM used by Linux */
+	for_each_memblock(memory, reg)
+		enable_caching(CACHE_REGION_START(reg->base),
+			       CACHE_REGION_START(reg->base + reg->size - 1));
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	/*
+	 * Enable caching for initrd which falls outside kernel memory.
+	 * Reserve if in kernel memory.
+	 */
+	if (initrd_start && initrd_size) {
+		if (memblock_is_region_memory(initrd_start, initrd_size))
+			memblock_reserve(initrd_start, initrd_size);
+		else
+			enable_caching(CACHE_REGION_START(initrd_start),
+				       CACHE_REGION_START(initrd_start +
+							  initrd_size - 1));
+	}
+#endif
+
+	/* Initialize the coherent memory */
+	coherent_mem_init();
+
+	init_mm.start_code = (unsigned long) &_stext;
+	init_mm.end_code   = (unsigned long) &_etext;
+	init_mm.end_data   = memory_start;
+	init_mm.brk        = memory_start;
+
+	/*
+	 * Give all the memory to the bootmap allocator,  tell it to put the
+	 * boot mem_map at the start of memory
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0),
+					 memory_start >> PAGE_SHIFT,
+					 PAGE_OFFSET >> PAGE_SHIFT,
+					 memory_end >> PAGE_SHIFT);
+	memblock_reserve(memory_start, bootmap_size);
+
+	memblock_analyze();
+	unflatten_device_tree();
+
+	/*
+	 * Free all memory as a starting point.
+	 */
+	free_bootmem(PAGE_OFFSET, memory_end - PAGE_OFFSET);
+
+	/*
+	 * Then reserve memory which is already being used.
+	 */
+	for_each_memblock(reserved, reg) {
+		pr_debug("reserved - 0x%08x-0x%08x\n",
+			 (u32) reg->base, (u32) reg->size);
+		reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
+	}
+
+	max_low_pfn = PFN_DOWN(memory_end);
+	min_low_pfn = PFN_UP(memory_start);
+	max_mapnr = max_low_pfn - min_low_pfn;
+
+	/* Get kmalloc into gear */
+	paging_init();
+
+	/* Call board configuration function */
+	if (c6x_md.setup_arch)
+		c6x_md.setup_arch();
+
+	/* Get CPU info */
+	get_cpuinfo();
+
+#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
+#endif
+}
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	seq_printf(m,
+		   "CPU:\t\t%s\n"
+		   "Core revision:\t%s\n"
+		   "Core voltage:\t%s\n"
+		   "Core id:\t%d\n"
+		   "SoC cores:\t%d\n"
+		   "MMU:\t\t%s\n"
+		   "FPU:\t\t%s\n"
+		   "Silicon rev:\t%s\n"
+		   "Clocking:\t%uMHz\n"
+		   "BogoMips:\t%lu.%02lu\n"
+		   "Calibration:\t%lu loops\n",
+		   cpu_name, cpu_rev, cpu_voltage,
+		   core_id, c6x_num_cores, mmu, fpu,
+		   soc_rev, (c6x_core_freq + 500000) / 1000000,
+		   (loops_per_jiffy/(500000/HZ)),
+		   (loops_per_jiffy/(5000/HZ))%100,
+		   loops_per_jiffy);
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < 1 ? (void *)1 : NULL;
+}
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	c_start,
+	c_stop,
+	c_next,
+	show_cpuinfo
+};
diff --git a/arch/c6x/kernel/vectors.S b/arch/c6x/kernel/vectors.S
new file mode 100644
index 0000000..58e8aff
--- /dev/null
+++ b/arch/c6x/kernel/vectors.S
@@ -0,0 +1,81 @@
+;
+;  Port on Texas Instruments TMS320C6x architecture
+;
+;  Copyright (C) 2004, 2006, 2009, 2010, 2011 Texas Instruments Incorporated
+;  Author: Aurelien Jacquiot (aurelien.jacquiot@jaluna.com)
+;
+;  This program is free software; you can redistribute it and/or modify
+;  it under the terms of the GNU General Public License version 2 as
+;  published by the Free Software Foundation.
+;
+;  This section handles all the interrupt vector routines.
+;  At RESET the processor sets up the DRAM timing parameters and
+;  branches to the label _c_int00 which handles initialization for the C code.
+;
+
+#define ALIGNMENT 5
+
+	.macro IRQVEC name, handler
+	.align ALIGNMENT
+	.hidden \name
+	.global \name
+\name:
+#ifdef CONFIG_BIG_KERNEL
+	STW	.D2T1	A0,*B15--[2]
+ ||	MVKL	.S1	\handler,A0
+	MVKH	.S1	\handler,A0
+	B	.S2X	A0
+	LDW	.D2T1	*++B15[2],A0
+	NOP	4
+	NOP
+	NOP
+	.endm
+#else /* CONFIG_BIG_KERNEL */
+	B	.S2	\handler
+	NOP
+	NOP
+	NOP
+	NOP
+	NOP
+	NOP
+	NOP
+	.endm
+#endif /* CONFIG_BIG_KERNEL */
+
+	   .sect ".vectors","ax"
+	   .align ALIGNMENT
+	   .global RESET
+	   .hidden RESET
+RESET:
+#ifdef CONFIG_BIG_KERNEL
+	   MVKL	.S1	_c_int00,A0		; branch to _c_int00
+	   MVKH	.S1	_c_int00,A0
+	   B	.S2X	A0
+#else
+	   B	.S2	_c_int00
+	   NOP
+	   NOP
+#endif
+	   NOP
+	   NOP
+	   NOP
+	   NOP
+	   NOP
+
+
+	   IRQVEC NMI,_nmi_handler		; NMI interrupt
+	   IRQVEC AINT,_bad_interrupt		; reserved
+	   IRQVEC MSGINT,_bad_interrupt		; reserved
+
+	   IRQVEC INT4,_int4_handler
+	   IRQVEC INT5,_int5_handler
+	   IRQVEC INT6,_int6_handler
+	   IRQVEC INT7,_int7_handler
+	   IRQVEC INT8,_int8_handler
+	   IRQVEC INT9,_int9_handler
+	   IRQVEC INT10,_int10_handler
+	   IRQVEC INT11,_int11_handler
+	   IRQVEC INT12,_int12_handler
+	   IRQVEC INT13,_int13_handler
+	   IRQVEC INT14,_int14_handler
+	   IRQVEC INT15,_int15_handler
-- 
1.7.6
