From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH v3 1/2] membarrier: Provide register expedited
 private command
Date: Fri, 22 Sep 2017 05:22:19 +0000 (UTC)
Message-ID: <1526992839.16270.1506057739771.JavaMail.zimbra@efficios.com>
References: <20170919221342.29915-1-mathieu.desnoyers@efficios.com> <20170922032206.GE10893@tardis> <20170922033057.GF10893@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:43391 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdIVFVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 01:21:24 -0400
In-Reply-To: <20170922033057.GF10893@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>

----- On Sep 21, 2017, at 11:30 PM, Boqun Feng boqun.feng@gmail.com wrote:

> On Fri, Sep 22, 2017 at 11:22:06AM +0800, Boqun Feng wrote:
>> Hi Mathieu,
>> 
>> On Tue, Sep 19, 2017 at 06:13:41PM -0400, Mathieu Desnoyers wrote:
>> > Provide a new command allowing processes to register their intent to use
>> > the private expedited command.
>> > 
>> > This allows PowerPC to skip the full memory barrier in switch_mm(), and
>> > only issue the barrier when scheduling into a task belonging to a
>> > process that has registered to use expedited private.
>> > 
>> > Processes are now required to register before using
>> > MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.
>> > 
>> 
>> Sorry I'm late for the party, but I couldn't stop thinking whether we
>> could avoid the register thing at all, because the registering makes
>> sys_membarrier() more complex(both for the interface and the
>> implementation). So how about we trade-off a little bit by taking
>> some(not all) the rq->locks?
>> 
>> The idea is in membarrier_private_expedited(), we go through all ->curr
>> on each CPU and
>> 
>> 1)	If it's a userspace task and its ->mm is matched, we send an ipi
>> 
>> 2)	If it's a kernel task, we skip
>> 
>> 	(Because there will be a smp_mb() implied by mmdrop(), when it
>> 	switchs to userspace task).
>> 
>> 3)	If it's a userspace task and its ->mm is not matched, we take
>> 	the corresponding rq->lock and check rq->curr again, if its ->mm
>> 	matched, we send an ipi, otherwise we do nothing.
>> 
>> 	(Because if we observe rq->curr is not matched with rq->lock
>> 	held, when a task having matched ->mm schedules in, the rq->lock
>> 	pairing along with the smp_mb__after_spinlock() will guarantee
>> 	it observes all memory ops before sys_membarrir()).
>> 
>> membarrier_private_expedited() will look like this if we choose this
>> way:
>> 
>> void membarrier_private_expedited()
>> {
>> 	int cpu;
>> 	bool fallback = false;
>> 	cpumask_var_t tmpmask;
>> 	struct rq_flags rf;
>> 
>> 
>> 	if (num_online_cpus() == 1)
>> 		return;
>> 
>> 	smp_mb();
>> 
>> 	if (!zalloc_cpumask_var(&tmpmask, GFP_NOWAIT)) {
>> 		/* Fallback for OOM. */
>> 		fallback = true;
>> 	}
>> 
>> 	cpus_read_lock();
>> 	for_each_online_cpu(cpu) {
>> 		struct task_struct *p;
>> 
>> 		if (cpu == raw_smp_processor_id())
>> 			continue;
>> 
>> 		rcu_read_lock();
>> 		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
>> 
>> 		if (!p) {
>> 			rcu_read_unlock();
>> 			continue;
>> 		}
>> 
>> 		if (p->mm == current->mm) {
>> 			if (!fallback)
>> 				__cpumask_set_cpu(cpu, tmpmask);
>> 			else
>> 				smp_call_function_single(cpu, ipi_mb, NULL, 1);
>> 		}
>> 
>> 		if (p->mm == current->mm || !p->mm) {
>> 			rcu_read_unlock();
>> 			continue;
>> 		}
>> 
>> 		rcu_read_unlock();
>> 		
>> 		/*
>> 		 * This should be a arch-specific code, as we don't
>> 		 * need it at else place other than some archs without
>> 		 * a smp_mb() in switch_mm() (i.e. powerpc)
>> 		 */
>> 		rq_lock_irq(cpu_rq(cpu), &rf);
>> 		if (p->mm == current->mm) {
> 
> Oops, this one should be
> 
>		if (cpu_curr(cpu)->mm == current->mm)
> 
>> 			if (!fallback)
>> 				__cpumask_set_cpu(cpu, tmpmask);
>> 			else
>> 				smp_call_function_single(cpu, ipi_mb, NULL, 1);
> 
> , and this better be moved out of the lock rq->lock critical section.
> 
> Regards,
> Boqun
> 
>> 		}
>> 		rq_unlock_irq(cpu_rq(cpu), &rf);
>> 	}
>> 	if (!fallback) {
>> 		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
>> 		free_cpumask_var(tmpmask);
>> 	}
>> 	cpus_read_unlock();
>> 
>> 	smp_mb();
>> }
>> 
>> Thoughts?

Hi Boqun,

The main concern Peter has with the runqueue locking approach
is interference with the scheduler by hitting all CPU's runqueue
locks repeatedly if someone performs membarrier system calls in
a short loop.

Just reading the rq->curr pointer does not generate as much
overhead as grabbing each rq lock.

Thanks,

Mathieu


>> 
>> Regards,
>> Boqun
>> 
> [...]

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
