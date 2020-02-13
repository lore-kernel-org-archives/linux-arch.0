From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 17/19] arm: vdso: Enable arm to use common headers
Date: Thu, 13 Feb 2020 16:16:12 +0000
Message-ID: <20200213161614.23246-18-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, ndesaulniers@google.com, avagin@openvz.org
List-Id: linux-arch.vger.kernel.org

Enable arm to use only the common headers in the implementation
of the vDSO library.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/include/asm/common/cp15.h       | 38 ++++++++++++++++++++++++
 arch/arm/include/asm/common/processor.h  | 22 ++++++++++++++
 arch/arm/include/asm/cp15.h              | 20 +------------
 arch/arm/include/asm/processor.h         | 11 +------
 arch/arm/include/asm/vdso/gettimeofday.h |  4 +--
 5 files changed, 64 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/include/asm/common/cp15.h
 create mode 100644 arch/arm/include/asm/common/processor.h

diff --git a/arch/arm/include/asm/common/cp15.h b/arch/arm/include/asm/common/cp15.h
new file mode 100644
index 000000000000..d1412c80120f
--- /dev/null
+++ b/arch/arm/include/asm/common/cp15.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_COMMON_CP15_H
+#define __ASM_COMMON_CP15_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_CPU_CP15
+
+#include <linux/stringify.h>
+
+#define __ACCESS_CP15(CRn, Op1, CRm, Op2)	\
+	"mrc", "mcr", __stringify(p15, Op1, %0, CRn, CRm, Op2), u32
+#define __ACCESS_CP15_64(Op1, CRm)		\
+	"mrrc", "mcrr", __stringify(p15, Op1, %Q0, %R0, CRm), u64
+
+#define __read_sysreg(r, w, c, t) ({				\
+	t __val;						\
+	asm volatile(r " " c : "=r" (__val));			\
+	__val;							\
+})
+#define read_sysreg(...)		__read_sysreg(__VA_ARGS__)
+
+#define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
+#define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
+
+#define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+#define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
+
+#define CNTVCT				__ACCESS_CP15_64(1, c14)
+
+#endif /* CONFIG_CPU_CP15 */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_COMMON_CP15_H */
diff --git a/arch/arm/include/asm/common/processor.h b/arch/arm/include/asm/common/processor.h
new file mode 100644
index 000000000000..0e76f3cb0d0d
--- /dev/null
+++ b/arch/arm/include/asm/common/processor.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_COMMON_PROCESSOR_H
+#define __ASM_COMMON_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
+#define cpu_relax()						\
+	do {							\
+		smp_mb();					\
+		__asm__ __volatile__("nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;");	\
+	} while (0)
+#else
+#define cpu_relax()			barrier()
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_COMMON_PROCESSOR_H */
diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index d2453e2d3f1f..fe47a65130ab 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -50,25 +50,7 @@
 
 #ifdef CONFIG_CPU_CP15
 
-#define __ACCESS_CP15(CRn, Op1, CRm, Op2)	\
-	"mrc", "mcr", __stringify(p15, Op1, %0, CRn, CRm, Op2), u32
-#define __ACCESS_CP15_64(Op1, CRm)		\
-	"mrrc", "mcrr", __stringify(p15, Op1, %Q0, %R0, CRm), u64
-
-#define __read_sysreg(r, w, c, t) ({				\
-	t __val;						\
-	asm volatile(r " " c : "=r" (__val));			\
-	__val;							\
-})
-#define read_sysreg(...)		__read_sysreg(__VA_ARGS__)
-
-#define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
-#define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
-
-#define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
-#define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
-
-#define CNTVCT				__ACCESS_CP15_64(1, c14)
+#include <asm/common/cp15.h>
 
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 614bf829e454..c098d95a88fa 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -14,6 +14,7 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/unified.h>
+#include <asm/common/processor.h>
 
 #ifdef __KERNEL__
 #define STACK_TOP	((current->personality & ADDR_LIMIT_32BIT) ? \
@@ -85,16 +86,6 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
-#if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()						\
-	do {							\
-		smp_mb();					\
-		__asm__ __volatile__("nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;");	\
-	} while (0)
-#else
-#define cpu_relax()			barrier()
-#endif
-
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
 
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index fe6e1f65932d..ffb88cef8cbb 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -7,9 +7,9 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/barrier.h>
-#include <asm/cp15.h>
+#include <asm/errno.h>
 #include <asm/unistd.h>
+#include <asm/common/cp15.h>
 #include <uapi/linux/time.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1
-- 
2.25.0
