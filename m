From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v5 3/3] locking/qrwlock: Don't contend with readers when setting _QW_WAITING
Date: Fri, 19 Jun 2015 11:50:02 -0400
Message-ID: <1434729002-57724-4-git-send-email-Waiman.Long@hp.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:38052 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbFSPvF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2015 11:51:05 -0400
In-Reply-To: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

The current cmpxchg() loop in setting the _QW_WAITING flag for writers
in queue_write_lock_slowpath() will contend with incoming readers
causing possibly extra cmpxchg() operations that are wasteful. This
patch changes the code to do a byte cmpxchg() to eliminate contention
with new readers.

A multithreaded microbenchmark running 5M read_lock/write_lock loop
on a 8-socket 80-core Westmere-EX machine running 4.0 based kernel
with the qspinlock patch have the following execution times (in ms)
with and without the patch:

With R:W ratio = 5:1

	Threads	   w/o patch	with patch	% change
	-------	   ---------	----------	--------
	   2	     990 	    895		  -9.6%
	   3	    2136 	   1912		 -10.5%
	   4	    3166	   2830		 -10.6%
	   5	    3953	   3629		  -8.2%
	   6	    4628	   4405		  -4.8%
	   7	    5344	   5197		  -2.8%
	   8	    6065	   6004		  -1.0%
	   9	    6826	   6811		  -0.2%
	  10	    7599	   7599		   0.0%
	  15	    9757	   9766		  +0.1%
	  20	   13767	  13817		  +0.4%

With small number of contending threads, this patch can improve
locking performance by up to 10%. With more contending threads,
however, the gain diminishes.

With the extended qrwlock structure defined in asm-generic/qrwlock,
the queue_write_unlock() function is also simplified to a
smp_store_release() call.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qrwlock.h      |    3 +--
 include/asm-generic/qrwlock_types.h |   18 +++++++++++++++++-
 kernel/locking/qrwlock.c            |    6 ++----
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
index a8810bf..5678b0a 100644
--- a/arch/x86/include/asm/qrwlock.h
+++ b/arch/x86/include/asm/qrwlock.h
@@ -7,8 +7,7 @@
 #define queued_write_unlock queued_write_unlock
 static inline void queued_write_unlock(struct qrwlock *lock)
 {
-        barrier();
-        ACCESS_ONCE(*(u8 *)&lock->cnts) = 0;
+	smp_store_release(&lock->wmode, 0);
 }
 #endif
 
diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 4d76f24..d614cde 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -3,13 +3,29 @@
 
 #include <linux/types.h>
 #include <asm/spinlock_types.h>
+#include <asm/byteorder.h>
 
 /*
  * The queue read/write lock data structure
+ *
+ * The 32-bit count is divided into an 8-bit writer mode byte
+ * (least significant byte) and a 24-bit reader count.
+ *
  */
 
 typedef struct qrwlock {
-	atomic_t		cnts;
+	union {
+		atomic_t	cnts;
+		struct {
+#ifdef __LITTLE_ENDIAN
+			u8	wmode;		/* Writer mode  */
+			u8	rcnt[3];	/* Reader count */
+#else
+			u8	rcnt[3];	/* Reader count */
+			u8	wmode;		/* Writer mode  */
+#endif
+		};
+	};
 	arch_spinlock_t		lock;
 } arch_rwlock_t;
 
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 26ca0ca..a7ac2c5 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -108,10 +108,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	 * or wait for a previous writer to go away.
 	 */
 	for (;;) {
-		cnts = atomic_read(&lock->cnts);
-		if (!(cnts & _QW_WMASK) &&
-		    (atomic_cmpxchg(&lock->cnts, cnts,
-				    cnts | _QW_WAITING) == cnts))
+		if (!READ_ONCE(lock->wmode) &&
+		   (cmpxchg(&lock->wmode, 0, _QW_WAITING) == 0))
 			break;
 
 		cpu_relax_lowlatency();
-- 
1.7.1
