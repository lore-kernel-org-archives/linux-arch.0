From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/11] sched, rcu: Make RCU use resched_cpu()
Date: Tue, 24 Sep 2013 06:37:42 -0700
Message-ID: <20130924133742.GY9093@linux.vnet.ibm.com>
References: <20130917082838.218329307@infradead.org>
 <20130917091143.449530904@infradead.org>
 <20130917144012.GC29354@twins.programming.kicks-ass.net>
 <20130923165540.GP9093@linux.vnet.ibm.com>
 <20130923211827.GA7032@linux.vnet.ibm.com>
 <20130924080706.GI9326@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:40040 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab3IXNht (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Sep 2013 09:37:49 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 24 Sep 2013 07:37:48 -0600
Content-Disposition: inline
In-Reply-To: <20130924080706.GI9326@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>

On Tue, Sep 24, 2013 at 10:07:06AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 23, 2013 at 02:18:27PM -0700, Paul E. McKenney wrote:
> > Passes light testing, but I am confused about why the change to
> > resched_task() when only resched_cpu() is invoked elsewhere in the patch.
> > Enlightenment?
> > > > -#ifdef CONFIG_SMP
> > > >  void resched_task(struct task_struct *p)
> > > >  {
> > > >  	int cpu;
> > > > 
> > > > -	assert_raw_spin_locked(&task_rq(p)->lock);
> > > > +	lockdep_assert_held(&task_rq(p)->lock);
> > > > 
> > > >  	if (test_tsk_need_resched(p))
> > > >  		return;
> 
> That one? Fly by fixup I suppose.. the lockdep check is cheaper as it
> compiles away for !lockdep kernels, also its more correct.

OK, happy to carry it, just wanted to make sure it was supposed to be there.

							Thanx, Paul
