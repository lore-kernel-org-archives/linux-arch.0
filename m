From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/rtmutex: drop usage of __HAVE_ARCH_CMPXCHG
Date: Wed, 25 Feb 2015 18:56:13 +0100
Message-ID: <20150225175613.GE6823@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44762 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbBYR4X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 12:56:23 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-rt-users@vger.kernel.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org

The rtmutex code is the only user of __HAVE_ARCH_CMPXCHG and we have a few
other user of cmpxchg() which do not care about __HAVE_ARCH_CMPXCHG. This
define was first introduced in 23f78d4a0 ("[PATCH] pi-futex: rt mutex core")
which is v2.6.18. The generic cmpxchg was introduced later in 068fbad288
("Add cmpxchg_local to asm-generic for per cpu atomic operations") which is
v2.6.25.
Back then something was required to get rtmutex working with the fast
path on architectures without cmpxchg and this seems to be the result.
Please correct me if I'm wrong but this what I learn from git log.

It popped up recently on rt-users because ARM (v6+) does not define
__HAVE_ARCH_CMPXCHG (even that it implements it) which results in slower
locking performance in the fast path.
To put some numbers on it: preempt -RT, am335x, 10 loops of
100000 invocations of rt_spin_lock() + rt_spin_unlock() (time "total" is
the average of the 10 loops for the 100000 invocations, "loop" is
"total / 100000 * 1000"):

     cmpxchg |    slowpath used  ||    cmpxchg used
             |   total   | loop  ||   total    | loop
     --------|-----------|-------||------------|-------
     ARMv6   | 9129.4 us | 91 ns ||  3311.9 us |  33 ns
     generic | 9360.2 us | 94 ns || 10834.6 us | 108 ns
     ----------------------------||--------------------

Forcing it to generic cmpxchg() made things worse for the slowpath and
even worse in cmpxchg() path. It boils down to 14ns more per lock+unlock
in a cache hot loop so it might not be that much in real world.
The last test was a substitute for pre ARMv6 machine but then I was able
to perform the comparison on imx28 which is ARMv5 and therefore is
always is using the generic cmpxchg implementation. And the numbers:

              |   total     | loop
     -------- |-----------  |--------
     slowpath | 263937.2 us | 2639 ns
     cmpxchg  |  16934.2 us |  169 ns
     --------------------------------

The numbers are larger since the machine is slower in general. However,
letting rtmutex use cmpxchg() instead the slowpath seem to improve things.

Since from the ARM (tested on am335x + imx28) point of view always
using cmpxchg() in rt_mutex_lock() + rt_mutex_unlock() makes sense I
would drop the define.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

If this gets applied I would prepare a removal __HAVE_ARCH_CMPXCHG in
the architectures the way the ARCH maintainers prefer (all in one patch
or one per ARCH).

 include/asm-generic/cmpxchg.h | 3 ---
 kernel/locking/rtmutex.c      | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 811fb1e9b061..3766ab34aa45 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -86,9 +86,6 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 
 /*
  * Atomic compare and exchange.
- *
- * Do not define __HAVE_ARCH_CMPXCHG because we want to use it to check whether
- * a cmpxchg primitive faster than repeated local irq save/restore exists.
  */
 #include <asm-generic/cmpxchg-local.h>
 
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3059bc2f022d..4c1245943aca 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -70,10 +70,10 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
 }
 
 /*
- * We can speed up the acquire/release, if the architecture
- * supports cmpxchg and if there's no debugging state to be set up
+ * We can speed up the acquire/release, if there's no debugging state to be
+ * set up.
  */
-#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_RT_MUTEXES)
+#ifndef CONFIG_DEBUG_RT_MUTEXES
 # define rt_mutex_cmpxchg(l,c,n)	(cmpxchg(&l->owner, c, n) == c)
 static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {
-- 
2.1.4
