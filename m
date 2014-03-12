From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC v6 10/11] pvqspinlock,
	x86: Enable qspinlock PV support for KVM
Date: Wed, 12 Mar 2014 14:54:57 -0400
Message-ID: <1394650498-30118-11-git-send-email-Waiman.Long@hp.com>
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

This patch adds the necessary KVM specific code to allow KVM to support
the sleeping and CPU kicking operations needed by the queue spinlock PV
code.

A KVM guest of 20 CPU cores was created to run the disk workload of
the AIM7 benchmark on both ext4 and xfs RAM disks at 3000 users on a
3.14-rc6 based kernel. The JPM (jobs/minute) data of the test run were:

  kernel                        XFS FS  %change ext4 FS %change
  ------                        ------  ------- ------- -------
  PV ticketlock (baseline)      2409639    -    1289398    -
  qspinlock                     2396804  -0.5%  1285714  -0.3%
  PV qspinlock                  2380952  -1.2%  1266714  -1.8%
  unfair qspinlock              2403204  -0.3%  1503759   +17%
  unfair + PV qspinlock         2425876  +0.8%  1530612   +19%

The XFS test had moderate spinlock contention of 1.6% whereas the
ext4 test had heavy spinlock contention of 15.4% as reported by perf.

The PV code doesn't seem to help much in performance as the
sleeping/kicking logic wasn't activated during the test run as shown
by statistics data in the debugfs. The unfair lock, on the other hand,
did help to improve, especially the ext4 filesystem test.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/kernel/kvm.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.locks  |    2 +-
 2 files changed, 88 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f318e78..aaf704e 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -568,6 +568,7 @@ static void kvm_kick_cpu(int cpu)
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
 }
 
+#ifndef CONFIG_QUEUE_SPINLOCK
 enum kvm_contention_stat {
 	TAKEN_SLOW,
 	TAKEN_SLOW_PICKUP,
@@ -795,6 +796,87 @@ static void kvm_unlock_kick(struct arch_spinlock *lock, __ticket_t ticket)
 		}
 	}
 }
+#else /* !CONFIG_QUEUE_SPINLOCK */
+
+#ifdef CONFIG_KVM_DEBUG_FS
+static struct dentry *d_spin_debug;
+static struct dentry *d_kvm_debug;
+static u32 lh_kick_stats;	/* Lock holder kick count */
+static u32 qh_kick_stats;	/* Queue head kick count  */
+static u32 hibernate_stats;	/* Hibernation count	  */
+
+static int __init kvm_spinlock_debugfs(void)
+{
+	d_kvm_debug = debugfs_create_dir("kvm-guest", NULL);
+	if (!d_kvm_debug) {
+		printk(KERN_WARNING
+		       "Could not create 'kvm' debugfs directory\n");
+		return -ENOMEM;
+	}
+	d_spin_debug = debugfs_create_dir("spinlocks", d_kvm_debug);
+
+	debugfs_create_u32("lh_kick_stats", 0644, d_spin_debug, &lh_kick_stats);
+	debugfs_create_u32("qh_kick_stats", 0644, d_spin_debug, &qh_kick_stats);
+	debugfs_create_u32("hibernate_stats",
+			   0644, d_spin_debug, &hibernate_stats);
+	return 0;
+}
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
+
+fs_initcall(kvm_spinlock_debugfs);
+
+#else /* CONFIG_KVM_DEBUG_FS */
+static inline void inc_kick_stats(enum pv_kick_type type)
+{
+}
+
+static inline void inc_hib_stats(void)
+{
+
+}
+#endif /* CONFIG_KVM_DEBUG_FS */
+
+static void kvm_kick_cpu_type(int cpu, enum pv_kick_type type)
+{
+	kvm_kick_cpu(cpu);
+	inc_kick_stats(type);
+}
+
+/*
+ * Halt the current CPU & release it back to the host
+ */
+static void kvm_hibernate(void)
+{
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+
+	inc_hib_stats();
+	/*
+	 * Make sure an interrupt handler can't upset things in a
+	 * partially setup state.
+	 */
+	local_irq_save(flags);
+	if (arch_irqs_disabled_flags(flags))
+		halt();
+	else
+		safe_halt();
+	local_irq_restore(flags);
+}
+#endif /* !CONFIG_QUEUE_SPINLOCK */
 
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
@@ -807,8 +889,13 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+	pv_lock_ops.kick_cpu = kvm_kick_cpu_type;
+	pv_lock_ops.hibernate = kvm_hibernate;
+#else
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
 	pv_lock_ops.unlock_kick = kvm_unlock_kick;
+#endif
 }
 
 static __init int kvm_spinlock_init_jump(void)
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index f185584..a70fdeb 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -229,4 +229,4 @@ config ARCH_USE_QUEUE_SPINLOCK
 
 config QUEUE_SPINLOCK
 	def_bool y if ARCH_USE_QUEUE_SPINLOCK
-	depends on SMP && !PARAVIRT_SPINLOCKS
+	depends on SMP && (!PARAVIRT_SPINLOCKS || !XEN)
-- 
1.7.1
