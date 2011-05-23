From: akpm@linux-foundation.org
Subject: [patch 1/4] arch/x86/include/asm/delay.h: fix udelay() and ndelay() for 8-bit args
Date: Mon, 23 May 2011 14:47:00 -0700
Message-ID: <201105232147.p4NLl0ti013960@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36732 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757651Ab1EWVrU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 May 2011 17:47:20 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@elte.hu
Cc: hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, linux-arch@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

With a non-constant 8-bit argument, a call to udelay() generates a warning:

drivers/gpu/drm/radeon/atom.c: In function 'atom_op_delay':
drivers/gpu/drm/radeon/atom.c:654: warning: comparison is always false due to limited range of data type

The code looks like it works OK with an 8-bit arg, and the calling code is
doing nothing wrong, so udelay() needs fixing.

Fixing it was rather tricky.  Simply typecasting `n' in the comparison with
20000 didn't change anything.  Hence the divide-by-20000 trick.

Using a do{}while loop didn't work because udelay() is used in ?: statements,
hence the ({...}) construct.

While I was there I replaced the brain-bending ?:?:?: mess with nice if/else
code.

Probably other architectures are generating the same warning and can use a
similar change.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/include/asm/delay.h |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff -puN arch/x86/include/asm/delay.h~arch-x86-include-asm-delayh-fix-udelay-and-ndelay-for-8-bit-args arch/x86/include/asm/delay.h
--- a/arch/x86/include/asm/delay.h~arch-x86-include-asm-delayh-fix-udelay-and-ndelay-for-8-bit-args
+++ a/arch/x86/include/asm/delay.h
@@ -16,15 +16,36 @@ extern void __ndelay(unsigned long nsecs
 extern void __const_udelay(unsigned long xloops);
 extern void __delay(unsigned long loops);
 
+/*
+ * The weird n/20000 thing suppresses a "comparison is always false due to
+ * limited range of data type" warning with non-const 8-bit arguments.
+ */
+
 /* 0x10c7 is 2**32 / 1000000 (rounded up) */
-#define udelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_udelay() : __const_udelay((n) * 0x10c7ul)) : \
-	__udelay(n))
+#define udelay(n)							\
+	({								\
+		if (__builtin_constant_p(n)) {				\
+			if ((n) / 20000 >= 1)				\
+				 __bad_udelay();			\
+			else						\
+				__const_udelay((n) * 0x10c7ul);		\
+		} else {						\
+			__udelay(n);					\
+		}							\
+	})
 
 /* 0x5 is 2**32 / 1000000000 (rounded up) */
-#define ndelay(n) (__builtin_constant_p(n) ? \
-	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
-	__ndelay(n))
+#define ndelay(n)							\
+	({								\
+		if (__builtin_constant_p(n)) {				\
+			if ((n) / 20000 >= 1)				\
+				__bad_ndelay();				\
+			else						\
+				__const_udelay((n) * 5ul);		\
+		} else {						\
+			__ndelay(n);					\
+		}							\
+	})
 
 void use_tsc_delay(void);
 
_
