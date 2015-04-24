From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 10/14] pvqspinlock, x86: Enable PV qspinlock for KVM
Date: Fri, 24 Apr 2015 14:56:39 -0400
Message-ID: <1429901803-29771-11-git-send-email-Waiman.Long@hp.com>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

This patch adds the necessary KVM specific code to allow KVM to
support the CPU halting and kicking operations needed by the queue
spinlock PV code.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/kernel/kvm.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.locks  |    2 +-
 2 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index e354cc6..4bb42c0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -584,6 +584,39 @@ static void kvm_kick_cpu(int cpu)
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
 }
 
+
+#ifdef CONFIG_QUEUE_SPINLOCK
+
+#include <asm/qspinlock.h>
+
+static void kvm_wait(u8 *ptr, u8 val)
+{
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+
+	local_irq_save(flags);
+
+	if (READ_ONCE(*ptr) != val)
+		goto out;
+
+	/*
+	 * halt until it's our turn and kicked. Note that we do safe halt
+	 * for irq enabled case to avoid hang when lock info is overwritten
+	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
+	 */
+	if (arch_irqs_disabled_flags(flags))
+		halt();
+	else
+		safe_halt();
+
+out:
+	local_irq_restore(flags);
+}
+
+#else /* !CONFIG_QUEUE_SPINLOCK */
+
 enum kvm_contention_stat {
 	TAKEN_SLOW,
 	TAKEN_SLOW_PICKUP,
@@ -817,6 +850,8 @@ static void kvm_unlock_kick(struct arch_spinlock *lock, __ticket_t ticket)
 	}
 }
 
+#endif /* !CONFIG_QUEUE_SPINLOCK */
+
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
  */
@@ -828,8 +863,16 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+	__pv_init_lock_hash();
+	pv_lock_ops.queue_spin_lock_slowpath = __pv_queue_spin_lock_slowpath;
+	pv_lock_ops.queue_spin_unlock = PV_CALLEE_SAVE(__pv_queue_spin_unlock);
+	pv_lock_ops.wait = kvm_wait;
+	pv_lock_ops.kick = kvm_kick_cpu;
+#else /* !CONFIG_QUEUE_SPINLOCK */
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
 	pv_lock_ops.unlock_kick = kvm_unlock_kick;
+#endif
 }
 
 static __init int kvm_spinlock_init_jump(void)
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index c6a8f7c..537b13e 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -240,7 +240,7 @@ config ARCH_USE_QUEUE_SPINLOCK
 
 config QUEUE_SPINLOCK
 	def_bool y if ARCH_USE_QUEUE_SPINLOCK
-	depends on SMP && !PARAVIRT_SPINLOCKS
+	depends on SMP && (!PARAVIRT_SPINLOCKS || !XEN)
 
 config ARCH_USE_QUEUE_RWLOCK
 	bool
-- 
1.7.1
