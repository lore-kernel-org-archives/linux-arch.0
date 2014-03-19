From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v7 03/11] qspinlock: More optimized code for smaller NR_CPUS
Date: Wed, 19 Mar 2014 16:14:01 -0400
Message-ID: <1395260049-30839-4-git-send-email-Waiman.Long@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
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
 include/asm-generic/qspinlock_types.h |   19 +++++-
 kernel/locking/qspinlock.c            |  100 +++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 4 deletions(-)

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
index fbfe898..5df2f53 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -33,17 +33,30 @@
 /*
  * The queue spinlock data structure - a 32-bit word
  *
- * The bits assignment are:
+ * For NR_CPUS >= 16K, the bits assignment are:
  *   Bit  0   : Set if locked
  *   Bits 1-7 : Not used
  *   Bits 8-31: Queue code
+ *
+ * For NR_CPUS < 16K, the bits assignment are:
+ *   Bit   0   : Set if locked
+ *   Bits  1-7 : Not used
+ *   Bits  8-15: Reserved for architecture specific optimization
+ *   Bits 16-31: Queue code
  */
 typedef struct qspinlock {
 	atomic_t	qlcode;	/* Lock + queue code */
 } arch_spinlock_t;
 
-#define _QCODE_OFFSET		8
+#if CONFIG_NR_CPUS >= (1 << 14)
+# define _Q_MANY_CPUS
+# define _QCODE_OFFSET		8
+# define _QLOCK_LOCK_MASK	0xff
+#else
+# define _QCODE_OFFSET		16
+# define _QLOCK_LOCK_MASK	0xffff
+#endif
+
 #define _QLOCK_LOCKED		1U
-#define	_QLOCK_LOCK_MASK	0xff
 
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index a3b9ed3..b093a97 100644
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
@@ -102,6 +106,101 @@ struct qnode_set {
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
+ * Return: NORMAL_EXIT is always returned
+ */
+static inline enum exitval
+queue_code_xchg(struct qspinlock *lock, u32 *ocode, u32 ncode)
+{
+	union arch_qspinlock *qlock = (union arch_qspinlock *)lock;
+
+	*ocode = xchg(&qlock->qcode, (u16)ncode);
+	return NORMAL_EXIT;
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
+	return atomic_cmpxchg(&lock->qlcode, qcode, _QLOCK_LOCKED) == qcode;
+}
+
+#define queue_get_lock_qcode queue_get_lock_qcode
+/**
+ * queue_get_lock_qcode - get the lock & qcode values
+ * @lock  : Pointer to queue spinlock structure
+ * @qcode : Pointer to the returned qcode value
+ * Return : != 0 if lock is not available
+ *	     = 0 if lock is free
+ *
+ * It is considered locked when either the lock bit or the wait bit is set.
+ */
+static inline int
+queue_get_lock_qcode(struct qspinlock *lock, u32 *qcode)
+{
+	u32 qlcode = (u32)atomic_read(&lock->qlcode);
+
+	*qcode = qlcode >> _QCODE_OFFSET;
+	return qlcode & _QLOCK_LOCK_MASK;
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
+	return cmpxchg(&qlock->lock, 0, _QLOCK_LOCKED) == 0;
+}
+#else /*  _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS  */
+/*
+ * Generic functions for architectures that do not support atomic
+ * byte or short data types.
+ */
 /**
  *_queue_spin_setlock - try to acquire the lock by setting the lock bit
  * @lock: Pointer to queue spinlock structure
@@ -116,6 +215,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
 			return 1;
 	return 0;
 }
+#endif /* _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS */
 
 /*
  ************************************************************************
-- 
1.7.1
