From: Paul Mackerras <paulus@samba.org>
Subject: Re: SMP barriers semantics
Date: Wed, 3 Mar 2010 11:55:29 +1100
Message-ID: <20100303005529.GA3879@brick.ozlabs.ibm.com>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:33190 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab0CCAzh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Mar 2010 19:55:37 -0500
Content-Disposition: inline
In-Reply-To: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>

On Tue, Mar 02, 2010 at 10:52:58AM +0000, Catalin Marinas wrote:

> We have an issue with the barriers usage/implementation on ARM and I
> would like some clarification.
> 
> As a background - latest ARM processors have two kinds of barriers - a
> lightweight one (DMB) which basically only ensures the ordering of
> accesses to the same memory type (the definition is a bit more
> complicated but in the context of Linux this is a safe simplification).
> The second kind of barrier is a heavyweight one (DSB) which drains the
> write buffers.
> 
> Both *mb() and smp_*mb() are currently implemented with the lightweight
> version (DMB) but this is not enough for coherent DMA operations where a
> DSB is needed to drain the write buffer before writing to the device I/O
> memory for starting the transfer. My proposal on the ARM lists was to
> change mb()/wmb() to DSB but leave the smp_*mb() as a DMB.
> 
> The main question - are the Linux SMP barriers supposed to have an
> effect outside of cacheable memory accesses (i.e. ordering wrt I/O
> accesses)?

The SMP barriers are only required to order cacheable accesses.  The
plain (non-SMP) barriers (mb, wmb, rmb) are required to order both
cacheable and non-cacheable accesses.

> My understanding from other comments in the kernel source is that the
> SMP barriers are only meant or cacheable memory but there are drivers
> that do something like below (e.g. drivers/net/r8169.c):
> 
> 		/* We need for force the visibility of tp->intr_mask
> 		 * for other CPUs, as we can loose an MSI interrupt
> 		 * and potentially wait for a retransmit timeout if we don't.
> 		 * The posted write to IntrMask is safe, as it will
> 		 * eventually make it to the chip and we won't loose anything
> 		 * until it does.
> 		 */
> 		tp->intr_mask = 0xffff;
> 		smp_wmb();
> 		RTL_W16(IntrMask, tp->intr_event);
> 
> Is this supposed to work given the SMP barriers semantics?

Well, if the smp_wmb() is supposed to make the assignment to
tp->intr_mask globally visible before any effects of the RTL_W16(),
then it's buggy.  But from the comments it appears that the smp_wmb()
might be intended to order the store to tp->intr_mask with respect to
following cacheable stores, rather than with respect to the RTL_W16(),
which would be OK.  I can't say without having a much closer look at
what that driver is actually doing.

Paul.
