From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 7/9] qspinlock: Revert to test-and-set on
	hypervisors
Date: Mon, 16 Mar 2015 14:16:20 +0100
Message-ID: <20150316133112.211733056@infradead.org>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline;
	filename=peter_zijlstra-qspinlock-revert_to_test-and-set_on_hypervisors.patch
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Waiman.Long@hp.com
Cc: raghavendra.kt@linux.vnet.ibm.com, kvm@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, x86@kernel.org, mingo@redhat.com, doug.hatch@hp.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, scott.norton@hp.com, paolo.bonzini@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, oleg@redhat.com, luto@amacapital.net, david.vrabel@citrix.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When we detect a hypervisor (!paravirt, see qspinlock paravirt support
patches), revert to a simple test-and-set lock to avoid the horrors
of queue preemption.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Scott J Norton <scott.norton@hp.com>
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>
Cc: Douglas Hatch <doug.hatch@hp.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1421784755-21945-8-git-send-email-Waiman.Long@hp.com
---
 arch/x86/include/asm/qspinlock.h |   14 ++++++++++++++
 include/asm-generic/qspinlock.h  |    7 +++++++
 kernel/locking/qspinlock.c       |    3 +++
 3 files changed, 24 insertions(+)

--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_X86_QSPINLOCK_H
 #define _ASM_X86_QSPINLOCK_H
 
+#include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
 
 #define	queue_spin_unlock queue_spin_unlock
@@ -15,6 +16,19 @@ static inline void queue_spin_unlock(str
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
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -111,6 +111,13 @@ static inline void queue_spin_unlock_wai
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
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -259,6 +259,9 @@ void queue_spin_lock_slowpath(struct qsp
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	if (virt_queue_spin_lock(lock))
+		return;
+
 	/*
 	 * wait for in-progress pending->locked hand-overs
 	 *
