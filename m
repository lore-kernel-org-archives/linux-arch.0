From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Tue, 14 Feb 2017 17:03:06 +0100
Message-ID: <20170214160306.GP6500@twins.programming.kicks-ass.net>
References: <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
	<14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
	<20170213104716.GM6515@twins.programming.kicks-ass.net>
	<20170213105343.GJ6536@twins.programming.kicks-ass.net>
	<3dc50409-60dd-ad47-f971-448191e66038@redhat.com>
	<6f69b112-7ae4-bf8f-b767-29a68fd48632@redhat.com>
	<20170213215220.GN25813@worktop.programming.kicks-ass.net>
	<933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
	<20170214093946.GM6500@twins.programming.kicks-ass.net>
	<fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 14, 2017 at 09:46:17AM -0500, Waiman Long wrote:
> On 02/14/2017 04:39 AM, Peter Zijlstra wrote:
> > On Mon, Feb 13, 2017 at 05:34:01PM -0500, Waiman Long wrote:
> >> It is the address of &steal_time that will exceed the 32-bit limit.
> > That seems extremely unlikely. That would mean we have more than 4G
> > worth of per-cpu variables declared in the kernel.
> 
> I have some doubt about if the compiler is able to properly use
> RIP-relative addressing for this.

Its not RIP relative, &steal_time lives in the .data..percpu section and
is absolute in that.

> Anyway, it seems like constraints
> aren't allowed for asm() when not in the function context, at least for
> the the compiler that I am using (4.8.5). So it is a moot point.

Well kvm_steal_time is (host/guest) ABI anyway, so the offset is fixed
and hard-coding it isn't a problem.

$ readelf -s defconfig-build/vmlinux | grep steal_time
100843: 0000000000017ac0    64 OBJECT  WEAK   DEFAULT   35 steal_time

$ objdump -dr defconfig-build/vmlinux | awk '/[<][^>]*[>]:/ { o=0 } /[<]__raw_callee_save___kvm_vcpu_is_preempted[>]:/ {o=1} { if (o) print $0 }'
ffffffff810b4480 <__raw_callee_save___kvm_vcpu_is_preempted>:
ffffffff810b4480:       55                      push   %rbp
ffffffff810b4481:       48 89 e5                mov    %rsp,%rbp
ffffffff810b4484:       48 8b 04 fd 00 94 46    mov    -0x7db96c00(,%rdi,8),%rax
ffffffff810b448b:       82 
                        ffffffff810b4488: R_X86_64_32S  __per_cpu_offset
ffffffff810b448c:       80 b8 d0 7a 01 00 00    cmpb   $0x0,0x17ad0(%rax)
                        ffffffff810b448e: R_X86_64_32S  steal_time+0x10
ffffffff810b4493:       0f 95 c0                setne  %al
ffffffff810b4496:       5d                      pop    %rbp
ffffffff810b4497:       c3                      retq   


And as you'll note, the displacement is correct and 'small'.

The below relies on the 'extra' cast in PVOP_CALL_ARG1() to extend the
argument to 64bit on the call side of things.

---
 arch/x86/kernel/kvm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 099fcba..2c854b8 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -589,6 +589,7 @@ static void kvm_wait(u8 *ptr, u8 val)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_X86_32
 __visible bool __kvm_vcpu_is_preempted(int cpu)
 {
 	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
@@ -597,6 +598,26 @@ __visible bool __kvm_vcpu_is_preempted(int cpu)
 }
 PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_preempted);
 
+#else
+
+extern bool __raw_callee_save___kvm_vcpu_is_preempted(int cpu);
+
+asm(
+".pushsection .text;"
+".global __raw_callee_save___kvm_vcpu_is_preempted;"
+".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
+"__raw_callee_save___kvm_vcpu_is_preempted:"
+FRAME_BEGIN
+"movq __per_cpu_offset(,%rdi,8), %rax;"
+"cmpb $0, 16+steal_time(%rax);"
+"setne %al;"
+FRAME_END
+"ret;"
+".popsection"
+);
+
+#endif
+
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
  */
