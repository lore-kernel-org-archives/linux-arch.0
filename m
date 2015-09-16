From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Wed, 16 Sep 2015 11:14:52 +0200
Message-ID: <20150916091452.GC3816@twins.programming.kicks-ass.net>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59116 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbIPJUR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2015 05:20:17 -0400
Content-Disposition: inline
In-Reply-To: <20150915174724.GP4029@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 15, 2015 at 10:47:24AM -0700, Paul E. McKenney wrote:
> > diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> > index 0eca6efc0631..919624634d0a 100644
> > --- a/arch/powerpc/include/asm/barrier.h
> > +++ b/arch/powerpc/include/asm/barrier.h
> > @@ -87,6 +87,7 @@ do {									\
> >  	___p1;								\
> >  })
> > 
> > +#define smp_mb__release_acquire()   smp_mb()
> 
> If we are handling locking the same as atomic acquire and release
> operations, this could also be placed between the unlock and the lock.

I think the point was exactly that we need to separate LOCK/UNLOCK from
ACQUIRE/RELEASE.

> However, independently of the unlock/lock case, this definition and
> use of smp_mb__release_acquire() does not handle full ordering of a
> release by one CPU and an acquire of that same variable by another.

> In that case, we need roughly the same setup as the much-maligned
> smp_mb__after_unlock_lock().  So, do we care about this case?  (RCU does,
> though not 100% sure about any other subsystems.)

Indeed, that is a hole in the definition, that I think we should close.

> >  #define smp_mb__before_atomic()     smp_mb()
> >  #define smp_mb__after_atomic()      smp_mb()
> >  #define smp_mb__before_spinlock()   smp_mb()
> > diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> > index 0681d2532527..1c61ad251e0e 100644
> > --- a/arch/x86/include/asm/barrier.h
> > +++ b/arch/x86/include/asm/barrier.h
> > @@ -85,6 +85,8 @@ do {									\
> >  	___p1;								\
> >  })
> > 
> > +#define smp_mb__release_acquire()	smp_mb()
> > +
> >  #endif
> > 

All TSO archs would want this.

> >  /* Atomic operations are already serializing on x86 */
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index b42afada1280..61ae95199397 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -119,5 +119,9 @@ do {									\
> >  	___p1;								\
> >  })
> > 
> > +#ifndef smp_mb__release_acquire
> > +#define smp_mb__release_acquire()	do { } while (0)
> 
> Doesn't this need to be barrier() in the case where one variable was
> released and another was acquired?

Yes, I think its very prudent to never let any barrier degrade to less
than barrier().
