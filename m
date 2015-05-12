Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33741 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbELE2s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2015 00:28:48 -0400
Message-ID: <55518112.9040808@synopsys.com>
Date: Tue, 12 May 2015 09:56:58 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] clone: Support passing tls argument via C rather
 than pt_regs magic
References: <20150421174711.GA5127@jtriplet-mobl1> <C2D7FE5348E1B147BCA15975FBA230756659F586@IN01WEMBXB.internal.synopsys.com> <20150511144717.GC6130@x>
In-Reply-To: <20150511144717.GC6130@x>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@ZenIV.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20150512042658.z5b-O23qHx6svieWPn1GGAHzn687zbxnXwJVeAkqDhw@z>

+CC Arnd, Al, linux-arch

On Monday 11 May 2015 08:17 PM, Josh Triplett wrote:
> On Mon, May 11, 2015 at 02:31:39PM +0000, Vineet Gupta wrote:
>> On Tuesday 21 April 2015 11:17 PM, Josh Triplett wrote:
>>> clone with CLONE_SETTLS accepts an argument to set the thread-local
>>> storage area for the new thread.  sys_clone declares an int argument
>>> tls_val in the appropriate point in the argument list (based on the
>>> various CLONE_BACKWARDS variants), but doesn't actually use or pass
>>> along that argument.  Instead, sys_clone calls do_fork, which calls
>>> copy_process, which calls the arch-specific copy_thread, and copy_thread
>>> pulls the corresponding syscall argument out of the pt_regs captured at
>>> kernel entry (knowing what argument of clone that architecture passes
>>> tls in).
>>>
>>> Apart from being awful and inscrutable, that also only works because
>>> only one code path into copy_thread can pass the CLONE_SETTLS flag, and
>>> that code path comes from sys_clone with its architecture-specific
>>> argument-passing order.  This prevents introducing a new version of the
>>> clone system call without propagating the same architecture-specific
>>> position of the tls argument.
>>>
>>> However, there's no reason to pull the argument out of pt_regs when
>>> sys_clone could just pass it down via C function call arguments.
>>>
>>> Introduce a new CONFIG_HAVE_COPY_THREAD_TLS for architectures to opt
>>> into, and a new copy_thread_tls that accepts the tls parameter as an
>>> additional unsigned long (syscall-argument-sized) argument.
>>> Change sys_clone's tls argument to an unsigned long (which does
>>> not change the ABI), and pass that down to copy_thread_tls.
>>>
>>> Architectures that don't opt into copy_thread_tls will continue to
>>> ignore the C argument to sys_clone in favor of the pt_regs captured at
>>> kernel entry, and thus will be unable to introduce new versions of the
>>> clone syscall.
>>>
>>> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
>>> Signed-off-by: Thiago Macieira <thiago.macieira@intel.com>
>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>> ---
>>>  arch/Kconfig             |  7 ++++++
>>>  include/linux/sched.h    | 14 ++++++++++++
>>>  include/linux/syscalls.h |  6 +++---
>>>  kernel/fork.c            | 55 +++++++++++++++++++++++++++++++-----------------
>>>  4 files changed, 60 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 05d7a8a..4834a58 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -484,6 +484,13 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
>>>  	  This spares a stack switch and improves cache usage on softirq
>>>  	  processing.
>>>  
>>> +config HAVE_COPY_THREAD_TLS
>>> +	bool
>>> +	help
>>> +	  Architecture provides copy_thread_tls to accept tls argument via
>>> +	  normal C parameter passing, rather than extracting the syscall
>>> +	  argument from pt_regs.
>>> +
>>>  #
>>>  # ABI hall of shame
>>>  #
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index a419b65..2cc88c6 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -2480,8 +2480,22 @@ extern struct mm_struct *mm_access(struct task_struct *task, unsigned int mode);
>>>  /* Remove the current tasks stale references to the old mm_struct */
>>>  extern void mm_release(struct task_struct *, struct mm_struct *);
>>>  
>>> +#ifdef CONFIG_HAVE_COPY_THREAD_TLS
>>> +extern int copy_thread_tls(unsigned long, unsigned long, unsigned long,
>>> +			struct task_struct *, unsigned long);
>>> +#else
>>>  extern int copy_thread(unsigned long, unsigned long, unsigned long,
>>>  			struct task_struct *);
>>> +
>>> +/* Architectures that haven't opted into copy_thread_tls get the tls argument
>>> + * via pt_regs, so ignore the tls argument passed via C. */
>>> +static inline int copy_thread_tls(
>>> +		unsigned long clone_flags, unsigned long sp, unsigned long arg,
>>> +		struct task_struct *p, unsigned long tls)
>>> +{
>>> +	return copy_thread(clone_flags, sp, arg, p);
>>> +}
>>> +#endif
>>
>> Is this detour really needed. Can we not update copy_thread() of all arches in one
>> go and add the tls arg, w/o using it.
>>
>> And then arch maintainers can micro-optimize their code to use that arg vs.
>> pt_regs->rxx version at their own leisure. The only downside I see with that is
>> bigger churn (touches all arches), and a interim unused arg warning ?
> 
> In addition to the cleanup and simplification, the purpose of this patch
> is specifically to make sure that any architecture opting into
> HAVE_COPY_THREAD_TLS does *not* care how tls is passed in, and in
> particular doesn't depend on it arriving in a specific syscall argument.

Sorry for sounding dense, but as I see here, in the end even for non opting
arches, copy_thread_tls() calling convention expects tls arg passed to it from
sys_clone call stack, but simply drops it. So that arg is always available, has to
be, otherwise even the pt_regs approach won't get to it.

The opt in approach simply avoids touching all arches in one go, to pass @tls
unconditionally to copy_thread().

I think latter has simpler unified calling convention and avoids proliferating
another Kconfig option across arches, which actually any sane arch will opt into
in the end - there's no reason not to.

Note that passing the arg doesn't mean arch needs to be converted right away in
terms of how it references the orig syscall @tls param. It can do it as maintainer
deems fit and in fact the build warning will pester them to do that sooner than later.

> I have patches in flight (for CLONE_FD and clone4) that depend on that
> assumption, by introducing additional syscalls (with tls passed
> differently) that call down through these same code paths.

But that is different from copy_thread() vs, copy_thread_tls() aspect of the
story. Perhaps if u could point me to your in works git branch or some such I'd be
able to comprehend this better.

Thx,
-Vineet
