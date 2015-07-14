From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 10:34:15 +0200
Message-ID: <20150714083415.GH19282@twins.programming.kicks-ass.net>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713182332.GW3717@linux.vnet.ibm.com>
 <55A41481.7000702@hurleysoftware.com>
 <20150713201642.GY3717@linux.vnet.ibm.com>
 <20150713221503.GD19282@twins.programming.kicks-ass.net>
 <1436827424.3948.239.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436827424.3948.239.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Hurley <peter@hurleysoftware.com>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 14, 2015 at 08:43:44AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2015-07-14 at 00:15 +0200, Peter Zijlstra wrote:
> 
> > > This is instead the sequence that is of concern:
> > > 
> > > 	store a
> > > 	unlock M
> > > 	lock N
> > > 	load b
> > 
> > So its late and that table didn't parse, but that should be ordered too.
> > The load of b should not be able to escape the lock N.
> > 
> > If only because LWSYNC is a valid RMB and any LOCK implementation must
> > load the lock state to observe it unlocked.
> 
> What happens is that the load passes the store conditional, though it
> doesn't pass the load with reserve. However, both store A and unlock M
> being just stores with an lwsync, can pass a load, so they can pass the
> load with reserve. And thus inside the LL/SC loop, our store A has
> passed our load B.

Ah cute.. Thanks, clearly I wasn't awake enough anymore :-)
