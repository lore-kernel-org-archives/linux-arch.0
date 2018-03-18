From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 09/19] csky: VDSO and rt_sigreturn
Date: Mon, 19 Mar 2018 03:51:31 +0800
Message-ID: <6277b52bf426b2ac345f9c502ecbd4045d318b97.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv1/inc/abi/vdso.h | 19 +++++++++
 arch/csky/abiv2/inc/abi/vdso.h | 18 +++++++++
 arch/csky/include/asm/vdso.h   | 12 ++++++
 arch/csky/kernel/vdso.c        | 89 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 arch/csky/abiv1/inc/abi/vdso.h
 create mode 100644 arch/csky/abiv2/inc/abi/vdso.h
 create mode 100644 arch/csky/include/asm/vdso.h
 create mode 100644 arch/csky/kernel/vdso.c

diff --git a/arch/csky/abiv1/inc/abi/vdso.h b/arch/csky/abiv1/inc/abi/vdso.h
new file mode 100644
index 0000000..029c4e3
--- /dev/null
+++ b/arch/csky/abiv1/inc/abi/vdso.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/uaccess.h>
+
+static inline int setup_vdso_page(unsigned short *ptr)
+{
+	int err;
+
+	/* movi r1, 127 */
+	err |= __put_user(0x6000 + (127 << 4)+1, ptr+0);
+	/* addi r1, 32 */
+	err |= __put_user(0x2000 + ((32-1)  << 4)+1, ptr+1);
+	/* addi r1, 173-127-32 */
+	err |= __put_user(0x2000 + (((173-127-32) -1)<< 4)+1, ptr+2);
+	/* trap 0 */
+	err |= __put_user(0x08, ptr+3);
+
+	return err;
+}
diff --git a/arch/csky/abiv2/inc/abi/vdso.h b/arch/csky/abiv2/inc/abi/vdso.h
new file mode 100644
index 0000000..f9da48a
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/vdso.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#include <linux/uaccess.h>
+
+static inline int setup_vdso_page(unsigned short *ptr)
+{
+	int err;
+
+	/* movi r7, 173 */
+	err |= __put_user(0xEA00+7, ptr);
+	err |= __put_user(173,      ptr+1);
+
+	/* trap 0 */
+	err |= __put_user(0xC000,   ptr+2);
+	err |= __put_user(0x2020,   ptr+3);
+
+	return err;
+}
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
new file mode 100644
index 0000000..b275440
--- /dev/null
+++ b/arch/csky/include/asm/vdso.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
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
index 0000000..dd59aae
--- /dev/null
+++ b/arch/csky/kernel/vdso.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
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
+	/*
+	 * __NR_rt_sigreturn must be 173
+	 * Because gcc/config/csky/linux-unwind.h use hard code to parse rt_sigframe.
+	 */
+	err = setup_vdso_page(vdso->rt_signal_retcode);
+	if (err) panic("Cannot set signal return code, err: %x.", err);
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
+
-- 
2.7.4
