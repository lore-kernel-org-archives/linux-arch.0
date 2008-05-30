From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 20:47:16 +0200
Message-ID: <1212173236.24826.29.camel@lappy.programming.kicks-ass.net>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins>
	 <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
	 <1212171574.24826.12.camel@lappy.programming.kicks-ass.net>
	 <Pine.LNX.4.64.0805301126130.14781@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59676 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYE3StV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:49:21 -0400
In-Reply-To: <Pine.LNX.4.64.0805301126130.14781@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2008-05-30 at 11:26 -0700, Christoph Lameter wrote:
> On Fri, 30 May 2008, Peter Zijlstra wrote:
> 
> > Please consider adding this get/put interface.
> 
> If you could explain why? So far this seems to be based on a 
> misunderstanding.

Take for instance kmem_cache_cpu, you currently serialize that by strict
per-cpu-ness and disabling preemption.

The problem is that the preempt-off sections are rather long - so what
we do is add a lock (mutex) and serialize that way - ignoring the cpu
affinity.


so currently:

  preempt_disable();
  c = get_cpu_slab();

  do load of stuff on c;
  preempt_enable();


where the preempt-off section is rather long, we'd like to change that
to:


  c = get_cpu_slab();

  do stuff to c;

  put_cpu_slab(c);


so that we can pick between:


!rt

get_cpu_slab(s)
{
	preempt_disable();
	return THIS_CPU(s->cpu_slab);
}

put_cpu_slab(c)
{
	preempt_enable();
}


-rt:

get_cpu_slab(s)
{
	c = THIS_CPU(s->cpu_slab);
	spin_lock(&c->lock); // <-- really a PI-mutex
}

put_cpu_slab(c)
{
	spin_unlock(&c->lock);
}


Also, it explicitly ties the preempt-off section to the data used in
case of !rt, which in turn allows for the direct conversion to the
locked version.
