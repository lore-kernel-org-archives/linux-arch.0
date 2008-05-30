From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 12:10:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301156530.16253@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com>  <1212138752.12349.227.camel@twins>
  <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
 <1212171574.24826.12.camel@lappy.programming.kicks-ass.net>
 <Pine.LNX.4.64.0805301126130.14781@schroedinger.engr.sgi.com>
 <1212173236.24826.29.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:33316 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753375AbYE3TKF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 15:10:05 -0400
In-Reply-To: <1212173236.24826.29.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> Take for instance kmem_cache_cpu, you currently serialize that by strict
> per-cpu-ness and disabling preemption.

Right. The preemption in the fast paths could go away. Would be more 
difficult to do in the slow paths.
 
> The problem is that the preempt-off sections are rather long - so what
> we do is add a lock (mutex) and serialize that way - ignoring the cpu
> affinity.

long? What is so expensive to process there?
 
> 
> so currently:
> 
>   preempt_disable();
>   c = get_cpu_slab();
> 
>   do load of stuff on c;
>   preempt_enable();
> 
> 
> where the preempt-off section is rather long, we'd like to change that
> to:
> 
> 
>   c = get_cpu_slab();
> 
>   do stuff to c;
> 
>   put_cpu_slab(c);
> 
> 
> so that we can pick between:
> 
> 
> !rt
> 
> get_cpu_slab(s)
> {
> 	preempt_disable();
> 	return THIS_CPU(s->cpu_slab);
> }
> 
> put_cpu_slab(c)
> {
> 	preempt_enable();
> }
> 
> 
> -rt:
> 
> get_cpu_slab(s)
> {
> 	c = THIS_CPU(s->cpu_slab);
> 	spin_lock(&c->lock); // <-- really a PI-mutex
> }
> 
> put_cpu_slab(c)
> {
> 	spin_unlock(&c->lock);
> }
> 
> 
> Also, it explicitly ties the preempt-off section to the data used in
> case of !rt, which in turn allows for the direct conversion to the
> locked version.

Ahh. Okay. This would make the lockless preemptless fastpath impossible 
because it would have to use some sort of locking to avoid access to the 
same percpu data from multiple processor?
