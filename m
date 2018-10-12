From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 09/21] csky: VDSO and rt_sigreturn
Date: Fri, 12 Oct 2018 12:42:44 +0800
Message-ID: <9f8264bd92aceca78d2a95a45710908905421a47.1539315391.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds files related to VDSO and our VDSO only support
rt_sigreturn.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/vdso.h | 17 +++++++++
 arch/csky/abiv2/inc/abi/vdso.h | 23 +++++++++++
 arch/csky/include/asm/vdso.h   | 12 ++++++
 arch/csky/kernel/vdso.c        | 86 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv2/inc/abi/vdso.h
 create mode 100644 arch/csky/include/asm/vdso.h
 create mode 100644 arch/csky/kernel/vdso.c

diff --git a/arch/csky/abiv1/inc/abi/vdso.h b/arch/csky/abiv1/inc/abi/vdso.h
new file mode 100644
index 0000000..14352f5
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/vdso.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/uaccess.h>
+
+static inline int setup_vdso_page(unsigned short *ptr)
+{
+	int err = 0;
+
+	/* movi r1, 127 */
+	err |= __put_user(0x67f1, ptr + 0);
+	/* addi r1, (139 - 127) */
+	err |= __put_user(0x20b1, ptr + 1);
+	/* trap 0 */
+	err |= __put_user(0x0008, ptr + 2);
+
+	return err;
+}
diff --git a/arch/csky/abiv2/inc/abi/vdso.h b/arch/csky/abiv2/inc/abi/vdso.h
new file mode 100644
index 0000000..b60d4a0
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/vdso.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ABI_CSKY_VDSO_H
+#define __ABI_CSKY_VDSO_H
+
+#include <linux/uaccess.h>
+
+static inline int setup_vdso_page(unsigned short *ptr)
+{
+	int err = 0;
+
+	/* movi r7, 173 */
+	err |= __put_user(0xea07, ptr);
+	err |= __put_user(0x008b,      ptr+1);
+
+	/* trap 0 */
+	err |= __put_user(0xc000,   ptr+2);
+	err |= __put_user(0x2020,   ptr+3);
+
+	return err;
+}
+
+#endif /* __ABI_CSKY_STRING_H */
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
new file mode 100644
index 0000000..d963d69
--- /dev/null
+++ b/arch/csky/include/asm/vdso.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_VDSO_H
+#define __ASM_CSKY_VDSO_H
+
+#include <abi/vdso.h>
+
+struct csky_vdso {
+	unsigned short rt_signal_retcode[4];
+};
+
+#endif /* __ASM_CSKY_VDSO_H */
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
new file mode 100644
index 0000000..60ff7ad
--- /dev/null
+++ b/arch/csky/kernel/vdso.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/vmalloc.h>
+#include <linux/unistd.h>
+#include <linux/uaccess.h>
+
+#include <asm/vdso.h>
+#include <asm/cacheflush.h>
+
+static struct page *vdso_page;
+
+static int __init init_vdso(void)
+{
+	struct csky_vdso *vdso;
+	int err = 0;
+
+	vdso_page = alloc_page(GFP_KERNEL);
+	if (!vdso_page)
+		panic("Cannot allocate vdso");
+
+	vdso = vmap(&vdso_page, 1, 0, PAGE_KERNEL);
+	if (!vdso)
+		panic("Cannot map vdso");
+
+	clear_page(vdso);
+
+	err = setup_vdso_page(vdso->rt_signal_retcode);
+	if (err)
+		panic("Cannot set signal return code, err: %x.", err);
+
+	dcache_wb_range((unsigned long)vdso, (unsigned long)vdso + 16);
+
+	vunmap(vdso);
+
+	return 0;
+}
+subsys_initcall(init_vdso);
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	int ret;
+	unsigned long addr;
+	struct mm_struct *mm = current->mm;
+
+	down_write(&mm->mmap_sem);
+
+	addr = get_unmapped_area(NULL, STACK_TOP, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	ret = install_special_mapping(
+			mm,
+			addr,
+			PAGE_SIZE,
+			VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+			&vdso_page);
+	if (ret)
+		goto up_fail;
+
+	mm->context.vdso = (void *)addr;
+
+up_fail:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm == NULL)
+		return NULL;
+
+	if (vma->vm_start == (long)vma->vm_mm->context.vdso)
+		return "[vdso]";
+	else
+		return NULL;
+}
-- 
2.7.4
