From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 3/3] math128, x86_64: Implement {mult,add}_u128 in 64bit asm
Date: Tue, 24 Apr 2012 18:10:42 +0200
Message-ID: <20120424162224.588822231@chello.nl>
References: <20120424161039.293018424@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=math128-x86_64.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-arch.vger.kernel.org



Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/x86/include/asm/math128.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/arch/x86/include/asm/math128.h
+++ b/arch/x86/include/asm/math128.h
@@ -1,4 +1,33 @@
 #ifndef _ASM_MATH128_H
 #define _ASM_MATH128_H
 
+#ifdef CONFIG_X86_64
+
+static inline mult_u128(u64 a, u64 b)
+{
+	u128 res;
+
+	asm("mulq %2"
+		: "=a" (res.lo), "=d" (res.hi)
+		:  "rm" (b), "0" (a));
+
+	return res;
+}
+#define mult_u128 mult_u128
+
+static inline add_u128(u128 a, u128 b)
+{
+	u128 res;
+
+	asm("addq %2,%0;\n"
+	    "adcq %3,%1;\n"
+		: "=rm" (res.lo), "=rm" (res.hi)
+		: "r" (b.lo), "r" (b.hi), "0" (a.lo), "1" (a.hi));
+
+	return res;
+}
+#define add_u128 add_u128
+
+#endif /* CONFIG_X86_64 */
+
 #endif /* _ASM_MATH128_H */
