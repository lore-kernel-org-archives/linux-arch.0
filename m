From: Jamie Lokier <jamie@shareable.org>
Subject: Re: SMP barriers semantics
Date: Fri, 12 Mar 2010 20:38:35 +0000
Message-ID: <20100312203835.GD6491@shareable.org>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com> <20100303005529.GA3879@brick.ozlabs.ibm.com> <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com> <20100312123105.GB4400@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:39318 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab0CLUiy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2010 15:38:54 -0500
Content-Disposition: inline
In-Reply-To: <20100312123105.GB4400@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

Ralf Baechle wrote:
> On Wed, Mar 03, 2010 at 12:03:45PM +0000, Catalin Marinas wrote:
> > > >               /* We need for force the visibility of tp->intr_mask
> > > >                * for other CPUs, as we can loose an MSI interrupt
> > > >                * and potentially wait for a retransmit timeout if we don't.
> > > >                * The posted write to IntrMask is safe, as it will
> > > >                * eventually make it to the chip and we won't loose anything
> > > >                * until it does.
> > > >                */
> > > >               tp->intr_mask = 0xffff;
> > > >               smp_wmb();
> > > >               RTL_W16(IntrMask, tp->intr_event);
> > > >
> > > > Is this supposed to work given the SMP barriers semantics?
> > > 
> > > Well, if the smp_wmb() is supposed to make the assignment to
> > > tp->intr_mask globally visible before any effects of the RTL_W16(),
> > > then it's buggy.  But from the comments it appears that the smp_wmb()
> > > might be intended to order the store to tp->intr_mask with respect to
> > > following cacheable stores, rather than with respect to the RTL_W16(),
> > > which would be OK.  I can't say without having a much closer look at
> > > what that driver is actually doing.
> > 
> > I cc'ed the r8169.c maintainer.
> > 
> > But from the architectural support perspective, we don't need to support
> > more than a lightweight barrier in this case.

If the ordering relative to RTL_W16 doesn't matter, imho it would be
much clearer to move the RTL_W16() somewhere else, such as before the
comment.  The comment is quite misleading.

> Be afraid, very afraid when you find a non-SMP memory barrier in the
> kernel.  A while ago I reviewed a number of uses throughout the kernel and
> each one of them was somehow buggy - either entirely unnecessary or should
> be replaced with an SMP memory barrier or was simple miss-placed.

It's not hard to think of cases where a non-SMP barrier is necessary
outside of the kernel code API (dma_* etc.), but it would be quite
interesting if those cases never occur with real devices, or if they
can always be transformed to something else.

The RTL_W16 sample is quite interesting - even if it does not apply to
that particular driver, it's suggestive of a pattern where some device
may need to delay triggering an interrupt (on a different CPU) until a
data structure is written, or that some device may require ordered
MMIO reads and writes.  In the case of interrupts, code like that can
probably be transformed.

-- Jamie
