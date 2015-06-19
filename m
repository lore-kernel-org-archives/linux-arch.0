From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 22/28] ARCv2: STAR 9000837815 workaround hardware exclusive transactions livelock
Date: Fri, 19 Jun 2015 15:25:26 +0530
Message-ID: <1434707726-32624-1-git-send-email-vgupta@synopsys.com>
References: <20150610110234.GH3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:39711 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753824AbbFSJzt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2015 05:55:49 -0400
In-Reply-To: <20150610110234.GH3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

A quad core SMP build could get into hardware livelock with concurrent
LLOCK/SCOND. Workaround that by adding a PREFETCHW which is serialized by
SCU (System Coherency Unit). It brings the cache line in Exclusive state
and makes others invalidate their lines. This gives enough time for
winner to complete the LLOCK/SCOND, before others can get the line back.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 20b7dc17979e..03484cb4d16d 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -23,13 +23,21 @@
 
 #define atomic_set(v, i) (((v)->counter) = (i))
 
+#ifdef CONFIG_ISA_ARCV2
+#define PREFETCHW	"	prefetchw   [%1]	\n"
+#else
+#define PREFETCHW
+#endif
+
 #define ATOMIC_OP(op, c_op, asm_op)					\
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned int temp;						\
 									\
 	__asm__ __volatile__(						\
-	"1:	llock   %0, [%1]	\n"				\
+	"1:				\n"				\
+	PREFETCHW							\
+	"	llock   %0, [%1]	\n"				\
 	"	" #asm_op " %0, %0, %2	\n"				\
 	"	scond   %0, [%1]	\n"				\
 	"	bnz     1b		\n"				\
@@ -50,7 +58,9 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	smp_mb();							\
 									\
 	__asm__ __volatile__(						\
-	"1:	llock   %0, [%1]	\n"				\
+	"1:				\n"				\
+	PREFETCHW							\
+	"	llock   %0, [%1]	\n"				\
 	"	" #asm_op " %0, %0, %2	\n"				\
 	"	scond   %0, [%1]	\n"				\
 	"	bnz     1b		\n"				\
-- 
1.9.1
