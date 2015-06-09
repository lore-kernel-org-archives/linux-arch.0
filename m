From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 22/28] ARCv2: STAR 9000837815 workaround hardware exclusive transactions livelock
Date: Tue, 9 Jun 2015 17:18:22 +0530
Message-ID: <1433850508-26317-23-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 6fc968f78500..abaf222665e6 100644
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
@@ -46,7 +54,9 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
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
