From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 13/15] x86: Improve spinlocks using ISO C++11 intrinsic
 atomics
Date: Wed, 18 May 2016 16:12:15 +0100
Message-ID: <146358433517.8596.492761570975545534.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Make some improvements to the x86 spinlock implementation using the ISO
C++11 intrinsic atomic wrappers.  Note that since the spinlocks use
cmpxchg(), xadd() and __add(), it already makes some use of this.

 (1) Use acquire variants in spin_lock() and spin_trylock() paths.  On x86
     this shouldn't actually make a difference.

 (2) Use try_cmpxchg*() rather than cmpxchg*().  This should produce
     slightly more efficient code as a comparison can be discarded in
     favour of using the value in the Z flag.

Note as mentioned before, the LOCK prefix is currently mandatory, but a gcc
ticket is open to try and get these listed for suppression.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/qspinlock.h |    2 +-
 arch/x86/include/asm/spinlock.h  |   18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index eaba08076030..b56b8c2a9ed2 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -55,7 +55,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 	do {
 		while (atomic_read(&lock->val) != 0)
 			cpu_relax();
-	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+	} while (!atomic_try_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL));
 
 	return true;
 }
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index be0a05913b91..1cbddef2b3f3 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -81,7 +81,7 @@ static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock,
 		new.tickets.tail = old.tickets.tail;
 
 		/* try to clear slowpath flag when there are no contenders */
-		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
+		try_cmpxchg_acquire(&lock->head_tail, old.head_tail, new.head_tail);
 	}
 }
 
@@ -107,7 +107,7 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
 {
 	register struct __raw_tickets inc = { .tail = TICKET_LOCK_INC };
 
-	inc = xadd(&lock->tickets, inc);
+	inc = xadd_acquire(&lock->tickets, inc);
 	if (likely(inc.head == inc.tail))
 		goto out;
 
@@ -128,19 +128,21 @@ out:
 	barrier();	/* make sure nothing creeps before the lock is taken */
 }
 
-static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
+static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
 {
 	arch_spinlock_t old, new;
 
 	old.tickets = READ_ONCE(lock->tickets);
 	if (!__tickets_equal(old.tickets.head, old.tickets.tail))
-		return 0;
+		return false;
 
 	new.head_tail = old.head_tail + (TICKET_LOCK_INC << TICKET_SHIFT);
 	new.head_tail &= ~TICKET_SLOWPATH_FLAG;
 
-	/* cmpxchg is a full barrier, so nothing can move before it */
-	return cmpxchg(&lock->head_tail, old.head_tail, new.head_tail) == old.head_tail;
+	/* Insert an acquire barrier with the cmpxchg so that nothing
+	 * can move before it.
+	 */
+	return try_cmpxchg_acquire(&lock->head_tail, old.head_tail, new.head_tail);
 }
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
@@ -151,14 +153,14 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 
 		BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
 
-		head = xadd(&lock->tickets.head, TICKET_LOCK_INC);
+		head = xadd_release(&lock->tickets.head, TICKET_LOCK_INC);
 
 		if (unlikely(head & TICKET_SLOWPATH_FLAG)) {
 			head &= ~TICKET_SLOWPATH_FLAG;
 			__ticket_unlock_kick(lock, (head + TICKET_LOCK_INC));
 		}
 	} else
-		__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
+		add_release(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
 }
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
