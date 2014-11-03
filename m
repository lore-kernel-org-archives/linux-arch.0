Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0081.outbound.protection.outlook.com ([207.46.100.81]:39362
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752458AbaKCKyg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Nov 2014 05:54:36 -0500
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v6 17/29] nios2: System calls handling
Date: Mon, 3 Nov 2014 18:52:13 +0800
Message-ID: <1415011945-3297-18-git-send-email-lftan@altera.com>
In-Reply-To: <1415011945-3297-1-git-send-email-lftan@altera.com>
References: <1415011945-3297-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141103105213.bavwlHejQVqbpSeESG-WQSkWfTIldaFiUr4dsgAZQb4@z>

This patch adds support for system calls from userspaces. It uses the
asm-generic/unistd.h definitions with architecture spcific syscall.
The sys_call_table is just an array defined in a C file and it contains
pointers to the syscall functions.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/nios2/include/asm/syscall.h     | 138 +++++++++++++++++++++++++++++++++++
 arch/nios2/include/asm/syscalls.h    |  25 +++++++
 arch/nios2/include/uapi/asm/unistd.h |  25 +++++++
 arch/nios2/kernel/sys_nios2.c        |  53 ++++++++++++++
 arch/nios2/kernel/syscall_table.c    |  29 ++++++++
 5 files changed, 270 insertions(+)
 create mode 100644 arch/nios2/include/asm/syscall.h
 create mode 100644 arch/nios2/include/asm/syscalls.h
 create mode 100644 arch/nios2/include/uapi/asm/unistd.h
 create mode 100644 arch/nios2/kernel/sys_nios2.c
 create mode 100644 arch/nios2/kernel/syscall_table.c

diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
new file mode 100644
index 0000000..9de2208
--- /dev/null
+++ b/arch/nios2/include/asm/syscall.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright Altera Corporation (C) <2014>. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_NIOS2_SYSCALL_H__
+#define __ASM_NIOS2_SYSCALL_H__
+
+#include <linux/err.h>
+#include <linux/sched.h>
+
+static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->r2;
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+				struct pt_regs *regs)
+{
+	regs->r2 = regs->orig_r2;
+	regs->r7 = regs->orig_r7;
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				struct pt_regs *regs)
+{
+	return regs->r7 ? regs->r2 : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+	struct pt_regs *regs)
+{
+	return regs->r2;
+}
+
+static inline void syscall_set_return_value(struct task_struct *task,
+	struct pt_regs *regs, int error, long val)
+{
+	if (error) {
+		/* error < 0, but nios2 uses > 0 return value */
+		regs->r2 = -error;
+		regs->r7 = 1;
+	} else {
+		regs->r2 = val;
+		regs->r7 = 0;
+	}
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+	struct pt_regs *regs, unsigned int i, unsigned int n,
+	unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+
+	switch (i) {
+	case 0:
+		if (!n--)
+			break;
+		*args++ = regs->r4;
+	case 1:
+		if (!n--)
+			break;
+		*args++ = regs->r5;
+	case 2:
+		if (!n--)
+			break;
+		*args++ = regs->r6;
+	case 3:
+		if (!n--)
+			break;
+		*args++ = regs->r7;
+	case 4:
+		if (!n--)
+			break;
+		*args++ = regs->r8;
+	case 5:
+		if (!n--)
+			break;
+		*args++ = regs->r9;
+	case 6:
+		if (!n--)
+			break;
+	default:
+		BUG();
+	}
+}
+
+static inline void syscall_set_arguments(struct task_struct *task,
+	struct pt_regs *regs, unsigned int i, unsigned int n,
+	const unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+
+	switch (i) {
+	case 0:
+		if (!n--)
+			break;
+		regs->r4 = *args++;
+	case 1:
+		if (!n--)
+			break;
+		regs->r5 = *args++;
+	case 2:
+		if (!n--)
+			break;
+		regs->r6 = *args++;
+	case 3:
+		if (!n--)
+			break;
+		regs->r7 = *args++;
+	case 4:
+		if (!n--)
+			break;
+		regs->r8 = *args++;
+	case 5:
+		if (!n--)
+			break;
+		regs->r9 = *args++;
+	case 6:
+		if (!n)
+			break;
+	default:
+		BUG();
+	}
+}
+
+#endif
diff --git a/arch/nios2/include/asm/syscalls.h b/arch/nios2/include/asm/syscalls.h
new file mode 100644
index 0000000..0245d78
--- /dev/null
+++ b/arch/nios2/include/asm/syscalls.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright Altera Corporation (C) 2013. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#ifndef __ASM_NIOS2_SYSCALLS_H
+#define __ASM_NIOS2_SYSCALLS_H
+
+int sys_cacheflush(unsigned long addr, unsigned long len,
+				unsigned int op);
+
+#include <asm-generic/syscalls.h>
+
+#endif /* __ASM_NIOS2_SYSCALLS_H */
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
new file mode 100644
index 0000000..c4bf795
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2013 Altera Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+ #define sys_mmap2 sys_mmap_pgoff
+
+/* Use the standard ABI for syscalls */
+#include <asm-generic/unistd.h>
+
+/* Additional Nios II specific syscalls. */
+#define __NR_cacheflush (__NR_arch_specific_syscall)
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
diff --git a/arch/nios2/kernel/sys_nios2.c b/arch/nios2/kernel/sys_nios2.c
new file mode 100644
index 0000000..cd390ec
--- /dev/null
+++ b/arch/nios2/kernel/sys_nios2.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2013 Altera Corporation
+ * Copyright (C) 2011-2012 Tobias Klauser <tklauser@distanz.ch>
+ * Copyright (C) 2004 Microtronix Datacom Ltd.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
+
+/* sys_cacheflush -- flush the processor cache. */
+asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
+				unsigned int op)
+{
+	struct vm_area_struct *vma;
+
+	if (len == 0)
+		return 0;
+
+	/* We only support op 0 now, return error if op is non-zero.*/
+	if (op)
+		return -EINVAL;
+
+	/* Check for overflow */
+	if (addr + len < addr)
+		return -EFAULT;
+
+	/*
+	 * Verify that the specified address region actually belongs
+	 * to this process.
+	 */
+	vma = find_vma(current->mm, addr);
+	if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end)
+		return -EFAULT;
+
+	flush_cache_range(vma, addr, addr + len);
+
+	return 0;
+}
+
+asmlinkage int sys_getpagesize(void)
+{
+	return PAGE_SIZE;
+}
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
new file mode 100644
index 0000000..06e6ac1
--- /dev/null
+++ b/arch/nios2/kernel/syscall_table.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright Altera Corporation (C) 2013. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/syscalls.h>
+#include <linux/signal.h>
+#include <linux/unistd.h>
+
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+void *sys_call_table[__NR_syscalls] = {
+#include <asm/unistd.h>
+};
-- 
1.8.2.1

