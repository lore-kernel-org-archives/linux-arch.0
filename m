From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 15/15] pvqspinlock: Add debug code to check
	for PV lock hash sanity
Date: Mon,  6 Apr 2015 22:55:50 -0400
Message-ID: <1428375350-9213-16-git-send-email-Waiman.Long@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
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

The current code for PV lock hash table processing will panic the
system if pv_hash_find() can't find the desired hash bucket. However,
there is no check to see if there is more than one entry for a given
lock which should never happen.

This patch adds a pv_hash_check_duplicate() function to do that which
will only be enabled if CONFIG_DEBUG_SPINLOCK is defined because of
the performance overhead it introduces.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 kernel/locking/qspinlock_paravirt.h |   58 +++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index a9fe10d..4d39c8b 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -107,6 +107,63 @@ static inline u32 hash_align(u32 hash)
 }
 
 /*
+ * Hash table debugging code
+ */
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+#define _NODE_IDX(pn)	((((unsigned long)pn) & (SMP_CACHE_BYTES - 1)) /\
+				sizeof(struct mcs_spinlock))
+/*
+ * Check if there is additional hash buckets with the same lock which
+ * should not happen.
+ */
+static inline void pv_hash_check_duplicate(struct qspinlock *lock)
+{
+	struct pv_hash_bucket *hb, *end, *hb1 = NULL;
+	int count = 0, used = 0;
+
+	end = &pv_lock_hash[1 << pv_lock_hash_bits];
+	for (hb = pv_lock_hash; hb < end; hb++) {
+		struct qspinlock *l = READ_ONCE(hb->lock);
+		struct pv_node *pn;
+
+		if (l)
+			used++;
+		if (l != lock)
+			continue;
+		if (++count == 1) {
+			hb1 = hb;
+			continue;
+		}
+		WARN_ON(count == 2);
+		if (hb1) {
+			pn = READ_ONCE(hb1->node);
+			printk(KERN_ERR "PV lock hash error: duplicated entry "
+			       "#%d - hash %ld, node %ld, cpu %d\n", 1,
+			       hb1 - pv_lock_hash, _NODE_IDX(pn),
+			       pn ? pn->cpu : -1);
+			hb1 = NULL;
+		}
+		pn = READ_ONCE(hb->node);
+		printk(KERN_ERR "PV lock hash error: duplicated entry #%d - "
+		       "hash %ld, node %ld, cpu %d\n", count, hb - pv_lock_hash,
+		       _NODE_IDX(pn), pn ? pn->cpu : -1);
+	}
+	/*
+	 * Warn if more than half of the buckets are used
+	 */
+	if (used > (1 << (pv_lock_hash_bits - 1)))
+		printk(KERN_WARNING "PV lock hash warning: "
+		       "%d hash entries used!\n", used);
+}
+
+#else /* CONFIG_DEBUG_SPINLOCK */
+
+static inline void pv_hash_check_duplicate(struct qspinlock *lock) {}
+
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
+/*
  * Set up an entry in the lock hash table
  * This is not inlined to reduce size of generated code as it is included
  * twice and is used only in the slowest path of handling CPU halting.
@@ -141,6 +198,7 @@ pv_hash(struct qspinlock *lock, struct pv_node *node)
 	}
 
 done:
+	pv_hash_check_duplicate(lock);
 	return &hb->lock;
 }
 
-- 
1.7.1
