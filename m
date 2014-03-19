From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 24/31] arch,score: Convert smp_mb__*
Date: Wed, 19 Mar 2014 07:47:53 +0100
Message-ID: <20140319065205.060180266@infradead.org>
References: <20140319064729.660482086@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-score-smp_mb__atomic.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

score fully relies on asm-generic/barrier.h, so it can use its default
implementation.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/score/include/asm/bitops.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/arch/score/include/asm/bitops.h
+++ b/arch/score/include/asm/bitops.h
@@ -2,12 +2,7 @@
 #define _ASM_SCORE_BITOPS_H
 
 #include <asm/byteorder.h> /* swab32 */
-
-/*
- * clear_bit() doesn't provide any barrier for the compiler.
- */
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
+#include <asm/barrier.h>
 
 #include <asm-generic/bitops.h>
 #include <asm-generic/bitops/__fls.h>
