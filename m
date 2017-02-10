From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
	callee-save function
Date: Fri, 10 Feb 2017 11:35:02 -0500
Message-ID: <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
	<20170210161928.GI6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170210161928.GI6515@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/10/2017 11:19 AM, Peter Zijlstra wrote:
> On Fri, Feb 10, 2017 at 10:43:09AM -0500, Waiman Long wrote:
>> It was found when running fio sequential write test with a XFS ramdisk
>> on a VM running on a 2-socket x86-64 system, the %CPU times as reported
>> by perf were as follows:
>>
>>  69.75%  0.59%  fio  [k] down_write
>>  69.15%  0.01%  fio  [k] call_rwsem_down_write_failed
>>  67.12%  1.12%  fio  [k] rwsem_down_write_failed
>>  63.48% 52.77%  fio  [k] osq_lock
>>   9.46%  7.88%  fio  [k] __raw_callee_save___kvm_vcpu_is_preempt
>>   3.93%  3.93%  fio  [k] __kvm_vcpu_is_preempted
>>
> Thinking about this again, wouldn't something like the below also work?
>
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 099fcba4981d..6aa33702c15c 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -589,6 +589,7 @@ static void kvm_wait(u8 *ptr, u8 val)
>  	local_irq_restore(flags);
>  }
>  
> +#ifdef CONFIG_X86_32
>  __visible bool __kvm_vcpu_is_preempted(int cpu)
>  {
>  	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
> @@ -597,6 +598,31 @@ __visible bool __kvm_vcpu_is_preempted(int cpu)
>  }
>  PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_preempted);
>  
> +#else
> +
> +extern bool __raw_callee_save___kvm_vcpu_is_preempted(int);
> +
> +asm(
> +".pushsection .text;"
> +".global __raw_callee_save___kvm_vcpu_is_preempted;"
> +".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
> +"__raw_callee_save___kvm_vcpu_is_preempted:"
> +FRAME_BEGIN
> +"push %rdi;"
> +"push %rdx;"
> +"movslq  %edi, %rdi;"
> +"movq    $steal_time+16, %rax;"
> +"movq    __per_cpu_offset(,%rdi,8), %rdx;"
> +"cmpb    $0, (%rdx,%rax);"
> +"setne   %al;"
> +"pop %rdx;"
> +"pop %rdi;"
> +FRAME_END
> +"ret;"
> +".popsection");
> +
> +#endif
> +
>  /*
>   * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
>   */

That should work for now. I have done something similar for
__pv_queued_spin_unlock. However, this has the problem of creating a
dependency on the exact layout of the steal_time structure. Maybe the
constant 16 can be passed in as a parameter offsetof(struct
kvm_steal_time, preempted) to the asm call.

Cheers,
Longman
