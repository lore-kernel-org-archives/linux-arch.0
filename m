Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754815AbXKTQqa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2007 11:46:30 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20071120160220.GA22196@wotan.suse.de>
References: <20071120160220.GA22196@wotan.suse.de>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Date: Tue, 20 Nov 2007 16:46:22 +0000
Message-ID: <4680.1195577182@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


Hi Nick,

Some comments on the documentation changes in your patch:

>  The Linux kernel has eight basic CPU memory barriers:

That should be 'eleven' at least with these changes.

Can I recommend that unless io_lock() and io_unlock() actually take locks, you
postfix their names with _mb or _barrier.  If they are actual locking
primitives, then they don't belong in this table.

> + TYPE	    FULL		    CACHEABLE (SMP CONDITIONAL) IO

I think I'd make that 'SMP CONDITIONAL' with '(CACHEABLE)' on the next line or
vice versa.  This means the table doesn't have to expand quite so much, and
for the data dep barrier lines, do:

	TYPE		FULL		CACHEABLE		I/O
					(SMP CONDITIONAL)
	===============	===============	=======================	===============
	GENERAL		mb()		smp_mb()		io_mb()
	WRITE	    	wmb()		smp_wmb()		io_wmb()
	READ	    	rmb()		smp_rmb()		io_rmb()
	DATA DEPEPENDENCY
			read_barrier_depends()
					smp_read_barrier_depends()

Does having 'CACHEABLE' imply that 'FULL' ones are or that they aren't?

I think I would alter this:

+CACHEABLE memory barriers control order of access to regular (cacheable) RAM
+by the CPU.  They are reduced to compiler barriers on uniprocessor compiled
+systems because cacheable memory is operated upon by CPUs, and a a CPU is
+self-consistent.

To say something like:

 SMP conditional memory barriers control the order of access to regular,
 cacheable RAM by the CPU.  They are reduced to compiler barriers on
 uniprocessor compiled systems because it is assumed that a CPU will appear to
 be self-consistent, and will order overlapping accesses correctly with
 respect to itself when writing to ordinary RAM.

And 'IO' should be 'I/O' for consistency.

> +[!] Note that CACHEABLE or FULL memory barriers must be used to control the
> +ordering of references to shared memory on SMP systems, though the use of
> +locking instead is sufficient.

So a spin_lock() or a down() will do the trick?

> +CACHEABLE accesses within the critical section). io_lock must be called

Sentence breaks should be two spaces or a newline after the full stop, btw.

> Do not get smart.

I'd very much recommend against saying that.

> +All barriers are required even on non-SMP systems as they affect the order in
> +which memory operations appear to a device by prohibiting both the compiler and
> +(in the case of IO and FULL barriers) the CPU from reordering them.

Add to that, perhaps, that if the barriers are unnecessary for a particular
arch then they'll be optimised away.  That might help discourage people from
saying "but I don't need them on arch X or platform Y because they don't do
anything there".

> -Under certain circumstances (especially involving NUMA), I/O accesses within
> -two spinlocked sections on two different CPUs may be seen as interleaved by the
> -PCI bridge, because the PCI bridge does not necessarily participate in the
> -cache-coherence protocol, and is therefore incapable of issuing the required
> -read memory barriers.

Is this not true?  If it is true, why remove it?  Just stick in a blank line
and add the next paragraph.

> +SMP locking primitives are implemented with operations to CACHEABLE memory,
> +and they are guaranteed only to provide LOCK and UNLOCK ordering for other
> +CACHEABLE memory accesses inside the critical section. IO memory accesses,
> +even if performed inside the lock section, can "leak out".

Hmmm...  I'm not sure 'CACHEABLE' needs capitalising quite so much.  I can see
why you're doing this though.

> -	writel(0, ADDR)
> +	writel(0, ADDR);

Seems I wasn't very consistent on the usage of semicolons in these tables.
Adding them is fine.

> +which would probably cause the hardware to malfunction. The reason is that
> +the stores to IO memory from CPU 1 is not ordered with respect to the

'are not ordered'

> +spin_unlock, so it may not be visible to the PCI bridge before the spin_unlock

'so they may not be visible'

> +What is necessary here is to use some type of FULL memory barrier to prevent
> +the reordering of CACHEABLE and IO operations.

I'd insert a 'both' after the second 'of'.

> The best way to do this is with
> +io_lock and io_unlock barriers, which directs the critical section to order
> +IO access as well. For example:

Should there be a spin_lock_io() for example?

> +this will ensure that the two IO stores issued on CPU 1 appear at the PCI
> +bridge before either of the IO stores issued on CPU 2.

Hmmm...  How about 'stores to I/O' rather than 'I/O stores'?

> +XXX: get rid of this, and just prefer io_lock()/io_unlock() ?

What do you mean?

David
