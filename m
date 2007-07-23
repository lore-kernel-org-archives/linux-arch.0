Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:56185 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757608AbXGWGQo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jul 2007 02:16:44 -0400
Date: Mon, 23 Jul 2007 08:16:42 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] bitops: lock bitops
Message-ID: <20070723061642.GA7559@wotan.suse.de>
References: <20070712031419.GF32414@wotan.suse.de> <1185170792.5439.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1185170792.5439.105.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, tony.luck@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jul 23, 2007 at 04:06:31PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2007-07-12 at 05:14 +0200, Nick Piggin wrote:
> > Here is a set of patches that aims to mitigate some of the lock_page
> > overhead on powerpc introduced in the fault path by another set.
> > Fortunately it also improves various other things too :)
> 
>  Some nits...
> 
> > +static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
> > +{
> > +	unsigned long old;
> > +	unsigned long mask = BITOP_MASK(nr);
> > +	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> > +
> > +	__asm__ __volatile__(
> > +	LWSYNC_ON_SMP
> > +"1:"	PPC_LLARX "%0,0,%3	# clear_bit_unlock\n"
> > +	"andc	%0,%0,%2\n"
> > +	PPC405_ERR77(0,%3)
> > +	PPC_STLCX "%0,0,%3\n"
> > +	"bne-	1b"
> > +	: "=&r" (old), "+m" (*p)
> > +	: "r" (mask), "r" (p)
> > +	: "cc" );
> > +}
> 
> You also want a "memory" clobber on clear_bit_unlock() to tell gcc to
> consider it as a barrier for memory accesses.

Ah good catch, thanks.


> In addition, it's worth documenting that while spin_unlock() provides
> synchronization with outstanding MMIOs (look at the io sync stuff we
> have in spinlock.h), these bitops don't (and I don't want to add that
> here anyway), so drivers abusing bitops for lock might want to use
> mmiowb() explicitely.

OK, I'll mention that in the ppc code... but generic code shouldn't
rely on this anyway, right? (Or was it decided that spinlocks must
fence IO?).

Would _io postfixed locks be a sane way to handle this?


> > +static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
> > +{
> > +	__asm__ __volatile__(LWSYNC_ON_SMP);
> > +	__clear_bit(nr, addr);
> > +}
> 
> The above needs a "memory" clobber too.

Yep.

Thanks for taking a look.
