From: Nick Piggin <npiggin@suse.de>
Subject: Re: SMP barriers semantics
Date: Tue, 23 Mar 2010 14:42:36 +1100
Message-ID: <20100323034236.GN26495@laptop>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
 <20100303005529.GA3879@brick.ozlabs.ibm.com>
 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
 <20100312123105.GB4400@linux-mips.org>
 <1268792716.2335.170.camel@pasglop>
 <20100317134243.GA15235@shareable.org>
 <20100322120203.GL17637@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43973 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231Ab0CWDmr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 23:42:47 -0400
Content-Disposition: inline
In-Reply-To: <20100322120203.GL17637@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Mon, Mar 22, 2010 at 11:02:03PM +1100, Nick Piggin wrote:
> On Wed, Mar 17, 2010 at 01:42:43PM +0000, Jamie Lokier wrote:
> > Benjamin Herrenschmidt wrote:
> > > Maybe we can agree on a set of relaxed accessors defined specifically
> > > with those semantics (more relaxed implies use of raw_*) :
> > > 
> > >   - order is guaranteed between MMIOs
> > >   - no order is guaranteed between MMIOs and spinlocks
> > 
> > No order between MMIOs and spinlocks will be fun :-)
> 
> There isn't anyway, and things are pretty messed up in this area
> already. We have mmiowb. Some architectures do a bit of mmio vs
> lock synchronization. Eg. powerpc. But it doesn't do barriers on
> some other locks like bit spinlocks or mutexes or rwsems or
> semaphores blah blah.
> 
> When this came up I grepped a couple of drivers and found possible
> problems straight away.

Ie. with drivers using a mutex to synchronise mmios, which breaks on
powerpc (even though spinlocks would work due to their hack in there).

And on some other architectures the driver would be broken whether it
uses spinlocks or not because it is not using the right barriers.

I think we have basically everything we need right now except to
have things clearly documented and consistent over architectures, and
to have mmio acquire/release to be paired with _any_ locking function
(bitops, atomics, spinlocks, mutexes, etc).

If we enforce *strong* ordering with cacheable accesses and other IO
for regular IO accessors, then a driver would not have to do anything
special for ios or locks or anything. This can be very expensive on
some archs, but IMO it is the best default because any driver that would
work on x86 using these will work on any other arch.

It is much easier for a powerpc or altix developer to take a working
but underperforming driver, identify some of the critical ios and relax
them than it is for them to try to fix a strangely broken driver (and
where the driver developer and 99% of driver testers doesn't have their
hardware).

For relaxed accessors, I think acquire/release (versus cacheable), and
then traditional mb, rmb, wmb should be pretty good start.

Anyone disagree? I would volunteer to post some patches if not...
