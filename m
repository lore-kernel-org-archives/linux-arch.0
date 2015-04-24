From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 11/14] pvqspinlock,
	x86: Enable PV qspinlock for Xen
Date: Fri, 24 Apr 2015 14:56:40 -0400
Message-ID: <1429901803-29771-12-git-send-email-Waiman.Long@hp.com>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

From: David Vrabel <david.vrabel@citrix.com>

This patch adds the necessary Xen specific code to allow Xen to
support the CPU halting and kicking operations needed by the queue
spinlock PV code.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/xen/spinlock.c |   64 ++++++++++++++++++++++++++++++++++++++++++++---
 kernel/Kconfig.locks    |    2 +-
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 956374c..3215ffc 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -17,6 +17,56 @@
 #include "xen-ops.h"
 #include "debugfs.h"
 
+static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
+static DEFINE_PER_CPU(char *, irq_name);
+static bool xen_pvspin = true;
+
+#ifdef CONFIG_QUEUE_SPINLOCK
+
+#include <asm/qspinlock.h>
+
+static void xen_qlock_kick(int cpu)
+{
+	xen_send_IPI_one(cpu, XEN_SPIN_UNLOCK_VECTOR);
+}
+
+/*
+ * Halt the current CPU & release it back to the host
+ */
+static void xen_qlock_wait(u8 *byte, u8 val)
+{
+	int irq = __this_cpu_read(lock_kicker_irq);
+
+	/* If kicker interrupts not initialized yet, just spin */
+	if (irq == -1)
+		return;
+
+	/* clear pending */
+	xen_clear_irq_pending(irq);
+	barrier();
+
+	/*
+	 * We check the byte value after clearing pending IRQ to make sure
+	 * that we won't miss a wakeup event because of the clearing.
+	 *
+	 * The sync_clear_bit() call in xen_clear_irq_pending() is atomic.
+	 * So it is effectively a memory barrier for x86.
+	 */
+	if (READ_ONCE(*byte) != val)
+		return;
+
+	/*
+	 * If an interrupt happens here, it will leave the wakeup irq
+	 * pending, which will cause xen_poll_irq() to return
+	 * immediately.
+	 */
+
+	/* Block until irq becomes pending (or perhaps a spurious wakeup) */
+	xen_poll_irq(irq);
+}
+
+#else /* CONFIG_QUEUE_SPINLOCK */
+
 enum xen_contention_stat {
 	TAKEN_SLOW,
 	TAKEN_SLOW_PICKUP,
@@ -100,12 +150,9 @@ struct xen_lock_waiting {
 	__ticket_t want;
 };
 
-static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
-static DEFINE_PER_CPU(char *, irq_name);
 static DEFINE_PER_CPU(struct xen_lock_waiting, lock_waiting);
 static cpumask_t waiting_cpus;
 
-static bool xen_pvspin = true;
 __visible void xen_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 {
 	int irq = __this_cpu_read(lock_kicker_irq);
@@ -217,6 +264,7 @@ static void xen_unlock_kick(struct arch_spinlock *lock, __ticket_t next)
 		}
 	}
 }
+#endif /* CONFIG_QUEUE_SPINLOCK */
 
 static irqreturn_t dummy_handler(int irq, void *dev_id)
 {
@@ -280,8 +328,16 @@ void __init xen_init_spinlocks(void)
 		return;
 	}
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
+#ifdef CONFIG_QUEUE_SPINLOCK
+	__pv_init_lock_hash();
+	pv_lock_ops.queue_spin_lock_slowpath = __pv_queue_spin_lock_slowpath;
+	pv_lock_ops.queue_spin_unlock = PV_CALLEE_SAVE(__pv_queue_spin_unlock);
+	pv_lock_ops.wait = xen_qlock_wait;
+	pv_lock_ops.kick = xen_qlock_kick;
+#else
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(xen_lock_spinning);
 	pv_lock_ops.unlock_kick = xen_unlock_kick;
+#endif
 }
 
 /*
@@ -310,7 +366,7 @@ static __init int xen_parse_nopvspin(char *arg)
 }
 early_param("xen_nopvspin", xen_parse_nopvspin);
 
-#ifdef CONFIG_XEN_DEBUG_FS
+#if defined(CONFIG_XEN_DEBUG_FS) && !defined(CONFIG_QUEUE_SPINLOCK)
 
 static struct dentry *d_spin_debug;
 
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 537b13e..0b42933 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -240,7 +240,7 @@ config ARCH_USE_QUEUE_SPINLOCK
 
 config QUEUE_SPINLOCK
 	def_bool y if ARCH_USE_QUEUE_SPINLOCK
-	depends on SMP && (!PARAVIRT_SPINLOCKS || !XEN)
+	depends on SMP
 
 config ARCH_USE_QUEUE_RWLOCK
 	bool
-- 
1.7.1
