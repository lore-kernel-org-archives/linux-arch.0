From: Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/2] x86/kvm: Provide optimized version of vcpu_is_preempted() for x86-64
Date: Wed, 15 Feb 2017 13:31:02 -0500
Message-ID: <1487183463-882-3-git-send-email-longman@redhat.com>
References: <1487183463-882-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487183463-882-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

It was found when running fio sequential write test with a XFS ramdisk
on a KVM guest running on a 2-socket x86-64 system, the %CPU times
as reported by perf were as follows:

 69.75%  0.59%  fio  [k] down_write
 69.15%  0.01%  fio  [k] call_rwsem_down_write_failed
 67.12%  1.12%  fio  [k] rwsem_down_write_failed
 63.48% 52.77%  fio  [k] osq_lock
  9.46%  7.88%  fio  [k] __raw_callee_save___kvm_vcpu_is_preempt
  3.93%  3.93%  fio  [k] __kvm_vcpu_is_preempted

Making vcpu_is_preempted() a callee-save function has a relatively
high cost on x86-64 primarily due to at least one more cacheline of
data access from the saving and restoring of registers (8 of them)
to and from stack as well as one more level of function call.

To reduce this performance overhead, an optimized assembly version
of the the __raw_callee_save___kvm_vcpu_is_preempt() function is
provided for x86-64.

With this patch applied on a KVM guest on a 2-socekt 16-core 32-thread
system with 16 parallel jobs (8 on each socket), the aggregrate
bandwidth of the fio test on an XFS ramdisk were as follows:

   I/O Type      w/o patch    with patch
   --------      ---------    ----------
   random read   8141.2 MB/s  8497.1 MB/s
   seq read      8229.4 MB/s  8304.2 MB/s
   random write  1675.5 MB/s  1701.5 MB/s
   seq write     1681.3 MB/s  1699.9 MB/s

There are some increases in the aggregated bandwidth because of
the patch.

The perf data now became:

 70.78%  0.58%  fio  [k] down_write
 70.20%  0.01%  fio  [k] call_rwsem_down_write_failed
 69.70%  1.17%  fio  [k] rwsem_down_write_failed
 59.91% 55.42%  fio  [k] osq_lock
 10.14% 10.14%  fio  [k] __kvm_vcpu_is_preempted

The assembly code was verified by using a test kernel module to
compare the output of C __kvm_vcpu_is_preempted() and that of assembly
__raw_callee_save___kvm_vcpu_is_preempt() to verify that they matched.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/kvm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 85ed343..83e22c1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -589,6 +589,7 @@ static void kvm_wait(u8 *ptr, u8 val)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_X86_32
 __visible bool __kvm_vcpu_is_preempted(long cpu)
 {
 	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
@@ -597,11 +598,38 @@ __visible bool __kvm_vcpu_is_preempted(long cpu)
 }
 PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_preempted);
 
+#else
+
+extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
+
+/*
+ * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
+ * restoring to/from the stack. It is assumed that the preempted value
+ * is at an offset of 16 from the beginning of the kvm_steal_time structure
+ * which is verified by the BUILD_BUG_ON() macro below.
+ */
+#define PREEMPTED_OFFSET	16
+asm(
+".pushsection .text;"
+".global __raw_callee_save___kvm_vcpu_is_preempted;"
+".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
+"__raw_callee_save___kvm_vcpu_is_preempted:"
+"movq	__per_cpu_offset(,%rdi,8), %rax;"
+"cmpb	$0, " __stringify(PREEMPTED_OFFSET) "+steal_time(%rax);"
+"setne	%al;"
+"ret;"
+".popsection");
+
+#endif
+
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
  */
 void __init kvm_spinlock_init(void)
 {
+	BUILD_BUG_ON((offsetof(struct kvm_steal_time, preempted)
+		!= PREEMPTED_OFFSET) || (sizeof(steal_time.preempted) != 1));
+
 	if (!kvm_para_available())
 		return;
 	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
-- 
1.8.3.1
