From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Thu, 16 Jul 2015 11:34:25 +1000
Message-ID: <1437010465.28475.1.camel@ellerman.id.au>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <1436826689.3948.233.camel@kernel.crashing.org>
	 <1436929578.10956.3.camel@ellerman.id.au>
	 <20150715141814.GZ3717@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150715141814.GZ3717@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2015-07-15 at 07:18 -0700, Paul E. McKenney wrote:
> On Wed, Jul 15, 2015 at 01:06:18PM +1000, Michael Ellerman wrote:
> > On Tue, 2015-07-14 at 08:31 +1000, Benjamin Herrenschmidt wrote:
> > > Michael, at some point you were experimenting a bit with that and tried
> > > to get some perf numbers of the impact that would have, did that
> > > solidify ? Otherwise, I'll have a look when I'm back next week.
> > 
> > I was mainly experimenting with replacing the lwsync in lock with an isync.
> > 
> > But I think you're talking about making it a full sync in lock.
> > 
> > That was about +7% on p8, +25% on p7 and +88% on p6.
> 
> Just for completeness, what were you running as benchmark?  ;-)

Heh sorry :)

That was my lockcomparison benchmark, based on Anton's original. It just does
100,000,000 lock/unlocks for each type in userspace:

  https://github.com/mpe/lockcomparison/blob/master/lock_comparison.c

cheers
