Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:51734 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeA2Sfe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jan 2018 13:35:34 -0500
Date: Mon, 29 Jan 2018 18:36:05 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <485936677.11601.1517250965043.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180129181529.GG2295@hirez.programming.kicks-ass.net>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com> <20180123155733.3404-9-mathieu.desnoyers@efficios.com> <20180129180414.GO2249@hirez.programming.kicks-ass.net> <20180129181529.GG2295@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 08/11] membarrier: Provide core serializing command (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, "Russell King, ARM Linux" <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86 <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180129183605.PgKIxjCa38ZdAy-VuScxX2cSR3ch4I6MZTCzobG-GlQ@z>

----- On Jan 29, 2018, at 1:15 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Jan 29, 2018 at 07:04:14PM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 23, 2018 at 10:57:30AM -0500, Mathieu Desnoyers wrote:
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index f38c4c7e256a..041893128f51 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -2662,9 +2662,13 @@ static struct rq *finish_task_switch(struct task_struct
>> > *prev)
>> >  	 * thread, mmdrop()'s implicit full barrier is required by the
>> >  	 * membarrier system call, because the current active_mm can
>> >  	 * become the current mm without going through switch_mm().
>> > +	 * membarrier also requires a core serializing instruction
>> > +	 * before going back to user-space after storing to rq->curr.
>> >  	 */
>> > -	if (mm)
>> > +	if (mm) {
>> > +		membarrier_mm_sync_core_before_usermode(mm);
>> >  		mmdrop(mm);
>> > +	}
>> 
>> *confused*, when we switch from process A to process B, context_switch()
>> will not set rq->prev_mm and the above mm will be NULL and we'll not
>> pass through your_function_names_are_waaay_too_long and we'll not get
>> cookies.
>> 
>> And if there's anything more complicated going on, the comment/changelog
>> are not adequate.
> 
> Aaah, its the case where we do not pass through switch_mm(), the partial
> comment got to me. I only realized after reading the next patch.

Indeed, if we read the entire comment, it's made clear that this case is for
when switch_mm is not invoked, where the current mm is changed without going
through switch_mm(), when scheduling between uthread->kthread->uthread for
instance.

        /*
         * When transitioning from a kernel thread to a userspace
         * thread, mmdrop()'s implicit full barrier is required by the
         * membarrier system call, because the current active_mm can
         * become the current mm without going through switch_mm().
         * membarrier also requires a core serializing instruction
         * before going back to user-space after storing to rq->curr.
         */

Is there something I should improve in the wording of this added
sentence to make it clearer ?

Thanks,

Mathieu


> 
>> >  	if (unlikely(prev_state == TASK_DEAD)) {
>> >  		if (prev->sched_class->task_dead)
>> >  			prev->sched_class->task_dead(prev);
>> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
