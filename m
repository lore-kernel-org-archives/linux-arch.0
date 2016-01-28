From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Thu, 28 Jan 2016 10:01:05 +0000
Message-ID: <20160128100105.GD30928@arm.com>
References: <1453918924-27606-1-git-send-email-will.deacon@arm.com>
 <20160128024623.GA14082@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160128024623.GA14082@fixme-laptop.cn.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 28, 2016 at 10:46:23AM +0800, Boqun Feng wrote:
> On Wed, Jan 27, 2016 at 06:22:04PM +0000, Will Deacon wrote:
> > As much as we'd like to live in a world where RELEASE -> ACQUIRE is
> > always cheaply ordered and can be used to construct UNLOCK -> LOCK
> > definitions with similar guarantees, the grim reality is that this isn't
> > even possible on x86 (thanks to Paul for bringing us crashing down to
> > Earth).
> > 
> > This patch handles the issue by introducing a new barrier macro,
> > smp_mb__after_release_acquire, that can be placed after an ACQUIRE that
> > either reads from a RELEASE or is in program-order after a RELEASE. The
> > barrier upgrades the RELEASE-ACQUIRE pair to a full memory barrier,
> > implying global transitivity. At the moment, it doesn't have any users,
> > so its existence serves mainly as a documentation aid and a potential
> > stepping stone to the reintroduction of smp_mb__after_unlock_lock() used
> > by RCU.
> > 
> > Documentation/memory-barriers.txt is updated to describe more clearly
> > the ACQUIRE and RELEASE ordering in this area and to show some examples
> > of the new barrier in action.
> > 
> 
> Maybe also add an entry in "CPU MEMORY BARRIERS" section of
> memory-barriers.txt? Something like (copy and paste from you commit log
> ;-)):
> 
>  (*) smp_mb__after_release_acquire();
> 
>      Placed after an ACQUIRE that either reads from a RELEASE or is in
>      program-order after a RELEASE. The barrier upgrades the
>      RELEASE-ACQUIRE pair to a full memory barrier, implying global
>      transitivity.
> 
> This could give the readers an overview of the usage of this barrier.

Thanks, I'll add that.

> > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > index 5c8db3ce61c8..ee31da604b11 100644
> > --- a/arch/s390/include/asm/barrier.h
> > +++ b/arch/s390/include/asm/barrier.h
> > @@ -45,6 +45,7 @@ do {									\
> >  	___p1;								\
> >  })
> >  
> > +#define __smp_mb__release_acquire()	__smp_mb()
> 
> Should be __smp_mb__after_release_acquire(), so is the title of this
> patch ;-)

Well spotted. That's a hangover from v2, which I'll fix.

Cheers,

Will
