Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVMZz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:25:55 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 06/23] arm64: compat: Split kuser32
Date: Fri, 22 Feb 2019 12:24:13 +0000
Message-ID: <20190222122430.21180-7-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122413.Qb3VDYwrHqtRKSmlYLkx1I5a5SmgTU3RxK2lyvxnZZE@z>

To make it possible to disable kuser helpers in aarch32 we need to
divide the kuser and the sigreturn functionalities.

Split the current version of kuser32 in kuser32 (for kuser helpers)
and sigreturn32 (for sigreturn helpers).

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/Makefile      |  2 +-
 arch/arm64/kernel/kuser32.S     | 58 ++-------------------------------
 arch/arm64/kernel/sigreturn32.S | 46 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cd434d0719c1..50f76b88a967 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 obj-$(CONFIG_COMPAT)			+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o
+					   sigreturn32.o sys_compat.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index 997e6b27ff6a..f19e2b015097 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -1,24 +1,9 @@
 /*
- * Low-level user helpers placed in the vectors page for AArch32.
+ * AArch32 user helpers.
  * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
  *
  * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- *
- * AArch32 user helpers.
+ * Copyright (C) 2012-2018 ARM Ltd.
  *
  * Each segment is 32-byte aligned and will be moved to the top of the high
  * vector page.  New segments (if ever needed) must be added in front of
@@ -77,42 +62,3 @@ __kuser_helper_version:			// 0xffff0ffc
 	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
 	.globl	__kuser_helper_end
 __kuser_helper_end:
-
-/*
- * AArch32 sigreturn code
- *
- * For ARM syscalls, the syscall number has to be loaded into r7.
- * We do not support an OABI userspace.
- *
- * For Thumb syscalls, we also pass the syscall number via r7. We therefore
- * need two 16-bit instructions.
- */
-	.globl __aarch32_sigret_code_start
-__aarch32_sigret_code_start:
-
-	/*
-	 * ARM Code
-	 */
-	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
-
-	/*
-	 * ARM code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
-
-	/*
-	 * Thumb code
-	 */
-	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
-
-        .globl __aarch32_sigret_code_end
-__aarch32_sigret_code_end:
diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
new file mode 100644
index 000000000000..475d30d471ac
--- /dev/null
+++ b/arch/arm64/kernel/sigreturn32.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AArch32 sigreturn code.
+ * Based on the kuser helpers in arch/arm/kernel/entry-armv.S.
+ *
+ * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
+ * Copyright (C) 2012-2018 ARM Ltd.
+ *
+ * For ARM syscalls, the syscall number has to be loaded into r7.
+ * We do not support an OABI userspace.
+ *
+ * For Thumb syscalls, we also pass the syscall number via r7. We therefore
+ * need two 16-bit instructions.
+ */
+
+#include <asm/unistd.h>
+
+	.globl __aarch32_sigret_code_start
+__aarch32_sigret_code_start:
+
+	/*
+	 * ARM Code
+	 */
+	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3		// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef		// svc	#__NR_compat_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
+
+	/*
+	 * ARM code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
+
+	/*
+	 * Thumb code
+	 */
+	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
+
+        .globl __aarch32_sigret_code_end
+__aarch32_sigret_code_end:
-- 
2.20.1
