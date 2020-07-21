From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Tue, 21 Jul 2020 21:08:47 +1000
Message-ID: <1595327263.lk78cqolxm.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200708084106.GE597537@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Excerpts from Peter Zijlstra's message of July 8, 2020 6:41 pm:
> On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> Yes, powerpc could certainly get more performance out of the slow
>> paths, and then there are a few parameters to tune.
> 

Sorry for the delay, got bogged down and distracted by other things :(

> Can you clarify? The slow path is already in use on ARM64 which is weak,
> so I doubt there's superfluous serialization present. And Will spend a
> fair amount of time on making that thing guarantee forward progressm, so
> there just isn't too much room to play.

Sure, the way the pending not-queued slowpath (which I guess is the
medium-path) is implemented is just poorly structured for LL/SC. It
has one more atomic than necessary (queued_fetch_set_pending_acquire),
and a lot of branches in suboptimal order.

Attached patch (completely untested just compiled and looked at asm
so far) is a way we can fix this on powerpc I think. It's actually
very little generic code change which is good, duplicated medium-path
logic unfortunately but that's no worse than something like x86
really.

>> We don't have a good alternate patching for function calls yet, but
>> that would be something to do for native vs pv.
> 
> Going by your jump_label implementation, support for static_call should
> be fairly straight forward too, no?
> 
>   https://lkml.kernel.org/r/20200624153024.794671356@infradead.org

Nice, yeah it should be. I've wanted this for ages!

powerpc is kind of annoying to implement that with limited call range,
Hmm, not sure if we'd need a new linker feature to support it. We'd
provide call site patch space for indirect branches for those out of
range of direct call, so that should work fine. The trick would be 
patching in the TOC lookup for the function... should be doable somehow.

Thanks,
Nick

---

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index b752d34517b3..26d8766a1106 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -31,16 +31,57 @@ static inline void queued_spin_unlock(struct qspinlock *lock)
 
 #else
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
 #endif
 
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val = 0;
-
-	if (likely(atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
+	atomic_t *a = &lock->val;
+	u32 val;
+
+again:
+	asm volatile(
+"1:\t"	PPC_LWARX(%0,0,%1,1) "	# queued_spin_lock			\n"
+	: "=&r" (val)
+	: "r" (&a->counter)
+	: "memory");
+
+	if (likely(val == 0)) {
+		asm_volatile_goto(
+	"	stwcx.	%0,0,%1							\n"
+	"	bne-	%l[again]						\n"
+	"\t"	PPC_ACQUIRE_BARRIER "						\n"
+		:
+		: "r"(_Q_LOCKED_VAL), "r" (&a->counter)
+		: "cr0", "memory"
+		: again );
 		return;
-
-	queued_spin_lock_slowpath(lock, val);
+	}
+
+	if (likely(val == _Q_LOCKED_VAL)) {
+		asm_volatile_goto(
+	"	stwcx.	%0,0,%1							\n"
+	"	bne-	%l[again]						\n"
+		:
+		: "r"(_Q_LOCKED_VAL | _Q_PENDING_VAL), "r" (&a->counter)
+		: "cr0", "memory"
+		: again );
+
+		atomic_cond_read_acquire(a, !(VAL & _Q_LOCKED_MASK));
+//		clear_pending_set_locked(lock);
+		WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+//		lockevent_inc(lock_pending);
+		return;
+	}
+
+	if (val == _Q_PENDING_VAL) {
+		int cnt = _Q_PENDING_LOOPS;
+		val = atomic_cond_read_relaxed(a,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
+		if (!(val & ~_Q_LOCKED_MASK))
+			goto again;
+        }
+	queued_spin_lock_slowpath_queue(lock);
 }
 #define queued_spin_lock queued_spin_lock
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index b9515fcc9b29..ebcc6f5d99d5 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -287,10 +287,14 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
+#define queued_spin_lock_slowpath_queue	native_queued_spin_lock_slowpath_queue
 #endif
 
 #endif /* _GEN_PV_LOCK_SLOWPATH */
 
+void queued_spin_lock_slowpath_queue(struct qspinlock *lock);
+static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock);
+
 /**
  * queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -314,12 +318,6 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  */
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
-	struct mcs_spinlock *prev, *next, *node;
-	u32 old, tail;
-	int idx;
-
-	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
-
 	if (pv_enabled())
 		goto pv_queue;
 
@@ -397,6 +395,26 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 queue:
 	lockevent_inc(lock_slowpath);
 pv_queue:
+	__queued_spin_lock_slowpath_queue(lock);
+}
+EXPORT_SYMBOL(queued_spin_lock_slowpath);
+
+void queued_spin_lock_slowpath_queue(struct qspinlock *lock)
+{
+	lockevent_inc(lock_slowpath);
+	__queued_spin_lock_slowpath_queue(lock);
+}
+EXPORT_SYMBOL(queued_spin_lock_slowpath_queue);
+
+static void __queued_spin_lock_slowpath_queue(struct qspinlock *lock)
+{
+	struct mcs_spinlock *prev, *next, *node;
+	u32 old, tail;
+	u32 val;
+	int idx;
+
+	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
+
 	node = this_cpu_ptr(&qnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
@@ -559,7 +577,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
 }
-EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 /*
  * Generate the paravirt code for queued_spin_unlock_slowpath().
