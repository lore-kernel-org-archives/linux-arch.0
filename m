From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v6 03/11] qspinlock: More optimized code for
	smaller NR_CPUS
Date: Wed, 12 Mar 2014 14:54:50 -0400
Message-ID: <1394650498-30118-4-git-send-email-Waiman.Long@hp.com>
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

For architectures that support atomic operations on smaller 8 or
16 bits data types. It is possible to simplify the code and produce
slightly better optimized code at the expense of smaller number of
supported CPUs.

The qspinlock code can support up to a maximum of 4M-1 CPUs. With
less than 16K CPUs, it is possible to squeeze the queue code into a
2-byte short word which can be accessed directly as a 16-bit short
data type. This enables the simplification of the queue code exchange
portion of the slowpath code.

This patch introduces a new macro _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
which can now be defined in an architecture specific qspinlock.h header
file to indicate its support for smaller atomic operation data types.
This macro triggers the replacement of some of the generic functions
by more optimized versions.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/include/asm/qspinlock.h      |   14 ++++-
 include/asm-generic/qspinlock_types.h |    8 ++-
 kernel/locking/qspinlock.c            |  100 +++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 44cefee..acbe155 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -8,11 +8,23 @@
 #define _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
 
 /*
+ * As the qcode will be accessed as a 16-bit word, no offset is needed
+ */
+#define _QCODE_VAL_OFFSET	0
+
+/*
  * x86-64 specific queue spinlock union structure
+ * Besides the slock and lock fields, the other fields are only
+ * valid with less than 16K CPUs.
  */
 union arch_qspinlock {
 	struct qspinlock slock;
-	u8		 lock;	/* Lock bit	*/
+	struct {
+		u8  lock;	/* Lock bit	*/
+		u8  reserved;
+		u16 qcode;	/* Queue code	*/
+	};
+	u32 qlcode;		/* Complete lock word */
 };
 
 #define	queue_spin_unlock queue_spin_unlock
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index df981d0..3a02a9e 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -48,7 +48,13 @@ typedef struct qspinlock {
 	atomic_t	qlcode;	/* Lock + queue code */
 } arch_spinlock_t;
 
-#define _QCODE_OFFSET		8
+#if CONFIG_NR_CPUS >= (1 << 14)
+# define _Q_MANY_CPUS
+# define _QCODE_OFFSET	8
+#else
+# define _QCODE_OFFSET	16
+#endif
+
 #define _QSPINLOCK_LOCKED	1U
 #define	_QSPINLOCK_LOCK_MASK	0xff
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index f1a8102..52d3580 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -62,6 +62,10 @@
  * Bits 0-1 : queue node index (4 nodes)
  * Bits 2-23: CPU number + 1   (4M - 1 CPUs)
  *
+ * The 16-bit queue node code is divided into the following 2 fields:
+ * Bits 0-1 : queue node index (4 nodes)
+ * Bits 2-15: CPU number + 1   (16K - 1 CPUs)
+ *
  * A queue node code of 0 indicates that no one is waiting for the lock.
  * As the value 0 cannot be used as a valid CPU number. We need to add
  * 1 to it before putting it into the queue code.
@@ -93,6 +97,101 @@ struct qnode_set {
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode_set, qnset) = { { { 0 } }, 0 };
 
+/*
+ ************************************************************************
+ * The following optimized codes are for architectures that support:	*
+ *  1) Atomic byte and short data write					*
+ *  2) Byte and short data exchange and compare-exchange instructions	*
+ *									*
+ * For those architectures, their asm/qspinlock.h header file should	*
+ * define the followings in order to use the optimized codes.		*
+ *  1) The _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS macro			*
+ *  2) A "union arch_qspinlock" structure that include the individual	*
+ *     fields of the qspinlock structure, including:			*
+ *      o slock     - the qspinlock structure				*
+ *      o lock      - the lock byte					*
+ *      o qcode     - the queue node code				*
+ *      o qlcode    - the 32-bit qspinlock word				*
+ *									*
+ ************************************************************************
+ */
+#ifdef _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
+#ifndef _Q_MANY_CPUS
+/*
+ * With less than 16K CPUs, the following optimizations are possible with
+ * architectures that allows atomic 8/16 bit operations:
+ *  1) The 16-bit queue code can be accessed or modified directly as a
+ *     16-bit short value without disturbing the first 2 bytes.
+ */
+#define queue_encode_qcode(cpu, idx)	(((cpu) + 1) << 2 | (idx))
+
+#define queue_code_xchg queue_code_xchg
+/**
+ * queue_code_xchg - exchange a queue code value
+ * @lock : Pointer to queue spinlock structure
+ * @ocode: Old queue code in the lock [OUT]
+ * @ncode: New queue code to be exchanged
+ * Return: 0 is always returned
+ */
+static inline int queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	*ocode = xchg(&qlock->qcode, (u16)ncode);
+	return 0;
+}
+
+#define queue_spin_trylock_and_clr_qcode queue_spin_trylock_and_clr_qcode
+/**
+ * queue_spin_trylock_and_clr_qcode - Try to lock & clear qcode simultaneously
+ * @lock : Pointer to queue spinlock structure
+ * @qcode: The supposedly current qcode value
+ * Return: true if successful, false otherwise
+ */
+static inline int
+queue_spin_trylock_and_clr_qcode(struct qspinlock *lock, u32 qcode)
+{
+	qcode <<= _QCODE_OFFSET;
+	return atomic_cmpxchg(&lock->qlcode, qcode, _QSPINLOCK_LOCKED) == qcode;
+}
+
+#define queue_get_lock_qcode queue_get_lock_qcode
+/**
+ * queue_get_lock_qcode - get the lock & qcode values
+ * @lock  : Pointer to queue spinlock structure
+ * @qcode : Pointer to the returned qcode value
+ * @mycode: My qcode value
+ * Return : != 0 if lock is not available
+ *	     = 0 if lock is free
+ *
+ * It is considered locked when either the lock bit or the wait bit is set.
+ */
+static inline int
+queue_get_lock_qcode(struct qspinlock *lock, u32 *qcode, u32 mycode)
+{
+	u32 qlcode = (u32)atomic_read(&lock->qlcode);
+
+	*qcode = qlcode >> _QCODE_OFFSET;
+	return qlcode & _QSPINLOCK_LOCKED;
+}
+#endif /* _Q_MANY_CPUS */
+
+/**
+ * queue_spin_setlock - try to acquire the lock by setting the lock bit
+ * @lock: Pointer to queue spinlock structure
+ * Return: 1 if lock bit set successfully, 0 if failed
+ */
+static __always_inline int queue_spin_setlock(struct qspinlock *lock)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	return cmpxchg(&qlock->lock, 0, _QSPINLOCK_LOCKED) == 0;
+}
+#else /*  _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS  */
+/*
+ * Generic functions for architectures that do not support atomic
+ * byte or short data types.
+ */
 /**
  *_queue_spin_setlock - try to acquire the lock by setting the lock bit
  * @lock: Pointer to queue spinlock structure
@@ -107,6 +206,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
 			return 1;
 	return 0;
 }
+#endif /* _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS */
 
 /*
  ************************************************************************
-- 
1.7.1
