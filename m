From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 5/7] locking/qrwlock: make use of
 acquire/release/relaxed atomics
Date: Thu, 16 Jul 2015 19:13:27 +0100
Message-ID: <20150716181327.GT26390@arm.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
 <1437060758-10381-6-git-send-email-will.deacon@arm.com>
 <20150716165903.GA19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150716165903.GA19282@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2015 at 05:59:03PM +0100, Peter Zijlstra wrote:
> On Thu, Jul 16, 2015 at 04:32:36PM +0100, Will Deacon wrote:
> > @@ -130,8 +130,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
> >  	/*
> >  	 * Atomically decrement the reader count
> >  	 */
> > -	smp_mb__before_atomic();
> > -	atomic_sub(_QR_BIAS, &lock->cnts);
> > +	(void)atomic_sub_return_release(_QR_BIAS, &lock->cnts);
> >  }
> >  
> >  /**
> 
> This one will actually cause different code on x86; I think its still
> fine though. LOCK XADD should not be (much) slower than LOCK SUB.

Yeah, I wondered whether introduced atomic_sub_release etc was worth the
hassle and decided against it for now.

> > diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> > index a71bb3541880..879c8fab7bea 100644
> > --- a/kernel/locking/qrwlock.c
> > +++ b/kernel/locking/qrwlock.c
> > @@ -36,7 +36,7 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
> >  {
> >  	while ((cnts & _QW_WMASK) == _QW_LOCKED) {
> >  		cpu_relax_lowlatency();
> > -		cnts = smp_load_acquire((u32 *)&lock->cnts);
> > +		cnts = atomic_read_acquire(&lock->cnts);
> >  	}
> >  }
> 
> It might make sense to add comments to the users of this function that
> actually rely on the _acquire semantics, I had to double check that :-)

Good point, I'll add those.

> But otherwise that all looks good.

Cheers. I'll send a v3 next week with your comments addressed. Pending
any objection, I guess this could be merged via -tip with the exception
of the ARM patch? FWIW, I plan to port arm64 once I've got my pending
asm/atomic.h rework queued.

Will
