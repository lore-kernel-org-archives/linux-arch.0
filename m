From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH RFC v5 6/8] pvqspinlock,
	x86: Rename paravirt_ticketlocks_enabled
Date: Wed, 26 Feb 2014 23:32:45 -0500
Message-ID: <1393475567-4453-7-git-send-email-Waiman.Long@hp.com>
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

This patch renames the paravirt_ticketlocks_enabled static key to a
more generic paravirt_spinlocks_enabled name.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/spinlock.h      |    4 ++--
 arch/x86/kernel/kvm.c                |    2 +-
 arch/x86/kernel/paravirt-spinlocks.c |    4 ++--
 arch/x86/xen/spinlock.c              |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 6e6de1f..283f2cf 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -40,7 +40,7 @@
 /* How long a lock should spin before we consider blocking */
 #define SPIN_THRESHOLD	(1 << 15)
 
-extern struct static_key paravirt_ticketlocks_enabled;
+extern struct static_key paravirt_spinlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
 #ifdef CONFIG_QUEUE_SPINLOCK
@@ -151,7 +151,7 @@ static inline void __ticket_unlock_slowpath(arch_spinlock_t *lock,
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	if (TICKET_SLOWPATH_FLAG &&
-	    static_key_false(&paravirt_ticketlocks_enabled)) {
+	    static_key_false(&paravirt_spinlocks_enabled)) {
 		arch_spinlock_t prev;
 
 		prev = *lock;
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a489140..f318e78 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -818,7 +818,7 @@ static __init int kvm_spinlock_init_jump(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return 0;
 
-	static_key_slow_inc(&paravirt_ticketlocks_enabled);
+	static_key_slow_inc(&paravirt_spinlocks_enabled);
 	printk(KERN_INFO "KVM setup paravirtual spinlock\n");
 
 	return 0;
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index a50032a..8c67cbe 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -17,8 +17,8 @@ struct pv_lock_ops pv_lock_ops = {
 };
 EXPORT_SYMBOL(pv_lock_ops);
 
-struct static_key paravirt_ticketlocks_enabled = STATIC_KEY_INIT_FALSE;
-EXPORT_SYMBOL(paravirt_ticketlocks_enabled);
+struct static_key paravirt_spinlocks_enabled = STATIC_KEY_INIT_FALSE;
+EXPORT_SYMBOL(paravirt_spinlocks_enabled);
 #endif
 
 #ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 581521c..06f4a64 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -290,7 +290,7 @@ static __init int xen_init_spinlocks_jump(void)
 	if (!xen_pvspin)
 		return 0;
 
-	static_key_slow_inc(&paravirt_ticketlocks_enabled);
+	static_key_slow_inc(&paravirt_spinlocks_enabled);
 	return 0;
 }
 early_initcall(xen_init_spinlocks_jump);
-- 
1.7.1
