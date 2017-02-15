From: Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/2] x86/paravirt: Change vcp_is_preempted() arg type to long
Date: Wed, 15 Feb 2017 16:37:49 -0500
Message-ID: <1487194670-6319-2-git-send-email-longman@redhat.com>
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487194670-6319-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

The cpu argument in the function prototype of vcpu_is_preempted()
is changed from int to long. That makes it easier to provide a better
optimized assembly version of that function.

For Xen, vcpu_is_preempted(long) calls xen_vcpu_stolen(int), the
downcast from long to int is not a problem as vCPU number won't exceed
32 bits.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/paravirt.h      | 2 +-
 arch/x86/include/asm/qspinlock.h     | 2 +-
 arch/x86/kernel/kvm.c                | 2 +-
 arch/x86/kernel/paravirt-spinlocks.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1eea6ca..f75fbfe 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -673,7 +673,7 @@ static __always_inline void pv_kick(int cpu)
 	PVOP_VCALL1(pv_lock_ops.kick, cpu);
 }
 
-static __always_inline bool pv_vcpu_is_preempted(int cpu)
+static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
 }
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index c343ab5..48a706f 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -34,7 +34,7 @@ static inline void queued_spin_unlock(struct qspinlock *lock)
 }
 
 #define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(int cpu)
+static inline bool vcpu_is_preempted(long cpu)
 {
 	return pv_vcpu_is_preempted(cpu);
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 099fcba..85ed343 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -589,7 +589,7 @@ static void kvm_wait(u8 *ptr, u8 val)
 	local_irq_restore(flags);
 }
 
-__visible bool __kvm_vcpu_is_preempted(int cpu)
+__visible bool __kvm_vcpu_is_preempted(long cpu)
 {
 	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
 
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 6259327..8f2d1c9 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -20,7 +20,7 @@ bool pv_is_native_spin_unlock(void)
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
-__visible bool __native_vcpu_is_preempted(int cpu)
+__visible bool __native_vcpu_is_preempted(long cpu)
 {
 	return false;
 }
-- 
1.8.3.1
