From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Wed, 16 Sep 2015 11:29:08 +0100
Message-ID: <20150916102908.GA28771@arm.com>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150916091452.GC3816@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul, Peter,

Thanks for the comments. More below...

On Wed, Sep 16, 2015 at 10:14:52AM +0100, Peter Zijlstra wrote:
> On Tue, Sep 15, 2015 at 10:47:24AM -0700, Paul E. McKenney wrote:
> > > diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> > > index 0eca6efc0631..919624634d0a 100644
> > > --- a/arch/powerpc/include/asm/barrier.h
> > > +++ b/arch/powerpc/include/asm/barrier.h
> > > @@ -87,6 +87,7 @@ do {									\
> > >  	___p1;								\
> > >  })
> > > 
> > > +#define smp_mb__release_acquire()   smp_mb()
> > 
> > If we are handling locking the same as atomic acquire and release
> > operations, this could also be placed between the unlock and the lock.
> 
> I think the point was exactly that we need to separate LOCK/UNLOCK from
> ACQUIRE/RELEASE.

Yes, pending the PPC investigation, I'd like to keep this separate for
now.

> > However, independently of the unlock/lock case, this definition and
> > use of smp_mb__release_acquire() does not handle full ordering of a
> > release by one CPU and an acquire of that same variable by another.
> 
> > In that case, we need roughly the same setup as the much-maligned
> > smp_mb__after_unlock_lock().  So, do we care about this case?  (RCU does,
> > though not 100% sure about any other subsystems.)
> 
> Indeed, that is a hole in the definition, that I think we should close.

I'm struggling to understand the hole, but here's my intuition. If an
ACQUIRE on CPUx reads from a RELEASE by CPUy, then I'd expect CPUx to
observe all memory accessed performed by CPUy prior to the RELEASE
before it observes the RELEASE itself, regardless of this new barrier.
I think this matches what we currently have in memory-barriers.txt (i.e.
acquire/release are neither transitive or multi-copy atomic).

Do we have use-cases that need these extra guarantees (outside of the
single RCU case, which is using smp_mb__after_unlock_lock)? I'd rather
not augment smp_mb__release_acquire unless we really have to, so I'd
prefer to document that it only applies when the RELEASE and ACQUIRE are
performed by the same CPU. Thoughts?

> > >  #define smp_mb__before_atomic()     smp_mb()
> > >  #define smp_mb__after_atomic()      smp_mb()
> > >  #define smp_mb__before_spinlock()   smp_mb()
> > > diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> > > index 0681d2532527..1c61ad251e0e 100644
> > > --- a/arch/x86/include/asm/barrier.h
> > > +++ b/arch/x86/include/asm/barrier.h
> > > @@ -85,6 +85,8 @@ do {									\
> > >  	___p1;								\
> > >  })
> > > 
> > > +#define smp_mb__release_acquire()	smp_mb()
> > > +
> > >  #endif
> > > 
> 
> All TSO archs would want this.

If we look at all architectures that implement smp_store_release without
an smp_mb already, we get:

  ia64
  powerpc
  s390
  sparc
  x86

so it should be enough to provide those with definitions. I'll do that
once we've settled on the documentation bits.

> > >  /* Atomic operations are already serializing on x86 */
> > > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > > index b42afada1280..61ae95199397 100644
> > > --- a/include/asm-generic/barrier.h
> > > +++ b/include/asm-generic/barrier.h
> > > @@ -119,5 +119,9 @@ do {									\
> > >  	___p1;								\
> > >  })
> > > 
> > > +#ifndef smp_mb__release_acquire
> > > +#define smp_mb__release_acquire()	do { } while (0)
> > 
> > Doesn't this need to be barrier() in the case where one variable was
> > released and another was acquired?
> 
> Yes, I think its very prudent to never let any barrier degrade to less
> than barrier().

Hey, I just copied read_barrier_depends from the same file! Both
smp_load_acquire and smp_store_release should already provide at least
barrier(), so the above should be sufficient.

Will
