From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: SMP barriers semantics
Date: Fri, 12 Mar 2010 13:31:05 +0100
Message-ID: <20100312123105.GB4400@linux-mips.org>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
 <20100303005529.GA3879@brick.ozlabs.ibm.com>
 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:37129 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab0CLMbX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2010 07:31:23 -0500
Received: from localhost.localdomain ([127.0.0.1]:45728 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492050Ab0CLMbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2010 13:31:21 +0100
Content-Disposition: inline
In-Reply-To: <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Wed, Mar 03, 2010 at 12:03:45PM +0000, Catalin Marinas wrote:

> > > My understanding from other comments in the kernel source is that the
> > > SMP barriers are only meant or cacheable memory but there are drivers
> > > that do something like below (e.g. drivers/net/r8169.c):
> > >
> > >               /* We need for force the visibility of tp->intr_mask
> > >                * for other CPUs, as we can loose an MSI interrupt
> > >                * and potentially wait for a retransmit timeout if we don't.
> > >                * The posted write to IntrMask is safe, as it will
> > >                * eventually make it to the chip and we won't loose anything
> > >                * until it does.
> > >                */
> > >               tp->intr_mask = 0xffff;
> > >               smp_wmb();
> > >               RTL_W16(IntrMask, tp->intr_event);
> > >
> > > Is this supposed to work given the SMP barriers semantics?
> > 
> > Well, if the smp_wmb() is supposed to make the assignment to
> > tp->intr_mask globally visible before any effects of the RTL_W16(),
> > then it's buggy.  But from the comments it appears that the smp_wmb()
> > might be intended to order the store to tp->intr_mask with respect to
> > following cacheable stores, rather than with respect to the RTL_W16(),
> > which would be OK.  I can't say without having a much closer look at
> > what that driver is actually doing.
> 
> I cc'ed the r8169.c maintainer.
> 
> But from the architectural support perspective, we don't need to support
> more than a lightweight barrier in this case.

Be afraid, very afraid when you find a non-SMP memory barrier in the
kernel.  A while ago I reviewed a number of uses throughout the kernel and
each one of them was somehow buggy - either entirely unnecessary or should
be replaced with an SMP memory barrier or was simple miss-placed.

  Ralf
