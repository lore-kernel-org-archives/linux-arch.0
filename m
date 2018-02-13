From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 20/37] nds32: VDSO support
Date: Tue, 13 Feb 2018 17:09:24 +0800
Message-ID: <e8bae4af9975ee44773eefcc4584a2b3b0809b13.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1518505384.git.greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
In-Reply-To: <cover.1518505384.git.greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
References: <cover.1518505384.git.greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

This patch adds VDSO support. The VDSO code is currently used for
sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).

Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 arch/nds32/include/asm/vdso.h              |  24 +++
 arch/nds32/include/asm/vdso_datapage.h     |  36 ++++
 arch/nds32/include/asm/vdso_timer_info.h   |  14 ++
 arch/nds32/kernel/vdso.c                   | 230 ++++++++++++++++++++++++
 arch/nds32/kernel/vdso/Makefile            |  82 +++++++++
 arch/nds32/kernel/vdso/datapage.S          |  21 +++
 arch/nds32/kernel/vdso/gen_vdso_offsets.sh |  15 ++
 arch/nds32/kernel/vdso/gettimeofday.c      | 270 +++++++++++++++++++++++++++++
 arch/nds32/kernel/vdso/note.S              |  11 ++
 arch/nds32/kernel/vdso/sigreturn.S         |  19 ++
 arch/nds32/kernel/vdso/vdso.S              |  18 ++
 arch/nds32/kernel/vdso/vdso.lds.S          |  76 ++++++++
 12 files changed, 816 insertions(+)
 create mode 100644 arch/nds32/include/asm/vdso.h
 create mode 100644 arch/nds32/include/asm/vdso_datapage.h
 create mode 100644 arch/nds32/include/asm/vdso_timer_info.h
 create mode 100644 arch/nds32/kernel/vdso.c
 create mode 100644 arch/nds32/kernel/vdso/Makefile
 create mode 100644 arch/nds32/kernel/vdso/datapage.S
 create mode 100755 arch/nds32/kernel/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/nds32/kernel/vdso/gettimeofday.c
 create mode 100644 arch/nds32/kernel/vdso/note.S
 create mode 100644 arch/nds32/kernel/vdso/sigreturn.S
 create mode 100644 arch/nds32/kernel/vdso/vdso.S
 create mode 100644 arch/nds32/kernel/vdso/vdso.lds.S

diff --git a/arch/nds32/include/asm/vdso.h b/arch/nds32/include/asm/vdso.h
new file mode 100644
index 000000000000..af2c6afc2469
--- /dev/null
+++ b/arch/nds32/include/asm/vdso.h
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ */
+
+#ifndef __ASM_VDSO_H
+#define __ASM_VDSO_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <generated/vdso-offsets.h>
+
+#define VDSO_SYMBOL(base, name)						   \
+({									   \
+	(unsigned long)(vdso_offset_##name + (unsigned long)(base)); \
+})
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_H */
diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
new file mode 100644
index 000000000000..79db5a12ca5e
--- /dev/null
+++ b/arch/nds32/include/asm/vdso_datapage.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 ARM Limited
+// Copyright (C) 2005-2017 Andes Technology Corporation
+#ifndef __ASM_VDSO_DATAPAGE_H
+#define __ASM_VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+struct vdso_data {
+	bool cycle_count_down;	/* timer cyclye counter is decrease with time */
+	u32 cycle_count_offset;	/* offset of timer cycle counter register */
+	u32 seq_count;		/* sequence count - odd during updates */
+	u32 xtime_coarse_sec;	/* coarse time */
+	u32 xtime_coarse_nsec;
+
+	u32 wtm_clock_sec;	/* wall to monotonic offset */
+	u32 wtm_clock_nsec;
+	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
+	u32 cs_mult;		/* clocksource multiplier */
+	u32 cs_shift;		/* Cycle to nanosecond divisor (power of two) */
+
+	u64 cs_cycle_last;	/* last cycle value */
+	u64 cs_mask;		/* clocksource mask */
+
+	u64 xtime_clock_nsec;	/* CLOCK_REALTIME sub-ns base */
+	u32 tz_minuteswest;	/* timezone info for gettimeofday(2) */
+	u32 tz_dsttime;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/nds32/include/asm/vdso_timer_info.h b/arch/nds32/include/asm/vdso_timer_info.h
new file mode 100644
index 000000000000..50ba117cff12
--- /dev/null
+++ b/arch/nds32/include/asm/vdso_timer_info.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+extern struct timer_info_t timer_info;
+#define EMPTY_VALUE ~(0UL)
+#define EMPTY_TIMER_MAPPING EMPTY_VALUE
+#define EMPTY_REG_OFFSET EMPTY_VALUE
+
+struct timer_info_t
+{
+	bool cycle_count_down;
+	unsigned long mapping_base;
+	unsigned long cycle_count_reg_offset;
+};
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
new file mode 100644
index 000000000000..f1198d7a5654
--- /dev/null
+++ b/arch/nds32/kernel/vdso.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 ARM Limited
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/cache.h>
+#include <linux/clocksource.h>
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/timekeeper_internal.h>
+#include <linux/vmalloc.h>
+#include <linux/random.h>
+
+#include <asm/cacheflush.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+#include <asm/vdso_timer_info.h>
+#include <asm/cache_info.h>
+extern struct cache_info L1_cache_info[2];
+extern char vdso_start, vdso_end;
+static unsigned long vdso_pages __ro_after_init;
+static unsigned long timer_mapping_base;
+
+struct timer_info_t timer_info = {
+	.cycle_count_down = true,
+	.mapping_base = EMPTY_TIMER_MAPPING,
+	.cycle_count_reg_offset = EMPTY_REG_OFFSET
+};
+/*
+ * The vDSO data page.
+ */
+static struct page *no_pages[] = { NULL };
+
+static union {
+	struct vdso_data data;
+	u8 page[PAGE_SIZE];
+} vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data = &vdso_data_store.data;
+static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
+	{
+	 .name = "[vvar]",
+	 .pages = no_pages,
+	 },
+	{
+	 .name = "[vdso]",
+	 },
+};
+
+static void get_timer_node_info(void)
+{
+	timer_mapping_base = timer_info.mapping_base;
+	vdso_data->cycle_count_offset =
+		timer_info.cycle_count_reg_offset;
+	vdso_data->cycle_count_down =
+		timer_info.cycle_count_down;
+}
+
+static int __init vdso_init(void)
+{
+	int i;
+	struct page **vdso_pagelist;
+
+	if (memcmp(&vdso_start, "\177ELF", 4)) {
+		pr_err("vDSO is not a valid ELF object!\n");
+		return -EINVAL;
+	}
+	/* Creat a timer io mapping to get clock cycles counter */
+	get_timer_node_info();
+
+	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
+		vdso_pages + 1, vdso_pages, &vdso_start, 1L, vdso_data);
+
+	/* Allocate the vDSO pagelist */
+	vdso_pagelist = kcalloc(vdso_pages, sizeof(struct page *), GFP_KERNEL);
+	if (vdso_pagelist == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < vdso_pages; i++)
+		vdso_pagelist[i] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+	vdso_spec[1].pages = &vdso_pagelist[0];
+
+	return 0;
+}
+
+arch_initcall(vdso_init);
+
+unsigned long inline vdso_random_addr(unsigned long vdso_mapping_len)
+{
+	unsigned long start = current->mm->mmap_base, end, offset, addr;
+	start = PAGE_ALIGN(start);
+
+	/* Round the lowest possible end address up to a PMD boundary. */
+	end = (start + vdso_mapping_len + PMD_SIZE - 1) & PMD_MASK;
+	if (end >= TASK_SIZE)
+		end = TASK_SIZE;
+	end -= vdso_mapping_len;
+
+	if (end > start) {
+		offset = get_random_int() % (((end - start) >> PAGE_SHIFT) + 1);
+		addr = start + (offset << PAGE_SHIFT);
+	} else {
+		addr = start;
+	}
+	return addr;
+}
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	struct vm_area_struct *vma;
+	unsigned long addr = 0;
+	pgprot_t prot;
+	int ret, vvar_page_num = 2;
+
+	vdso_text_len = vdso_pages << PAGE_SHIFT;
+
+	if(timer_mapping_base == EMPTY_VALUE)
+		vvar_page_num = 1;
+	/* Be sure to map the data page */
+	vdso_mapping_len = vdso_text_len + vvar_page_num * PAGE_SIZE;
+#ifdef CONFIG_CPU_CACHE_ALIASING
+	vdso_mapping_len += L1_cache_info[DCACHE].aliasing_num - 1;
+#endif
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	addr = vdso_random_addr(vdso_mapping_len);
+	vdso_base = get_unmapped_area(NULL, addr, vdso_mapping_len, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		ret = vdso_base;
+		goto up_fail;
+	}
+
+#ifdef CONFIG_CPU_CACHE_ALIASING
+	{
+		unsigned int aliasing_mask =
+		    L1_cache_info[DCACHE].aliasing_mask;
+		unsigned int page_colour_ofs;
+		page_colour_ofs = ((unsigned int)vdso_data & aliasing_mask) -
+		    (vdso_base & aliasing_mask);
+		vdso_base += page_colour_ofs & aliasing_mask;
+	}
+#endif
+
+	vma = _install_special_mapping(mm, vdso_base, vvar_page_num * PAGE_SIZE,
+				       VM_READ | VM_MAYREAD, &vdso_spec[0]);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto up_fail;
+	}
+
+	/*Map vdata to user space */
+	ret = io_remap_pfn_range(vma, vdso_base,
+				 virt_to_phys(vdso_data) >> PAGE_SHIFT,
+				 PAGE_SIZE, vma->vm_page_prot);
+	if (ret)
+		goto up_fail;
+
+	/*Map timer to user space */
+	vdso_base += PAGE_SIZE;
+	prot = __pgprot(_PAGE_V | _PAGE_M_UR_KR | _PAGE_D |  _PAGE_C_DEV);
+	ret = io_remap_pfn_range(vma, vdso_base, timer_mapping_base >> PAGE_SHIFT,
+				 PAGE_SIZE, prot);
+	if (ret)
+		goto up_fail;
+
+	/*Map vdso to user space */
+	vdso_base += PAGE_SIZE;
+	mm->context.vdso = (void *)vdso_base;
+	vma = _install_special_mapping(mm, vdso_base, vdso_text_len,
+				       VM_READ | VM_EXEC |
+				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+				       &vdso_spec[1]);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto up_fail;
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+
+up_fail:
+	mm->context.vdso = NULL;
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+static void vdso_write_begin(struct vdso_data *vdata)
+{
+	++vdso_data->seq_count;
+	smp_wmb();		/* Pairs with smp_rmb in vdso_read_retry */
+}
+
+static void vdso_write_end(struct vdso_data *vdata)
+{
+	smp_wmb();		/* Pairs with smp_rmb in vdso_read_begin */
+	++vdso_data->seq_count;
+}
+
+void update_vsyscall(struct timekeeper *tk)
+{
+	vdso_write_begin(vdso_data);
+	vdso_data->cs_mask = tk->tkr_mono.mask;
+	vdso_data->cs_mult = tk->tkr_mono.mult;
+	vdso_data->cs_shift = tk->tkr_mono.shift;
+	vdso_data->cs_cycle_last = tk->tkr_mono.cycle_last;
+	vdso_data->wtm_clock_sec = tk->wall_to_monotonic.tv_sec;
+	vdso_data->wtm_clock_nsec = tk->wall_to_monotonic.tv_nsec;
+	vdso_data->xtime_clock_sec = tk->xtime_sec;
+	vdso_data->xtime_clock_nsec = tk->tkr_mono.xtime_nsec;
+	vdso_data->xtime_coarse_sec = tk->xtime_sec;
+	vdso_data->xtime_coarse_nsec = tk->tkr_mono.xtime_nsec >>
+	    tk->tkr_mono.shift;
+	vdso_write_end(vdso_data);
+}
+
+void update_vsyscall_tz(void)
+{
+	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
+	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
+}
diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Makefile
new file mode 100644
index 000000000000..e6c50a701313
--- /dev/null
+++ b/arch/nds32/kernel/vdso/Makefile
@@ -0,0 +1,82 @@
+#
+# Building a vDSO image for AArch64.
+#
+# Author: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
+# Heavily based on the vDSO Makefiles for other archs.
+#
+
+obj-vdso := note.o datapage.o sigreturn.o gettimeofday.o
+
+# Build rules
+targets := $(obj-vdso) vdso.so vdso.so.dbg
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+
+ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
+		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+ccflags-y += -fPIC -Wl,-shared -g
+
+# Disable gcov profiling for VDSO code
+GCOV_PROFILE := n
+
+
+obj-y += vdso.o
+extra-y += vdso.lds
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+# Force dependency
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
+	$(call if_changed,vdsold)
+
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+define cmd_vdsosym
+	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+endef
+
+include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+
+
+# Assembly rules for the .S files
+
+sigreturn.o : sigreturn.S
+	$(call if_changed_dep,vdsoas)
+
+note.o : note.S
+	$(call if_changed_dep,vdsoas)
+
+datapage.o : datapage.S
+	$(call if_changed_dep,vdsoas)
+
+gettimeofday.o : gettimeofday.c FORCE
+	$(call if_changed_dep,vdsocc)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOL   $@
+      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
+quiet_cmd_vdsoas = VDSOA   $@
+      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
+quiet_cmd_vdsocc = VDSOA   $@
+      cmd_vdsocc = $(CC) $(c_flags) -c -o $@ $<
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/nds32/kernel/vdso/datapage.S b/arch/nds32/kernel/vdso/datapage.S
new file mode 100644
index 000000000000..4a62c3cab1c8
--- /dev/null
+++ b/arch/nds32/kernel/vdso/datapage.S
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/page.h>
+
+ENTRY(__get_timerpage)
+	sethi	$r0, hi20(. + PAGE_SIZE + 8)
+	ori	$r0, $r0, lo12(. + PAGE_SIZE + 4)
+	mfusr	$r1, $pc
+	sub	$r0, $r1, $r0
+	ret
+ENDPROC(__get_timerpage)
+
+ENTRY(__get_datapage)
+	sethi	$r0, hi20(. + 2*PAGE_SIZE + 8)
+	ori	$r0, $r0, lo12(. + 2*PAGE_SIZE + 4)
+	mfusr	$r1, $pc
+	sub	$r0, $r1, $r0
+	ret
+ENDPROC(__get_datapage)
diff --git a/arch/nds32/kernel/vdso/gen_vdso_offsets.sh b/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
new file mode 100755
index 000000000000..01924ff071ad
--- /dev/null
+++ b/arch/nds32/kernel/vdso/gen_vdso_offsets.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+#
+# Match symbols in the DSO that look like VDSO_*; produce a header file
+# of constant offsets into the shared object.
+#
+# Doing this inside the Makefile will break the $(filter-out) function,
+# causing Kbuild to rebuild the vdso-offsets header file every time.
+#
+# Author: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org
+#
+
+LC_ALL=C
+sed -n -e 's/^00*/0/' -e \
+'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define vdso_offset_\2\t0x\1/p'
diff --git a/arch/nds32/kernel/vdso/gettimeofday.c b/arch/nds32/kernel/vdso/gettimeofday.c
new file mode 100644
index 000000000000..038721af40e3
--- /dev/null
+++ b/arch/nds32/kernel/vdso/gettimeofday.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/compiler.h>
+#include <linux/hrtimer.h>
+#include <linux/time.h>
+#include <asm/io.h>
+#include <asm/barrier.h>
+#include <asm/bug.h>
+#include <asm/page.h>
+#include <asm/unistd.h>
+#include <asm/vdso_datapage.h>
+#include <asm/vdso_timer_info.h>
+#include <asm/asm-offsets.h>
+
+#define X(x) #x
+#define Y(x) X(x)
+
+extern struct vdso_data *__get_datapage(void);
+extern struct vdso_data *__get_timerpage(void);
+
+static notrace unsigned int __vdso_read_begin(const struct vdso_data *vdata)
+{
+	u32 seq;
+repeat:
+	seq = READ_ONCE(vdata->seq_count);
+	if (seq & 1) {
+		cpu_relax();
+		goto repeat;
+	}
+	return seq;
+}
+
+static notrace unsigned int vdso_read_begin(const struct vdso_data *vdata)
+{
+	unsigned int seq;
+
+	seq = __vdso_read_begin(vdata);
+
+	smp_rmb();		/* Pairs with smp_wmb in vdso_write_end */
+	return seq;
+}
+
+static notrace int vdso_read_retry(const struct vdso_data *vdata, u32 start)
+{
+	smp_rmb();		/* Pairs with smp_wmb in vdso_write_begin */
+	return vdata->seq_count != start;
+}
+
+static notrace long clock_gettime_fallback(clockid_t _clkid,
+					   struct timespec *_ts)
+{
+	register struct timespec *ts asm("$r1") = _ts;
+	register clockid_t clkid asm("$r0") = _clkid;
+	register long ret asm("$r0");
+
+	asm volatile ("movi	$r15, %3\n"
+		      "syscall 	0x0\n"
+		      :"=r" (ret)
+		      :"r"(clkid), "r"(ts), "i"(__NR_clock_gettime)
+		      :"$r15", "memory");
+
+	return ret;
+}
+
+static notrace int do_realtime_coarse(struct timespec *ts,
+				      struct vdso_data *vdata)
+{
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		ts->tv_sec = vdata->xtime_coarse_sec;
+		ts->tv_nsec = vdata->xtime_coarse_nsec;
+
+	} while (vdso_read_retry(vdata, seq));
+	return 0;
+}
+
+static notrace int do_monotonic_coarse(struct timespec *ts,
+				       struct vdso_data *vdata)
+{
+	struct timespec tomono;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		ts->tv_sec = vdata->xtime_coarse_sec;
+		ts->tv_nsec = vdata->xtime_coarse_nsec;
+
+		tomono.tv_sec = vdata->wtm_clock_sec;
+		tomono.tv_nsec = vdata->wtm_clock_nsec;
+
+	} while (vdso_read_retry(vdata, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	timespec_add_ns(ts, tomono.tv_nsec);
+	return 0;
+}
+
+static notrace inline u64 vgetsns(struct vdso_data *vdso)
+{
+	u32 cycle_now;
+	u32 cycle_delta;
+	u32 *timer_cycle_base;
+
+	timer_cycle_base =
+	    (u32 *) ((char *)__get_timerpage() + vdso->cycle_count_offset);
+	cycle_now = readl_relaxed(timer_cycle_base);
+	if (true == vdso->cycle_count_down)
+		cycle_now = ~(*timer_cycle_base);
+	cycle_delta = cycle_now - (u32) vdso->cs_cycle_last;
+	return ((u64) cycle_delta & vdso->cs_mask) * vdso->cs_mult;
+}
+
+static notrace int do_realtime(struct timespec *ts, struct vdso_data *vdata)
+{
+	unsigned count;
+	u64 ns;
+	do {
+		count = vdso_read_begin(vdata);
+		ts->tv_sec = vdata->xtime_clock_sec;
+		ns = vdata->xtime_clock_nsec;
+		ns += vgetsns(vdata);
+		ns >>= vdata->cs_shift;
+	} while (vdso_read_retry(vdata, count));
+
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
+static notrace int do_monotonic(struct timespec *ts, struct vdso_data *vdata)
+{
+	struct timespec tomono;
+	u64 nsecs;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vdata);
+
+		ts->tv_sec = vdata->xtime_clock_sec;
+		nsecs = vdata->xtime_clock_nsec;
+		nsecs += vgetsns(vdata);
+		nsecs >>= vdata->cs_shift;
+
+		tomono.tv_sec = vdata->wtm_clock_sec;
+		tomono.tv_nsec = vdata->wtm_clock_nsec;
+
+	} while (vdso_read_retry(vdata, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	ts->tv_nsec = 0;
+	timespec_add_ns(ts, nsecs + tomono.tv_nsec);
+	return 0;
+}
+
+notrace int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
+{
+	struct vdso_data *vdata;
+	int ret = -1;
+
+	vdata = __get_datapage();
+	if (vdata->cycle_count_offset == EMPTY_REG_OFFSET)
+		return clock_gettime_fallback(clkid, ts);
+
+	switch (clkid) {
+	case CLOCK_REALTIME_COARSE:
+		ret = do_realtime_coarse(ts, vdata);
+		break;
+	case CLOCK_MONOTONIC_COARSE:
+		ret = do_monotonic_coarse(ts, vdata);
+		break;
+	case CLOCK_REALTIME:
+		ret = do_realtime(ts, vdata);
+		break;
+	case CLOCK_MONOTONIC:
+		ret = do_monotonic(ts, vdata);
+		break;
+	default:
+		break;
+	}
+
+	if (ret)
+		ret = clock_gettime_fallback(clkid, ts);
+
+	return ret;
+}
+
+static notrace int clock_getres_fallback(clockid_t _clk_id,
+					  struct timespec *_res)
+{
+	register clockid_t clk_id asm("$r0") = _clk_id;
+	register struct timespec *res asm("$r1") = _res;
+	register int ret asm("$r0");
+
+	asm volatile ("movi	$r15, %3\n"
+		      "syscall	0x0\n"
+		      :"=r" (ret)
+		      :"r"(clk_id), "r"(res), "i"(__NR_clock_getres)
+		      :"$r15", "memory");
+
+	return ret;
+}
+
+notrace int __vdso_clock_getres(clockid_t clk_id, struct timespec *res)
+{
+	if (res == NULL)
+		return 0;
+	switch (clk_id) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		res->tv_sec = 0;
+		res->tv_nsec = CLOCK_REALTIME_RES;
+		break;
+	case CLOCK_REALTIME_COARSE:
+	case CLOCK_MONOTONIC_COARSE:
+		res->tv_sec = 0;
+		res->tv_nsec = CLOCK_COARSE_RES;
+		break;
+	default:
+		return clock_getres_fallback(clk_id, res);
+	}
+	return 0;
+}
+
+static notrace inline int gettimeofday_fallback(struct timeval *_tv,
+						struct timezone *_tz)
+{
+	register struct timeval *tv asm("$r0") = _tv;
+	register struct timezone *tz asm("$r1") = _tz;
+	register int ret asm("$r0");
+
+	asm volatile ("movi	$r15, %3\n"
+		      "syscall	0x0\n"
+		      :"=r" (ret)
+		      :"r"(tv), "r"(tz), "i"(__NR_gettimeofday)
+		      :"$r15", "memory");
+
+	return ret;
+}
+
+notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+{
+	struct timespec ts;
+	struct vdso_data *vdata;
+	int ret;
+
+	vdata = __get_datapage();
+
+	if (vdata->cycle_count_offset == EMPTY_REG_OFFSET)
+		return gettimeofday_fallback(tv, tz);
+
+	ret = do_realtime(&ts, vdata);
+
+	if (tv) {
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+	if (tz) {
+		tz->tz_minuteswest = vdata->tz_minuteswest;
+		tz->tz_dsttime = vdata->tz_dsttime;
+	}
+
+	return ret;
+}
diff --git a/arch/nds32/kernel/vdso/note.S b/arch/nds32/kernel/vdso/note.S
new file mode 100644
index 000000000000..0aeaa19b05f0
--- /dev/null
+++ b/arch/nds32/kernel/vdso/note.S
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 ARM Limited
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
diff --git a/arch/nds32/kernel/vdso/sigreturn.S b/arch/nds32/kernel/vdso/sigreturn.S
new file mode 100644
index 000000000000..67e4d1d1612a
--- /dev/null
+++ b/arch/nds32/kernel/vdso/sigreturn.S
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 ARM Limited
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+	.text
+
+ENTRY(__kernel_rt_sigreturn)
+	.cfi_startproc
+	movi $r15, __NR_rt_sigreturn
+	/*
+	 * The SWID of syscall should be __NR_rt_sigreturn to synchronize
+	 * the unwinding scheme in gcc
+	 */
+	syscall	__NR_rt_sigreturn
+	.cfi_endproc
+ENDPROC(__kernel_rt_sigreturn)
diff --git a/arch/nds32/kernel/vdso/vdso.S b/arch/nds32/kernel/vdso/vdso.S
new file mode 100644
index 000000000000..16737c11e55b
--- /dev/null
+++ b/arch/nds32/kernel/vdso/vdso.S
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 ARM Limited
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/page.h>
+
+	.globl vdso_start, vdso_end
+	.section .rodata
+	.balign PAGE_SIZE
+vdso_start:
+	.incbin "arch/nds32/kernel/vdso/vdso.so"
+	.balign PAGE_SIZE
+vdso_end:
+
+	.previous
diff --git a/arch/nds32/kernel/vdso/vdso.lds.S b/arch/nds32/kernel/vdso/vdso.lds.S
new file mode 100644
index 000000000000..36630352ee02
--- /dev/null
+++ b/arch/nds32/kernel/vdso/vdso.lds.S
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ */
+
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf32-nds32le-linux", "elf32-nds32be-linux", "elf32-nds32le-linux")
+OUTPUT_ARCH(nds32)
+
+SECTIONS
+{
+	. = SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+
+	.text		: { *(.text*) }			:text
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+	LINUX_4 {
+	global:
+		__kernel_rt_sigreturn;
+		__vdso_gettimeofday;
+		__vdso_clock_getres;
+		__vdso_clock_gettime;
+	local: *;
+	};
+}
+
+/*
+ * Make the rt_sigreturn code visible to the kernel.
+ */
+VDSO_rt_sigtramp	= __kernel_rt_sigreturn;
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
