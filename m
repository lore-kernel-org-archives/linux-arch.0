From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/20] x86: Kill atomic_or_long()
Date: Thu, 08 May 2014 15:58:41 +0200
Message-ID: <20140508135851.768177189@infradead.org>
References: <20140508135840.956784204@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-kill-atomic_or_long.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

There are no users, kill it.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -219,21 +219,6 @@ static inline short int atomic_inc_short
 	return *v;
 }
 
-#ifdef CONFIG_X86_64
-/**
- * atomic_or_long - OR of two long integers
- * @v1: pointer to type unsigned long
- * @v2: pointer to type unsigned long
- *
- * Atomically ORs @v1 and @v2
- * Returns the result of the OR
- */
-static inline void atomic_or_long(unsigned long *v1, unsigned long v2)
-{
-	asm(LOCK_PREFIX "orq %1, %0" : "+m" (*v1) : "r" (v2));
-}
-#endif
-
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr)				\
 	asm volatile(LOCK_PREFIX "andl %0,%1"			\
