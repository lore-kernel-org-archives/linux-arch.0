From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 03/21] csky: Kernel booting
Date: Fri, 12 Oct 2018 12:42:38 +0800
Message-ID: <338de92bd8fd56f9ce5d459a55596cbb4916addd.1539315391.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch add boot code. Thx boot params is all in dtb and it's
the only way to let kernel get bootloader param information.

Changelog:
 - Use built-in dtb when dtb param is NULL.
 - Add dummy console for allmodconfig.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/head.S        |  77 ++++++++++++++++++++
 arch/csky/kernel/setup.c       | 162 +++++++++++++++++++++++++++++++++++++++++
 arch/csky/kernel/vmlinux.lds.S |  66 +++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 arch/csky/kernel/head.S
 create mode 100644 arch/csky/kernel/setup.c
 create mode 100644 arch/csky/kernel/vmlinux.lds.S

diff --git a/arch/csky/kernel/head.S b/arch/csky/kernel/head.S
new file mode 100644
index 0000000..9c4ec47
--- /dev/null
+++ b/arch/csky/kernel/head.S
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/page.h>
+#include <abi/entry.h>
+
+__HEAD
+ENTRY(_start)
+	/* set super user mode */
+	lrw	a3, DEFAULT_PSR_VALUE
+	mtcr    a3, psr
+	psrset  ee
+
+	SETUP_MMU a3
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
+	tlbi.alls
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
+	SETUP_MMU a3
+
+	/* enable MMU */
+	movi	a3, 1
+	mtcr    a3, cr18
+
+	jmpi	_goto_mmu_on
+_goto_mmu_on:
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
index 0000000..a5e3ab1
--- /dev/null
+++ b/arch/csky/kernel/setup.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/console.h>
+#include <linux/memblock.h>
+#include <linux/bootmem.h>
+#include <linux/initrd.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/start_kernel.h>
+#include <linux/dma-contiguous.h>
+#include <linux/screen_info.h>
+#include <asm/sections.h>
+#include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
+
+#ifdef CONFIG_DUMMY_CONSOLE
+struct screen_info screen_info = {
+	.orig_video_lines	= 30,
+	.orig_video_cols	= 80,
+	.orig_video_mode	= 0,
+	.orig_video_ega_bx	= 0,
+	.orig_video_isVGA	= 1,
+	.orig_video_points	= 8
+};
+#endif
+
+phys_addr_t __init_memblock memblock_end_of_REG0(void)
+{
+	return (memblock.memory.regions[0].base +
+		memblock.memory.regions[0].size);
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
+	max_pfn	    = PFN_DOWN(memblock_end_of_DRAM());
+
+	max_low_pfn = PFN_UP(memblock_end_of_REG0());
+	if (max_low_pfn == 0)
+		max_low_pfn = max_pfn;
+
+	size = max_pfn - min_low_pfn;
+
+	if (memblock.memory.cnt > 1) {
+		zone_size[ZONE_NORMAL]  =
+			PFN_DOWN(memblock_start_of_REG1()) - min_low_pfn;
+		zhole_size[ZONE_NORMAL] =
+			PFN_DOWN(memblock_start_of_REG1()) - max_low_pfn;
+	} else {
+		if (size <= PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET))
+			zone_size[ZONE_NORMAL] = max_pfn - min_low_pfn;
+		else {
+			zone_size[ZONE_NORMAL] =
+				PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+			max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
+		}
+	}
+
+#ifdef CONFIG_HIGHMEM
+	size = 0;
+	if (memblock.memory.cnt > 1) {
+		size = PFN_DOWN(memblock_size_of_REG1());
+		highstart_pfn = PFN_DOWN(memblock_start_of_REG1());
+	} else {
+		size = max_pfn - min_low_pfn -
+			PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+		highstart_pfn =  min_low_pfn +
+			PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+	}
+
+	if (size > 0)
+		zone_size[ZONE_HIGHMEM] = size;
+
+	highend_pfn = max_pfn;
+#endif
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+
+	dma_contiguous_reserve(0);
+
+	free_area_init_node(0, zone_size, min_low_pfn, zhole_size);
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	*cmdline_p = boot_command_line;
+
+	console_verbose();
+
+	pr_info("Phys. mem: %ldMB\n",
+		(unsigned long) memblock_phys_mem_size()/1024/1024);
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
+asmlinkage __visible void __init csky_start(unsigned int unused, void *param)
+{
+	/* Clean up bss section */
+	memset(__bss_start, 0, __bss_stop - __bss_start);
+
+	pre_trap_init();
+	pre_mmu_init();
+
+	if (param == NULL)
+		early_init_dt_scan(__dtb_start);
+	else
+		early_init_dt_scan(param);
+
+	start_kernel();
+
+	asm volatile("br .\n");
+}
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..ae7961b
--- /dev/null
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
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
+	vec_base = .; \
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
-- 
2.7.4
