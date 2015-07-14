From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Tue, 14 Jul 2015 12:31:47 +0100
Message-ID: <20150714113147.GF16213@arm.com>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
 <1436790687-11984-2-git-send-email-will.deacon@arm.com>
 <20150714102511.GI19282@twins.programming.kicks-ass.net>
 <20150714103220.GB16213@arm.com>
 <20150714105837.GJ19282@twins.programming.kicks-ass.net>
 <20150714110811.GE16213@arm.com>
 <20150714112420.GK3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33875 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbbGNLbu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 07:31:50 -0400
Content-Disposition: inline
In-Reply-To: <20150714112420.GK3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Tue, Jul 14, 2015 at 12:24:20PM +0100, Peter Zijlstra wrote:
> On Tue, Jul 14, 2015 at 12:08:11PM +0100, Will Deacon wrote:
> > On Tue, Jul 14, 2015 at 11:58:37AM +0100, Peter Zijlstra wrote:
> 
> 
> > > #ifndef atomic_add_return_relaxed
> > > 
> > > #define atomic_add_return_relaxed	atomic_add_return
> > > /*
> > >  * If one cannot define a more relaxed version,
> > >  * acquire/release are out the window too.
> > >  */
> > > #define  atomic_add_return_acquire	atomic_add_return
> > > #define  atomic_add_return_release	atomic_add_return
> > > 
> > > #else /* relaxed */
> > > 
> > > #ifndef atomic_add_return_acquire
> > > #define  atomic_add_return_acquire(args...)	\
> > > do {						\
> > > 	atomic_add_return_relaxed(args);	\
> > > 	smp_mb__after_atomic();			\
> > > } while (0)
> > > #endif
> > > 
> > > #ifndef atomic_add_return_release
> > > #define  atomic_add_return_release(args...)	\
> > > do {						\
> > > 	smp_mb__before_atomic();		\
> > > 	atomic_add_return_relaxed(args);	\
> > > } while (0)
> > > #endif
> 
> One could even take it one step further and go:
> 
> #ifndef atomic_add_return
> #define atomic_add_return(args...)		\
> do {						\
> 	smp_mb__before_atomic();		\
> 	atomid_add_return_relaxed(args);	\
> 	smp_mb__after_atomic();			\
> } while (0)

...and

#ifndef atomic_add
#define atomic_add(args...)	(void)atomic_add_return_relaxed(args);

It would mean a new architecture only has to define a barrier instruction
and a handful of relaxed atomics for a bare-minimum atomic.h avoiding
spinlocks.

Will
