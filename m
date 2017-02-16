From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 2/2] x86/kvm: Provide optimized version of
	vcpu_is_preempted() for x86-64
Date: Thu, 16 Feb 2017 17:48:15 +0100
Message-ID: <20170216164815.GD6515@twins.programming.kicks-ass.net>
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
	<1487194670-6319-3-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1487194670-6319-3-git-send-email-longman@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, andrew.cooper3@citrix.com, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 15, 2017 at 04:37:50PM -0500, Waiman Long wrote:
> +/*
> + * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
> + * restoring to/from the stack. It is assumed that the preempted value
> + * is at an offset of 16 from the beginning of the kvm_steal_time structure
> + * which is verified by the BUILD_BUG_ON() macro below.
> + */
> +#define PREEMPTED_OFFSET	16

As per Andrew's suggestion, the 'right' way is something like so.

---
 asm-offsets_64.c |   11 +++++++++++
 kvm.c            |   14 ++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -13,6 +13,10 @@ static char syscalls_ia32[] = {
 #include <asm/syscalls_32.h>
 };
 
+#ifdef CONFIG_KVM_GUEST
+#include <asm/kvm_para.h>
+#endif
+
 int main(void)
 {
 #ifdef CONFIG_PARAVIRT
@@ -22,6 +26,13 @@ int main(void)
 	BLANK();
 #endif
 
+#ifdef CONFIG_KVM_GUEST
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	OFFSET(KVM_STEAL_TIME_preempted, kvm_steal_time, preempted);
+	BLANK();
+#endif
+#endif
+
 #define ENTRY(entry) OFFSET(pt_regs_ ## entry, pt_regs, entry)
 	ENTRY(bx);
 	ENTRY(cx);
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -600,22 +600,21 @@ PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_
 
 #else
 
+#include <asm/asm-offsets.h>
+
 extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
 
 /*
  * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
- * restoring to/from the stack. It is assumed that the preempted value
- * is at an offset of 16 from the beginning of the kvm_steal_time structure
- * which is verified by the BUILD_BUG_ON() macro below.
+ * restoring to/from the stack. 
  */
-#define PREEMPTED_OFFSET	16
 asm(
 ".pushsection .text;"
 ".global __raw_callee_save___kvm_vcpu_is_preempted;"
 ".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
 "__raw_callee_save___kvm_vcpu_is_preempted:"
 "movq	__per_cpu_offset(,%rdi,8), %rax;"
-"cmpb	$0, " __stringify(PREEMPTED_OFFSET) "+steal_time(%rax);"
+"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
 "setne	%al;"
 "ret;"
 ".popsection");
@@ -627,11 +626,6 @@ asm(
  */
 void __init kvm_spinlock_init(void)
 {
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON((offsetof(struct kvm_steal_time, preempted)
-		!= PREEMPTED_OFFSET) || (sizeof(steal_time.preempted) != 1));
-#endif
-
 	if (!kvm_para_available())
 		return;
 	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
