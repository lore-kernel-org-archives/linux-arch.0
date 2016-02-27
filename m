From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch 20/20] rcu: Make CPU_DYING_IDLE an explicit call
Date: Fri, 26 Feb 2016 18:23:08 -0800
Message-ID: <20160227022308.GA3959@linux.vnet.ibm.com>
References: <20160226164321.657646833@linutronix.de>
 <20160226182341.870167933@linutronix.de>
 <20160227021429.GN3522@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:58109 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933856AbcB0CX3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 21:23:29 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 26 Feb 2016 19:23:28 -0700
Content-Disposition: inline
In-Reply-To: <20160227021429.GN3522@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Fri, Feb 26, 2016 at 06:14:29PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 26, 2016 at 06:43:44PM -0000, Thomas Gleixner wrote:
> > Make the RCU CPU_DYING_IDLE callback an explicit function call, so it gets
> > invoked at the proper place.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> A question below...
> 
> > ---
> >  include/linux/cpu.h      |    4 +---
> >  include/linux/notifier.h |    2 ++
> >  include/linux/rcupdate.h |    4 +---
> >  kernel/cpu.c             |    1 +
> >  kernel/rcu/tree.c        |   26 +++++++++++++++-----------
> >  kernel/sched/idle.c      |    2 --
> >  6 files changed, 20 insertions(+), 19 deletions(-)
> > 
> > Index: b/include/linux/cpu.h
> > ===================================================================
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -101,9 +101,7 @@ enum {
> >  					* Called on the new cpu, just before
> >  					* enabling interrupts. Must not sleep,
> >  					* must not fail */
> > -#define CPU_DYING_IDLE		0x000B /* CPU (unsigned)v dying, reached
> > -					* idle loop. */
> > -#define CPU_BROKEN		0x000C /* CPU (unsigned)v did not die properly,
> > +#define CPU_BROKEN		0x000B /* CPU (unsigned)v did not die properly,
> >  					* perhaps due to preemption. */
> > 
> >  /* Used for CPU hotplug events occurring while tasks are frozen due to a suspend
> > Index: b/include/linux/notifier.h
> > ===================================================================
> > --- a/include/linux/notifier.h
> > +++ b/include/linux/notifier.h
> > @@ -47,6 +47,8 @@
> >   * runtime initialization.
> >   */
> > 
> > +struct notifier_block;
> > +
> >  typedef	int (*notifier_fn_t)(struct notifier_block *nb,
> >  			unsigned long action, void *data);
> > 
> > Index: b/include/linux/rcupdate.h
> > ===================================================================
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -332,9 +332,7 @@ void rcu_init(void);
> >  void rcu_sched_qs(void);
> >  void rcu_bh_qs(void);
> >  void rcu_check_callbacks(int user);
> > -struct notifier_block;
> > -int rcu_cpu_notify(struct notifier_block *self,
> > -		   unsigned long action, void *hcpu);
> > +void rcu_report_dead(unsigned int cpu);
> > 
> >  #ifndef CONFIG_TINY_RCU
> >  void rcu_end_inkernel_boot(void);
> > Index: b/kernel/cpu.c
> > ===================================================================
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -762,6 +762,7 @@ void cpuhp_report_idle_dead(void)
> >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> >  	st->state = CPUHP_AP_IDLE_DEAD;
> >  	complete(&st->done);
> 
> What prevents the other CPU from killing this CPU at this point, so
> that this CPU does not tell RCU that it is dead?
> 
> I agree that the odds should be low, but there are all manner of things
> that might delay a CPU for just a little bit too long...
> 
> Or am I missing something subtle here?

Just in case I am not missing anything...

One approach is to go back to the spinning, but to do rcu_report_dead()
just before kicking the other CPU.  This would also fix some issues with
use of RCU of the offline path, so would definitely be better than my
earlier approach of notifying RCU from within the idle loop.

This assumes that all the offline paths have been consolidated into
this path.  (Yes, I was too lazy and cowardly to consolidate them all
last I touched this code, but perhaps that has happened elsewise?)

							Thanx, Paul

> > +	rcu_report_dead(smp_processor_id());
> >  }
> > 
> >  #else
> > Index: b/kernel/rcu/tree.c
> > ===================================================================
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4247,6 +4247,21 @@ static void rcu_prepare_cpu(int cpu)
> >  		rcu_init_percpu_data(cpu, rsp);
> >  }
> > 
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +void rcu_report_dead(unsigned int cpu)
> > +{
> > +	struct rcu_state *rsp;
> > +
> > +	/* QS for any half-done expedited RCU-sched GP. */
> > +	preempt_disable();
> > +	rcu_report_exp_rdp(&rcu_sched_state,
> > +			   this_cpu_ptr(rcu_sched_state.rda), true);
> > +	preempt_enable();
> > +	for_each_rcu_flavor(rsp)
> > +		rcu_cleanup_dying_idle_cpu(cpu, rsp);
> > +}
> > +#endif
> > +
> >  /*
> >   * Handle CPU online/offline notification events.
> >   */
> > @@ -4278,17 +4293,6 @@ int rcu_cpu_notify(struct notifier_block
> >  		for_each_rcu_flavor(rsp)
> >  			rcu_cleanup_dying_cpu(rsp);
> >  		break;
> > -	case CPU_DYING_IDLE:
> > -		/* QS for any half-done expedited RCU-sched GP. */
> > -		preempt_disable();
> > -		rcu_report_exp_rdp(&rcu_sched_state,
> > -				   this_cpu_ptr(rcu_sched_state.rda), true);
> > -		preempt_enable();
> > -
> > -		for_each_rcu_flavor(rsp) {
> > -			rcu_cleanup_dying_idle_cpu(cpu, rsp);
> > -		}
> > -		break;
> >  	case CPU_DEAD:
> >  	case CPU_DEAD_FROZEN:
> >  	case CPU_UP_CANCELED:
> > Index: b/kernel/sched/idle.c
> > ===================================================================
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -220,8 +220,6 @@ static void cpu_idle_loop(void)
> >  			rmb();
> > 
> >  			if (cpu_is_offline(smp_processor_id())) {
> > -				rcu_cpu_notify(NULL, CPU_DYING_IDLE,
> > -					       (void *)(long)smp_processor_id());
> >  				cpuhp_report_idle_dead();
> >  				arch_cpu_idle_dead();
> >  			}
> > 
> > 
