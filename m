From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC v5 4/8] pvqspinlock,
	x86: Allow unfair spinlock in a real PV environment
Date: Wed, 26 Feb 2014 23:32:43 -0500
Message-ID: <1393475567-4453-5-git-send-email-Waiman.Long@hp.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew
List-Id: linux-arch.vger.kernel.org

Locking is always an issue in a virtualized environment as the virtual
CPU that is waiting on a lock may get scheduled out and hence block
any progress in lock acquisition even when the lock has been freed.

One solution to this problem is to allow unfair lock in a
para-virtualized environment. In this case, a new lock acquirer can
come and steal the lock if the next-in-line CPU to get the lock is
scheduled out. Unfair lock in a native environment is generally not a
good idea as there is a possibility of lock starvation for a heavily
contended lock.

This patch add a new configuration option for the x86
architecture to enable the use of unfair queue spinlock
(PARAVIRT_UNFAIR_LOCKS) in a real para-virtualized guest. A jump label
(paravirt_unfairlocks_enabled) is used to switch between a fair and
an unfair version of the spinlock code. This jump label will only be
enabled in a real PV guest.

Enabling this configuration feature decreases the performance of an
uncontended lock-unlock operation by about 1-2%.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/Kconfig                     |   11 +++++
 arch/x86/include/asm/qspinlock.h     |   74 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/Makefile             |    1 +
 arch/x86/kernel/paravirt-spinlocks.c |    7 +++
 4 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5bf70ab..8d7c941 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -645,6 +645,17 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
+config PARAVIRT_UNFAIR_LOCKS
+	bool "Enable unfair locks in a para-virtualized guest"
+	depends on PARAVIRT && SMP && QUEUE_SPINLOCK
+	depends on !CONFIG_X86_OOSTORE && !CONFIG_X86_PPRO_FENCE
+	---help---
+	  This changes the kernel to use unfair locks in a real
+	  para-virtualized guest system. This will help performance
+	  in most cases. However, there is a possibility of lock
+	  starvation on a heavily contended lock especially in a
+	  large guest with many virtual CPUs.
+
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 98db42e..c278aed 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -56,4 +56,78 @@ static inline void queue_spin_unlock(struct qspinlock *lock)
 
 #include <asm-generic/qspinlock.h>
 
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+/**
+ * queue_spin_lock_unfair - acquire a queue spinlock unfairly
+ * @lock: Pointer to queue spinlock structure
+ */
+static __always_inline void queue_spin_lock_unfair(struct qspinlock *lock)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	if (likely(cmpxchg(&qlock->lock, 0, _QSPINLOCK_LOCKED) == 0))
+		return;
+	/*
+	 * Since the lock is now unfair, there is no need to activate
+	 * the 2-task quick spinning code path.
+	 */
+	queue_spin_lock_slowpath(lock, -1);
+}
+
+/**
+ * queue_spin_trylock_unfair - try to acquire the queue spinlock unfairly
+ * @lock : Pointer to queue spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static __always_inline int queue_spin_trylock_unfair(struct qspinlock *lock)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	if (!qlock->lock &&
+	   (cmpxchg(&qlock->lock, 0, _QSPINLOCK_LOCKED) == 0))
+		return 1;
+	return 0;
+}
+
+/*
+ * Redefine arch_spin_lock and arch_spin_trylock as inline functions that will
+ * jump to the unfair versions if the static key paravirt_unfairlocks_enabled
+ * is true.
+ */
+#undef arch_spin_lock
+#undef arch_spin_trylock
+#undef arch_spin_lock_flags
+
+extern struct static_key paravirt_unfairlocks_enabled;
+
+/**
+ * arch_spin_lock - acquire a queue spinlock
+ * @lock: Pointer to queue spinlock structure
+ */
+static inline void arch_spin_lock(struct qspinlock *lock)
+{
+	if (static_key_false(&paravirt_unfairlocks_enabled)) {
+		queue_spin_lock_unfair(lock);
+		return;
+	}
+	queue_spin_lock(lock);
+}
+
+/**
+ * arch_spin_trylock - try to acquire the queue spinlock
+ * @lock : Pointer to queue spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static inline int arch_spin_trylock(struct qspinlock *lock)
+{
+	if (static_key_false(&paravirt_unfairlocks_enabled)) {
+		return queue_spin_trylock_unfair(lock);
+	}
+	return queue_spin_trylock(lock);
+}
+
+#define arch_spin_lock_flags(l, f)	arch_spin_lock(l)
+
+#endif /* CONFIG_PARAVIRT_UNFAIR_LOCKS */
+
 #endif /* _ASM_X86_QSPINLOCK_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index cb648c8..1107a20 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_$(BITS).o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
+obj-$(CONFIG_PARAVIRT_UNFAIR_LOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index bbb6c73..a50032a 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -8,6 +8,7 @@
 
 #include <asm/paravirt.h>
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
 	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
@@ -18,3 +19,9 @@ EXPORT_SYMBOL(pv_lock_ops);
 
 struct static_key paravirt_ticketlocks_enabled = STATIC_KEY_INIT_FALSE;
 EXPORT_SYMBOL(paravirt_ticketlocks_enabled);
+#endif
+
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+struct static_key paravirt_unfairlocks_enabled = STATIC_KEY_INIT_FALSE;
+EXPORT_SYMBOL(paravirt_unfairlocks_enabled);
+#endif
-- 
1.7.1
