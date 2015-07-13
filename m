From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 08:43:44 +1000
Message-ID: <1436827424.3948.239.camel@kernel.crashing.org>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <20150713131143.GY19282@twins.programming.kicks-ass.net>
	 <20150713140915.GD2632@arm.com> <20150713142109.GE2632@arm.com>
	 <20150713155447.GB19282@twins.programming.kicks-ass.net>
	 <20150713182332.GW3717@linux.vnet.ibm.com>
	 <55A41481.7000702@hurleysoftware.com>
	 <20150713201642.GY3717@linux.vnet.ibm.com>
	 <20150713221503.GD19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713221503.GD19282@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Hurley <peter@hurleysoftware.com>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 2015-07-14 at 00:15 +0200, Peter Zijlstra wrote:

> > This is instead the sequence that is of concern:
> > 
> > 	store a
> > 	unlock M
> > 	lock N
> > 	load b
> 
> So its late and that table didn't parse, but that should be ordered too.
> The load of b should not be able to escape the lock N.
> 
> If only because LWSYNC is a valid RMB and any LOCK implementation must
> load the lock state to observe it unlocked.

What happens is that the load passes the store conditional, though it
doesn't pass the load with reserve. However, both store A and unlock M
being just stores with an lwsync, can pass a load, so they can pass the
load with reserve. And thus inside the LL/SC loop, our store A has
passed our load B.

> > > Additionally, the assertion in Documentation/memory_barriers.txt that
> > > the sequence above can be reordered as
> > > 
> > >   LOCK N
> > >   store b
> > >   store a
> > >   UNLOCK M
> > > 
> > > is not true on any existing arch in Linux.
> > 
> > It was at one time and might be again.
> 
> What would be required to make this true? I'm having a hard time seeing
> how things can get reordered like that.
