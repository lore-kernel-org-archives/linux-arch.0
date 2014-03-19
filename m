From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 13/31] arch,hexagon: Convert smp_mb__*
Date: Wed, 19 Mar 2014 07:47:42 +0100
Message-ID: <20140319065204.474701877@infradead.org>
References: <20140319064729.660482086@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-hexagon-smp_mb__atomic.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Hexagon uses asm-gemeric/barrier.h and its smp_mb() is barrier().
Therefore we can use the default implementation that uses smp_mb().

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/hexagon/include/asm/atomic.h |    6 +-----
 arch/hexagon/include/asm/bitops.h |    4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -24,6 +24,7 @@
 
 #include <linux/types.h>
 #include <asm/cmpxchg.h>
+#include <asm/barrier.h>
 
 #define ATOMIC_INIT(i)		{ (i) }
 #define atomic_set(v, i)	((v)->counter = (i))
@@ -163,9 +164,4 @@ static inline int __atomic_add_unless(at
 #define atomic_inc_return(v) (atomic_add_return(1, v))
 #define atomic_dec_return(v) (atomic_sub_return(1, v))
 
-#define smp_mb__before_atomic_dec()	barrier()
-#define smp_mb__after_atomic_dec()	barrier()
-#define smp_mb__before_atomic_inc()	barrier()
-#define smp_mb__after_atomic_inc()	barrier()
-
 #endif
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -25,12 +25,10 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
+#include <asm/barrier.h>
 
 #ifdef __KERNEL__
 
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
-
 /*
  * The offset calculations for these are based on BITS_PER_LONG == 32
  * (i.e. I get to shift by #5-2 (32 bits per long, 4 bytes per access),
