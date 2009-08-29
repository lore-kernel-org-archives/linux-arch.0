From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/8] sparc: rename __spin_try_lock() and friends
Date: Sat, 29 Aug 2009 12:21:17 +0200
Message-ID: <20090829102155.053354161@de.ibm.com>
References: <20090829102115.638224800@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:41951 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbZH2KWD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2009 06:22:03 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate4.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7TALvml049928
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 10:21:57 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7TALvLs2904164
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 11:21:57 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7TALtWw001120
	for <linux-arch@vger.kernel.org>; Sat, 29 Aug 2009 11:21:57 +0100
Content-Disposition: inline; filename=sparc.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Rename __spin_try_trylock() and friends to arch_spin_try_lock() etc.

Needed to avoid namespace conflicts when the common code function
bodies of _spin_try_lock() etc. are moved to a header file where the
function name would be __spin_try_lock().

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/sparc/include/asm/spinlock_32.h |   12 ++++++------
 arch/sparc/include/asm/spinlock_64.h |   28 ++++++++++++++--------------
 2 files changed, 20 insertions(+), 20 deletions(-)

Index: linux-2.6/arch/sparc/include/asm/spinlock_32.h
===================================================================
--- linux-2.6.orig/arch/sparc/include/asm/spinlock_32.h
+++ linux-2.6/arch/sparc/include/asm/spinlock_32.h
@@ -76,7 +76,7 @@ static inline void __raw_spin_unlock(raw
  *
  * Unfortunately this scheme limits us to ~16,000,000 cpus.
  */
-static inline void __read_lock(raw_rwlock_t *rw)
+static inline void arch_read_lock(raw_rwlock_t *rw)
 {
 	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
@@ -92,11 +92,11 @@ static inline void __read_lock(raw_rwloc
 #define __raw_read_lock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	__read_lock(lock); \
+	arch_read_lock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
-static inline void __read_unlock(raw_rwlock_t *rw)
+static inline void arch_read_unlock(raw_rwlock_t *rw)
 {
 	register raw_rwlock_t *lp asm("g1");
 	lp = rw;
@@ -112,7 +112,7 @@ static inline void __read_unlock(raw_rwl
 #define __raw_read_unlock(lock) \
 do {	unsigned long flags; \
 	local_irq_save(flags); \
-	__read_unlock(lock); \
+	arch_read_unlock(lock); \
 	local_irq_restore(flags); \
 } while(0)
 
@@ -150,7 +150,7 @@ static inline int __raw_write_trylock(ra
 	return (val == 0);
 }
 
-static inline int __read_trylock(raw_rwlock_t *rw)
+static inline int arch_read_trylock(raw_rwlock_t *rw)
 {
 	register raw_rwlock_t *lp asm("g1");
 	register int res asm("o0");
@@ -169,7 +169,7 @@ static inline int __read_trylock(raw_rwl
 ({	unsigned long flags; \
 	int res; \
 	local_irq_save(flags); \
-	res = __read_trylock(lock); \
+	res = arch_read_trylock(lock); \
 	local_irq_restore(flags); \
 	res; \
 })
Index: linux-2.6/arch/sparc/include/asm/spinlock_64.h
===================================================================
--- linux-2.6.orig/arch/sparc/include/asm/spinlock_64.h
+++ linux-2.6/arch/sparc/include/asm/spinlock_64.h
@@ -92,7 +92,7 @@ static inline void __raw_spin_lock_flags
 
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
 
-static void inline __read_lock(raw_rwlock_t *lock)
+static void inline arch_read_lock(raw_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -115,7 +115,7 @@ static void inline __read_lock(raw_rwloc
 	: "memory");
 }
 
-static int inline __read_trylock(raw_rwlock_t *lock)
+static int inline arch_read_trylock(raw_rwlock_t *lock)
 {
 	int tmp1, tmp2;
 
@@ -136,7 +136,7 @@ static int inline __read_trylock(raw_rwl
 	return tmp1;
 }
 
-static void inline __read_unlock(raw_rwlock_t *lock)
+static void inline arch_read_unlock(raw_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -152,7 +152,7 @@ static void inline __read_unlock(raw_rwl
 	: "memory");
 }
 
-static void inline __write_lock(raw_rwlock_t *lock)
+static void inline arch_write_lock(raw_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2;
 
@@ -177,7 +177,7 @@ static void inline __write_lock(raw_rwlo
 	: "memory");
 }
 
-static void inline __write_unlock(raw_rwlock_t *lock)
+static void inline arch_write_unlock(raw_rwlock_t *lock)
 {
 	__asm__ __volatile__(
 "	stw		%%g0, [%0]"
@@ -186,7 +186,7 @@ static void inline __write_unlock(raw_rw
 	: "memory");
 }
 
-static int inline __write_trylock(raw_rwlock_t *lock)
+static int inline arch_write_trylock(raw_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2, result;
 
@@ -210,14 +210,14 @@ static int inline __write_trylock(raw_rw
 	return result;
 }
 
-#define __raw_read_lock(p)	__read_lock(p)
-#define __raw_read_lock_flags(p, f) __read_lock(p)
-#define __raw_read_trylock(p)	__read_trylock(p)
-#define __raw_read_unlock(p)	__read_unlock(p)
-#define __raw_write_lock(p)	__write_lock(p)
-#define __raw_write_lock_flags(p, f) __write_lock(p)
-#define __raw_write_unlock(p)	__write_unlock(p)
-#define __raw_write_trylock(p)	__write_trylock(p)
+#define __raw_read_lock(p)	arch_read_lock(p)
+#define __raw_read_lock_flags(p, f) arch_read_lock(p)
+#define __raw_read_trylock(p)	arch_read_trylock(p)
+#define __raw_read_unlock(p)	arch_read_unlock(p)
+#define __raw_write_lock(p)	arch_write_lock(p)
+#define __raw_write_lock_flags(p, f) arch_write_lock(p)
+#define __raw_write_unlock(p)	arch_write_unlock(p)
+#define __raw_write_trylock(p)	arch_write_trylock(p)
 
 #define __raw_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
 #define __raw_write_can_lock(rw)	(!(rw)->lock)

-- 
