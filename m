From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Date: Fri, 21 Feb 2020 21:25:11 +0100
Message-ID: <20200221202511.GB14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
 <20200221100855.2f9bec3a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 15:25:38 -0500
Content-Disposition: inline
In-Reply-To: <20200221100855.2f9bec3a@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Feb 21, 2020 at 10:08:55AM -0500, Steven Rostedt wrote:
> On Fri, 21 Feb 2020 14:34:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
> >  
> >  void lockdep_off(void)
> >  {
> > -	current->lockdep_recursion++;
> > +	current->lockdep_recursion += BIT(16);
> >  }
> >  EXPORT_SYMBOL(lockdep_off);
> >  
> >  void lockdep_on(void)
> >  {
> > -	current->lockdep_recursion--;
> > +	current->lockdep_recursion -= BIT(16);
> >  }
> >  EXPORT_SYMBOL(lockdep_on);
> >  
> 
> > +
> > +static bool lockdep_nmi(void)
> > +{
> > +	if (current->lockdep_recursion & 0xFFFF)
> 
> Nitpick, but the association with bit 16 and this mask really should be
> defined as a macro somewhere and not have hard coded numbers.

Right, I suppose I can do something like:

#define LOCKDEP_RECURSION_BITS	16
#define LOCKDEP_OFF (1U << LOCKDEP_RECURSION_BITS)
#define LOCKDEP_RECURSION_MASK (LOCKDEP_OFF - 1)
