Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55297 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879Ab2HNRxM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:12 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 18/31] arm64: VDSO support
Date: Tue, 14 Aug 2012 18:52:19 +0100
Message-ID: <1344966752-16102-19-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175219._xa1P9_m3LjJANIy_GcW4pzpIjahLse-yeXybDm4S7I@z>

From: Will Deacon <will.deacon@arm.com>

This patch adds VDSO support for 64-bit applications. The VDSO code is
currently used for sys_rt_sigreturn() and optimised gettimeofday()
(using the user-accessible generic counter).

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/vdso.h              |   41 +++++
 arch/arm64/include/asm/vdso_datapage.h     |   43 +++++
 arch/arm64/kernel/vdso.c                   |  261 ++++++++++++++++++++++++=
++++
 arch/arm64/kernel/vdso/.gitignore          |    2 +
 arch/arm64/kernel/vdso/Makefile            |   63 +++++++
 arch/arm64/kernel/vdso/gen_vdso_offsets.sh |   15 ++
 arch/arm64/kernel/vdso/gettimeofday.S      |  242 ++++++++++++++++++++++++=
++
 arch/arm64/kernel/vdso/note.S              |   28 +++
 arch/arm64/kernel/vdso/sigreturn.S         |   37 ++++
 arch/arm64/kernel/vdso/vdso.S              |   33 ++++
 arch/arm64/kernel/vdso/vdso.lds.S          |  100 +++++++++++
 11 files changed, 865 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso.h
 create mode 100644 arch/arm64/include/asm/vdso_datapage.h
 create mode 100644 arch/arm64/kernel/vdso.c
 create mode 100644 arch/arm64/kernel/vdso/.gitignore
 create mode 100644 arch/arm64/kernel/vdso/Makefile
 create mode 100755 arch/arm64/kernel/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/note.S
 create mode 100644 arch/arm64/kernel/vdso/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso/vdso.S
 create mode 100644 arch/arm64/kernel/vdso/vdso.lds.S

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
new file mode 100644
index 0000000..839ce00
--- /dev/null
+++ b/arch/arm64/include/asm/vdso.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_VDSO_H
+#define __ASM_VDSO_H
+
+#ifdef __KERNEL__
+
+/*
+ * Default link address for the vDSO.
+ * Since we randomise the VDSO mapping, there's little point in trying
+ * to prelink this.
+ */
+#define VDSO_LBASE=090x0
+
+#ifndef __ASSEMBLY__
+
+#include <generated/vdso-offsets.h>
+
+#define VDSO_SYMBOL(base, name)=09=09=09=09=09=09   \
+({=09=09=09=09=09=09=09=09=09   \
+=09(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
+})
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_H */
diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/as=
m/vdso_datapage.h
new file mode 100644
index 0000000..de66199
--- /dev/null
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_VDSO_DATAPAGE_H
+#define __ASM_VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+struct vdso_data {
+=09__u64 cs_cycle_last;=09/* Timebase at clocksource init */
+=09__u64 xtime_clock_sec;=09/* Kernel time */
+=09__u64 xtime_clock_nsec;
+=09__u64 xtime_coarse_sec;=09/* Coarse time */
+=09__u64 xtime_coarse_nsec;
+=09__u64 wtm_clock_sec;=09/* Wall to monotonic time */
+=09__u64 wtm_clock_nsec;
+=09__u32 tb_seq_count;=09/* Timebase sequence counter */
+=09__u32 cs_mult;=09=09/* Clocksource multiplier */
+=09__u32 cs_shift;=09=09/* Clocksource shift */
+=09__u32 tz_minuteswest;=09/* Whacky timezone stuff */
+=09__u32 tz_dsttime;
+=09__u32 use_syscall;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
new file mode 100644
index 0000000..8d8a365
--- /dev/null
+++ b/arch/arm64/kernel/vdso.c
@@ -0,0 +1,261 @@
+/*
+ * VDSO implementation for AArch64 and vector page setup for AArch32.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include <asm/cacheflush.h>
+#include <asm/signal32.h>
+#include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
+
+extern char vdso_start, vdso_end;
+static unsigned long vdso_pages;
+static struct page **vdso_pagelist;
+
+/*
+ * The vDSO data page.
+ */
+static union {
+=09struct vdso_data=09data;
+=09u8=09=09=09page[PAGE_SIZE];
+} vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data =3D &vdso_data_store.data;
+
+#ifdef CONFIG_AARCH32_EMULATION
+/*
+ * Create and map the vectors page for AArch32 tasks.
+ */
+static struct page *vectors_page[1];
+
+static int alloc_vectors_page(void)
+{
+=09extern char __kuser_helper_start[], __kuser_helper_end[];
+=09int kuser_sz =3D __kuser_helper_end - __kuser_helper_start;
+=09unsigned long vpage;
+
+=09vpage =3D get_zeroed_page(GFP_ATOMIC);
+
+=09if (!vpage)
+=09=09return -ENOMEM;
+
+=09/* kuser helpers */
+=09memcpy((void *)vpage + 0x1000 - kuser_sz, __kuser_helper_start,
+=09=09kuser_sz);
+
+=09/* sigreturn code */
+=09memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
+=09=09aarch32_sigret_code, sizeof(aarch32_sigret_code));
+
+=09flush_icache_range(vpage, vpage + PAGE_SIZE);
+=09vectors_page[0] =3D virt_to_page(vpage);
+
+=09return 0;
+}
+arch_initcall(alloc_vectors_page);
+
+int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+{
+=09struct mm_struct *mm =3D current->mm;
+=09unsigned long addr =3D AARCH32_VECTORS_BASE;
+=09int ret;
+
+=09down_write(&mm->mmap_sem);
+=09current->mm->context.vdso =3D (void *)addr;
+
+=09/* Map vectors page at the high address. */
+=09ret =3D install_special_mapping(mm, addr, PAGE_SIZE,
+=09=09=09=09      VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
+=09=09=09=09      vectors_page);
+
+=09up_write(&mm->mmap_sem);
+
+=09return ret;
+}
+#endif /* CONFIG_AARCH32_EMULATION */
+
+static int __init vdso_init(void)
+{
+=09struct page *pg;
+=09char *vbase;
+=09int i, ret =3D 0;
+
+=09vdso_pages =3D (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+=09pr_info("vdso: %ld pages (%ld code, %ld data) at base %p\n",
+=09=09vdso_pages + 1, vdso_pages, 1L, &vdso_start);
+
+=09/* Allocate the vDSO pagelist, plus a page for the data. */
+=09vdso_pagelist =3D kzalloc(sizeof(struct page *) * (vdso_pages + 1),
+=09=09=09=09GFP_KERNEL);
+=09if (vdso_pagelist =3D=3D NULL) {
+=09=09pr_err("Failed to allocate vDSO pagelist!\n");
+=09=09return -ENOMEM;
+=09}
+
+=09/* Grab the vDSO code pages. */
+=09for (i =3D 0; i < vdso_pages; i++) {
+=09=09pg =3D virt_to_page(&vdso_start + i*PAGE_SIZE);
+=09=09ClearPageReserved(pg);
+=09=09get_page(pg);
+=09=09vdso_pagelist[i] =3D pg;
+=09}
+
+=09/* Sanity check the shared object header. */
+=09vbase =3D vmap(vdso_pagelist, 1, 0, PAGE_KERNEL);
+=09if (vbase =3D=3D NULL) {
+=09=09pr_err("Failed to map vDSO pagelist!\n");
+=09=09return -ENOMEM;
+=09} else if (memcmp(vbase, "\177ELF", 4)) {
+=09=09pr_err("vDSO is not a valid ELF object!\n");
+=09=09ret =3D -EINVAL;
+=09=09goto unmap;
+=09}
+
+=09/* Grab the vDSO data page. */
+=09pg =3D virt_to_page(vdso_data);
+=09get_page(pg);
+=09vdso_pagelist[i] =3D pg;
+
+unmap:
+=09vunmap(vbase);
+=09return ret;
+}
+arch_initcall(vdso_init);
+
+int arch_setup_additional_pages(struct linux_binprm *bprm,
+=09=09=09=09int uses_interp)
+{
+=09struct mm_struct *mm =3D current->mm;
+=09unsigned long vdso_base, vdso_mapping_len;
+=09int ret;
+
+=09/* Be sure to map the data page */
+=09vdso_mapping_len =3D (vdso_pages + 1) << PAGE_SHIFT;
+
+=09down_write(&mm->mmap_sem);
+=09vdso_base =3D get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+=09if (IS_ERR_VALUE(vdso_base)) {
+=09=09ret =3D vdso_base;
+=09=09goto up_fail;
+=09}
+=09mm->context.vdso =3D (void *)vdso_base;
+
+=09ret =3D install_special_mapping(mm, vdso_base, vdso_mapping_len,
+=09=09=09=09      VM_READ|VM_EXEC|
+=09=09=09=09      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+=09=09=09=09      vdso_pagelist);
+=09if (ret) {
+=09=09mm->context.vdso =3D NULL;
+=09=09goto up_fail;
+=09}
+
+up_fail:
+=09up_write(&mm->mmap_sem);
+
+=09return ret;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+=09/*
+=09 * We can re-use the vdso pointer in mm_context_t for identifying
+=09 * the vectors page for compat applications. The vDSO will always
+=09 * sit above TASK_UNMAPPED_BASE and so we don't need to worry about
+=09 * it conflicting with the vectors base.
+=09 */
+=09if (vma->vm_mm && vma->vm_start =3D=3D (long)vma->vm_mm->context.vdso) =
{
+#ifdef CONFIG_AARCH32_EMULATION
+=09=09if (vma->vm_start =3D=3D AARCH32_VECTORS_BASE)
+=09=09=09return "[vectors]";
+#endif
+=09=09return "[vdso]";
+=09}
+
+=09return NULL;
+}
+
+/*
+ * We define AT_SYSINFO_EHDR, so we need these function stubs to keep
+ * Linux happy.
+ */
+int in_gate_area_no_mm(unsigned long addr)
+{
+=09return 0;
+}
+
+int in_gate_area(struct mm_struct *mm, unsigned long addr)
+{
+=09return 0;
+}
+
+struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
+{
+=09return NULL;
+}
+
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+void update_vsyscall(struct timespec *ts, struct timespec *wtm,
+=09=09     struct clocksource *clock, u32 mult)
+{
+=09struct timespec xtime_coarse;
+=09u32 use_syscall =3D strcmp(clock->name, "arch_sys_counter");
+
+=09++vdso_data->tb_seq_count;
+=09smp_wmb();
+
+=09xtime_coarse =3D __current_kernel_time();
+=09vdso_data->use_syscall=09=09=09=3D use_syscall;
+=09vdso_data->xtime_coarse_sec=09=09=3D xtime_coarse.tv_sec;
+=09vdso_data->xtime_coarse_nsec=09=09=3D xtime_coarse.tv_nsec;
+
+=09if (!use_syscall) {
+=09=09vdso_data->cs_cycle_last=09=3D clock->cycle_last;
+=09=09vdso_data->xtime_clock_sec=09=3D ts->tv_sec;
+=09=09vdso_data->xtime_clock_nsec=09=3D ts->tv_nsec;
+=09=09vdso_data->cs_mult=09=09=3D mult;
+=09=09vdso_data->cs_shift=09=09=3D clock->shift;
+=09=09vdso_data->wtm_clock_sec=09=3D wtm->tv_sec;
+=09=09vdso_data->wtm_clock_nsec=09=3D wtm->tv_nsec;
+=09}
+
+=09smp_wmb();
+=09++vdso_data->tb_seq_count;
+}
+
+void update_vsyscall_tz(void)
+{
+=09++vdso_data->tb_seq_count;
+=09smp_wmb();
+=09vdso_data->tz_minuteswest=09=3D sys_tz.tz_minuteswest;
+=09vdso_data->tz_dsttime=09=09=3D sys_tz.tz_dsttime;
+=09smp_wmb();
+=09++vdso_data->tb_seq_count;
+}
diff --git a/arch/arm64/kernel/vdso/.gitignore b/arch/arm64/kernel/vdso/.gi=
tignore
new file mode 100644
index 0000000..b8cc94e
--- /dev/null
+++ b/arch/arm64/kernel/vdso/.gitignore
@@ -0,0 +1,2 @@
+vdso.lds
+vdso-offsets.h
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makef=
ile
new file mode 100644
index 0000000..d8064af
--- /dev/null
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -0,0 +1,63 @@
+#
+# Building a vDSO image for AArch64.
+#
+# Author: Will Deacon <will.deacon@arm.com>
+# Heavily based on the vDSO Makefiles for other archs.
+#
+
+obj-vdso :=3D gettimeofday.o note.o sigreturn.o
+
+# Build rules
+targets :=3D $(obj-vdso) vdso.so vdso.so.dbg
+obj-vdso :=3D $(addprefix $(obj)/, $(obj-vdso))
+
+ccflags-y :=3D -shared -fno-common -fno-builtin
+ccflags-y +=3D -nostdlib -Wl,-soname=3Dlinux-vdso.so.1 \
+=09=09$(call cc-ldoption, -Wl$(comma)--hash-style=3Dsysv)
+
+obj-y +=3D vdso.o
+extra-y +=3D vdso.lds vdso-offsets.h
+CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
+
+# Force dependency (incbin is bad)
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
+=09$(call if_changed,vdsold)
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS :=3D -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+=09$(call if_changed,objcopy)
+
+# Generate VDSO offsets using helper script
+gen-vdsosym :=3D $(srctree)/$(src)/gen_vdso_offsets.sh
+quiet_cmd_vdsosym =3D VDSOSYM $@
+define cmd_vdsosym
+=09$(NM) $< | $(gen-vdsosym) | LC_ALL=3DC sort > $@ && \
+=09cp $@ include/generated/
+endef
+
+$(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+=09$(call if_changed,vdsosym)
+
+# Assembly rules for the .S files
+$(obj-vdso): %.o: %.S
+=09$(call if_changed_dep,vdsoas)
+
+# Actual build commands
+quiet_cmd_vdsold =3D VDSOL $@
+      cmd_vdsold =3D $(CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdsoas =3D VDSOA $@
+      cmd_vdsoas =3D $(CC) $(a_flags) -c -o $@ $<
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install =3D INSTALL $@
+      cmd_vdso_install =3D cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso.so: $(obj)/vdso.so.dbg
+=09@mkdir -p $(MODLIB)/vdso
+=09$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/arm64/kernel/vdso/gen_vdso_offsets.sh b/arch/arm64/kernel=
/vdso/gen_vdso_offsets.sh
new file mode 100755
index 0000000..01924ff
--- /dev/null
+++ b/arch/arm64/kernel/vdso/gen_vdso_offsets.sh
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
+# Author: Will Deacon <will.deacon@arm.com
+#
+
+LC_ALL=3DC
+sed -n -e 's/^00*/0/' -e \
+'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define vdso_offset_\2\t0x=
\1/p'
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso=
/gettimeofday.S
new file mode 100644
index 0000000..dcb8c20
--- /dev/null
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -0,0 +1,242 @@
+/*
+ * Userspace implementations of gettimeofday() and friends.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+#define NSEC_PER_SEC_LO16=090xca00
+#define NSEC_PER_SEC_HI16=090x3b9a
+
+vdso_data=09.req=09x6
+use_syscall=09.req=09w7
+seqcnt=09=09.req=09w8
+
+=09.macro=09seqcnt_acquire
+9999:=09ldr=09seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
+=09tbnz=09seqcnt, #0, 9999b
+=09dmb=09ishld
+=09ldr=09use_syscall, [vdso_data, #VDSO_USE_SYSCALL]
+=09.endm
+
+=09.macro=09seqcnt_read, cnt
+=09dmb=09ishld
+=09ldr=09\cnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
+=09.endm
+
+=09.macro=09seqcnt_check, cnt, fail
+=09cmp=09\cnt, seqcnt
+=09b.ne=09\fail
+=09.endm
+
+=09.text
+
+/* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
+ENTRY(__kernel_gettimeofday)
+=09.cfi_startproc
+=09mov=09x2, x30
+=09.cfi_register x30, x2
+
+=09/* Acquire the sequence counter and get the timespec. */
+=09adr=09vdso_data, _vdso_data
+1:=09seqcnt_acquire
+=09cbnz=09use_syscall, 4f
+
+=09/* If tv is NULL, skip to the timezone code. */
+=09cbz=09x0, 2f
+=09bl=09__do_get_tspec
+=09seqcnt_check w13, 1b
+
+=09/* Convert ns to us. */
+=09mov=09x11, #1000
+=09udiv=09x10, x10, x11
+=09stp=09x9, x10, [x0, #TVAL_TV_SEC]
+2:
+=09/* If tz is NULL, return 0. */
+=09cbz=09x1, 3f
+=09ldp=09w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
+=09seqcnt_read w13
+=09seqcnt_check w13, 1b
+=09stp=09w4, w5, [x1, #TZ_MINWEST]
+3:
+=09mov=09x0, xzr
+=09ret=09x2
+4:
+=09/* Syscall fallback. */
+=09mov=09x8, #__NR_gettimeofday
+=09svc=09#0
+=09ret=09x2
+=09.cfi_endproc
+ENDPROC(__kernel_gettimeofday)
+
+/* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
+ENTRY(__kernel_clock_gettime)
+=09.cfi_startproc
+=09cmp=09w0, #CLOCK_REALTIME
+=09ccmp=09w0, #CLOCK_MONOTONIC, #0x4, ne
+=09b.ne=092f
+
+=09mov=09x2, x30
+=09.cfi_register x30, x2
+
+=09/* Get kernel timespec. */
+=09adr=09vdso_data, _vdso_data
+1:=09seqcnt_acquire
+=09cbnz=09use_syscall, 7f
+
+=09bl=09__do_get_tspec
+=09seqcnt_check w13, 1b
+
+=09cmp=09w0, #CLOCK_MONOTONIC
+=09b.ne=096f
+
+=09/* Get wtm timespec. */
+=09ldp=09x14, x15, [vdso_data, #VDSO_WTM_CLK_SEC]
+
+=09/* Check the sequence counter. */
+=09seqcnt_read w13
+=09seqcnt_check w13, 1b
+=09b=094f
+2:
+=09cmp=09w0, #CLOCK_REALTIME_COARSE
+=09ccmp=09w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
+=09b.ne=098f
+
+=09/* Get coarse timespec. */
+=09adr=09vdso_data, _vdso_data
+3:=09seqcnt_acquire
+=09ldp=09x9, x10, [vdso_data, #VDSO_XTIME_CRS_SEC]
+
+=09cmp=09w0, #CLOCK_MONOTONIC_COARSE
+=09b.ne=096f
+
+=09/* Get wtm timespec. */
+=09ldp=09x14, x15, [vdso_data, #VDSO_WTM_CLK_SEC]
+
+=09/* Check the sequence counter. */
+=09seqcnt_read w13
+=09seqcnt_check w13, 3b
+4:
+=09/* Add on wtm timespec. */
+=09add=09x9, x9, x14
+=09add=09x10, x10, x15
+
+=09/* Normalise the new timespec. */
+=09mov=09x14, #NSEC_PER_SEC_LO16
+=09movk=09x14, #NSEC_PER_SEC_HI16, lsl #16
+=09cmp=09x10, x14
+=09b.lt=095f
+=09sub=09x10, x10, x14
+=09add=09x9, x9, #1
+5:
+=09cmp=09x10, #0
+=09b.ge=096f
+=09add=09x10, x10, x14
+=09sub=09x9, x9, #1
+
+6:=09/* Store to the user timespec. */
+=09stp=09x9, x10, [x1, #TSPEC_TV_SEC]
+=09mov=09x0, xzr
+=09ret=09x2
+7:
+=09mov=09x30, x2
+8:=09/* Syscall fallback. */
+=09mov=09x8, #__NR_clock_gettime
+=09svc=09#0
+=09ret
+=09.cfi_endproc
+ENDPROC(__kernel_clock_gettime)
+
+/* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
+ENTRY(__kernel_clock_getres)
+=09.cfi_startproc
+=09cbz=09w1, 3f
+
+=09cmp=09w0, #CLOCK_REALTIME
+=09ccmp=09w0, #CLOCK_MONOTONIC, #0x4, ne
+=09b.ne=091f
+
+=09ldr=09x2, 5f
+=09b=092f
+1:
+=09cmp=09w0, #CLOCK_REALTIME_COARSE
+=09ccmp=09w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
+=09b.ne=094f
+=09ldr=09x2, 6f
+2:
+=09stp=09xzr, x2, [x1]
+
+3:=09/* res =3D=3D NULL. */
+=09mov=09w0, wzr
+=09ret
+
+4:=09/* Syscall fallback. */
+=09mov=09x8, #__NR_clock_getres
+=09svc=09#0
+=09ret
+5:
+=09.quad=09CLOCK_REALTIME_RES
+6:
+=09.quad=09CLOCK_COARSE_RES
+=09.cfi_endproc
+ENDPROC(__kernel_clock_getres)
+
+/*
+ * Read the current time from the architected counter.
+ * Expects vdso_data to be initialised.
+ * Clobbers the temporary registers (x9 - x15).
+ * Returns:
+ *  - (x9, x10) =3D (ts->tv_sec, ts->tv_nsec)
+ *  - (x11, x12) =3D (xtime->tv_sec, xtime->tv_nsec)
+ *  - w13 =3D vDSO sequence counter
+ */
+ENTRY(__do_get_tspec)
+=09.cfi_startproc
+
+=09/* Read from the vDSO data page. */
+=09ldr=09x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
+=09ldp=09x11, x12, [vdso_data, #VDSO_XTIME_CLK_SEC]
+=09ldp=09w14, w15, [vdso_data, #VDSO_CS_MULT]
+=09seqcnt_read w13
+
+=09/* Read the physical counter. */
+=09isb
+=09mrs=09x9, cntpct_el0
+
+=09/* Calculate cycle delta and convert to ns. */
+=09sub=09x10, x9, x10
+=09/* We can only guarantee 56 bits of precision. */
+=09movn=09x9, #0xff0, lsl #48
+=09and=09x10, x9, x10
+=09mul=09x10, x10, x14
+=09lsr=09x10, x10, x15
+
+=09/* Use the kernel time to calculate the new timespec. */
+=09add=09x10, x12, x10
+=09mov=09x14, #NSEC_PER_SEC_LO16
+=09movk=09x14, #NSEC_PER_SEC_HI16, lsl #16
+=09udiv=09x15, x10, x14
+=09add=09x9, x15, x11
+=09mul=09x14, x14, x15
+=09sub=09x10, x10, x14
+
+=09ret
+=09.cfi_endproc
+ENDPROC(__do_get_tspec)
diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
new file mode 100644
index 0000000..b82c85e
--- /dev/null
+++ b/arch/arm64/kernel/vdso/note.S
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ *
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO t=
ext.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+
+ELFNOTE_START(Linux, 0, "a")
+=09.long LINUX_VERSION_CODE
+ELFNOTE_END
diff --git a/arch/arm64/kernel/vdso/sigreturn.S b/arch/arm64/kernel/vdso/si=
greturn.S
new file mode 100644
index 0000000..20d98ef
--- /dev/null
+++ b/arch/arm64/kernel/vdso/sigreturn.S
@@ -0,0 +1,37 @@
+/*
+ * Sigreturn trampoline for returning from a signal when the SA_RESTORER
+ * flag is not set.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+=09.text
+
+=09nop
+ENTRY(__kernel_rt_sigreturn)
+=09.cfi_startproc
+=09.cfi_signal_frame
+=09.cfi_def_cfa=09x29, 0
+=09.cfi_offset=09x29, 0 * 8
+=09.cfi_offset=09x30, 1 * 8
+=09mov=09x8, #__NR_rt_sigreturn
+=09svc=09#0
+=09.cfi_endproc
+ENDPROC(__kernel_rt_sigreturn)
diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso/vdso.S
new file mode 100644
index 0000000..60c1db5
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vdso.S
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/page.h>
+
+=09__PAGE_ALIGNED_DATA
+
+=09.globl vdso_start, vdso_end
+=09.balign PAGE_SIZE
+vdso_start:
+=09.incbin "arch/arm64/kernel/vdso/vdso.so"
+=09.balign PAGE_SIZE
+vdso_end:
+
+=09.previous
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vds=
o.lds.S
new file mode 100644
index 0000000..8154b8d
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -0,0 +1,100 @@
+/*
+ * GNU linker script for the VDSO library.
+*
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Heavily based on the vDSO linker scripts for other archs.
+ */
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf64-littleaarch64", "elf64-bigaarch64", "elf64-littleaarc=
h64")
+OUTPUT_ARCH(aarch64)
+
+SECTIONS
+{
+=09. =3D VDSO_LBASE + SIZEOF_HEADERS;
+
+=09.hash=09=09: { *(.hash) }=09=09=09:text
+=09.gnu.hash=09: { *(.gnu.hash) }
+=09.dynsym=09=09: { *(.dynsym) }
+=09.dynstr=09=09: { *(.dynstr) }
+=09.gnu.version=09: { *(.gnu.version) }
+=09.gnu.version_d=09: { *(.gnu.version_d) }
+=09.gnu.version_r=09: { *(.gnu.version_r) }
+
+=09.note=09=09: { *(.note.*) }=09=09:text=09:note
+
+=09. =3D ALIGN(16);
+
+=09.text=09=09: { *(.text*) }=09=09=09:text=09=3D0xd503201f
+=09PROVIDE (__etext =3D .);
+=09PROVIDE (_etext =3D .);
+=09PROVIDE (etext =3D .);
+
+=09.eh_frame_hdr=09: { *(.eh_frame_hdr) }=09=09:text=09:eh_frame_hdr
+=09.eh_frame=09: { KEEP (*(.eh_frame)) }=09:text
+
+=09.dynamic=09: { *(.dynamic) }=09=09:text=09:dynamic
+
+=09.rodata=09=09: { *(.rodata*) }=09=09:text
+
+=09_end =3D .;
+=09PROVIDE(end =3D .);
+
+=09. =3D ALIGN(PAGE_SIZE);
+=09PROVIDE(_vdso_data =3D .);
+
+=09/DISCARD/=09: {
+=09=09*(.note.GNU-stack)
+=09=09*(.data .data.* .gnu.linkonce.d.* .sdata*)
+=09=09*(.bss .sbss .dynbss .dynsbss)
+=09}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-onl=
y.
+ */
+PHDRS
+{
+=09text=09=09PT_LOAD=09=09FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+=09dynamic=09=09PT_DYNAMIC=09FLAGS(4);=09=09/* PF_R */
+=09note=09=09PT_NOTE=09=09FLAGS(4);=09=09/* PF_R */
+=09eh_frame_hdr=09PT_GNU_EH_FRAME;
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+=09LINUX_2.6.39 {
+=09global:
+=09=09__kernel_rt_sigreturn;
+=09=09__kernel_gettimeofday;
+=09=09__kernel_clock_gettime;
+=09=09__kernel_clock_getres;
+=09local: *;
+=09};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_sigtramp=09=09=3D __kernel_rt_sigreturn;

