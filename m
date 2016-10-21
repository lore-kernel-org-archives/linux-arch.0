From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 17/18] arm64:ilp32: add vdso-ilp32 and use for signal return
Date: Fri, 21 Oct 2016 23:33:16 +0300
Message-ID: <1477081997-4770-18-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, ynorov@caviumnetworks.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

ILP32 VDSO exports next symbols:
 __kernel_rt_sigreturn;
 __kernel_gettimeofday;
 __kernel_clock_gettime;
 __kernel_clock_getres.

What shared object to use, kernel selects depending on result of
is_ilp32_compat_task() in arch/arm64/kernel/vdso.c, so it substitutes
correct pages and spec.

Adjusted to move the move data page before code pages in sync with
commit 601255ae3c98 ("arm64: vdso: move data page before code pages")

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
---
 arch/arm64/include/asm/vdso.h                 |  6 ++
 arch/arm64/kernel/Makefile                    | 11 ++++
 arch/arm64/kernel/asm-offsets.c               |  7 ++
 arch/arm64/kernel/signal.c                    |  2 +
 arch/arm64/kernel/vdso-ilp32/.gitignore       |  2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         | 74 +++++++++++++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     | 33 ++++++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S | 95 +++++++++++++++++++++++++++
 arch/arm64/kernel/vdso.c                      | 66 ++++++++++++++++---
 arch/arm64/kernel/vdso/gettimeofday.S         | 20 +++++-
 arch/arm64/kernel/vdso/vdso.S                 |  6 +-
 11 files changed, 306 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce00..649a9a4 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -29,6 +29,12 @@
 
 #include <generated/vdso-offsets.h>
 
+#ifdef CONFIG_ARM64_ILP32
+#include <generated/vdso-ilp32-offsets.h>
+#else
+#define vdso_offset_sigtramp_ilp32
+#endif
+
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
 	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index af400fb..43e680a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -55,6 +55,17 @@ arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_ARM64_ILP32)		+= vdso-ilp32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
+
+# vDSO - this must be built first to generate the symbol offsets
+$(call objectify,$(arm64-obj-y)): $(obj)/vdso/vdso-offsets.h
+$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
+
+ifeq ($(CONFIG_ARM64_ILP32),y)
+# vDSO - this must be built first to generate the symbol offsets
+$(call objectify,$(arm64-obj-y)): $(obj)/vdso-ilp32/vdso-ilp32-offsets.h
+$(obj)/vdso-ilp32/vdso-ilp32-offsets.h: $(obj)/vdso-ilp32
+endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index d8d7086..8f844b9 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -119,6 +119,13 @@ int main(void)
   DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
   DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_TVAL_TV_SEC,	offsetof(struct compat_timeval, tv_sec));
+  DEFINE(COMPAT_TVAL_TV_USEC,	offsetof(struct compat_timeval, tv_usec));
+  DEFINE(COMPAT_TSPEC_TV_SEC,	offsetof(struct compat_timespec, tv_sec));
+  DEFINE(COMPAT_TSPEC_TV_NSEC,	offsetof(struct compat_timespec, tv_nsec));
+  BLANK();
+#endif
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
   BLANK();
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 1b130f4..72f68f0 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -267,6 +267,8 @@ void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
+	else if (is_ilp32_compat_task())
+		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp_ilp32);
 	else
 		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
 
diff --git a/arch/arm64/kernel/vdso-ilp32/.gitignore b/arch/arm64/kernel/vdso-ilp32/.gitignore
new file mode 100644
index 0000000..61806c3
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/.gitignore
@@ -0,0 +1,2 @@
+vdso-ilp32.lds
+vdso-ilp32-offsets.h
diff --git a/arch/arm64/kernel/vdso-ilp32/Makefile b/arch/arm64/kernel/vdso-ilp32/Makefile
new file mode 100644
index 0000000..0671e88
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/Makefile
@@ -0,0 +1,74 @@
+#
+# Building a vDSO image for AArch64.
+#
+# Author: Will Deacon <will.deacon@arm.com>
+# Heavily based on the vDSO Makefiles for other archs.
+#
+
+obj-ilp32-vdso := gettimeofday-ilp32.o note-ilp32.o sigreturn-ilp32.o
+
+# Build rules
+targets := $(obj-ilp32-vdso) vdso-ilp32.so vdso-ilp32.so.dbg
+obj-ilp32-vdso := $(addprefix $(obj)/, $(obj-ilp32-vdso))
+
+ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y += -nostdlib -Wl,-soname=linux-ilp32-vdso.so.1 \
+		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+
+obj-y += vdso-ilp32.o
+extra-y += vdso-ilp32.lds vdso-ilp32-offsets.h
+CPPFLAGS_vdso-ilp32.lds += -P -C -U$(ARCH) -mabi=ilp32
+
+# Force dependency (incbin is bad)
+$(obj)/vdso-ilp32.o : $(obj)/vdso-ilp32.so
+
+# Link rule for the .so file, .lds has to be first
+$(obj)/vdso-ilp32.so.dbg: $(src)/vdso-ilp32.lds $(obj-ilp32-vdso)
+	$(call if_changed,vdso-ilp32ld)
+
+# Strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(srctree)/$(src)/../vdso/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+define cmd_vdsosym
+	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@ && \
+	cp $@ include/generated/
+endef
+
+$(obj)/vdso-ilp32-offsets.h: $(obj)/vdso-ilp32.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+# Assembly rules for the .S files
+#$(obj-ilp32-vdso): %.o: $(src)/../vdso/$(subst -ilp32,,%.S)
+#	$(call if_changed_dep,vdso-ilp32as)
+
+$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
+	$(call if_changed_dep,vdso-ilp32as)
+
+$(obj)/note-ilp32.o: $(src)/../vdso/note.S
+	$(call if_changed_dep,vdso-ilp32as)
+
+# This one should be fine because ILP32 uses the same generic
+# __NR_rt_sigreturn syscall number.
+$(obj)/sigreturn-ilp32.o: $(src)/../vdso/sigreturn.S
+	$(call if_changed_dep,vdso-ilp32as)
+
+# Actual build commands
+quiet_cmd_vdso-ilp32ld = VDSOILP32L $@
+      cmd_vdso-ilp32ld = $(CC) $(c_flags) -mabi=ilp32  -Wl,-n -Wl,-T $^ -o $@
+quiet_cmd_vdso-ilp32as = VDSOILP32A $@
+      cmd_vdso-ilp32as = $(CC) $(a_flags) -mabi=ilp32 -c -o $@ $<
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso-ilp32.so: $(obj)/vdso-ilp32.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso-ilp32.so
diff --git a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
new file mode 100644
index 0000000..46ac072
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
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
+	__PAGE_ALIGNED_DATA
+
+	.globl vdso_ilp32_start, vdso_ilp32_end
+	.balign PAGE_SIZE
+vdso_ilp32_start:
+	.incbin "arch/arm64/kernel/vdso-ilp32/vdso-ilp32.so"
+	.balign PAGE_SIZE
+vdso_ilp32_end:
+
+	.previous
diff --git a/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
new file mode 100644
index 0000000..3b564ca
--- /dev/null
+++ b/arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
@@ -0,0 +1,95 @@
+/*
+ * GNU linker script for the VDSO library.
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
+ * Heavily based on the vDSO linker scripts for other archs.
+ */
+
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+SECTIONS
+{
+	PROVIDE(_vdso_data = . - PAGE_SIZE);
+	. = VDSO_LBASE + SIZEOF_HEADERS;
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
+	. = ALIGN(16);
+
+	.text		: { *(.text*) }			:text	=0xd503201f
+	PROVIDE (__etext = .);
+	PROVIDE (_etext = .);
+	PROVIDE (etext = .);
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	_end = .;
+	PROVIDE(end = .);
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
+	LINUX_4.9 {
+	global:
+		__kernel_rt_sigreturn;
+		__kernel_gettimeofday;
+		__kernel_clock_gettime;
+		__kernel_clock_getres;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_sigtramp_ilp32		= __kernel_rt_sigreturn;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 7f822cd..3f884e1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -37,8 +37,13 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start, vdso_end;
-static unsigned long vdso_pages __ro_after_init;
+extern char vdso_lp64_start, vdso_lp64_end;
+static unsigned long vdso_lp64_pages __ro_after_init;
+
+#ifdef CONFIG_ARM64_ILP32
+extern char vdso_ilp32_start, vdso_ilp32_end;
+static unsigned long vdso_ilp32_pages __ro_after_init;
+#endif
 
 /*
  * The vDSO data page.
@@ -110,7 +115,17 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_AARCH32_EL0 */
 
-static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
+static struct vm_special_mapping vdso_lp64_spec[2] __ro_after_init = {
+	{
+		.name	= "[vvar]",
+	},
+	{
+		.name	= "[vdso]",
+	},
+};
+
+#ifdef CONFIG_ARM64_ILP32
+static struct vm_special_mapping vdso_ilp32_spec[2] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 	},
@@ -118,20 +133,26 @@ static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
 		.name	= "[vdso]",
 	},
 };
+#endif
 
-static int __init vdso_init(void)
+static int __init vdso_init(char *vdso_start, char *vdso_end,
+					  unsigned long *vdso_pagesp,
+					  struct vm_special_mapping *vdso_spec)
 {
 	int i;
+	unsigned long vdso_pages;
 	struct page **vdso_pagelist;
 
-	if (memcmp(&vdso_start, "\177ELF", 4)) {
+	if (memcmp(vdso_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
 		return -EINVAL;
 	}
 
-	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
+	*vdso_pagesp = vdso_pages;
 	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, &vdso_start, 1L, vdso_data);
+					vdso_pages + 1, vdso_pages,
+					vdso_start, 1L, vdso_data);
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
 	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
@@ -144,14 +165,30 @@ static int __init vdso_init(void)
 
 	/* Grab the vDSO code pages. */
 	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
+		vdso_pagelist[i + 1] =
+			pfn_to_page(PHYS_PFN(__pa(vdso_start)) + i);
 
 	vdso_spec[0].pages = &vdso_pagelist[0];
 	vdso_spec[1].pages = &vdso_pagelist[1];
 
 	return 0;
 }
-arch_initcall(vdso_init);
+
+static int __init vdso_lp64_init(void)
+{
+	return vdso_init(&vdso_lp64_start, &vdso_lp64_end,
+				&vdso_lp64_pages, vdso_lp64_spec);
+}
+arch_initcall(vdso_lp64_init);
+
+#ifdef CONFIG_ARM64_ILP32
+static int __init vdso_ilp32_init(void)
+{
+	return vdso_init(&vdso_ilp32_start, &vdso_ilp32_end,
+				&vdso_ilp32_pages, vdso_ilp32_spec);
+}
+arch_initcall(vdso_ilp32_init);
+#endif
 
 int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
@@ -159,8 +196,17 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	struct mm_struct *mm = current->mm;
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
+	unsigned long pages = vdso_lp64_pages;
+	struct vm_special_mapping *vdso_spec = vdso_lp64_spec;
+
+#ifdef CONFIG_ARM64_ILP32
+	if (is_ilp32_compat_task()) {
+		pages = vdso_ilp32_pages;
+		vdso_spec = vdso_ilp32_spec;
+	}
+#endif
 
-	vdso_text_len = vdso_pages << PAGE_SHIFT;
+	vdso_text_len = pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
 	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
 
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index e00b467..062a33d 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -25,6 +25,16 @@
 #define NSEC_PER_SEC_LO16	0xca00
 #define NSEC_PER_SEC_HI16	0x3b9a
 
+#ifdef __LP64__
+#define PTR_REG(n)	x##n
+#define OFFSET(n)	n
+#define DELOUSE(n)
+#else
+#define PTR_REG(n)	w##n
+#define OFFSET(n)	COMPAT_##n
+#define DELOUSE(n)	mov     w##n, w##n
+#endif
+
 vdso_data	.req	x6
 seqcnt		.req	w7
 w_tmp		.req	w8
@@ -119,7 +129,7 @@ x_tmp		.req	x8
 	.if \shift == 1
 	lsr	x11, x11, x12
 	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
+	stp     PTR_REG(10), PTR_REG(11), [x1, #OFFSET(TSPEC_TV_SEC)]
 	mov	x0, xzr
 	ret
 	.endm
@@ -136,6 +146,8 @@ x_tmp		.req	x8
 /* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
 ENTRY(__kernel_gettimeofday)
 	.cfi_startproc
+	DELOUSE(0)
+	DELOUSE(1)
 	adr	vdso_data, _vdso_data
 	/* If tv is NULL, skip to the timezone code. */
 	cbz	x0, 2f
@@ -160,7 +172,7 @@ ENTRY(__kernel_gettimeofday)
 	mov	x13, #1000
 	lsl	x13, x13, x12
 	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
+	stp	PTR_REG(10), PTR_REG(11), [x0, #OFFSET(TVAL_TV_SEC)]
 2:
 	/* If tz is NULL, return 0. */
 	cbz	x1, 3f
@@ -182,6 +194,7 @@ ENDPROC(__kernel_gettimeofday)
 /* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
 ENTRY(__kernel_clock_gettime)
 	.cfi_startproc
+	DELOUSE(1)
 	cmp	w0, #JUMPSLOT_MAX
 	b.hi	syscall
 	adr	vdso_data, _vdso_data
@@ -297,6 +310,7 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
+	DELOUSE(1)
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
@@ -311,7 +325,7 @@ ENTRY(__kernel_clock_getres)
 	ldr	x2, 6f
 2:
 	cbz	w1, 3f
-	stp	xzr, x2, [x1]
+	stp	PTR_REG(zr), PTR_REG(2), [x1]
 
 3:	/* res == NULL. */
 	mov	w0, wzr
diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso/vdso.S
index 82379a7..a40ae24 100644
--- a/arch/arm64/kernel/vdso/vdso.S
+++ b/arch/arm64/kernel/vdso/vdso.S
@@ -21,12 +21,12 @@
 #include <linux/const.h>
 #include <asm/page.h>
 
-	.globl vdso_start, vdso_end
+	.globl vdso_lp64_start, vdso_lp64_end
 	.section .rodata
 	.balign PAGE_SIZE
-vdso_start:
+vdso_lp64_start:
 	.incbin "arch/arm64/kernel/vdso/vdso.so"
 	.balign PAGE_SIZE
-vdso_end:
+vdso_lp64_end:
 
 	.previous
-- 
2.7.4
