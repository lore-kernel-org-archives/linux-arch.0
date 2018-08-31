From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: __clear_bit_lock to use atomic clear_bit (was Re: Patch
 "asm-generic/bitops/lock.h)
Date: Fri, 31 Aug 2018 09:24:44 +0200
Message-ID: <20180831072444.GD24124@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 31, 2018 at 12:29:27AM +0000, Vineet Gupta wrote:
> On 08/30/2018 02:44 AM, Peter Zijlstra wrote:
> >> Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> >> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> >> __clear_bit_unlock()")
> >> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> >> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> >>
> >> This patch undoes that which could explain the issues you see. @Peter, @Will ?
> > Right, so the thinking is that on platforms that suffer that issue,
> > atomic_set*() should DTRT. And if you look at your spinlock based atomic
> > implementation, you'll note that atomic_set() does indeed do the right
> > thing.
> >
> > arch/arc/include/asm/atomic.h:108
> 
> For !LLSC atomics, ARC has always had atomic_set() DTRT even in the git revision
> of 2016. The problem was not in atomics, but the asymmetric way slub bit lock etc
> worked (haven't checked if this changed), i.e.
> 
>      slab_lock() -> bit_spin_lock() -> test_and_set_bit()    # atomic
>      slab_unlock() -> __bit_spin_unlock() -> __clear_bit()    # non-atomic
> 
> And with v4.19-rc1, we have essentially reverted f75d48644c56a due to 84c6591103db
> ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> 
> So what we have with 4.19-rc1 is
> 
>    static inline void __clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
>    {
>      unsigned long old;
>      p += ((nr) / 32);
>      old = // some typecheck magic on *p
>      old &= ~(1UL << ((nr) % 32));
>      atomic_long_set_release((atomic_long_t *)p, old);
>    }
> 
> So @p is being r-m-w non atomically. The lock variant uses atomic op...
> 
>    int test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
>    { 
>       ...
>       old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
>       ....
>    }
> 
> Now I don't know why we don't see the issue with LLSC atomics, perhaps race window
> reduces due to less verbose code itself etc..
> 
> Am I missing something still ?

Yes :-) So there are 2 things to consider:

 1) this whole test_and_set_bit() + __clear_bit() combo only works if we
    have the guarantee that no other bit will change while we have our
    'lock' bit set.

    This means that @old is invariant.

 2) atomic ops and stores work as 'expected' -- which is true for all
    hardware LL/SC or CAS implementations, but not for spinlock based
    atomics.

The bug in f75d48644c56a was the atomic test_and_set loosing the
__clear_bit() store.

With LL/SC this cannot happen, because the competing store (__clear_bit)
will cause the SC to fail, then we'll retry, the second LL observes the
new value.

So the main point is that test_and_set must not loose a store.
atomic_fetch_or() vs atomic_set() ensures this.


NOTE: another possible solution for spinlock based bitops is making
test_and_set 'smarter':

	spin_lock();
	val = READ_ONCE(word);
	if (!(val & bit)) {
		val |= bit;
		WRITE_ONCE(word, val);
	}
	spin_unlock();

But that is not something that works in generic (the other atomic ops),
and therefore atomic_set() is required to take the spinlock too, which
also cures the problem.
