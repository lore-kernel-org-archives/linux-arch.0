From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Sat, 31 May 2008 20:25:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805312021560.20941@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com>  <1212138752.12349.227.camel@twins>
 <20080530091847.GA26563@elte.hu>  <Pine.LNX.4.64.0805301109120.14564@schroedinger.engr.sgi.com>
  <1212172834.24826.22.camel@lappy.programming.kicks-ass.net>
 <Pine.LNX.4.64.0805301155380.16253@schroedinger.engr.sgi.com>
 <1212174798.24826.44.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:34961 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753658AbYFADZ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 31 May 2008 23:25:57 -0400
In-Reply-To: <1212174798.24826.44.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> Remember, horribly long on -rt is in the order of ~30us.
> 
> See for instance the path:
> 
>  flush_slab()
>    slab_lock() <-- bit_spinlock
>    deactive_slab()
>      loop over objects

looping over all objects is rarely ever done.

>      unfreeze_slab()
>        add_partial()
>          spin_lock(&n->list_lock) <-- another lock
> 
> all of that runs with preempt disabled, and worse it can spin for some
> indefinite amount of time.
> 
> That is totally unacceptable on -rt, so we need to make it all
> preemptible and use sleeping locks (IRQ inversion can't happen, for the
> only thing that runs in hardirq is try_to_wake_up()).

The way I thought about -rt was that it would convert the 
spinlocks to semaphores. Isnt it possible to sleep on a bit spinlock in 
-rt? Aside from that I would have thought that the simple disabling of 
rescheduling on another processor in some context would gets us there. 

Never thought about the details though.
