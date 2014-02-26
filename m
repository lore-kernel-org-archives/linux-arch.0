From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC v5 5/8] pvqspinlock,
	x86: Enable unfair queue spinlock in a KVM guest
Date: Wed, 26 Feb 2014 10:14:25 -0500
Message-ID: <1393427668-60228-6-git-send-email-Waiman.Long@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, x86@kernel.org, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Daniel J Blueman <daniel@numascale.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ke
List-Id: linux-arch.vger.kernel.org

This patch adds a KVM init function to activate the unfair queue
spinlock in a KVM guest when the PARAVIRT_UNFAIR_LOCKS kernel config
option is selected.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/kernel/kvm.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 713f1b3..a489140 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -826,3 +826,20 @@ static __init int kvm_spinlock_init_jump(void)
 early_initcall(kvm_spinlock_init_jump);
 
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
+
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+/*
+ * Enable unfair lock if running in a real para-virtualized environment
+ */
+static __init int kvm_unfair_locks_init_jump(void)
+{
+	if (!kvm_para_available())
+		return 0;
+
+	static_key_slow_inc(&paravirt_unfairlocks_enabled);
+	printk(KERN_INFO "KVM setup unfair spinlock\n");
+
+	return 0;
+}
+early_initcall(kvm_unfair_locks_init_jump);
+#endif
-- 
1.7.1
