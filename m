From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 09/14] pvqspinlock, x86: Implement the paravirt qspinlock call patching
Date: Fri, 24 Apr 2015 14:56:38 -0400
Message-ID: <1429901803-29771-10-git-send-email-Waiman.Long@hp.com>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Sender: kvm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Waiman Long <Waiman.Long@hp.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

We use the regular paravirt call patching to switch between:

  native_queue_spin_lock_slowpath()	__pv_queue_spin_lock_slowpath()
  native_queue_spin_unlock()		__pv_queue_spin_unlock()

We use a callee saved call for the unlock function which reduces the
i-cache footprint and allows 'inlining' of SPIN_UNLOCK functions
again.

We further optimize the unlock path by patching the direct call with a
"movb $0,%arg1" if we are indeed using the native unlock code. This
makes the unlock code almost as fast as the !PARAVIRT case.

This significantly lowers the overhead of having
CONFIG_PARAVIRT_SPINLOCKS enabled, even for native code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/x86/Kconfig                          |    2 +-
 arch/x86/include/asm/paravirt.h           |   29 ++++++++++++++++++++++++++++-
 arch/x86/include/asm/paravirt_types.h     |   10 ++++++++++
 arch/x86/include/asm/qspinlock.h          |   25 ++++++++++++++++++++++++-
 arch/x86/include/asm/qspinlock_paravirt.h |    6 ++++++
 arch/x86/kernel/paravirt-spinlocks.c      |   24 +++++++++++++++++++++++-
 arch/x86/kernel/paravirt_patch_32.c       |   22 ++++++++++++++++++----
 arch/x86/kernel/paravirt_patch_64.c       |   22 ++++++++++++++++++----
 8 files changed, 128 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/qspinlock_paravirt.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49fecb1..a0946e7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -661,7 +661,7 @@ config PARAVIRT_DEBUG
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP
-	select UNINLINE_SPIN_UNLOCK
+	select UNINLINE_SPIN_UNLOCK if !QUEUE_SPINLOCK
 	---help---
 	  Paravirtualized spinlocks allow a pvops backend to replace the
 	  spinlock implementation with something virtualization-friendly
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 965c47d..f76199a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -712,6 +712,31 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+
+static __always_inline void pv_queue_spin_lock_slowpath(struct qspinlock *lock,
+							u32 val)
+{
+	PVOP_VCALL2(pv_lock_ops.queue_spin_lock_slowpath, lock, val);
+}
+
+static __always_inline void pv_queue_spin_unlock(struct qspinlock *lock)
+{
+	PVOP_VCALLEE1(pv_lock_ops.queue_spin_unlock, lock);
+}
+
+static __always_inline void pv_wait(u8 *ptr, u8 val)
+{
+	PVOP_VCALL2(pv_lock_ops.wait, ptr, val);
+}
+
+static __always_inline void pv_kick(int cpu)
+{
+	PVOP_VCALL1(pv_lock_ops.kick, cpu);
+}
+
+#else /* !CONFIG_QUEUE_SPINLOCK */
+
 static __always_inline void __ticket_lock_spinning(struct arch_spinlock *lock,
 							__ticket_t ticket)
 {
@@ -724,7 +749,9 @@ static __always_inline void __ticket_unlock_kick(struct arch_spinlock *lock,
 	PVOP_VCALL2(pv_lock_ops.unlock_kick, lock, ticket);
 }
 
-#endif
+#endif /* CONFIG_QUEUE_SPINLOCK */
+
+#endif /* SMP && PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_X86_32
 #define PV_SAVE_REGS "pushl %ecx; pushl %edx;"
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 7549b8b..f6acaea 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -333,9 +333,19 @@ struct arch_spinlock;
 typedef u16 __ticket_t;
 #endif
 
+struct qspinlock;
+
 struct pv_lock_ops {
+#ifdef CONFIG_QUEUE_SPINLOCK
+	void (*queue_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
+	struct paravirt_callee_save queue_spin_unlock;
+
+	void (*wait)(u8 *ptr, u8 val);
+	void (*kick)(int cpu);
+#else /* !CONFIG_QUEUE_SPINLOCK */
 	struct paravirt_callee_save lock_spinning;
 	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
+#endif /* !CONFIG_QUEUE_SPINLOCK */
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 64c925e..c8290db 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -3,6 +3,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
+#include <asm/paravirt.h>
 
 #define	queue_spin_unlock queue_spin_unlock
 /**
@@ -11,11 +12,33 @@
  *
  * A smp_store_release() on the least-significant byte.
  */
-static inline void queue_spin_unlock(struct qspinlock *lock)
+static inline void native_queue_spin_unlock(struct qspinlock *lock)
 {
 	smp_store_release((u8 *)lock, 0);
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_init_lock_hash(void);
+extern void __pv_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __raw_callee_save___pv_queue_spin_unlock(struct qspinlock *lock);
+
+static inline void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	pv_queue_spin_lock_slowpath(lock, val);
+}
+
+static inline void queue_spin_unlock(struct qspinlock *lock)
+{
+	pv_queue_spin_unlock(lock);
+}
+#else
+static inline void queue_spin_unlock(struct qspinlock *lock)
+{
+	native_queue_spin_unlock(lock);
+}
+#endif
+
 #define virt_queue_spin_lock virt_queue_spin_lock
 
 static inline bool virt_queue_spin_lock(struct qspinlock *lock)
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
new file mode 100644
index 0000000..803ace5
--- /dev/null
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_QSPINLOCK_PARAVIRT_H
+#define __ASM_QSPINLOCK_PARAVIRT_H
+
+PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);
+
+#endif
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index bbb6c73..ff134b4 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -8,11 +8,33 @@
 
 #include <asm/paravirt.h>
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+__visible void __native_queue_spin_unlock(struct qspinlock *lock)
+{
+	native_queue_spin_unlock(lock);
+}
+
+PV_CALLEE_SAVE_REGS_THUNK(__native_queue_spin_unlock);
+
+bool pv_is_native_spin_unlock(void)
+{
+	return pv_lock_ops.queue_spin_unlock.func ==
+		__raw_callee_save___native_queue_spin_unlock;
+}
+#endif
+
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
+#ifdef CONFIG_QUEUE_SPINLOCK
+	.queue_spin_lock_slowpath = native_queue_spin_lock_slowpath,
+	.queue_spin_unlock = PV_CALLEE_SAVE(__native_queue_spin_unlock),
+	.wait = paravirt_nop,
+	.kick = paravirt_nop,
+#else /* !CONFIG_QUEUE_SPINLOCK */
 	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
 	.unlock_kick = paravirt_nop,
-#endif
+#endif /* !CONFIG_QUEUE_SPINLOCK */
+#endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
 
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d9f32e6..3169754 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -12,6 +12,10 @@ DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
 DEF_NATIVE(pv_cpu_ops, clts, "clts");
 DEF_NATIVE(pv_cpu_ops, read_tsc, "rdtsc");
 
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUE_SPINLOCKS)
+DEF_NATIVE(pv_lock_ops, queue_spin_unlock, "movb $0, (%eax)");
+#endif
+
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
 {
 	/* arg in %eax, return in %eax */
@@ -24,6 +28,8 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 	return 0;
 }
 
+extern bool pv_is_native_spin_unlock(void);
+
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
 {
@@ -47,14 +53,22 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_mmu_ops, write_cr3);
 		PATCH_SITE(pv_cpu_ops, clts);
 		PATCH_SITE(pv_cpu_ops, read_tsc);
-
-	patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
-		break;
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUE_SPINLOCKS)
+		case PARAVIRT_PATCH(pv_lock_ops.queue_spin_unlock):
+			if (pv_is_native_spin_unlock()) {
+				start = start_pv_lock_ops_queue_spin_unlock;
+				end   = end_pv_lock_ops_queue_spin_unlock;
+				goto patch_site;
+			}
+#endif
 
 	default:
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
+
+patch_site:
+		ret = paravirt_patch_insns(ibuf, len, start, end);
+		break;
 	}
 #undef PATCH_SITE
 	return ret;
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index a1da673..e2f3a33 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -21,6 +21,10 @@ DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUE_SPINLOCK)
+DEF_NATIVE(pv_lock_ops, queue_spin_unlock, "movb $0, (%rdi)");
+#endif
+
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
 {
 	return paravirt_patch_insns(insnbuf, len,
@@ -33,6 +37,8 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 				    start__mov64, end__mov64);
 }
 
+extern bool pv_is_native_spin_unlock(void);
+
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
 {
@@ -59,14 +65,22 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_cpu_ops, clts);
 		PATCH_SITE(pv_mmu_ops, flush_tlb_single);
 		PATCH_SITE(pv_cpu_ops, wbinvd);
-
-	patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
-		break;
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUE_SPINLOCK)
+		case PARAVIRT_PATCH(pv_lock_ops.queue_spin_unlock):
+			if (pv_is_native_spin_unlock()) {
+				start = start_pv_lock_ops_queue_spin_unlock;
+				end   = end_pv_lock_ops_queue_spin_unlock;
+				goto patch_site;
+			}
+#endif
 
 	default:
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
+
+patch_site:
+		ret = paravirt_patch_insns(ibuf, len, start, end);
+		break;
 	}
 #undef PATCH_SITE
 	return ret;
-- 
1.7.1

