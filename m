From: David Dillow <dave@thedillows.org>
Subject: Re: SMP barriers semantics
Date: Wed, 03 Mar 2010 21:23:46 -0500
Message-ID: <1267669426.23829.2.camel@obelisk.thedillows.org>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
	 <20100303005529.GA3879@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.knology.net ([24.214.63.101]:41808 "EHLO smtp.knology.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab0CDCa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Mar 2010 21:30:28 -0500
In-Reply-To: <20100303005529.GA3879@brick.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Wed, 2010-03-03 at 11:55 +1100, Paul Mackerras wrote:
> On Tue, Mar 02, 2010 at 10:52:58AM +0000, Catalin Marinas wrote:
> > The main question - are the Linux SMP barriers supposed to have an
> > effect outside of cacheable memory accesses (i.e. ordering wrt I/O
> > accesses)?
> 
> The SMP barriers are only required to order cacheable accesses.  The
> plain (non-SMP) barriers (mb, wmb, rmb) are required to order both
> cacheable and non-cacheable accesses.
> 
> > My understanding from other comments in the kernel source is that the
> > SMP barriers are only meant or cacheable memory but there are drivers
> > that do something like below (e.g. drivers/net/r8169.c):
> > 
> > 		/* We need for force the visibility of tp->intr_mask
> > 		 * for other CPUs, as we can loose an MSI interrupt
> > 		 * and potentially wait for a retransmit timeout if we don't.
> > 		 * The posted write to IntrMask is safe, as it will
> > 		 * eventually make it to the chip and we won't loose anything
> > 		 * until it does.
> > 		 */
> > 		tp->intr_mask = 0xffff;
> > 		smp_wmb();
> > 		RTL_W16(IntrMask, tp->intr_event);
> > 
> > Is this supposed to work given the SMP barriers semantics?
> 
> Well, if the smp_wmb() is supposed to make the assignment to
> tp->intr_mask globally visible before any effects of the RTL_W16(),
> then it's buggy.  But from the comments it appears that the smp_wmb()
> might be intended to order the store to tp->intr_mask with respect to
> following cacheable stores, rather than with respect to the RTL_W16(),
> which would be OK.  I can't say without having a much closer look at
> what that driver is actually doing.

It's buggy. The code was intended to ensure the write to intr_mask was
visible to other CPUs before we told the NIC that it could generate
another interrupt. Give the definition of the barriers above, this
should be wmb() instead of smp_wmb().
