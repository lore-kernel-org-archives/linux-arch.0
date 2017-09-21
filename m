From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 1/2] membarrier: Provide register expedited
 private command
Date: Thu, 21 Sep 2017 08:27:28 -0700
Message-ID: <20170921152728.GF3521@linux.vnet.ibm.com>
References: <20170918223648.31505-1-mathieu.desnoyers@efficios.com>
 <20170921121344.movkcoj6rm2s23ig@hirez.programming.kicks-ass.net>
 <196603634.15769.1506006703406.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <196603634.15769.1506006703406.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 21, 2017 at 03:11:43PM +0000, Mathieu Desnoyers wrote:
> ----- On Sep 21, 2017, at 8:13 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Mon, Sep 18, 2017 at 06:36:47PM -0400, Mathieu Desnoyers wrote:
> >> @@ -3373,6 +3362,7 @@ static void __sched notrace __schedule(bool preempt)
> >>  
> >>  		/* Also unlocks the rq: */
> >>  		rq = context_switch(rq, prev, next, &rf);
> >> +		membarrier_arch_sched_in(prev, next);
> > 
> > That's wrong iirc; we just switched stacks, you cannot use @prev and
> > @next.
> 
> Yes, it did indeed explode spectacularly at boot in testing. RFC v3 fixes that.

Good to hear that there is a useful test.  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> >>  	} else {
> >>  		rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> > >  		rq_unlock_irq(rq, &rf);
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
