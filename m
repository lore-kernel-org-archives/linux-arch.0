From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 10/31] arch,c6x: Convert smp_mb__*
Date: Wed, 19 Mar 2014 07:47:39 +0100
Message-ID: <20140319065204.317916607@infradead.org>
References: <20140319064729.660482086@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-c6x-smp_mb__atomic.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

c6x doesn't have a barrier.h and completely relies on
asm-generic/barrier.h. Therefore its smp_mb() is barrier() and we can
use the default versions that are smp_mb().

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/c6x/include/asm/bitops.h |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/arch/c6x/include/asm/bitops.h
+++ b/arch/c6x/include/asm/bitops.h
@@ -14,14 +14,8 @@
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
-
 #include <asm/byteorder.h>
-
-/*
- * clear_bit() doesn't provide any barrier for the compiler.
- */
-#define smp_mb__before_clear_bit() barrier()
-#define smp_mb__after_clear_bit()  barrier()
+#include <asm/barrier.h>
 
 /*
  * We are lucky, DSP is perfect for bitops: do it in 3 cycles
