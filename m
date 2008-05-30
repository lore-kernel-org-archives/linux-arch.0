From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:18:47 +0200
Message-ID: <20080530091847.GA26563@elte.hu>
References: <20080530035620.587204923@sgi.com> <1212138752.12349.227.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:38369 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbYE3JTI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 05:19:08 -0400
Content-Disposition: inline
In-Reply-To: <1212138752.12349.227.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> What this does is make a strong connection between data and 
> concurrency control. Your proposed scheme weakens the 
> data<->concurrency relation instead of making it stronger.

and that's not just an issue for -rt but also for general kernel 
maintainability: opaque APIs weaken our data structures because it's not 
apparent what is done exactly why. In that sense a 
spin_lock(&data->lock) is as clear as it gets.

> One sign of that is that you replace things like get_cpu with explicit 
> preempt_disable().
> 
> We're trying to get rid of as many explicit preempt_disable()s as 
> possible - in the light of -rt, preempt_disable() is as bad as the BKL 
> in that its opaque - unrelated to a specific data set.
> 
> *lightbulb*
> 
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

seconded.

	Ingo
