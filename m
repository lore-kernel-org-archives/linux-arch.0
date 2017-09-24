From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Sun, 24 Sep 2017 14:23:04 +0000 (UTC)
Message-ID: <1879888051.17397.1506262984228.JavaMail.zimbra@efficios.com>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com> <20170922085959.GG10893@tardis> <121420896.16597.1506093010487.JavaMail.zimbra@efficios.com> <20170924133038.GA8673@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:44424 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdIXOWD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Sep 2017 10:22:03 -0400
In-Reply-To: <20170924133038.GA8673@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>

----- On Sep 24, 2017, at 9:30 AM, Boqun Feng boqun.feng@gmail.com wrote:

> On Fri, Sep 22, 2017 at 03:10:10PM +0000, Mathieu Desnoyers wrote:
>> ----- On Sep 22, 2017, at 4:59 AM, Boqun Feng boqun.feng@gmail.com wrote:
>> 
>> > On Tue, Sep 19, 2017 at 06:13:41PM -0400, Mathieu Desnoyers wrote:
>> > [...]
>> >> +static inline void membarrier_arch_sched_in(struct task_struct *prev,
>> >> +		struct task_struct *next)
>> >> +{
>> >> +	/*
>> >> +	 * Only need the full barrier when switching between processes.
>> >> +	 */
>> >> +	if (likely(!test_ti_thread_flag(task_thread_info(next),
>> >> +			TIF_MEMBARRIER_PRIVATE_EXPEDITED)
>> >> +				|| prev->mm == next->mm))
>> > 
>> > And we also don't need the smp_mb() if !prev->mm, because switching from
>> > kernel to user will have a smp_mb() implied by mmdrop()?
>> 
>> Right. And we also don't need it when switching from userspace to kernel
> 
> Yep, but this case is covered already, as I think we don't allow kernel
> thread to have TIF_MEMBARRIER_PRIVATE_EXPEDITED set, right?

Good point.

> 
>> thread neither. Something like this:
>> 
>> static inline void membarrier_arch_sched_in(struct task_struct *prev,
>>                 struct task_struct *next)
>> {
>>         /*
>>          * Only need the full barrier when switching between processes.
>>          * Barrier when switching from kernel to userspace is not
>>          * required here, given that it is implied by mmdrop(). Barrier
>>          * when switching from userspace to kernel is not needed after
>>          * store to rq->curr.
>>          */
>>         if (likely(!test_ti_thread_flag(task_thread_info(next),
>>                         TIF_MEMBARRIER_PRIVATE_EXPEDITED)
>>                         || !prev->mm || !next->mm || prev->mm == next->mm))
> 
> , so no need to test next->mm here.
> 

Right, it's redundant wrt testing the thread flag.

>>                 return;
>> 
>>         /*
>>          * The membarrier system call requires a full memory barrier
>>          * after storing to rq->curr, before going back to user-space.
>>          */
>>         smp_mb();
>> }
>> 
>> > 
>> >> +		return;
>> >> +
>> >> +	/*
>> >> +	 * The membarrier system call requires a full memory barrier
>> >> +	 * after storing to rq->curr, before going back to user-space.
>> >> +	 */
>> >> +	smp_mb();
>> >> +}
>> > 
>> > [...]
>> > 
>> >> +static inline void membarrier_fork(struct task_struct *t,
>> >> +		unsigned long clone_flags)
>> >> +{
>> >> +	if (!current->mm || !t->mm)
>> >> +		return;
>> >> +	t->mm->membarrier_private_expedited =
>> >> +		current->mm->membarrier_private_expedited;
>> > 
>> > Have we already done the copy of ->membarrier_private_expedited in
>> > copy_mm()?
>> 
>> copy_mm() is performed without holding current->sighand->siglock, so
>> it appears to be racing with concurrent membarrier register cmd.
> 
> Speak of racing, I think we currently have a problem if we do a
> register_private_expedited in one thread and do a
> membarrer_private_expedited in another thread(sharing the same mm), as
> follow:
> 
>	{t1,t2,t3 sharing the same ->mm}
>	CPU 0				CPU 1				CPU2
>	====================		===================		============
>	{in thread t1}
>	membarrier_register_private_expedited():
>	  ...
>	  WRITE_ONCE(->mm->membarrier_private_expedited, 1);
>	  membarrier_arch_register_private_expedited():
>	    ...
>	    <haven't set the TIF for t3 yet>
> 
>	    				{in thread t2}
>					membarrier_private_expedited():
>					  READ_ONCE(->mm->membarrier_private_expedited); // == 1
>					  ...
>					  for_each_online_cpu()
>					    ...
>					    <p is cpu_rq(CPU2)->curr>
>					    if (p && p->mm == current->mm) // false
>					    <so no ipi sent to CPU2>
>					    				
>									{about to switch to t3}
>									rq->curr = t3;
>									....
>									context_switch():
>									  ...
>									  finish_task_swtich():
>									    membarrier_sched_in():
>									    <TIF is not set>
>									    // no smp_mb() here.
> 
> , and we will miss the smp_mb() on CPU2, right? And this could even
> happen if t2 has a membarrier_register_private_expedited() preceding the
> membarrier_private_expedited().
>					
> Am I missing something subtle here?

I think the problem sits in this function:

static void membarrier_register_private_expedited(void)
{
        struct task_struct *p = current;

        if (READ_ONCE(p->mm->membarrier_private_expedited))
                return;
        WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
        membarrier_arch_register_private_expedited(p);
}

I need to change the order between WRITE_ONCE() and invoking
membarrier_arch_register_private_expedited. If I issue the
WRITE_ONCE after the arch code (which sets the TIF flags),
then concurrent membarrier priv exped commands will simply
return an -EPERM error:

static void membarrier_register_private_expedited(void)
{
        struct task_struct *p = current;

        if (READ_ONCE(p->mm->membarrier_private_expedited))
                return;
        membarrier_arch_register_private_expedited(p);
        WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
}

Do you agree that this would fix the race you identified ?

Thanks,

Mathieu


> 
> Regards,
> Boqun
> 
> 
>> However, given that it is a single flag updated with WRITE_ONCE()
>> and read with READ_ONCE(), it might be OK to rely on copy_mm there.
>> If userspace runs registration concurrently with fork, they should
>> not expect the child to be specifically registered or unregistered.
>> 
>> So yes, I think you are right about removing this copy and relying on
>> copy_mm() instead. I also think we can improve membarrier_arch_fork()
>> on powerpc to test the current thread flag rather than using current->mm.
>> 
>> Which leads to those two changes:
>> 
>> static inline void membarrier_fork(struct task_struct *t,
>>                 unsigned long clone_flags)
>> {
>>         /*
>>          * Prior copy_mm() copies the membarrier_private_expedited field
>>          * from current->mm to t->mm.
>>          */
>>         membarrier_arch_fork(t, clone_flags);
>> }
>> 
>> And on PowerPC:
>> 
>> static inline void membarrier_arch_fork(struct task_struct *t,
>>                 unsigned long clone_flags)
>> {
>>         /*
>>          * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
>>          * fork is protected by siglock. membarrier_arch_fork is called
>>          * with siglock held.
>>          */
>>         if (test_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED))
>>                 set_ti_thread_flag(task_thread_info(t),
>>                                 TIF_MEMBARRIER_PRIVATE_EXPEDITED);
>> }
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> 
>> > 
>> > Regards,
>> > Boqun
>> > 
>> >> +	membarrier_arch_fork(t, clone_flags);
>> >> +}
>> >> +static inline void membarrier_execve(struct task_struct *t)
>> >> +{
>> >> +	t->mm->membarrier_private_expedited = 0;
>> >> +	membarrier_arch_execve(t);
>> >> +}
>> >> +#else
>> >> +static inline void membarrier_sched_in(struct task_struct *prev,
>> >> +		struct task_struct *next)
>> >> +{
>> >> +}
>> >> +static inline void membarrier_fork(struct task_struct *t,
>> >> +		unsigned long clone_flags)
>> >> +{
>> >> +}
>> >> +static inline void membarrier_execve(struct task_struct *t)
>> >> +{
>> >> +}
>> >> +#endif
>> >> +
>> > [...]
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
