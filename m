From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:12:32 +0200
Message-ID: <1212138752.12349.227.camel@twins>
References: <20080530035620.587204923@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:56552 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYE3JN4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 05:13:56 -0400
In-Reply-To: <20080530035620.587204923@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

Hi Christoph,

I'm having some trouble liking this.

For one the fixed size alloction limit as pointed out by Andrew.

Secondly but way more important (for me), you seem to make life way more
difficult for -rt.

The thing we generally do is, we add a lock to each per-cpu data item,
use raw_smp_processor_id() to obtain the current cpu's data lock the
thing and work from it - even if we are migrated away.

For instance:

struct kmem_cache_cpu {
	.....
	spinlock_t lock;
}

struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s, int cpu)
{
	struct kmem_cache_cpu *c = s->cpu_slab[cpu];
	spin_lock(&c->lock);
	return c;
}

void put_cpu_slab(struct kmem_cache_cpu *c)
{
	spin_unlock(&c->lock);
}

What this does is make a strong connection between data and concurrency
control. Your proposed scheme weakens the data<->concurrency relation
instead of making it stronger.

One sign of that is that you replace things like get_cpu with explicit
preempt_disable().

We're trying to get rid of as many explicit preempt_disable()s as
possible - in the light of -rt, preempt_disable() is as bad as the BKL
in that its opaque - unrelated to a specific data set.

*lightbulb*

Ah, we could still do the above by writing:

struct kmem_cache_cpu *get_cpu_slab(struct kmem_cache *s)
{
	struct kmem_cache_cpu *c = THIS_CPU(s->cpu_slab);
	spin_lock(&c->lock);
	return c;
}

void put_cpu_slab(struct kmem_cache_cpu *c)
{
	spin_unlock(&c->lock);
}

Would it be possible to re-structure your API to also have these get/put
methods instead of just a get?


#define GET_THIS_CPU(__p) \
	({ preempt_disable(); SHIFT_PERCPU_PTR((__p), my_cpu_offset); })

#define PUT_THIS_CPU(__c)	\
do {				\
	(void)(__c);		\
	preempt_enable();	\
} while (0)


That would immediately get rid of those preempt_disable() calls, and
provide enough hooks for -rt.



Also, please add:

QUILT_DIFF_OPTS="--show-c-function"

somewhere to your environment or .quiltrc
