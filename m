Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902241B8F8;
	Tue, 28 Jul 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237421; cv=none; b=bGgkTHk4irp/UUWCke1kQqau26mZE8LXXkhu2m6wkudrifJ2uJOdSb2mA6jhhHfLe6y7utkiCg7fFehKP8enivTYIQ0ebGJJD4EzB1zu/Ky2UVDfgkM4nLETDB6wmnGrQc2lwCsYQHoNwCToiZdOJpcQf/Mv1DDwfsMqw0auyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237421; c=relaxed/simple;
	bh=Z7Qc2NcYtYt9kXB+gy+Ybj9A1mFMRthRE15p9KsYA2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/DAhAck/93F9Bed+cjNxeT3fZ0zC4EQlFSrnv566budW7ShLUIvpM+bsOVaiMhcZpzm4PQArUXZsNeJ0XpVXvWe1Y9+bvE4NcNnbCQvlI2YG+D1PVNz4myqzL9qm2xRdYo9kAIkrl420FkZq+8hDyOuhUCLFN8ywL+KQKJIr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=acCvhA+D; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="acCvhA+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1785236901;
	bh=TY0hPq1DZRY+oQjDvxLhEtkwszNy4loaKqn689w042k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=acCvhA+DUH9/IL5BtyczwSZ+lRbF0mTHcTf5yZzehWwcl/UKF3uCkKJprUAJooRsL
	 +E1MSkaxPjbSFUUfsOARQxxS0I79jSNWZtvypMpYo2doS9wRsfiyFfOB+Ry25zmPID
	 M3l4nDoOMtWc7/suDwSDxfVQ4mGy9wHcsFjPykMg=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 43E20E13B2;
	Tue, 28 Jul 2026 11:08:21 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:08:17 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 5/7] locking: Add contended_release tracepoint to
 qspinlock
Message-ID: <amiNocZ8olirlihI@shell.ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
 <5d7ea75ffe74a785e6b234ada9f23c6373d4b4c1.1777999826.git.d@ilvokhin.com>
 <20260513193342.GB2545104@noisy.programming.kicks-ass.net>
 <agXBb0ga_6HJrrnm@shell.ilvokhin.com>
 <20260603120811.GW3493090@noisy.programming.kicks-ass.net>
 <aiA3dzjKVq2_cpSY@shell.ilvokhin.com>
 <20260603142659.GW3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603142659.GW3102624@noisy.programming.kicks-ass.net>

On Wed, Jun 03, 2026 at 04:26:59PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 03, 2026 at 02:17:27PM +0000, Dmitry Ilvokhin wrote:
> 
> > > Something a little like so, which is completely untested, except to
> > > build kernel/locking/spinlock.o (with clang-23).
> > 
> > Thanks a lot for taking a look, Peter.
> > 
> > I like the static_call idea. It's truly zero cost on x86 (and, as you
> > note, even a byte smaller). The one caveat is that it relies on
> > HAVE_STATIC_CALL_INLINE to stay free. 
> > 
> > So my plan would be: static_call where HAVE_STATIC_CALL_INLINE is
> > available (x86), and a static branch fallback elsewhere, gated behind a
> > default-off config so it imposes nothing on arches/kernels that don't
> > opt in. I'm mostly interested in x86, but would like arm64 to work too,
> > which would use the fallback.
> 
> (i386 doesn't have STATIC_CALL_INLINE, but nobody cares about the
> performance on that target, so anything goes really ;-)
> 
> > 
> > Concretely:
> > 
> > 1. Split the sleepable-lock patches out and send them separately.
> >    They're independent of the static call work and look far less
> >    controversial.
> > 
> > 2. Convert the paravirt spinlock unlock to a static_call, as the
> >    foundation for the unlock tracepoint. I'm happy to take a stab at it.
> >    Let me know if you'd rather do it yourself.
> 
> Yeah, I think that patch as-is *should* work, but like said, I haven't
> even tried it, so it could be terribly broken :-)

Hello Peter,

I picked up your static_call() paravirt-spinlock draft and fixed it up
to where it boots. I think it stands on its own as a cleanup,
independent of the contended_release tracepoint it was meant to enable,
so I'd like to submit it for wider review.

On top of your draft:

- Fix the CONFIG_PARAVIRT_SPINLOCKS=n build.

- Pass @lock to the callee-save unlock. Without it the boot hungs under
  CONFIG_CALL_DEPTH_TRACKING.

- Teach __static_call_validate() about the inline unlock insn so the
  site can be re-validated after it's patched to the movb.

- Make the slowpath site module-safe: static_call_mod() +
  EXPORT_STATIC_CALL_TRAMP().

Boot tested native and as a KVM PV guest.

One important thing missing is your Signed-off-by. Is there any chance
you could provide one if you're happy with the result?

Let me know if you'd like to submit this patch yourself.

From b6a114c9cd7698115c78812115199087a6cd8276 Mon Sep 17 00:00:00 2001
From: Dmitry Ilvokhin <d@ilvokhin.com>
Date: Mon, 29 Jun 2026 09:46:05 -0700
Subject: [PATCH] x86/paravirt: Use static_call() for the paravirt spinlock ops

From: Peter Zijlstra <peterz@infradead.org>

queued_spin_lock_slowpath() and queued_spin_unlock() are dispatched
through pv_ops_lock via the paravirt-ops ALTERNATIVE machinery, which
picks the target (native inline store / hypervisor call) once at boot
and cannot change at runtime.

Convert both to static_call(). The site becomes a direct call patched in
place (one byte smaller), and on native the unlock still collapses to
the inline "movb $0, (%rdi)" store, so the fast path is unchanged.

Unlike the ALTERNATIVE mechanism, a static_call() target can also be
updated at runtime via static_call_update(). This is a prerequisite for
the contended_release tracepoint, which has to swap in a traced unlock
while the system is running.

Drop the now-unused
pv_ops_lock.{queued_spin_lock_slowpath,queued_spin_unlock} members and
the X86_FEATURE_PVUNLOCK feature bit. KVM, Xen and Hyper-V install their
backends with static_call_update(), and pv_is_native_spin_unlock() reads
the current target with static_call_query(). The native unlock is
emitted inline at the call site from __static_call_transform(),
mirroring the existing __static_call_return0 and __WARN_trap special
cases.

[ ilvokhin: fix PARAVIRT_SPINLOCKS=n build; teach
  __static_call_validate() about the inline unlock insn; make the
  slowpath site module-safe: static_call_mod() +
  EXPORT_STATIC_CALL_TRAMP(); pass @lock to the callee-save unlock,
  fixing a boot hang under CALL_DEPTH_TRACKING. Boot tested native + KVM
  PV guest. ]

Link: https://lore.kernel.org/all/20260603120811.GW3493090@noisy.programming.kicks-ass.net/
Co-developed-by: Dmitry Ilvokhin <d@ilvokhin.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 arch/x86/hyperv/hv_spinlock.c            |  4 ++--
 arch/x86/include/asm/cpufeatures.h       |  1 -
 arch/x86/include/asm/paravirt-spinlock.h | 19 +++++++++++------
 arch/x86/kernel/kvm.c                    |  5 ++---
 arch/x86/kernel/paravirt-spinlocks.c     | 12 +++++------
 arch/x86/kernel/static_call.c            | 27 ++++++++++++++++++++++++
 arch/x86/xen/spinlock.c                  |  5 ++---
 tools/arch/x86/include/asm/cpufeatures.h |  1 -
 8 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 210b494e4de0..6b4bdea18218 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -78,8 +78,8 @@ void __init hv_init_spinlocks(void)
 	pr_info("PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops_lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
 	pv_ops_lock.wait = hv_qlock_wait;
 	pv_ops_lock.kick = hv_qlock_kick;
 	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1b4a48bff18f..e41fe5c24841 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -225,7 +225,6 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
 
diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index 7beffcb08ed6..ff735830de4a 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_PARAVIRT_SPINLOCK_H
 
 #include <asm/paravirt_types.h>
+#include <linux/static_call_types.h>
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock_types.h>
@@ -11,9 +12,6 @@
 struct qspinlock;
 
 struct pv_lock_ops {
-	void (*queued_spin_lock_slowpath)(struct qspinlock *lock, u32 val);
-	struct paravirt_callee_save queued_spin_unlock;
-
 	void (*wait)(u8 *ptr, u8 val);
 	void (*kick)(int cpu);
 
@@ -26,20 +24,27 @@ extern struct pv_lock_ops pv_ops_lock;
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
 extern bool nopvspin;
 
+DECLARE_STATIC_CALL(queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
+DECLARE_STATIC_CALL(queued_spin_unlock, __raw_callee_save___native_queued_spin_unlock);
+
 static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 							 u32 val)
 {
-	PVOP_VCALL2(pv_ops_lock, queued_spin_lock_slowpath, lock, val);
+	static_call_mod(queued_spin_lock_slowpath)(lock, val);
 }
 
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	PVOP_ALT_VCALLEE1(pv_ops_lock, queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ")",
-			  ALT_NOT(X86_FEATURE_PVUNLOCK));
+	PVOP_CALL_ARGS;
+	__STATIC_CALL_MOD_ADDRESSABLE(queued_spin_unlock);
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(queued_spin_unlock)
+		      : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
+		      : PVOP_CALL_ARG1(lock)
+		      : "memory", "cc");
 }
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dcef84da304b..253c159c4abe 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1136,9 +1136,8 @@ void __init kvm_spinlock_init(void)
 	pr_info("PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops_lock.queued_spin_unlock =
-		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
 	pv_ops_lock.wait = kvm_wait;
 	pv_ops_lock.kick = kvm_kick_cpu;
 
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 95452444868f..ddc19dc28ba1 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -25,9 +25,14 @@ __visible void __native_queued_spin_unlock(struct qspinlock *lock)
 }
 PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
+DEFINE_STATIC_CALL(queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
+EXPORT_STATIC_CALL_TRAMP(queued_spin_lock_slowpath);
+DEFINE_STATIC_CALL(queued_spin_unlock, __raw_callee_save___native_queued_spin_unlock);
+EXPORT_STATIC_CALL_TRAMP(queued_spin_unlock);
+
 bool pv_is_native_spin_unlock(void)
 {
-	return pv_ops_lock.queued_spin_unlock.func ==
+	return static_call_query(queued_spin_unlock) ==
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
@@ -45,16 +50,11 @@ bool pv_is_native_vcpu_is_preempted(void)
 
 void __init paravirt_set_cap(void)
 {
-	if (!pv_is_native_spin_unlock())
-		setup_force_cpu_cap(X86_FEATURE_PVUNLOCK);
-
 	if (!pv_is_native_vcpu_is_preempted())
 		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
 }
 
 struct pv_lock_ops pv_ops_lock = {
-	.queued_spin_lock_slowpath	= native_queued_spin_lock_slowpath,
-	.queued_spin_unlock		= PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait				= paravirt_nop,
 	.kick				= paravirt_nop,
 	.vcpu_is_preempted		= PV_CALLEE_SAVE(__native_vcpu_is_preempted),
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 61592e41a6b1..bab9406e6d6a 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -4,6 +4,12 @@
 #include <linux/bug.h>
 #include <asm/text-patching.h>
 
+/* Declared locally to avoid pulling asm/paravirt-spinlock.h header. */
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+struct qspinlock;
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+#endif
+
 enum insn_type {
 	CALL = 0, /* site call */
 	NOP = 1,  /* site cond-call */
@@ -31,6 +37,17 @@ static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
  */
 static const u8 warninsn[] = { 0x67, 0x48, 0x0f, 0xb9, 0x3a };
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/*
+ * ds ds movb $0, (_ASM_ARG1)
+ */
+#ifdef CONFIG_64BIT
+static const u8 unlockinsn[] = { 0x3e, 0x3e, 0xc6, 0x07, 0x00 };
+#else
+static const u8 unlockinsn[] = { 0x3e, 0x3e, 0xc6, 0x00, 0x00 };
+#endif
+#endif
+
 static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
 {
 	u8 ret = 0;
@@ -78,6 +95,12 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 			emulate = code;
 			code = &warninsn;
 		}
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+		if (func == &__raw_callee_save___native_queued_spin_unlock) {
+			emulate = code;
+			code = &unlockinsn;
+		}
+#endif
 		break;
 
 	case NOP:
@@ -139,6 +162,10 @@ static void __static_call_validate(u8 *insn, bool tail, bool tramp)
 		    !memcmp(insn, xor5rax, 5) ||
 		    !memcmp(insn, warninsn, 5))
 			return;
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+		if (!memcmp(insn, unlockinsn, 5))
+			return;
+#endif
 	}
 
 	/*
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 83ac24ead289..f718e535ea7c 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -134,9 +134,8 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops_lock.queued_spin_unlock =
-		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
+	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
 	pv_ops_lock.wait = xen_qlock_wait;
 	pv_ops_lock.kick = xen_qlock_kick;
 	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 86d17b195e79..61541f042f74 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -225,7 +225,6 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
 
-- 
2.53.0-Meta

