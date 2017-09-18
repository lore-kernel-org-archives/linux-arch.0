From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/2] membarrier: Provide register expedited private
 command
Date: Mon, 18 Sep 2017 19:30:06 +0000 (UTC)
Message-ID: <802837763.12688.1505763006911.JavaMail.zimbra@efficios.com>
References: <Pine.LNX.4.44L0.1709181443540.1806-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1709181443540.1806-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

----- On Sep 18, 2017, at 2:46 PM, Alan Stern stern@rowland.harvard.edu wrote:

> On Mon, 18 Sep 2017, Mathieu Desnoyers wrote:
> 
>> Provide a new command allowing processes to register their intent to use
>> the private expedited command.
>> 
>> This allows PowerPC to skip the full memory barrier in switch_mm(), and
>> only issue the barrier when scheduling into a task belonging to a
>> process that has registered to use expedited private.
>> 
>> Processes are now required to register before using
>> MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.
>> 
>> [ Runtime testing on the PowerPC architecture would be welcome. ]
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
>> +++ b/arch/powerpc/include/asm/membarrier.h
>> @@ -0,0 +1,37 @@
>> +#ifndef _ASM_POWERPC_MEMBARRIER_H
>> +#define _ASM_POWERPC_MEMBARRIER_H
>> +
>> +static inline void membarrier_arch_sched_in(struct task_struct *prev,
>> +		struct task_struct *next)
>> +{
>> +	/*
>> +	 * Only need the full barrier when switching between processes.
>> +	 */
>> +	if (likely(!test_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED)
>> +			|| prev->mm == next->mm))

I think I should use:

test_ti_thread_flag(next, TIF_MEMBARRIER_PRIVATE_EXPEDITED)

instead of test_thread_flag above.

>> +		return;
>> +
>> +	/*
>> +	 * The membarrier system call requires a full memory barrier
>> +	 * after storing to rq->curr, before going back to user-space.
>> +	 */
>> +	smp_mb();
>> +}
>> +static inline void membarrier_arch_fork(struct task_struct *t,
>> +		unsigned long clone_flags)
>> +{
>> +	/*
>> +	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
>> +	 * fork is protected by siglock. membarrier_arch_fork is called
>> +	 * with siglock held.
>> +	 */
>> +	if (t->mm->membarrier_private_expedited)
>> +		set_ti_thread_flag(t, TIF_MEMBARRIER_PRIVATE_EXPEDITED);
>> +}
> 
> Why have two separate bitflags for the same thing?  Can't you just use
> the mm->membarrier_private_expedited flag everywhere and forget about
> TIF_MEMBARRIER_PRIVATE_EXPEDITED?

The goal here is to save chasing through the task->mm-> pointer in sched_in(),
and directly access the process registration state through a thread flag.

Thanks,

Mathieu


> 
> Alan Stern

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
