From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Date: Fri, 19 May 2017 11:03:02 +0200
Message-ID: <20170519090302.ph6jnqzlxxqzrvnu@hirez.programming.kicks-ass.net>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
 <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
 <20170518.223113.1783186374793423172.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48178 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756020AbdESJDU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2017 05:03:20 -0400
Content-Disposition: inline
In-Reply-To: <20170518.223113.1783186374793423172.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: babu.moger@oracle.com, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, May 18, 2017 at 10:31:13PM -0400, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 18 May 2017 18:36:08 -0600
> 
> > @@ -82,6 +82,7 @@ config SPARC64
> >  	select HAVE_ARCH_AUDITSYSCALL
> >  	select ARCH_SUPPORTS_ATOMIC_RMW
> >  	select HAVE_NMI
> > +	select ARCH_USE_QUEUED_RWLOCKS
> >  
> 
> If you are selecting this on SPARC64 all the time, then:
> 
> > @@ -94,6 +94,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long fla
> >  	: "memory");
> >  }
> >  
> > +#ifndef CONFIG_QUEUED_RWLOCKS
> >  /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
> 
> You can remove this segment of ifdef'd code altogether since it is in
> a sparc64 specific header file.


So IIRC Sparc v8 only has that single byte load-and-set (or swap)
instruction, right? That means you can only make test-and-set spinlocks
and then have to build the world on top of that.

I don't see qrwlock -- which assumes the spinlock implementation is fair
-- making much sense for that.

Also, IIRC Sparc-v8 didn't really have very big SMP systems, those came
with v9. And qspinlock only really makes sense on the bigger systems
(not to mention that building the qspinlock on top of atomic operations
build on test-and-set spinlocks just seems extremely dysfunctional).


In any case, I think what I'm saying is that it makes sense to make this
a Sparcv9 only feature.
