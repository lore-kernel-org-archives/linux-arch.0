From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 02/15] qspinlock, x86: Enable x86-64 to use queue spinlock
Date: Mon,  6 Apr 2015 22:55:37 -0400
Message-ID: <1428375350-9213-3-git-send-email-Waiman.Long@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

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

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                      |    1 +
 arch/x86/include/asm/qspinlock.h      |   20 ++++++++++++++++++++
 arch/x86/include/asm/spinlock.h       |    5 +++++
 arch/x86/include/asm/spinlock_types.h |    4 ++++
 4 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/qspinlock.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b7d31ca..49fecb1 100644
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
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
new file mode 100644
index 0000000..222995b
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
+ * A smp_store_release() on the least-significant byte.
+ */
+static inline void queue_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release((u8 *)lock, 0);
+}
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_X86_QSPINLOCK_H */
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index cf87de3..a9c01fd 100644
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
@@ -196,6 +200,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 		cpu_relax();
 	}
 }
+#endif /* CONFIG_QUEUE_SPINLOCK */
 
 /*
  * Read-write spinlocks, allowing multiple readers
diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index 5f9d757..5d654a1 100644
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
 
-- 
1.7.1
