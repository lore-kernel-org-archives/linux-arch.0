From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 20:39:02 +0200
Message-ID: <1212172742.24826.19.camel@lappy.programming.kicks-ass.net>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins>
	 <Pine.LNX.4.64.0805301106360.14564@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:50525 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYE3Sj6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:39:58 -0400
In-Reply-To: <Pine.LNX.4.64.0805301106360.14564@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2008-05-30 at 11:08 -0700, Christoph Lameter wrote:
> On Fri, 30 May 2008, Peter Zijlstra wrote:
> 
> > The thing we generally do is, we add a lock to each per-cpu data item,
> > use raw_smp_processor_id() to obtain the current cpu's data lock the
> > thing and work from it - even if we are migrated away.
> > 
> > For instance:
> > 
> > struct kmem_cache_cpu {
> > 	.....
> > 	spinlock_t lock;
> > }
> > 
> > struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s, int cpu)
> > {
> > 	struct kmem_cache_cpu *c = s->cpu_slab[cpu];
> > 	spin_lock(&c->lock);
> > 	return c;
> 
> Hmmm... Can we reschedule before spin_lock? It seems that preemption must 
> already be off for this to work.

spinlocks turn into PI-mutexes for -rt, so preemption doesn't get
disabled at all.

> 
> > What this does is make a strong connection between data and concurrency
> > control. Your proposed scheme weakens the data<->concurrency relation
> > instead of making it stronger.
> 
> Yes the cpu ops allow atomic per cpu ops without preemption / interrupt 
> enable disable. I thought that would help -rt quit a bit.

It does, but that is not the thing I'm pointing out.

The thing I'm addressing here is using structured per-cpu data like the
kmem_cache_cpu that needs preempt disabled (or another form of
concurrency control).

For -rt add the spinlock and thereby guarantee mutual exclusion in the
face of preemption. This of course does mean reduced performance due to
remote cpu memory accesses, but otherwise the allocator (slub in this
case) would have far too large preempt-off sections.

> > Ah, we could still do the above by writing:
> > 
> > struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s)
> > {
> > 	struct kmem_cache_cpu *c = THIS_CPU(s->cpu_slab);
> > 	spin_lock(&c->lock);
> > 	return c;
> > }
> > 
> > void put_cpu_slab(struct kmem_cache_cpu *c)
> > {
> > 	spin_unlock(&c->lock);
> > }
> > 
> > Would it be possible to re-structure your API to also have these get/put
> > methods instead of just a get?
> 
> I do not see a problem since you must already have preemption disabled 
> when callin get_cpu_slab(). Otherwise you may take the lock on another 
> processor if the process was rescheduled.

No, no, the !rt version looks like:

struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s)
{
	preempt_disable();
	return THIS_CPU(s->cpu_slab);
}

void put_cpu_slab(struct kmem_cache_cpu *c)
{
	preempt_enable();
}

For the -rt version it doesn't matter if we preempt or not, access is
regulated by the ->lock.
