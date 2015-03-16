Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45165 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbbCPNgG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 09:36:06 -0400
Message-ID: <20150316133112.211733056@infradead.org>
Date: Mon, 16 Mar 2015 14:16:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 7/9] qspinlock: Revert to test-and-set on hypervisors
References: <20150316131613.720617163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peter_zijlstra-qspinlock-revert_to_test-and-set_on_hypervisors.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150316131620.4IPKnd7t_dKvJaGwI7_YimNxr70VPSO49pKFpN5smYc@z>

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


