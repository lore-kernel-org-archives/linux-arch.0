From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
Date: Tue, 14 Jan 2020 12:08:46 -0800
Message-ID: <20200114200846.29434-5-vgupta@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200114200846.29434-1-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

These rely on word access rather than byte loop

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig                      |  2 +
 arch/arc/include/asm/Kbuild           |  1 -
 arch/arc/include/asm/uaccess.h        | 71 ++-------------------------
 arch/arc/include/asm/word-at-a-time.h | 49 ++++++++++++++++++
 4 files changed, 56 insertions(+), 67 deletions(-)
 create mode 100644 arch/arc/include/asm/word-at-a-time.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 26108ea785c2..3b074c4d31fb 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,8 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER if MMU
+	select GENERIC_STRNLEN_USER if MMU
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 1b505694691e..cb8d459b7f56 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -24,5 +24,4 @@ generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
-generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 0b34c152086f..f579e06447a9 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -23,7 +23,6 @@
 
 #include <linux/string.h>	/* for generic string functions */
 
-
 #define __kernel_ok		(uaccess_kernel())
 
 /*
@@ -52,6 +51,8 @@
 #define __access_ok(addr, sz)	(unlikely(__kernel_ok) || \
 				 likely(__user_ok((addr), (sz))))
 
+#define user_addr_max() 	(uaccess_kernel() ? ~0UL : get_fs())
+
 /*********** Single byte/hword/word copies ******************/
 
 #define __get_user_fn(sz, u, k)					\
@@ -655,75 +656,13 @@ static inline unsigned long __clear_user(void __user *to, unsigned long n)
 	return res;
 }
 
-static inline long
-__strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	long res = 0;
-	char val;
-
-	if (count == 0)
-		return 0;
-
-	__asm__ __volatile__(
-	"	mov	lp_count, %5		\n"
-	"	lp	3f			\n"
-	"1:	ldb.ab  %3, [%2, 1]		\n"
-	"	breq.d	%3, 0, 3f               \n"
-	"	stb.ab  %3, [%1, 1]		\n"
-	"	add	%0, %0, 1	# Num of NON NULL bytes copied	\n"
-	"3:								\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, %4		# sets @res as -EFAULT	\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word   1b, 4b			\n"
-	"	.previous			\n"
-	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
-	: "g"(-EFAULT), "r"(count)
-	: "lp_count", "memory");
-
-	return res;
-}
-
-static inline long __strnlen_user(const char __user *s, long n)
-{
-	long res, tmp1, cnt;
-	char val;
-
-	__asm__ __volatile__(
-	"	mov %2, %1			\n"
-	"1:	ldb.ab  %3, [%0, 1]		\n"
-	"	breq.d  %3, 0, 2f		\n"
-	"	sub.f   %2, %2, 1		\n"
-	"	bnz 1b				\n"
-	"	sub %2, %2, 1			\n"
-	"2:	sub %0, %1, %2			\n"
-	"3:	;nop				\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, 0			\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word 1b, 4b			\n"
-	"	.previous			\n"
-	: "=r"(res), "=r"(tmp1), "=r"(cnt), "=r"(val)
-	: "0"(s), "1"(n)
-	: "memory");
-
-	return res;
-}
-
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
 #define __clear_user		__clear_user
-#define __strncpy_from_user	__strncpy_from_user
-#define __strnlen_user		__strnlen_user
+
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
diff --git a/arch/arc/include/asm/word-at-a-time.h b/arch/arc/include/asm/word-at-a-time.h
new file mode 100644
index 000000000000..00e92be70987
--- /dev/null
+++ b/arch/arc/include/asm/word-at-a-time.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Synopsys Inc.
+ */
+#ifndef __ASM_ARC_WORD_AT_A_TIME_H
+#define __ASM_ARC_WORD_AT_A_TIME_H
+
+#ifdef __LITTLE_ENDIAN__
+
+#include <linux/kernel.h>
+
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits,
+				     const struct word_at_a_time *c)
+{
+	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+#define prep_zero_mask(a, bits, c) (bits)
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+#ifdef CONFIG_64BIT
+	return fls64(mask) >> 3;
+#else
+	return fls(mask) >> 3;
+#endif
+}
+
+#define zero_bytemask(mask) (mask)
+
+#else	/* __BIG_ENDIAN__ */
+#include <asm-generic/word-at-a-time.h>
+#endif
+
+#endif /* __ASM_WORD_AT_A_TIME_H */
-- 
2.20.1
