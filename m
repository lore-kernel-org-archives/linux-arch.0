Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45167 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbbCPNgG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 09:36:06 -0400
Message-ID: <20150316133111.891791423@infradead.org>
Date: Mon, 16 Mar 2015 14:16:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/9] qspinlock, x86: Enable x86-64 to use queue spinlock
References: <20150316131613.720617163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=waiman_long-qspinlock_x86-enable_x86-64_to_use_queue_spinlock.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150316131615.Zfazo4PeaMqgR-TaBjSModqZoSUYDWvc1gKtgaE5JNA@z>

From: Waiman Long <Waiman.Long@hp.com>

This patch makes the necessary changes at the x86 architecture
specific layer to enable the use of queue spinlock for x86-64. As
x86-32 machines are typically not multi-socket. The benefit of queue
spinlock may not be apparent. So queue spinlock is not enabled.

Currently, there is some incompatibilities between the para-virtualized
spinlock code (which hard-codes the use of ticket spinlock) and the
queue spinlock. Therefore, the use of queue spinlock is disabled when
the para-virtualized spinlock is enabled.

The arch/x86/include/asm/qspinlock.h header file includes some x86
specific optimization which will make the queue spinlock code perform
better than the generic implementation.

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
Link: http://lkml.kernel.org/r/1421784755-21945-3-git-send-email-Waiman.Long@hp.com
---
 arch/x86/Kconfig                      |    1 +
 arch/x86/include/asm/qspinlock.h      |   20 ++++++++++++++++++++
 arch/x86/include/asm/spinlock.h       |    5 +++++
 arch/x86/include/asm/spinlock_types.h |    4 ++++
 4 files changed, 30 insertions(+)
 create mode 100644 arch/x86/include/asm/qspinlock.h

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select MODULES_USE_ELF_RELA if X86_64
 	select CLONE_BACKWARDS if X86_32
 	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_QUEUE_SPINLOCK
 	select ARCH_USE_QUEUE_RWLOCK
 	select OLD_SIGSUSPEND3 if X86_32 || IA32_EMULATION
 	select OLD_SIGACTION if X86_32
--- /dev/null
+++ b/arch/x86/include/asm/qspinlock.h
@@ -0,0 +1,20 @@
+#ifndef _ASM_X86_QSPINLOCK_H
+#define _ASM_X86_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+
+#define	queue_spin_unlock queue_spin_unlock
+/**
+ * queue_spin_unlock - release a queue spinlock
+ * @lock : Pointer to queue spinlock structure
+ *
+ * An smp_store_release() on the least-significant byte.
+ */
+static inline void queue_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release((u8 *)lock, 0);
+}
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_X86_QSPINLOCK_H */
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -42,6 +42,10 @@
 extern struct static_key paravirt_ticketlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+#include <asm/qspinlock.h>
+#else
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 
 static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
@@ -196,6 +200,7 @@ static inline void arch_spin_unlock_wait
 		cpu_relax();
 	}
 }
+#endif /* CONFIG_QUEUE_SPINLOCK */
 
 /*
  * Read-write spinlocks, allowing multiple readers
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -23,6 +23,9 @@ typedef u32 __ticketpair_t;
 
 #define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+#include <asm-generic/qspinlock_types.h>
+#else
 typedef struct arch_spinlock {
 	union {
 		__ticketpair_t head_tail;
@@ -33,6 +36,7 @@ typedef struct arch_spinlock {
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ { 0 } }
+#endif /* CONFIG_QUEUE_SPINLOCK */
 
 #include <asm-generic/qrwlock_types.h>
 


