From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 16:11:13 +1000
Message-ID: <200806031611.13817.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <200806031416.18195.nickpiggin@yahoo.com.au> <1212467551.9496.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp118.mail.mud.yahoo.com ([209.191.84.167]:41294 "HELO
	smtp118.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752577AbYFCGL1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jun 2008 02:11:27 -0400
In-Reply-To: <1212467551.9496.23.camel@pasglop>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Tuesday 03 June 2008 14:32, Benjamin Herrenschmidt wrote:
> > This whole thread also ties in with my posts about mmiowb (which IMO
> > should go away).
> >
> > readl/writel:  strongly ordered wrt one another and other stores
> >                to cacheable RAM, byteswapping
> > __readl/__writel:  not ordered (needs mb/rmb/wmb to order with
> >                    other readl/writel and cacheable operations, or
> >                    io_*mb to order with one another)
> > raw_readl/raw_writel:  strongly ordered, no byteswapping
> > __raw_readl/__raw_writel:  not ordered, no byteswapping
> >
> > then get rid of *relaxed* variants.
>
> In addition, some archs like powerpc also provide readl_be/writel_be as
> being defined as big endian (ie. byteswap on LE archs, no byteswap on BE
> archs).

Sure.


> As of today, powerpc lacks the raw_readl/raw_writel and __readl/__writel
> variants (ie, we only provide fully ordered + byteswap and no ordering +
> no byteswap variants).
>
> If we agree on the above semantics, I'll do a patch providing the
> missing ones.

Let's see what Linus thinks...


> > Linus: on x86, memory operations to wc and wc+ memory are not ordered
> > with one another, or operations to other memory types (ie. load/load
> > and store/store reordering is allowed). Also, as you know, store/load
> > reordering is explicitly allowed as well, which covers all memory
> > types. So perhaps it is not quite true to say readl/writel is strongly
> > ordered by default even on x86. You would have to put in some
> > mfence instructions in them to make it so.
> >
> > So, what *exact* definition are you going to mandate for readl/writel?
> > Anything less than strict ordering then we also need to ensure drivers
> > use the correct barriers (to implement strict ordering, we could either
> > put mfence instructions in, or explicitly disallow readl/writel to be
> > used on wc/wc+ memory).
>
> The ordering guarantees that I provide on powerpc for "ordered" variants
> are:
>
> 	- cacheable store + writel stays ordered (ie, write to some
>           DMA stuff and then a register to trigger the DMA).
>
> 	- readl + cacheable read stays ordered (ie. read some status
>           register, for example, after an interrupt, and then read the
>           resulting data in memory).
>
> 	- any of these ordered vs. spin_lock and spin_unlock (with the
>           exception that stores done before the spin_lock
>           could potentially leak into the lock).
>
> 	- readl is synchronous (ie, makes the CPU think the
>           data was actually used before executing subsequent
>           instructions, thus waits for the data to come back,
>           for example to ensure that a read used to push out
>           post buffers followed by a delay will indeed happen
>           with the right delay).

So your readl can pass an earlier cacheable store or earlier writel?


> We don't provide meaningless ones like writel + cacheable store for
> example. (PCI posting would defeat it anyway).

What do you mean by meaningless? Ordering of writel followed by a
cacheable store  is meaningful eg. for retaining io operations within
locks. OK, you explicitly have some extra code for spin_unlock, but
not for bit locks, mutexes, etc. It would make sense to have the
default operations _very_ strongly ordered IMO, and then move drivers
to be more relaxed when they are verified.
