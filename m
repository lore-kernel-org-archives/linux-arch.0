From: Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Wed,  8 Feb 2017 13:00:24 -0500
Message-ID: <1486576825-17058-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Waiman Long <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

It was found when running fio sequential write test with a XFS ramdisk
on a 2-socket x86-64 system, the %CPU times as reported by perf were
as follows:

 71.27%  0.28%  fio  [k] down_write
 70.99%  0.01%  fio  [k] call_rwsem_down_write_failed
 69.43%  1.18%  fio  [k] rwsem_down_write_failed
 65.51% 54.57%  fio  [k] osq_lock
  9.72%  7.99%  fio  [k] __raw_callee_save___kvm_vcpu_is_preempted
  4.16%  4.16%  fio  [k] __kvm_vcpu_is_preempted

So making vcpu_is_preempted() a callee-save function has a pretty high
cost associated with it. As vcpu_is_preempted() is called within the
spinlock, mutex and rwsem slowpaths, there isn't much to gain by making
it callee-save. So it is now changed to a normal function call instead.

With this patch applied, the aggregrate bandwidth of the fio sequential
write test increased slightly from 2563.3MB/s to 2588.1MB/s (about 1%).

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/paravirt.h       | 2 +-
 arch/x86/include/asm/paravirt_types.h | 2 +-
 arch/x86/kernel/kvm.c                 | 7 ++-----
 arch/x86/kernel/paravirt-spinlocks.c  | 6 ++----
 arch/x86/xen/spinlock.c               | 4 +---
 5 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 864f57b..2515885 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -676,7 +676,7 @@ static __always_inline void pv_kick(int cpu)
 
 static __always_inline bool pv_vcpu_is_preempted(int cpu)
 {
-	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
+	return PVOP_CALL1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
 }
 
 #endif /* SMP && PARAVIRT_SPINLOCKS */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index bb2de45..88dc852 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -309,7 +309,7 @@ struct pv_lock_ops {
 	void (*wait)(u8 *ptr, u8 val);
 	void (*kick)(int cpu);
 
-	struct paravirt_callee_save vcpu_is_preempted;
+	bool (*vcpu_is_preempted)(int cpu);
 };
 
 /* This contains all the paravirt structures: we get a convenient
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 099fcba..eb3753d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -595,7 +595,6 @@ __visible bool __kvm_vcpu_is_preempted(int cpu)
 
 	return !!src->preempted;
 }
-PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_preempted);
 
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
@@ -614,10 +613,8 @@ void __init kvm_spinlock_init(void)
 	pv_lock_ops.wait = kvm_wait;
 	pv_lock_ops.kick = kvm_kick_cpu;
 
-	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_lock_ops.vcpu_is_preempted =
-			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
-	}
+	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
+		pv_lock_ops.vcpu_is_preempted = __kvm_vcpu_is_preempted;
 }
 
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 6259327..da050bc 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -24,12 +24,10 @@ __visible bool __native_vcpu_is_preempted(int cpu)
 {
 	return false;
 }
-PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
 
 bool pv_is_native_vcpu_is_preempted(void)
 {
-	return pv_lock_ops.vcpu_is_preempted.func ==
-		__raw_callee_save___native_vcpu_is_preempted;
+	return pv_lock_ops.vcpu_is_preempted == __native_vcpu_is_preempted;
 }
 
 struct pv_lock_ops pv_lock_ops = {
@@ -38,7 +36,7 @@ struct pv_lock_ops pv_lock_ops = {
 	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait = paravirt_nop,
 	.kick = paravirt_nop,
-	.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted),
+	.vcpu_is_preempted = __native_vcpu_is_preempted,
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 25a7c43..c85bb8f 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -114,8 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
-PV_CALLEE_SAVE_REGS_THUNK(xen_vcpu_stolen);
-
 /*
  * Our init of PV spinlocks is split in two init functions due to us
  * using paravirt patching and jump labels patching and having to do
@@ -138,7 +136,7 @@ void __init xen_init_spinlocks(void)
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_lock_ops.wait = xen_qlock_wait;
 	pv_lock_ops.kick = xen_qlock_kick;
-	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
+	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
 }
 
 static __init int xen_parse_nopvspin(char *arg)
-- 
1.8.3.1
