From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 10/28] ARCv2: Adhere to Zero Delay loop restriction
Date: Tue, 9 Jun 2015 17:18:10 +0530
Message-ID: <1433850508-26317-11-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:51821 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbbFILuY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:50:24 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Branch insn can't be scheduled as last insn of Zero Overhead loop

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/delay.h   |  9 ++++-----
 arch/arc/include/asm/uaccess.h | 17 ++++++++---------
 arch/arc/lib/memcmp.S          | 30 +++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/delay.h b/arch/arc/include/asm/delay.h
index 43de30256981..08e7e2a16ac1 100644
--- a/arch/arc/include/asm/delay.h
+++ b/arch/arc/include/asm/delay.h
@@ -22,11 +22,10 @@
 static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__(
-	"1:	sub.f %0, %0, 1	\n"
-	"	jpnz 1b		\n"
-	: "+r"(loops)
-	:
-	: "cc");
+	"	lp  1f	\n"
+	"	nop	\n"
+	"1:		\n"
+	: "+l"(loops));
 }
 
 extern void __bad_udelay(void);
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 30c9baffa96f..d1da6032b715 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -659,31 +659,30 @@ static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
 static inline long
 __arc_strncpy_from_user(char *dst, const char __user *src, long count)
 {
-	long res = count;
+	long res = 0;
 	char val;
-	unsigned int hw_count;
 
 	if (count == 0)
 		return 0;
 
 	__asm__ __volatile__(
-	"	lp 2f		\n"
+	"	lp	3f			\n"
 	"1:	ldb.ab  %3, [%2, 1]		\n"
-	"	breq.d  %3, 0, 2f		\n"
+	"	breq.d	%3, 0, 3f               \n"
 	"	stb.ab  %3, [%1, 1]		\n"
-	"2:	sub %0, %6, %4			\n"
-	"3:	;nop				\n"
+	"	add	%0, %0, 1	# Num of NON NULL bytes copied	\n"
+	"3:								\n"
 	"	.section .fixup, \"ax\"		\n"
 	"	.align 4			\n"
-	"4:	mov %0, %5			\n"
+	"4:	mov %0, %4		# sets @res as -EFAULT	\n"
 	"	j   3b				\n"
 	"	.previous			\n"
 	"	.section __ex_table, \"a\"	\n"
 	"	.align 4			\n"
 	"	.word   1b, 4b			\n"
 	"	.previous			\n"
-	: "=r"(res), "+r"(dst), "+r"(src), "=&r"(val), "=l"(hw_count)
-	: "g"(-EFAULT), "ir"(count), "4"(count)	/* this "4" seeds lp_count */
+	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
+	: "g"(-EFAULT), "l"(count)
 	: "memory");
 
 	return res;
diff --git a/arch/arc/lib/memcmp.S b/arch/arc/lib/memcmp.S
index 978bf8314dfb..a4015e7d9ab7 100644
--- a/arch/arc/lib/memcmp.S
+++ b/arch/arc/lib/memcmp.S
@@ -24,14 +24,32 @@ ENTRY(memcmp)
 	ld	r4,[r0,0]
 	ld	r5,[r1,0]
 	lsr.f	lp_count,r3,3
+#ifdef CONFIG_ISA_ARCV2
+	/* In ARCv2 a branch can't be the last instruction in a zero overhead
+	 * loop.
+	 * So we move the branch to the start of the loop, duplicate it
+	 * after the end, and set up r12 so that the branch isn't taken
+	 *  initially.
+	 */
+	mov_s	r12,WORD2
+	lpne	.Loop_end
+	brne	WORD2,r12,.Lodd
+	ld	WORD2,[r0,4]
+#else
 	lpne	.Loop_end
 	ld_s	WORD2,[r0,4]
+#endif
 	ld_s	r12,[r1,4]
 	brne	r4,r5,.Leven
 	ld.a	r4,[r0,8]
 	ld.a	r5,[r1,8]
+#ifdef CONFIG_ISA_ARCV2
+.Loop_end:
+	brne	WORD2,r12,.Lodd
+#else
 	brne	WORD2,r12,.Lodd
 .Loop_end:
+#endif
 	asl_s	SHIFT,SHIFT,3
 	bhs_s	.Last_cmp
 	brne	r4,r5,.Leven
@@ -89,7 +107,6 @@ ENTRY(memcmp)
 	bset.cs	r0,r0,31
 .Lodd:
 	cmp_s	WORD2,r12
-
 	mov_s	r0,1
 	j_s.d	[blink]
 	bset.cs	r0,r0,31
@@ -100,14 +117,25 @@ ENTRY(memcmp)
 	ldb	r4,[r0,0]
 	ldb	r5,[r1,0]
 	lsr.f	lp_count,r3
+#ifdef CONFIG_ISA_ARCV2
+	mov	r12,r3
 	lpne	.Lbyte_end
+	brne	r3,r12,.Lbyte_odd
+#else
+	lpne	.Lbyte_end
+#endif
 	ldb_s	r3,[r0,1]
 	ldb	r12,[r1,1]
 	brne	r4,r5,.Lbyte_even
 	ldb.a	r4,[r0,2]
 	ldb.a	r5,[r1,2]
+#ifdef CONFIG_ISA_ARCV2
+.Lbyte_end:
+	brne	r3,r12,.Lbyte_odd
+#else
 	brne	r3,r12,.Lbyte_odd
 .Lbyte_end:
+#endif
 	bcc	.Lbyte_even
 	brne	r4,r5,.Lbyte_even
 	ldb_s	r3,[r0,1]
-- 
1.9.1
