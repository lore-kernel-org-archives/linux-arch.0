From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Sun, 01 Jun 2008 10:19:15 +0200
Message-ID: <1212308355.18235.0.camel@twins>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins> <20080530091847.GA26563@elte.hu>
	 <Pine.LNX.4.64.0805301109120.14564@schroedinger.engr.sgi.com>
	 <1212172834.24826.22.camel@lappy.programming.kicks-ass.net>
	 <Pine.LNX.4.64.0805301155380.16253@schroedinger.engr.sgi.com>
	 <1212174798.24826.44.camel@lappy.programming.kicks-ass.net>
	 <Pine.LNX.4.64.0805312021560.20941@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:44813 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYFAIUh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Jun 2008 04:20:37 -0400
In-Reply-To: <Pine.LNX.4.64.0805312021560.20941@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Sat, 2008-05-31 at 20:25 -0700, Christoph Lameter wrote:
> On Fri, 30 May 2008, Peter Zijlstra wrote:
> 
> > Remember, horribly long on -rt is in the order of ~30us.
> > 
> > See for instance the path:
> > 
> >  flush_slab()
> >    slab_lock() <-- bit_spinlock
> >    deactive_slab()
> >      loop over objects
> 
> looping over all objects is rarely ever done.
> 
> >      unfreeze_slab()
> >        add_partial()
> >          spin_lock(&n->list_lock) <-- another lock
> > 
> > all of that runs with preempt disabled, and worse it can spin for some
> > indefinite amount of time.
> > 
> > That is totally unacceptable on -rt, so we need to make it all
> > preemptible and use sleeping locks (IRQ inversion can't happen, for the
> > only thing that runs in hardirq is try_to_wake_up()).
> 
> The way I thought about -rt was that it would convert the 
> spinlocks to semaphores. Isnt it possible to sleep on a bit spinlock in 
> -rt? Aside from that I would have thought that the simple disabling of 
> rescheduling on another processor in some context would gets us there. 
> 
> Never thought about the details though.

s/semaphores/PI-mutexes/

yes you can do a bit-sleep-lock ala lock_page.

But for any sleeping lock we must not have preemption disabled, coming
right back to the initial problem.
