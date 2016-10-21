Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:52647
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932739AbcJUUuf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Oct 2016 16:50:35 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 11/18] arm64: ilp32: share aarch32 syscall handlers
Date: Fri, 21 Oct 2016 23:33:10 +0300
Message-ID: <1477081997-4770-12-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
Message-ID: <20161021203310.3KDA0LXf4uaSqf7VVBkImvsGnb3e_3JT5cj7psYbz2I@z>

off_t is  passed in register pair just like in aarch32.
In this patch corresponding aarch32 handlers are shared to
ilp32 code.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/Makefile         |   1 +
 arch/arm64/kernel/entry32.S        |  80 ---------------------------
 arch/arm64/kernel/entry32_common.S | 107 +++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm64/kernel/entry32_common.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f661888..9123bb8 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -30,6 +30,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
 arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
+arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
index f332d5d..4bede03 100644
--- a/arch/arm64/kernel/entry32.S
+++ b/arch/arm64/kernel/entry32.S
@@ -39,83 +39,3 @@ ENTRY(compat_sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	compat_sys_rt_sigreturn
 ENDPROC(compat_sys_rt_sigreturn_wrapper)
-
-ENTRY(compat_sys_statfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_statfs64
-ENDPROC(compat_sys_statfs64_wrapper)
-
-ENTRY(compat_sys_fstatfs64_wrapper)
-	mov	w3, #84
-	cmp	w1, #88
-	csel	w1, w3, w1, eq
-	b	compat_sys_fstatfs64
-ENDPROC(compat_sys_fstatfs64_wrapper)
-
-/*
- * Note: off_4k (w5) is always in units of 4K. If we can't do the
- * requested offset because it is not page-aligned, we return -EINVAL.
- */
-ENTRY(compat_sys_mmap2_wrapper)
-#if PAGE_SHIFT > 12
-	tst	w5, #~PAGE_MASK >> 12
-	b.ne	1f
-	lsr	w5, w5, #PAGE_SHIFT - 12
-#endif
-	b	sys_mmap_pgoff
-1:	mov	x0, #-EINVAL
-	ret
-ENDPROC(compat_sys_mmap2_wrapper)
-
-/*
- * Wrappers for AArch32 syscalls that either take 64-bit parameters
- * in registers or that take 32-bit parameters which require sign
- * extension.
- */
-ENTRY(compat_sys_pread64_wrapper)
-	regs_to_64	x3, x4, x5
-	b	sys_pread64
-ENDPROC(compat_sys_pread64_wrapper)
-
-ENTRY(compat_sys_pwrite64_wrapper)
-	regs_to_64	x3, x4, x5
-	b	sys_pwrite64
-ENDPROC(compat_sys_pwrite64_wrapper)
-
-ENTRY(compat_sys_truncate64_wrapper)
-	regs_to_64	x1, x2, x3
-	b	sys_truncate
-ENDPROC(compat_sys_truncate64_wrapper)
-
-ENTRY(compat_sys_ftruncate64_wrapper)
-	regs_to_64	x1, x2, x3
-	b	sys_ftruncate
-ENDPROC(compat_sys_ftruncate64_wrapper)
-
-ENTRY(compat_sys_readahead_wrapper)
-	regs_to_64	x1, x2, x3
-	mov	w2, w4
-	b	sys_readahead
-ENDPROC(compat_sys_readahead_wrapper)
-
-ENTRY(compat_sys_fadvise64_64_wrapper)
-	mov	w6, w1
-	regs_to_64	x1, x2, x3
-	regs_to_64	x2, x4, x5
-	mov	w3, w6
-	b	sys_fadvise64_64
-ENDPROC(compat_sys_fadvise64_64_wrapper)
-
-ENTRY(compat_sys_sync_file_range2_wrapper)
-	regs_to_64	x2, x2, x3
-	regs_to_64	x3, x4, x5
-	b	sys_sync_file_range2
-ENDPROC(compat_sys_sync_file_range2_wrapper)
-
-ENTRY(compat_sys_fallocate_wrapper)
-	regs_to_64	x2, x2, x3
-	regs_to_64	x3, x4, x5
-	b	sys_fallocate
-ENDPROC(compat_sys_fallocate_wrapper)
diff --git a/arch/arm64/kernel/entry32_common.S b/arch/arm64/kernel/entry32_common.S
new file mode 100644
index 0000000..f4a5e4d
--- /dev/null
+++ b/arch/arm64/kernel/entry32_common.S
@@ -0,0 +1,107 @@
+/*
+ * Compat system call wrappers
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Authors: Will Deacon <will.deacon@arm.com>
+ *	    Catalin Marinas <catalin.marinas@arm.com>
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
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/errno.h>
+#include <asm/page.h>
+
+/*
+ * Note: off_4k (w5) is always in units of 4K. If we can't do the
+ * requested offset because it is not page-aligned, we return -EINVAL.
+ */
+ENTRY(compat_sys_mmap2_wrapper)
+#if PAGE_SHIFT > 12
+	tst	w5, #~PAGE_MASK >> 12
+	b.ne	1f
+	lsr	w5, w5, #PAGE_SHIFT - 12
+#endif
+	b	sys_mmap_pgoff
+1:	mov	x0, #-EINVAL
+	ret
+ENDPROC(compat_sys_mmap2_wrapper)
+
+/*
+ * Wrappers for AArch32 syscalls that either take 64-bit parameters
+ * in registers or that take 32-bit parameters which require sign
+ * extension.
+ */
+ENTRY(compat_sys_pread64_wrapper)
+	regs_to_64	x3, x4, x5
+	b	sys_pread64
+ENDPROC(compat_sys_pread64_wrapper)
+
+ENTRY(compat_sys_pwrite64_wrapper)
+	regs_to_64	x3, x4, x5
+	b	sys_pwrite64
+ENDPROC(compat_sys_pwrite64_wrapper)
+
+ENTRY(compat_sys_truncate64_wrapper)
+	regs_to_64	x1, x2, x3
+	b	sys_truncate
+ENDPROC(compat_sys_truncate64_wrapper)
+
+ENTRY(compat_sys_ftruncate64_wrapper)
+	regs_to_64	x1, x2, x3
+	b	sys_ftruncate
+ENDPROC(compat_sys_ftruncate64_wrapper)
+
+ENTRY(compat_sys_readahead_wrapper)
+	regs_to_64	x1, x2, x3
+	mov	w2, w4
+	b	sys_readahead
+ENDPROC(compat_sys_readahead_wrapper)
+
+ENTRY(compat_sys_fadvise64_64_wrapper)
+	mov	w6, w1
+	regs_to_64	x1, x2, x3
+	regs_to_64	x2, x4, x5
+	mov	w3, w6
+	b	sys_fadvise64_64
+ENDPROC(compat_sys_fadvise64_64_wrapper)
+
+ENTRY(compat_sys_sync_file_range2_wrapper)
+	regs_to_64	x2, x2, x3
+	regs_to_64	x3, x4, x5
+	b	sys_sync_file_range2
+ENDPROC(compat_sys_sync_file_range2_wrapper)
+
+ENTRY(compat_sys_fallocate_wrapper)
+	regs_to_64	x2, x2, x3
+	regs_to_64	x3, x4, x5
+	b	sys_fallocate
+ENDPROC(compat_sys_fallocate_wrapper)
+
+ENTRY(compat_sys_statfs64_wrapper)
+	mov	w3, #84
+	cmp	w1, #88
+	csel	w1, w3, w1, eq
+	b	compat_sys_statfs64
+ENDPROC(compat_sys_statfs64_wrapper)
+
+ENTRY(compat_sys_fstatfs64_wrapper)
+	mov	w3, #84
+	cmp	w1, #88
+	csel	w1, w3, w1, eq
+	b	compat_sys_fstatfs64
+ENDPROC(compat_sys_fstatfs64_wrapper)
-- 
2.7.4

