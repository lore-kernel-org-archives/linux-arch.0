From: Waiman Long <longman@redhat.com>
Subject: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a callee-save
	function
Date: Fri, 10 Feb 2017 10:43:09 -0500
Message-ID: <1486741389-8513-1-git-send-email-longman@redhat.com>
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
on a VM running on a 2-socket x86-64 system, the %CPU times as reported
by perf were as follows:

 69.75%  0.59%  fio  [k] down_write
 69.15%  0.01%  fio  [k] call_rwsem_down_write_failed
 67.12%  1.12%  fio  [k] rwsem_down_write_failed
 63.48% 52.77%  fio  [k] osq_lock
  9.46%  7.88%  fio  [k] __raw_callee_save___kvm_vcpu_is_preempt
  3.93%  3.93%  fio  [k] __kvm_vcpu_is_preempted

Making vcpu_is_preempted() a callee-save function has a relatively
high cost on x86-64 primarily due to at least one more cacheline of
data access from the saving and restoring of registers (8 of them)
to and from stack as well as one more level of function call. As
vcpu_is_preempted() is called within the spinlock, mutex and rwsem
slowpaths, there isn't much to gain by making it callee-save. So it
is now changed to a normal function call instead.

With this patch applied on both bare-metal & KVM guest on a 2-socekt
16-core 32-thread system with 16 parallel jobs (8 on each socket), the
aggregrate bandwidth of the fio test on an XFS ramdisk were as follows:

                       Bare Metal                KVM Guest
   I/O Type      w/o patch    with patch   w/o patch    with patch
   --------      ---------    ----------   ---------    ----------
   random read   8650.5 MB/s  8560.9 MB/s  7602.9 MB/s  8196.1 MB/s  
   seq read      9104.8 MB/s  9397.2 MB/s  8293.7 MB/s  8566.9 MB/s
   random write  1623.8 MB/s  1626.7 MB/s  1590.6 MB/s  1700.7 MB/s
   seq write     1626.4 MB/s  1624.9 MB/s  1604.8 MB/s  1726.3 MB/s

The perf data (on KVM guest) now became:

 70.78%  0.58%  fio  [k] down_write
 70.20%  0.01%  fio  [k] call_rwsem_down_write_failed
 69.70%  1.17%  fio  [k] rwsem_down_write_failed
 59.91% 55.42%  fio  [k] osq_lock
 10.14% 10.14%  fio  [k] __kvm_vcpu_is_preempted

On bare metal, the patch doesn't introduce any performance
regression. On KVM guest, it produces noticeable performance
improvement (up to 7%).

Signed-off-by: Waiman Long <longman@redhat.com>
---
 v1->v2:
  - Rerun the fio test on a different system on both bare-metal and a
    KVM guest. Both sockets were utilized in this test.
  - The commit log was updated with new performance numbers, but the
    patch wasn't changed.
  - Drop patch 2.

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
