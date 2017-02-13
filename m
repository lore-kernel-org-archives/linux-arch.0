From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
 callee-save function
Date: Mon, 13 Feb 2017 14:41:06 -0500
Message-ID: <c9c08e6f-0685-e3c8-1972-d901abacb959@redhat.com>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
 <20170210161928.GI6515@twins.programming.kicks-ass.net>
 <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
 <14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
 <20170213104716.GM6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbdBMTlP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Feb 2017 14:41:15 -0500
In-Reply-To: <20170213104716.GM6515@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>

On 02/13/2017 05:47 AM, Peter Zijlstra wrote:
> On Fri, Feb 10, 2017 at 12:00:43PM -0500, Waiman Long wrote:
>
>>>> +asm(
>>>> +".pushsection .text;"
>>>> +".global __raw_callee_save___kvm_vcpu_is_preempted;"
>>>> +".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
>>>> +"__raw_callee_save___kvm_vcpu_is_preempted:"
>>>> +FRAME_BEGIN
>>>> +"push %rdi;"
>>>> +"push %rdx;"
>>>> +"movslq  %edi, %rdi;"
>>>> +"movq    $steal_time+16, %rax;"
>>>> +"movq    __per_cpu_offset(,%rdi,8), %rdx;"
>>>> +"cmpb    $0, (%rdx,%rax);"
> Could we not put the $steal_time+16 displacement as an immediate in the
> cmpb and save a whole register here?
>
> That way we'd end up with something like:
>
> asm("
> push %rdi;
> movslq %edi, %rdi;
> movq __per_cpu_offset(,%rdi,8), %rax;
> cmpb $0, %[offset](%rax);
> setne %al;
> pop %rdi;
> " : : [offset] "i" (((unsigned long)&steal_time) + offsetof(struct steal_time, preempted)));
>
> And if we could get rid of the sign extend on edi we could avoid all the
> push-pop nonsense, but I'm not sure I see how to do that (then again,
> this asm foo isn't my strongest point).

Yes, I think that can work. I will try to ran this patch to see how
thing goes.

>>>> +"setne   %al;"
>>>> +"pop %rdx;"
>>>> +"pop %rdi;"
>>>> +FRAME_END
>>>> +"ret;"
>>>> +".popsection");
>>>> +
>>>> +#endif
>>>> +
>>>>  /*
>>>>   * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
>>>>   */
>>> That should work for now. I have done something similar for
>>> __pv_queued_spin_unlock. However, this has the problem of creating a
>>> dependency on the exact layout of the steal_time structure. Maybe the
>>> constant 16 can be passed in as a parameter offsetof(struct
>>> kvm_steal_time, preempted) to the asm call.
> Yeah it should be well possible to pass that in. But ideally we'd have
> GCC grow something like __attribute__((callee_saved)) or somesuch and it
> would do all this for us.

That will be really nice too. I am not too fond of working in assembly.

>> One more thing, that will improve KVM performance, but it won't help Xen.
> People still use Xen? ;-) In any case, their implementation looks very
> similar and could easily crib this.

In Red Hat, my focus will be on KVM performance. I do believe that there
are still Xen users out there. So we still need to keep their interest
into consideration. Given that, I am OK to make it work better in KVM
first and then think about Xen later.

>> I looked into the assembly code for rwsem_spin_on_owner, It need to save
>> and restore 2 additional registers with my patch. Doing it your way,
>> will transfer the save and restore overhead to the assembly code.
>> However, __kvm_vcpu_is_preempted() is called multiple times per
>> invocation of rwsem_spin_on_owner. That function is simple enough that
>> making __kvm_vcpu_is_preempted() callee-save won't produce much compiler
>> optimization opportunity.
> This is because of that noinline, right? Otherwise it would've been
> folded and register pressure would be much higher.

Yes, I guess so. The noinline is there so that we know what the CPU time
is for spinning rather than other activities within the slowpath.

>
>> The outer function rwsem_down_write_failed()
>> does appear to be a bit bigger (from 866 bytes to 884 bytes) though.
> I suspect GCC is being clever and since all this is static it plays
> games with the calling convention and pushes these clobbers out.
>
>

Cheers,
Longman
