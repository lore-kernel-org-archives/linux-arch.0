Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:52237 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeA2TUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jan 2018 14:20:25 -0500
Date: Mon, 29 Jan 2018 19:20:52 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <579395772.11661.1517253652787.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180129190923.GP2249@hirez.programming.kicks-ass.net>
References: <20180123155733.3404-1-mathieu.desnoyers@efficios.com> <20180123155733.3404-9-mathieu.desnoyers@efficios.com> <20180129180414.GO2249@hirez.programming.kicks-ass.net> <20180129181529.GG2295@hirez.programming.kicks-ass.net> <485936677.11601.1517250965043.JavaMail.zimbra@efficios.com> <20180129190923.GP2249@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 08/11] membarrier: Provide core serializing command (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, "Russell King, ARM Linux" <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86 <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180129192052.s_hDnVy4sTEaxzUBIvg2r_XUAPWgLq8uuEqMSxLdRE8@z>

----- On Jan 29, 2018, at 2:09 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Mon, Jan 29, 2018 at 06:36:05PM +0000, Mathieu Desnoyers wrote:
>> ----- On Jan 29, 2018, at 1:15 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
>> > Aaah, its the case where we do not pass through switch_mm(), the partial
>> > comment got to me. I only realized after reading the next patch.
>> 
>> Indeed, if we read the entire comment, it's made clear that this case is for
>> when switch_mm is not invoked, where the current mm is changed without going
>> through switch_mm(), when scheduling between uthread->kthread->uthread for
>> instance.
>> 
>>         /*
>>          * When transitioning from a kernel thread to a userspace
>>          * thread, mmdrop()'s implicit full barrier is required by the
>>          * membarrier system call, because the current active_mm can
>>          * become the current mm without going through switch_mm().
>>          * membarrier also requires a core serializing instruction
>>          * before going back to user-space after storing to rq->curr.
>>          */
>> 
>> Is there something I should improve in the wording of this added
>> sentence to make it clearer ?
> 
> Can be improved I think, its got two unqualified "membarrier"s in and
> its a bit mixed up. I'm having a major case of the mondays (brain just
> won't start today), but maybe something like:
> 
>	When we switched through a kernel thread, the loop in
>	membarrier_{private,global}_expedited() can have observed that
>	kernel thread and not issued an IPI. We will also not pass
>	through switch_mm(). Membarrier requires a barrier after writing
>	rq->curr and returning to userspace, so provide them here:
> 
>	  - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED
>	  - a sync_core for SYNC_CORE

Editing to remove use of "we" and clarify, which ends up as:

        /*
         * When switching through a kernel thread, the loop in
         * membarrier_{private,global}_expedited() may have observed that
         * kernel thread and not issued an IPI. It is therefore possible to
         * schedule between user->kernel->user threads without passing though
         * switch_mm(). Membarrier requires a barrier after storing to
         * rq->curr, before returning to userspace, so provide them here:
         *
         * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
         *   provided by mmdrop(),
         * - a sync_core for SYNC_CORE.
         */

> 
> Also I think changing the changlog to state where we need core-sync
> would be good. Currently the x86 patch does that, but not this one,
> while this introduces the feature.

Planning to add this:

Architectures selecting this feature need to either document that
they issue core serializing instructions when returning to user-space,
or implement their architecture-specific sync_core_before_usermode().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
