From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 29/33] locking: Remove the deprecated atomic_{set,clear}_mask() functions
Date: Tue, 31 May 2016 12:19:54 +0200
Message-ID: <20160531102643.274182840@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-mask-kill.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

These functions have been deprecated for a while and there is only the
one user left, convert and kill.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic.h              |   10 ----------
 kernel/locking/qspinlock_paravirt.h |    4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -480,16 +480,6 @@ static inline int atomic_fetch_andnot_re
 }
 #endif
 
-static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_andnot(mask, v);
-}
-
-static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
-{
-	atomic_or(mask, v);
-}
-
 /**
  * atomic_inc_not_zero_hint - increment if not null
  * @v: pointer of type atomic_t
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -112,12 +112,12 @@ static __always_inline int trylock_clear
 #else /* _Q_PENDING_BITS == 8 */
 static __always_inline void set_pending(struct qspinlock *lock)
 {
-	atomic_set_mask(_Q_PENDING_VAL, &lock->val);
+	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
 static __always_inline void clear_pending(struct qspinlock *lock)
 {
-	atomic_clear_mask(_Q_PENDING_VAL, &lock->val);
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
 }
 
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
