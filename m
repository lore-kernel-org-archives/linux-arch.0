From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 07/15] qspinlock: Revert to test-and-set on hypervisors
Date: Mon,  6 Apr 2015 22:55:42 -0400
Message-ID: <1428375350-9213-8-git-send-email-Waiman.Long@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Waiman Long <Waiman.Long@hp.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

When we detect a hypervisor (!paravirt, see qspinlock paravirt support
patches), revert to a simple test-and-set lock to avoid the horrors
of queue preemption.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qspinlock.h |   14 ++++++++++++++
 include/asm-generic/qspinlock.h  |    7 +++++++
 kernel/locking/qspinlock.c       |    3 +++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 222995b..64c925e 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_X86_QSPINLOCK_H
 #define _ASM_X86_QSPINLOCK_H
 
+#include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
 
 #define	queue_spin_unlock queue_spin_unlock
@@ -15,6 +16,19 @@ static inline void queue_spin_unlock(struct qspinlock *lock)
 	smp_store_release((u8 *)lock, 0);
 }
 
+#define virt_queue_spin_lock virt_queue_spin_lock
+
+static inline bool virt_queue_spin_lock(struct qspinlock *lock)
+{
+	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+		return false;
+
+	while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0)
+		cpu_relax();
+
+	return true;
+}
+
 #include <asm-generic/qspinlock.h>
 
 #endif /* _ASM_X86_QSPINLOCK_H */
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 315d6dc..bcbbc5e 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -111,6 +111,13 @@ static inline void queue_spin_unlock_wait(struct qspinlock *lock)
 		cpu_relax();
 }
 
+#ifndef virt_queue_spin_lock
+static __always_inline bool virt_queue_spin_lock(struct qspinlock *lock)
+{
+	return false;
+}
+#endif
+
 /*
  * Initializier
  */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 99503ef..fc2e5ab 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -249,6 +249,9 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	if (virt_queue_spin_lock(lock))
+		return;
+
 	/*
 	 * wait for in-progress pending->locked hand-overs
 	 *
-- 
1.7.1
