Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:52540 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbXKUAay (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2007 19:30:54 -0500
Date: Wed, 21 Nov 2007 01:30:53 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Message-ID: <20071121003053.GA11881@wotan.suse.de>
References: <20071120160220.GA22196@wotan.suse.de> <4680.1195577182@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4680.1195577182@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

Hi David, thanks for the feedback. Maybe this whole idea is still going to
be rejected, but most of your suggestions are good anyway ;)

Note that I think I've made one major mistake in the patch, too: that writel
is already supposed to be ordered WRT other I/O, so the io_wmb is not needed
in the drivers. However, we still have a writel_relaxed, so io_wmb is still
needed there.


On Tue, Nov 20, 2007 at 04:46:22PM +0000, David Howells wrote:
> 
> Hi Nick,
> 
> Some comments on the documentation changes in your patch:
> 
> >  The Linux kernel has eight basic CPU memory barriers:
> 
> That should be 'eleven' at least with these changes.
> 
> Can I recommend that unless io_lock() and io_unlock() actually take locks, you
> postfix their names with _mb or _barrier.  If they are actual locking
> primitives, then they don't belong in this table.

Yeah ... the name isn't ideal. _mb is a nice one, but I don't want to use it
unless it is guaranteed to be a full barrier (rather than lock/unlock
barriers). barrier similarly has an existing meaning.

Anyway, I agree with you, and it won't be just io_lock / io_unlock ;)

 
> 	TYPE		FULL		CACHEABLE		I/O
> 					(SMP CONDITIONAL)
> 	===============	===============	=======================	===============
> 	GENERAL		mb()		smp_mb()		io_mb()
> 	WRITE	    	wmb()		smp_wmb()		io_wmb()
> 	READ	    	rmb()		smp_rmb()		io_rmb()
> 	DATA DEPEPENDENCY
> 			read_barrier_depends()
> 					smp_read_barrier_depends()
> 
> Does having 'CACHEABLE' imply that 'FULL' ones are or that they aren't?

Are or aren't what?

The problem with just calling them mandatory or SMP conditional is that it
doesn't suggest the important *what* is being ordered.

 
> I think I would alter this:
> 
> +CACHEABLE memory barriers control order of access to regular (cacheable) RAM
> +by the CPU.  They are reduced to compiler barriers on uniprocessor compiled
> +systems because cacheable memory is operated upon by CPUs, and a a CPU is
> +self-consistent.
> 
> To say something like:
> 
>  SMP conditional memory barriers control the order of access to regular,
>  cacheable RAM by the CPU.  They are reduced to compiler barriers on
>  uniprocessor compiled systems because it is assumed that a CPU will appear to
>  be self-consistent, and will order overlapping accesses correctly with
>  respect to itself when writing to ordinary RAM.

Pretty verbose, isn't it ;) Not only does a CPU appear self consistent, it is.
And not only will overlapping accesses be ordered correctly, so will completely
out of order ones.

 
> > +[!] Note that CACHEABLE or FULL memory barriers must be used to control the
> > +ordering of references to shared memory on SMP systems, though the use of
> > +locking instead is sufficient.
> 
> So a spin_lock() or a down() will do the trick?

I hope so. I didn't write this (just changed slightly).

 
> > Do not get smart.
> 
> I'd very much recommend against saying that.

Really? What if you grep drivers/*, do you still recommend against? ;(

 
> > -Under certain circumstances (especially involving NUMA), I/O accesses within
> > -two spinlocked sections on two different CPUs may be seen as interleaved by the
> > -PCI bridge, because the PCI bridge does not necessarily participate in the
> > -cache-coherence protocol, and is therefore incapable of issuing the required
> > -read memory barriers.
> 
> Is this not true?  If it is true, why remove it?  Just stick in a blank line
> and add the next paragraph.

It's not because it doesn't participate in the cache coherence protocol. It
is because cacheable access isn't ordered with IO access, so it can leak
out of the lock.

The PCI bridge does not perform speculative, or out of order reads, so a read
memory barrier would not do anything for it.

As far as I know, the platforms that do this reordering (eg. Altix and pseries)
the PCI bridge does not reorder access, but it gets reordered before going
over the interconnect.

I just figure it is vague, unneccesary, hardware specific. Can take it out.


> > +this will ensure that the two IO stores issued on CPU 1 appear at the PCI
> > +bridge before either of the IO stores issued on CPU 2.
> 
> Hmmm...  How about 'stores to I/O' rather than 'I/O stores'?
> 
> > +XXX: get rid of this, and just prefer io_lock()/io_unlock() ?
> 
> What do you mean?

I mean that although the readl can obviate the need for mmiowb on PCI,
will it be a problem just to encourage the use of the IO locks instead.
Just for simplicity and clarity.

