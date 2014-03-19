From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v7 07/11] pvqspinlock,
	x86: Allow unfair queue spinlock in a XEN guest
Date: Wed, 19 Mar 2014 16:14:05 -0400
Message-ID: <1395260049-30839-8-git-send-email-Waiman.Long@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
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

This patch adds a XEN init function to activate the unfair queue
spinlock in a XEN guest when the PARAVIRT_UNFAIR_LOCKS kernel config
option is selected.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/xen/setup.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 0982233..66bb6f5 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -625,3 +625,22 @@ void __init xen_arch_setup(void)
 	numa_off = 1;
 #endif
 }
+
+#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
+/*
+ * Enable unfair lock if running in a Xen guest
+ */
+static __init int xen_unfair_locks_init_jump(void)
+{
+	/*
+	 * Disable unfair lock if not running in a PV domain
+	 */
+	if (!xen_pv_domain())
+		return 0;
+
+	static_key_slow_inc(&paravirt_unfairlocks_enabled);
+
+	return 0;
+}
+early_initcall(xen_unfair_locks_init_jump);
+#endif
-- 
1.7.1
