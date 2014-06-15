From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 08/11] qspinlock: Revert to test-and-set on hypervisors
Date: Sun, 15 Jun 2014 14:47:05 +0200
Message-ID: <20140615130153.940699466@chello.nl>
References: <20140615124657.264658593@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=peterz-qspinlock-test-and-set.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

When we detect a hypervisor (!paravirt, see later patches), revert to
a simple test-and-set lock to avoid the horrors of queue preemption.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
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
 
 #if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
@@ -20,6 +21,19 @@ static inline void queue_spin_unlock(str
 
 #endif /* !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE */
 
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
@@ -98,6 +98,13 @@ static __always_inline void queue_spin_u
 }
 #endif
 
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
@@ -247,6 +247,9 @@ void queue_spin_lock_slowpath(struct qsp
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	if (virt_queue_spin_lock(lock))
+		return;
+
 	/*
 	 * wait for in-progress pending->locked hand-overs
 	 *
