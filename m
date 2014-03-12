From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v6 06/11] pvqspinlock,
	x86: Allow unfair queue spinlock in a KVM guest
Date: Wed, 12 Mar 2014 14:54:53 -0400
Message-ID: <1394650498-30118-7-git-send-email-Waiman.Long@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
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
