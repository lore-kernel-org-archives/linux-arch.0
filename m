From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 13:51:46 +0100
Message-ID: <20150714125146.GJ16213@arm.com>
References: <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
 <20150713142109.GE2632@arm.com>
 <20150713155447.GB19282@twins.programming.kicks-ass.net>
 <20150713175029.GO2632@arm.com>
 <20150713202032.GZ3717@linux.vnet.ibm.com>
 <20150713222346.GE19282@twins.programming.kicks-ass.net>
 <20150713230405.GB3717@linux.vnet.ibm.com>
 <20150714100429.GC15448@arm.com>
 <20150714124540.GC3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714124540.GC3717@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Tue, Jul 14, 2015 at 01:45:40PM +0100, Paul E. McKenney wrote:
> On Tue, Jul 14, 2015 at 11:04:29AM +0100, Will Deacon wrote:
> > Given that RCU is currently the only user of this barrier, how would you
> > feel about making the barrier local to RCU and not part of the general
> > memory-barrier API?
> 
> In theory, no objection.  Your thought is to leave the definitions where
> they are, mark them as being used only by RCU, and removing mention from
> memory-barriers.txt?  Or did you have something else in mind?

Actually, I was thinking of defining them in an RCU header file with an
#ifdef CONFIG_POWERPC for the smb_mb() version. Then you could have a big
comment describing the semantics, or put that in an RCU Documentation file
instead of memory-barriers.txt.

That *should* then mean we notice anybody else trying to use the barrier,
because they'd need to send patches to either add something equivalent
or move the definition out again.

> > My main reason for proposing its removal is because I don't want to see
> > it being used (incorrectly) all over the place to order the new RELEASE
> > and ACQUIRE operations I posted separately, at which point we have to try
> > fixing up all the callers or retrofitting some semantics. It doesn't help
> > that memory-barriers.txt lumps things like LOCK and ACQUIRE together,
> > whereas this barrier is currently only intended to be used in conjunction
> > with the former.
> 
> Heh!  That lumping was considered to be a feature at the time.  ;-)

Oh, I'm sure it was added with good intentions!

Will
