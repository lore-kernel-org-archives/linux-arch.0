From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:08:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301106360.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <1212138752.12349.227.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:46191 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752564AbYE3SI4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 14:08:56 -0400
In-Reply-To: <1212138752.12349.227.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> The thing we generally do is, we add a lock to each per-cpu data item,
> use raw_smp_processor_id() to obtain the current cpu's data lock the
> thing and work from it - even if we are migrated away.
> 
> For instance:
> 
> struct kmem_cache_cpu {
> 	.....
> 	spinlock_t lock;
> }
> 
> struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s, int cpu)
> {
> 	struct kmem_cache_cpu *c = s->cpu_slab[cpu];
> 	spin_lock(&c->lock);
> 	return c;

Hmmm... Can we reschedule before spin_lock? It seems that preemption must 
already be off for this to work.


> What this does is make a strong connection between data and concurrency
> control. Your proposed scheme weakens the data<->concurrency relation
> instead of making it stronger.

Yes the cpu ops allow atomic per cpu ops without preemption / interrupt 
enable disable. I thought that would help -rt quit a bit.


> Ah, we could still do the above by writing:
> 
> struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s)
> {
> 	struct kmem_cache_cpu *c = THIS_CPU(s->cpu_slab);
> 	spin_lock(&c->lock);
> 	return c;
> }
> 
> void put_cpu_slab(struct kmem_cache_cpu *c)
> {
> 	spin_unlock(&c->lock);
> }
> 
> Would it be possible to re-structure your API to also have these get/put
> methods instead of just a get?

I do not see a problem since you must already have preemption disabled 
when callin get_cpu_slab(). Otherwise you may take the lock on another 
processor if the process was rescheduled.
