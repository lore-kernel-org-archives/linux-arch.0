From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Date: Mon, 20 Aug 2018 09:26:39 -0700
Message-ID: <20180820162639.GC25153@bombadil.infradead.org>
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
 <20180820155002.GB25153@bombadil.infradead.org>
 <20180820155650.GG24082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180820155650.GG24082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 20, 2018 at 05:56:50PM +0200, Peter Zijlstra wrote:
> Yeah, _acquire should be retained; sorry about loosing that. I'm neck
> deep into tlb invalidate stuff and wrote this without much thinking
> involved.

NP.  Here's the current version I've got, with some updated likely()
hints.

From 337298a88266f7b21492f893c2bf05409a5392c8 Mon Sep 17 00:00:00 2001
From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 20 Aug 2018 10:19:14 -0400
Subject: [PATCH] locking: Remove an insn from spin and write locks

Both spin locks and write locks currently do:

 f0 0f b1 17             lock cmpxchg %edx,(%rdi)
 85 c0                   test   %eax,%eax
 75 05                   jne    [slowpath]

This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
appropriately.  Peter pointed out that using atomic_try_cmpxchg_acquire()
will let the compiler know this is true.  Comparing before/after
disassemblies show the only effect is to remove this insn.

Take this opportunity to make the spin & write lock code resemble each
other more closely and have similar likely() hints.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/asm-generic/qrwlock.h   |  7 ++++---
 include/asm-generic/qspinlock.h | 17 ++++++++++-------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 0f7062bd55e5..36254d2da8e0 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -71,8 +71,8 @@ static inline int queued_write_trylock(struct qrwlock *lock)
 	if (unlikely(cnts))
 		return 0;
 
-	return likely(atomic_cmpxchg_acquire(&lock->cnts,
-					     cnts, cnts | _QW_LOCKED) == cnts);
+	return likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts,
+				_QW_LOCKED));
 }
 /**
  * queued_read_lock - acquire read lock of a queue rwlock
@@ -96,8 +96,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
  */
 static inline void queued_write_lock(struct qrwlock *lock)
 {
+	u32 cnts = 0;
 	/* Optimize for the unfair lock case where the fair flag is 0. */
-	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
+	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
 		return;
 
 	queued_write_lock_slowpath(lock);
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 95263e943fcc..24e7915eee56 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -68,10 +68,14 @@ int queued_spin_is_contended(const struct qspinlock *lock)
  */
 static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
-	if (!atomic_read(&lock->val) &&
-	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
-		return 1;
-	return 0;
+	u32 val;
+
+	val = atomic_read(&lock->val);
+	if (unlikely(val))
+		return 0;
+
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
+				_Q_LOCKED_VAL));
 }
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
@@ -82,10 +86,9 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val;
+	u32 val = 0;
 
-	val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
-	if (likely(val == 0))
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 	queued_spin_lock_slowpath(lock, val);
 }
-- 
2.18.0
