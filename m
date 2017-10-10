From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC tip/core/rcu 11/15] tracepoint: Remove
 smp_read_barrier_depends() from comment
Date: Tue, 10 Oct 2017 01:12:38 +0000 (UTC)
Message-ID: <506678791.34748.1507597958832.JavaMail.zimbra@efficios.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com> <1507594969-8347-11-git-send-email-paulmck@linux.vnet.ibm.com> <20171009203116.4246818c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:50096 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdJJBK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 21:10:56 -0400
In-Reply-To: <20171009203116.4246818c@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>

----- On Oct 9, 2017, at 8:31 PM, rostedt rostedt@goodmis.org wrote:

> [ added Mathieu ]
> 
> On Mon,  9 Oct 2017 17:22:45 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
>> The comment in tracepoint_add_func() mentions smp_read_barrier_depends(),
>> whose use should be quite restricted.  This commit updates the comment
>> to instead mention the smp_store_release() and rcu_dereference_sched()
>> that the current code actually uses.
>> 
>> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 

Yeah I think we don't need to spell out the implementation of
rcu_dereference_sched() there (which actually uses lockless_dereference(),
which indeed ends up relying on smp_read_barrier_depends()). The comment
was a bit too low-level for the benefit of its audience.

I agree with the change.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> -- Steve
> 
>> ---
>>  kernel/tracepoint.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>> index 685c50ae6300..671b13457387 100644
>> --- a/kernel/tracepoint.c
>> +++ b/kernel/tracepoint.c
>> @@ -212,11 +212,10 @@ static int tracepoint_add_func(struct tracepoint *tp,
>>  	}
>>  
>>  	/*
>> -	 * rcu_assign_pointer has a smp_wmb() which makes sure that the new
>> -	 * probe callbacks array is consistent before setting a pointer to it.
>> -	 * This array is referenced by __DO_TRACE from
>> -	 * include/linux/tracepoints.h. A matching smp_read_barrier_depends()
>> -	 * is used.
>> +	 * rcu_assign_pointer has as smp_store_release() which makes sure
>> +	 * that the new probe callbacks array is consistent before setting
>> +	 * a pointer to it.  This array is referenced by __DO_TRACE from
>> +	 * include/linux/tracepoint.h using rcu_dereference_sched().
>>  	 */
>>  	rcu_assign_pointer(tp->funcs, tp_funcs);
> >  	if (!static_key_enabled(&tp->key))

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
