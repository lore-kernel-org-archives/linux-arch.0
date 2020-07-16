From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/5] locking/qspinlock: Make qspinhlock store lock holder cpu number
Date: Thu, 16 Jul 2020 15:29:26 -0400
Message-ID: <20200716192927.12944-5-longman@redhat.com>
References: <20200716192927.12944-1-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716192927.12944-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

Make the qspinlock code to store an encoded cpu number (+2 saturated)
into the locked byte. The lock value of 1 is used by PV qspinlock to
signal that the PV unlock slowpath has to be called.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/qspinlock_paravirt.h | 42 +++++++++++------------
 include/asm-generic/qspinlock.h           | 10 ++++++
 include/asm-generic/qspinlock_types.h     |  2 +-
 kernel/locking/qspinlock_paravirt.h       |  7 ++--
 4 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 159622ee0674..82128803569c 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -12,7 +12,6 @@
 
 PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
 #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
-#define PV_UNLOCK		"__raw_callee_save___pv_queued_spin_unlock"
 #define PV_UNLOCK_SLOWPATH	"__raw_callee_save___pv_queued_spin_unlock_slowpath"
 
 /*
@@ -22,43 +21,44 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *
  * void __pv_queued_spin_unlock(struct qspinlock *lock)
  * {
- *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
+ *	const u8 lockval = _Q_LOCKED_VAL;
+ *	u8 locked = cmpxchg(&lock->locked, lockval, 0);
  *
- *	if (likely(lockval == _Q_LOCKED_VAL))
+ *	if (likely(locked == lockval))
  *		return;
- *	pv_queued_spin_unlock_slowpath(lock, lockval);
+ *	__pv_queued_spin_unlock_slowpath(lock, locked);
  * }
  *
  * For x86-64,
  *   rdi = lock              (first argument)
  *   rsi = lockval           (second argument)
- *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .text;"
-	".globl " PV_UNLOCK ";"
-	".type " PV_UNLOCK ", @function;"
-	".align 4,0x90;"
-	PV_UNLOCK ": "
-	FRAME_BEGIN
+__visible void notrace
+__raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	const u8 lockval = _Q_LOCKED_VAL;
+
+	asm volatile("or %0,%0" : : "a" (lockval));
+
+	asm volatile(
 	"push  %rdx;"
-	"mov   $0x1,%eax;"
-	"xor   %edx,%edx;"
-	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
-	"cmp   $0x1,%al;"
+	"push  %rcx;"
+	"xor   %ecx,%ecx;"
+	"mov   %eax,%edx;"
+	LOCK_PREFIX "cmpxchg %cl,(%rdi);"
+	"pop   %rcx;"
+	"cmp   %dl,%al;"
 	"jne   .slowpath;"
 	"pop   %rdx;"
 	FRAME_END
 	"ret;"
 	".slowpath: "
+	"pop    %rdx;"
 	"push   %rsi;"
 	"movzbl %al,%esi;"
 	"call " PV_UNLOCK_SLOWPATH ";"
-	"pop    %rsi;"
-	"pop    %rdx;"
-	FRAME_END
-	"ret;"
-	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
-	".popsection");
+	"pop    %rsi;");
+}
 
 #else /* CONFIG_64BIT */
 
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fde943d180e0..7003fcc94a43 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -12,6 +12,16 @@
 
 #include <asm-generic/qspinlock_types.h>
 
+/*
+ * If __cpu_number_sadd2 (+2 saturated cpu number) is defined, use it as the
+ * lock value. Otherwise, use 0xff instead. The lock value of 1 is reserved
+ * for PV qspinlock.
+ */
+#ifdef __cpu_number_sadd2
+#undef  _Q_LOCKED_VAL
+#define _Q_LOCKED_VAL		__cpu_number_sadd2
+#endif
+
 /**
  * queued_spin_is_locked - is the spinlock locked?
  * @lock: Pointer to queued spinlock structure
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 56d1309d32f8..f8b51bf42122 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -97,7 +97,7 @@ typedef struct qspinlock {
 #define _Q_TAIL_OFFSET		_Q_TAIL_IDX_OFFSET
 #define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
 
-#define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
+#define _Q_LOCKED_VAL		(255U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
 #endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index c8558876fc69..ffac1caabd7d 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -21,7 +21,7 @@
  * native_queued_spin_unlock().
  */
 
-#define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
+#define _Q_SLOW_VAL	(1U << _Q_LOCKED_OFFSET)
 
 /*
  * Queue Node Adaptive Spinning
@@ -552,9 +552,10 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	u8 locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
+	const u8 lockval = _Q_LOCKED_VAL;
+	u8 locked = cmpxchg_release(&lock->locked, lockval, 0);
 
-	if (likely(locked == _Q_LOCKED_VAL))
+	if (likely(locked == lockval))
 		return;
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);
-- 
2.18.1
