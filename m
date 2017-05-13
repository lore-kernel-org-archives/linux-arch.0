From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH] sched: remove sched_find_first_bit()
Date: Sat, 13 May 2017 04:01:52 +0300
Message-ID: <20170513010152.13986-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:24420
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756913AbdEMBCL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 May 2017 21:02:11 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>

sched_find_first_bit() is in fact the unrolled version of
find_first_bit(), which is theoretically faster in some cases.
But in the kernel it is called only in couple places in 
kernel/sched/rt.c, and both of them are not looking like hot
paths that will doubtly achieve measurable benefit from using
unrolled version of find_first_bit() - there's no hard loops,
and the execution path is not really short.

This patch removes sched_find_first_bit() and deletes
include/asm-generic/bitops/sched.h as it declares only this
function.  Alpha has it's own implementation, very similar to
generic one, so it is also removed.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/alpha/include/asm/bitops.h    | 18 ------------------
 arch/arc/include/asm/bitops.h      |  1 -
 arch/arm/include/asm/bitops.h      |  1 -
 arch/arm64/include/asm/bitops.h    |  1 -
 arch/blackfin/include/asm/bitops.h |  1 -
 arch/c6x/include/asm/bitops.h      |  1 -
 arch/cris/include/asm/bitops.h     |  2 --
 arch/frv/include/asm/bitops.h      |  1 -
 arch/h8300/include/asm/bitops.h    |  1 -
 arch/hexagon/include/asm/bitops.h  |  1 -
 arch/ia64/include/asm/bitops.h     |  2 --
 arch/m32r/include/asm/bitops.h     |  1 -
 arch/m68k/include/asm/bitops.h     |  1 -
 arch/metag/include/asm/bitops.h    |  1 -
 arch/mips/include/asm/bitops.h     |  2 --
 arch/mn10300/include/asm/bitops.h  |  1 -
 arch/openrisc/include/asm/bitops.h |  1 -
 arch/parisc/include/asm/bitops.h   |  1 -
 arch/powerpc/include/asm/bitops.h  |  2 --
 arch/s390/include/asm/bitops.h     |  1 -
 arch/sh/include/asm/bitops.h       |  1 -
 arch/sparc/include/asm/bitops_32.h |  1 -
 arch/sparc/include/asm/bitops_64.h |  1 -
 arch/tile/include/asm/bitops.h     |  1 -
 arch/x86/include/asm/bitops.h      |  2 --
 arch/xtensa/include/asm/bitops.h   |  1 -
 include/asm-generic/bitops.h       |  1 -
 include/asm-generic/bitops/sched.h | 31 -------------------------------
 kernel/sched/rt.c                  |  4 ++--
 29 files changed, 2 insertions(+), 82 deletions(-)
 delete mode 100644 include/asm-generic/bitops/sched.h

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index 4bdfbd444e63..9e4d5309c27f 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -433,24 +433,6 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 
 #ifdef __KERNEL__
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 100-bit bitmap.  It's guaranteed that at least
- * one of the 100 bits is cleared.
- */
-static inline unsigned long
-sched_find_first_bit(const unsigned long b[2])
-{
-	unsigned long b0, b1, ofs, tmp;
-
-	b0 = b[0];
-	b1 = b[1];
-	ofs = (b0 ? 0 : 64);
-	tmp = (b0 ? b0 : b1);
-
-	return __ffs(tmp) + ofs;
-}
-
 #include <asm-generic/bitops/le.h>
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 8da87feec59a..5db132568926 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -425,7 +425,6 @@ static inline __attribute__ ((const)) int __ffs(unsigned long x)
 
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/find.h>
diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index e943e6cee254..8498a8e3e76a 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -311,7 +311,6 @@ static inline unsigned long __ffs(unsigned long x)
 
 #include <asm-generic/bitops/fls64.h>
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
index 9c19594ce7cb..a3ca26e459e1 100644
--- a/arch/arm64/include/asm/bitops.h
+++ b/arch/arm64/include/asm/bitops.h
@@ -42,7 +42,6 @@ extern int test_and_change_bit(int nr, volatile unsigned long *p);
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/find.h>
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
diff --git a/arch/blackfin/include/asm/bitops.h b/arch/blackfin/include/asm/bitops.h
index b298b654a26f..6babd3ad7204 100644
--- a/arch/blackfin/include/asm/bitops.h
+++ b/arch/blackfin/include/asm/bitops.h
@@ -20,7 +20,6 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/const_hweight.h>
 #include <asm-generic/bitops/lock.h>
diff --git a/arch/c6x/include/asm/bitops.h b/arch/c6x/include/asm/bitops.h
index f0ab012401b6..d828299a8e3c 100644
--- a/arch/c6x/include/asm/bitops.h
+++ b/arch/c6x/include/asm/bitops.h
@@ -85,7 +85,6 @@ static inline int ffs(int x)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/find.h>
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
diff --git a/arch/cris/include/asm/bitops.h b/arch/cris/include/asm/bitops.h
index 8062cb52d343..e8b5d7ce010f 100644
--- a/arch/cris/include/asm/bitops.h
+++ b/arch/cris/include/asm/bitops.h
@@ -43,8 +43,6 @@
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 
-#include <asm-generic/bitops/sched.h>
-
 #endif /* __KERNEL__ */
 
 #endif /* _CRIS_BITOPS_H */
diff --git a/arch/frv/include/asm/bitops.h b/arch/frv/include/asm/bitops.h
index 0df8e95e3715..97e95cfc3f2d 100644
--- a/arch/frv/include/asm/bitops.h
+++ b/arch/frv/include/asm/bitops.h
@@ -312,7 +312,6 @@ int __ilog2_u64(u64 n)
 	return bit;
 }
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 
diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index 05999aba1d6a..e4121c8c1dea 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -170,7 +170,6 @@ static inline unsigned long __ffs(unsigned long word)
 }
 
 #include <asm-generic/bitops/find.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 5e4a59b3ec1b..56d75b58c080 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -288,7 +288,6 @@ static inline unsigned long __fls(unsigned long word)
 #include <asm-generic/bitops/find.h>
 
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 
 #include <asm-generic/bitops/le.h>
diff --git a/arch/ia64/include/asm/bitops.h b/arch/ia64/include/asm/bitops.h
index 71e8145243ee..231de1c39535 100644
--- a/arch/ia64/include/asm/bitops.h
+++ b/arch/ia64/include/asm/bitops.h
@@ -449,8 +449,6 @@ static __inline__ unsigned long __arch_hweight64(unsigned long x)
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 
-#include <asm-generic/bitops/sched.h>
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_IA64_BITOPS_H */
diff --git a/arch/m32r/include/asm/bitops.h b/arch/m32r/include/asm/bitops.h
index 86ba2b42a6cf..71779daf42f1 100644
--- a/arch/m32r/include/asm/bitops.h
+++ b/arch/m32r/include/asm/bitops.h
@@ -255,7 +255,6 @@ static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 
 #ifdef __KERNEL__
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index dda58cfe8c22..7a3584cc74d3 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -517,7 +517,6 @@ static inline int __fls(int x)
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/fls64.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
diff --git a/arch/metag/include/asm/bitops.h b/arch/metag/include/asm/bitops.h
index 2671134ee745..3cb18f94347d 100644
--- a/arch/metag/include/asm/bitops.h
+++ b/arch/metag/include/asm/bitops.h
@@ -119,7 +119,6 @@ static inline int test_and_change_bit(unsigned int bit,
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef12a46..b372fa86aced 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -606,8 +606,6 @@ static inline int ffs(int word)
 
 #ifdef __KERNEL__
 
-#include <asm-generic/bitops/sched.h>
-
 #include <asm/arch_hweight.h>
 #include <asm-generic/bitops/const_hweight.h>
 
diff --git a/arch/mn10300/include/asm/bitops.h b/arch/mn10300/include/asm/bitops.h
index fe6f8e2c3617..7f915010c7bc 100644
--- a/arch/mn10300/include/asm/bitops.h
+++ b/arch/mn10300/include/asm/bitops.h
@@ -223,7 +223,6 @@ int ffs(int x)
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/find.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/openrisc/include/asm/bitops.h b/arch/openrisc/include/asm/bitops.h
index 689f56819d53..8d8e87ad61d2 100644
--- a/arch/openrisc/include/asm/bitops.h
+++ b/arch/openrisc/include/asm/bitops.h
@@ -40,7 +40,6 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-#include <asm-generic/bitops/sched.h>
 #include <asm/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
index da87943328a5..8ba49ed73c4d 100644
--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h
@@ -218,7 +218,6 @@ static __inline__ int fls(int x)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-#include <asm-generic/bitops/sched.h>
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 33a24fdd7958..93af2bec3662 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -322,8 +322,6 @@ unsigned long __arch_hweight64(__u64 w);
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 
-#include <asm-generic/bitops/sched.h>
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_BITOPS_H */
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 99902b7b9f0c..1a8a78175b57 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -409,7 +409,6 @@ static inline int fls(int word)
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index a8699d60a8c4..cb9cd36490af 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -89,7 +89,6 @@ static inline unsigned long ffz(unsigned long word)
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
 #include <asm-generic/bitops/fls.h>
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
index 600ed1d9c8c8..acef3517eb79 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -92,7 +92,6 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/__ffs.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index 2d522402a937..994ab9413a7f 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -34,7 +34,6 @@ int ffs(int x);
 unsigned long __ffs(unsigned long);
 
 #include <asm-generic/bitops/ffz.h>
-#include <asm-generic/bitops/sched.h>
 
 /*
  * hweightN: returns the hamming weight (i.e. the number
diff --git a/arch/tile/include/asm/bitops.h b/arch/tile/include/asm/bitops.h
index 20caa346ac06..269ebad2efe6 100644
--- a/arch/tile/include/asm/bitops.h
+++ b/arch/tile/include/asm/bitops.h
@@ -87,7 +87,6 @@ static inline unsigned long __arch_hweight64(__u64 w)
 #include <asm-generic/bitops/const_hweight.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/find.h>
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/non-atomic.h>
 #include <asm-generic/bitops/le.h>
 
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 854022772c5b..2ca57cac13ae 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -508,8 +508,6 @@ static __always_inline int fls64(__u64 x)
 
 #include <asm-generic/bitops/find.h>
 
-#include <asm-generic/bitops/sched.h>
-
 #include <asm/arch_hweight.h>
 
 #include <asm-generic/bitops/const_hweight.h>
diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
index d3490189792b..c3ed220087cb 100644
--- a/arch/xtensa/include/asm/bitops.h
+++ b/arch/xtensa/include/asm/bitops.h
@@ -230,7 +230,6 @@ test_and_change_bit(unsigned int bit, volatile unsigned long *p)
 
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
-#include <asm-generic/bitops/sched.h>
 
 #endif	/* __KERNEL__ */
 
diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index dcdcacf2fd2b..47f9b0a23b9d 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -24,7 +24,6 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-#include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/lock.h>
diff --git a/include/asm-generic/bitops/sched.h b/include/asm-generic/bitops/sched.h
deleted file mode 100644
index 604fab7031a6..000000000000
--- a/include/asm-generic/bitops/sched.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef _ASM_GENERIC_BITOPS_SCHED_H_
-#define _ASM_GENERIC_BITOPS_SCHED_H_
-
-#include <linux/compiler.h>	/* unlikely() */
-#include <asm/types.h>
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 100-bit bitmap.  It's guaranteed that at least
- * one of the 100 bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#if BITS_PER_LONG == 64
-	if (b[0])
-		return __ffs(b[0]);
-	return __ffs(b[1]) + 64;
-#elif BITS_PER_LONG == 32
-	if (b[0])
-		return __ffs(b[0]);
-	if (b[1])
-		return __ffs(b[1]) + 32;
-	if (b[2])
-		return __ffs(b[2]) + 64;
-	return __ffs(b[3]) + 96;
-#else
-#error BITS_PER_LONG not defined
-#endif
-}
-
-#endif /* _ASM_GENERIC_BITOPS_SCHED_H_ */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 979b7341008a..f04346329204 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1092,7 +1092,7 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 			struct rt_prio_array *array = &rt_rq->active;
 
 			rt_rq->highest_prio.curr =
-				sched_find_first_bit(array->bitmap);
+				find_first_bit(array->bitmap, MAX_RT_PRIO);
 		}
 
 	} else
@@ -1496,7 +1496,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 	struct list_head *queue;
 	int idx;
 
-	idx = sched_find_first_bit(array->bitmap);
+	idx = find_first_bit(array->bitmap, MAX_RT_PRIO);
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
-- 
2.11.0
