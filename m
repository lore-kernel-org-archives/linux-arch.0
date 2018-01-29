Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58798 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeA2SPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jan 2018 13:15:51 -0500
Date: Mon, 29 Jan 2018 19:15:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 08/11] membarrier: Provide core serializing command (v2)
Message-ID: <20180129181529.GG2295@hirez.programming.kicks-ass.net>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com>
 <20180123155733.3404-9-mathieu.desnoyers@efficios.com>
 <20180129180414.GO2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129180414.GO2249@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180129181529.-P2MG1-1AiiQkxJRMuBp_DvPTdTbcMkgdzBoaGyiYcI@z>

On Mon, Jan 29, 2018 at 07:04:14PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 23, 2018 at 10:57:30AM -0500, Mathieu Desnoyers wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f38c4c7e256a..041893128f51 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2662,9 +2662,13 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  	 * thread, mmdrop()'s implicit full barrier is required by the
> >  	 * membarrier system call, because the current active_mm can
> >  	 * become the current mm without going through switch_mm().
> > +	 * membarrier also requires a core serializing instruction
> > +	 * before going back to user-space after storing to rq->curr.
> >  	 */
> > -	if (mm)
> > +	if (mm) {
> > +		membarrier_mm_sync_core_before_usermode(mm);
> >  		mmdrop(mm);
> > +	}
> 
> *confused*, when we switch from process A to process B, context_switch()
> will not set rq->prev_mm and the above mm will be NULL and we'll not
> pass through your_function_names_are_waaay_too_long and we'll not get
> cookies.
> 
> And if there's anything more complicated going on, the comment/changelog
> are not adequate.

Aaah, its the case where we do not pass through switch_mm(), the partial
comment got to me. I only realized after reading the next patch.

> >  	if (unlikely(prev_state == TASK_DEAD)) {
> >  		if (prev->sched_class->task_dead)
> >  			prev->sched_class->task_dead(prev);
> 
> 
