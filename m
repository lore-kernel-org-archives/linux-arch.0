Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43064 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbbCPNf4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2015 09:35:56 -0400
Message-ID: <20150316133112.333845162@infradead.org>
Date: Mon, 16 Mar 2015 14:16:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 9/9] qspinlock,x86,kvm: Implement KVM support for paravirt qspinlock
References: <20150316131613.720617163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-qspinlock-paravirt-x86-crap.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman.Long@hp.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150316131622.tPjL-a1b_GL9QJuc9HGbN3AvDV40eoKkIuHMy6a_zS0@z>

Implement the paravirt qspinlock for x86-kvm.

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
---
 arch/x86/Kconfig                      |    2 -
 arch/x86/include/asm/paravirt.h       |   28 ++++++++++++++++++++-
 arch/x86/include/asm/paravirt_types.h |   10 +++++++
 arch/x86/include/asm/qspinlock.h      |   22 ++++++++++++++++-
 arch/x86/kernel/kvm.c                 |   44 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/paravirt-spinlocks.c  |   24 +++++++++++++++++-
 arch/x86/kernel/paravirt_patch_32.c   |   22 +++++++++++++----
 arch/x86/kernel/paravirt_patch_64.c   |   22 +++++++++++++----
 kernel/Kconfig.locks                  |    2 -
 9 files changed, 163 insertions(+), 13 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -692,7 +692,7 @@ config PARAVIRT_DEBUG
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP
-	select UNINLINE_SPIN_UNLOCK
+	select UNINLINE_SPIN_UNLOCK if !QUEUE_SPINLOCK
 	---help---
 	  Paravirtualized spinlocks allow a pvops backend to replace the
 	  spinlock implementation with something virtualization-friendly
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -712,6 +712,30 @@ static inline void __set_fixmap(unsigned
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+
+static __always_inline void pv_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
@@ -724,7 +748,9 @@ static __always_inline void __ticket_unl
 	PVOP_VCALL2(pv_lock_ops.unlock_kick, lock, ticket);
 }
 
-#endif
+#endif /* CONFIG_QUEUE_SPINLOCK */
+
+#endif /* SMP && PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_X86_32
 #define PV_SAVE_REGS "pushl %ecx; pushl %edx;"
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
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -3,6 +3,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
+#include <asm/paravirt.h>
 
 #define	queue_spin_unlock queue_spin_unlock
 /**
@@ -11,11 +12,30 @@
  *
  * An smp_store_release() on the least-significant byte.
  */
-static inline void queue_spin_unlock(struct qspinlock *lock)
+static inline void native_queue_spin_unlock(struct qspinlock *lock)
 {
 	smp_store_release((u8 *)lock, 0);
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val);
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
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -584,6 +584,41 @@ static void kvm_kick_cpu(int cpu)
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
 }
 
+
+#ifdef CONFIG_QUEUE_SPINLOCK
+
+#include <asm/qspinlock.h>
+
+PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);
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
@@ -817,6 +852,8 @@ static void kvm_unlock_kick(struct arch_
 	}
 }
 
+#endif /* !CONFIG_QUEUE_SPINLOCK */
+
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
  */
@@ -828,8 +865,15 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
+#ifdef CONFIG_QUEUE_SPINLOCK
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
 
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -12,6 +12,10 @@ DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %c
 DEF_NATIVE(pv_cpu_ops, clts, "clts");
 DEF_NATIVE(pv_cpu_ops, read_tsc, "rdtsc");
 
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUE_SPINLOCKS)
+DEF_NATIVE(pv_lock_ops, queue_spin_unlock, "movb $0, (%eax)");
+#endif
+
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
 {
 	/* arg in %eax, return in %eax */
@@ -24,6 +28,8 @@ unsigned paravirt_patch_ident_64(void *i
 	return 0;
 }
 
+extern bool pv_is_native_spin_unlock(void);
+
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
 {
@@ -47,14 +53,22 @@ unsigned native_patch(u8 type, u16 clobb
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
+	patch_site:
+		ret = paravirt_patch_insns(ibuf, len, start, end);
+		break;
 	}
 #undef PATCH_SITE
 	return ret;
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -21,6 +21,10 @@ DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs")
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUE_SPINLOCK)
+DEF_NATIVE(pv_lock_ops, queue_spin_unlock, "movb $0, (%rdi)");
+#endif
+
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
 {
 	return paravirt_patch_insns(insnbuf, len,
@@ -33,6 +37,8 @@ unsigned paravirt_patch_ident_64(void *i
 				    start__mov64, end__mov64);
 }
 
+extern bool pv_is_native_spin_unlock(void);
+
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
 {
@@ -59,14 +65,22 @@ unsigned native_patch(u8 type, u16 clobb
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
+	patch_site:
+		ret = paravirt_patch_insns(ibuf, len, start, end);
+		break;
 	}
 #undef PATCH_SITE
 	return ret;
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -240,7 +240,7 @@ config ARCH_USE_QUEUE_SPINLOCK
 
 config QUEUE_SPINLOCK
 	def_bool y if ARCH_USE_QUEUE_SPINLOCK
-	depends on SMP && !PARAVIRT_SPINLOCKS
+	depends on SMP
 
 config ARCH_USE_QUEUE_RWLOCK
 	bool


