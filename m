From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 03/19] csky: Kernel booting
Date: Mon,  2 Jul 2018 01:30:06 +0800
Message-ID: <c63ea45045e201f85f3fd4cb4d20d6f8c3f79613.1530465326.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1530465325.git.ren_guo@c-sky.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/head.S        |  81 ++++++++++++++++++++++
 arch/csky/kernel/setup.c       | 148 +++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/vmlinux.lds.S |  65 ++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 arch/csky/kernel/head.S
 create mode 100644 arch/csky/kernel/setup.c
 create mode 100644 arch/csky/kernel/vmlinux.lds.S

diff --git a/arch/csky/kernel/head.S b/arch/csky/kernel/head.S
new file mode 100644
index 0000000..3f0be9a
--- /dev/null
+++ b/arch/csky/kernel/head.S
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/page.h>
+#include <abi/regdef.h>
+
+__HEAD
+ENTRY(_start)
+	/* set super user mode */
+	lrw	a3, DEFAULT_PSR_VALUE
+	mtcr    a3, psr
+	psrset  ee
+
+	/* set stack point */
+	lrw     a3, init_thread_union + THREAD_SIZE
+	mov	sp, a3
+
+	jmpi	csky_start
+END(_start)
+
+#ifdef CONFIG_SMP
+.align 10
+ENTRY(_start_smp_secondary)
+	/* Invalid I/Dcache BTB BHT */
+	movi	a3, 7
+	lsli	a3, 16
+	addi	a3, (1<<4) | 3
+	mtcr	a3, cr17
+
+	tlbi.all
+
+	/* setup PAGEMASK */
+	movi	a3, 0
+	mtcr	a3, cr<6, 15>
+
+	/* setup MEL0/MEL1 */
+	grs	a0, _start_smp_pc
+_start_smp_pc:
+	bmaski  a1, 13
+	andn    a0, a1
+	movi    a1, 0x00000006
+	movi    a2, 0x00001006
+	or      a1, a0
+	or      a2, a0
+	mtcr	a1, cr<2, 15>
+	mtcr	a2, cr<3, 15>
+
+	/* setup MEH */
+	mtcr	a0, cr<4, 15>
+
+	/* write TLB */
+	bgeni   a3, 28
+	mtcr	a3, cr<8, 15>
+
+	/* setup msa0 & msa1 */
+	lrw	a3, PHYS_OFFSET | 0x8e
+	mtcr	a3, cr<30, 15>
+	lrw	a3, PHYS_OFFSET | 0x26
+	mtcr	a3, cr<31, 15>
+
+	/* enable MMU */
+	movi	a3, 1
+	mtcr    a3, cr18
+
+	jmpi	_goto_mmu_on
+_goto_mmu_on:
+	movi	a3, 0xaa
+
+	lrw	a3, DEFAULT_PSR_VALUE
+	mtcr    a3, psr
+	psrset  ee
+
+	/* set stack point */
+	lrw     a3, secondary_stack
+	ld.w	a3, (a3, 0)
+	mov	sp, a3
+
+	jmpi	csky_start_secondary
+END(_start_smp_secondary)
+#endif
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
new file mode 100644
index 0000000..b7e14c8
--- /dev/null
+++ b/arch/csky/kernel/setup.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/console.h>
+#include <linux/memblock.h>
+#include <linux/bootmem.h>
+#include <linux/initrd.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/start_kernel.h>
+#include <asm/sections.h>
+#include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
+
+phys_addr_t __init_memblock memblock_end_of_REG0(void)
+{
+	return (memblock.memory.regions[0].base + memblock.memory.regions[0].size);
+}
+
+phys_addr_t __init_memblock memblock_start_of_REG1(void)
+{
+	return memblock.memory.regions[1].base;
+}
+
+size_t __init_memblock memblock_size_of_REG1(void)
+{
+	return memblock.memory.regions[1].size;
+}
+
+static void __init csky_memblock_init(void)
+{
+	unsigned long zone_size[MAX_NR_ZONES];
+	unsigned long zhole_size[MAX_NR_ZONES];
+	signed long size;
+
+	memblock_reserve(__pa(_stext), _end - _stext);
+#ifdef CONFIG_BLK_DEV_INITRD
+	memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
+#endif
+
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+
+	memblock_dump_all();
+
+	memset(zone_size, 0, sizeof(zone_size));
+	memset(zhole_size, 0, sizeof(zhole_size));
+
+	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
+	max_low_pfn = PFN_UP(memblock_end_of_REG0());
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+
+	size = max_pfn - min_low_pfn;
+
+	if (memblock.memory.cnt > 1) {
+		zone_size[ZONE_NORMAL]  = PFN_DOWN(memblock_start_of_REG1()) - min_low_pfn;
+		zhole_size[ZONE_NORMAL] = PFN_DOWN(memblock_start_of_REG1()) - max_low_pfn;
+	} else {
+		if (size <= PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET))
+			zone_size[ZONE_NORMAL] = max_pfn - min_low_pfn;
+		else {
+			zone_size[ZONE_NORMAL] = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+			max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
+		}
+	}
+
+#ifdef CONFIG_HIGHMEM
+	size = 0;
+	if(memblock.memory.cnt > 1) {
+		size = PFN_DOWN(memblock_size_of_REG1());
+		highstart_pfn = PFN_DOWN(memblock_start_of_REG1());
+	} else {
+		size = max_pfn - min_low_pfn - PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+		highstart_pfn =  min_low_pfn + PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+	}
+
+	if (size > 0)
+		zone_size[ZONE_HIGHMEM] = size;
+
+	highend_pfn = max_pfn;
+#endif
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+
+	free_area_init_node(0, zone_size, min_low_pfn, zhole_size);
+}
+
+extern void cpu_dt_probe(void);
+void __init setup_arch(char **cmdline_p)
+{
+	*cmdline_p = boot_command_line;
+
+	console_verbose();
+
+	pr_info("C-SKY: https://github.com/c-sky/csky-linux\n");
+	pr_info("Phys. mem: %ldMB\n", (unsigned long) memblock_phys_mem_size()/1024/1024);
+
+	init_mm.start_code = (unsigned long) _stext;
+	init_mm.end_code = (unsigned long) _etext;
+	init_mm.end_data = (unsigned long) _edata;
+	init_mm.brk = (unsigned long) _end;
+
+	parse_early_param();
+
+	csky_memblock_init();
+
+	unflatten_and_copy_device_tree();
+
+	cpu_dt_probe();
+
+#ifdef CONFIG_SMP
+	setup_smp();
+#endif
+
+	sparse_init();
+
+#ifdef CONFIG_HIGHMEM
+	kmap_init();
+#endif
+
+#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
+#endif
+}
+
+extern void pre_trap_init(void);
+extern void pre_mmu_init(void);
+
+asmlinkage __visible void __init csky_start(
+	unsigned int	unused,
+	void *		param
+	)
+{
+	/* Clean up bss section */
+	memset(__bss_start, 0, __bss_stop - __bss_start);
+
+	pre_trap_init();
+	pre_mmu_init();
+
+#ifdef CONFIG_CSKY_BUILTIN_DTB
+	pr_info("Use builtin dtb\n");
+	early_init_dt_scan(__dtb_start);
+#else
+	early_init_dt_scan(param);
+#endif
+	start_kernel();
+
+	while(1);
+}
+
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..fd02acf
--- /dev/null
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -0,0 +1,65 @@
+#include <asm/vmlinux.lds.h>
+#include <asm/page.h>
+
+OUTPUT_ARCH(csky)
+ENTRY(_start)
+
+#ifndef __cskyBE__
+jiffies = jiffies_64;
+#else
+jiffies = jiffies_64 + 4;
+#endif
+
+#define VBR_BASE \
+	. = ALIGN(1024); \
+	VMLINUX_SYMBOL(vec_base) = .; \
+	. += 512;
+
+SECTIONS
+{
+	. = PAGE_OFFSET + PHYS_OFFSET_OFFSET;
+
+	_stext = .;
+	__init_begin = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(PAGE_SIZE)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+
+	.text : AT(ADDR(.text) - LOAD_OFFSET) {
+		_text = .;
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		*(.fixup)
+		*(.gnu.warning)
+	} = 0
+	_etext = .;
+
+	/* __init_begin __init_end must be page aligned for free_initmem */
+	. = ALIGN(PAGE_SIZE);
+
+
+	_sdata = .;
+	RO_DATA_SECTION(PAGE_SIZE)
+	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	_edata = .;
+
+	NOTES
+	EXCEPTION_TABLE(L1_CACHE_BYTES)
+	BSS_SECTION(L1_CACHE_BYTES, PAGE_SIZE, L1_CACHE_BYTES)
+	VBR_BASE
+	_end = . ;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
+
-- 
2.7.4
