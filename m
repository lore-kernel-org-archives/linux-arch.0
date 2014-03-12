From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC v6 11/11] pvqspinlock,
	x86: Enable qspinlock PV support for XEN
Date: Wed, 12 Mar 2014 14:54:58 -0400
Message-ID: <1394650498-30118-12-git-send-email-Waiman.Long@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Scott J Norton <scott.norton@hp.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linu
List-Id: linux-arch.vger.kernel.org

This patch adds the necessary KVM specific code to allow XEN to support
the sleeping and CPU kicking operations needed by the queue spinlock PV
code.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/xen/spinlock.c |   95 ++++++++++++++++++++++++++++++++++++++++++++--
 kernel/Kconfig.locks    |    2 +-
 2 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 06f4a64..ae97c57 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -17,6 +17,12 @@
 #include "xen-ops.h"
 #include "debugfs.h"
 
+static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
+static DEFINE_PER_CPU(char *, irq_name);
+static bool xen_pvspin = true;
+
+#ifndef CONFIG_QUEUE_SPINLOCK
+
 enum xen_contention_stat {
 	TAKEN_SLOW,
 	TAKEN_SLOW_PICKUP,
@@ -100,12 +106,9 @@ struct xen_lock_waiting {
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
@@ -213,6 +216,78 @@ static void xen_unlock_kick(struct arch_spinlock *lock, __ticket_t next)
 	}
 }
 
+#else /* CONFIG_QUEUE_SPINLOCK */
+
+#ifdef CONFIG_XEN_DEBUG_FS
+static u32 lh_kick_stats;	/* Lock holder kick count */
+static u32 qh_kick_stats;	/* Queue head kick count  */
+static u32 hibernate_stats;	/* Hibernation count	  */
+
+static inline void inc_kick_stats(enum pv_kick_type type)
+{
+	if (type == PV_KICK_LOCK_HOLDER)
+		add_smp(&lh_kick_stats, 1);
+	else /* type == PV_KICK_QUEUE_HEAD */
+		add_smp(&qh_kick_stats, 1);
+}
+
+static inline void inc_hib_stats(void)
+{
+	add_smp(&hibernate_stats, 1);
+}
+#else /* CONFIG_XEN_DEBUG_FS */
+static inline void inc_kick_stats(enum pv_kick_type type)
+{
+}
+
+static inline void inc_hib_stats(void)
+{
+
+}
+#endif /* CONFIG_XEN_DEBUG_FS */
+
+static void xen_kick_cpu_type(int cpu, enum pv_kick_type type)
+{
+	xen_send_IPI_one(cpu, XEN_SPIN_UNLOCK_VECTOR);
+	inc_kick_stats(type);
+}
+
+/*
+ * Halt the current CPU & release it back to the host
+ */
+static void xen_hibernate(void)
+{
+	int irq = __this_cpu_read(lock_kicker_irq);
+	unsigned long flags;
+
+	/* If kicker interrupts not initialized yet, just spin */
+	if (irq == -1)
+		return;
+
+	/*
+	 * Make sure an interrupt handler can't upset things in a
+	 * partially setup state.
+	 */
+	local_irq_save(flags);
+
+	inc_hib_stats();
+	/* clear pending */
+	xen_clear_irq_pending(irq);
+
+	/* Allow interrupts while blocked */
+	local_irq_restore(flags);
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
+#endif /* CONFIG_QUEUE_SPINLOCK */
+
 static irqreturn_t dummy_handler(int irq, void *dev_id)
 {
 	BUG();
@@ -258,7 +333,6 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
-
 /*
  * Our init of PV spinlocks is split in two init functions due to us
  * using paravirt patching and jump labels patching and having to do
@@ -275,8 +349,13 @@ void __init xen_init_spinlocks(void)
 		return;
 	}
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+	pv_lock_ops.kick_cpu = xen_kick_cpu_type;
+        pv_lock_ops.hibernate = xen_hibernate;
+#else
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(xen_lock_spinning);
 	pv_lock_ops.unlock_kick = xen_unlock_kick;
+#endif
 }
 
 /*
@@ -318,6 +397,7 @@ static int __init xen_spinlock_debugfs(void)
 
 	d_spin_debug = debugfs_create_dir("spinlocks", d_xen);
 
+#ifndef CONFIG_QUEUE_SPINLOCK
 	debugfs_create_u8("zero_stats", 0644, d_spin_debug, &zero_stats);
 
 	debugfs_create_u32("taken_slow", 0444, d_spin_debug,
@@ -337,7 +417,12 @@ static int __init xen_spinlock_debugfs(void)
 
 	debugfs_create_u32_array("histo_blocked", 0444, d_spin_debug,
 				spinlock_stats.histo_spin_blocked, HISTO_BUCKETS + 1);
-
+#else /* CONFIG_QUEUE_SPINLOCK */
+	debugfs_create_u32("lh_kick_stats", 0644, d_spin_debug, &lh_kick_stats);
+	debugfs_create_u32("qh_kick_stats", 0644, d_spin_debug, &qh_kick_stats);
+	debugfs_create_u32("hibernate_stats",
+			   0644, d_spin_debug, &hibernate_stats);
+#endif /* CONFIG_QUEUE_SPINLOCK */
 	return 0;
 }
 fs_initcall(xen_spinlock_debugfs);
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index a70fdeb..451e392 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -229,4 +229,4 @@ config ARCH_USE_QUEUE_SPINLOCK
 
 config QUEUE_SPINLOCK
 	def_bool y if ARCH_USE_QUEUE_SPINLOCK
-	depends on SMP && (!PARAVIRT_SPINLOCKS || !XEN)
+	depends on SMP
-- 
1.7.1
