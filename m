From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: SMP barriers semantics
Date: Thu, 04 Mar 2010 09:48:46 +0000
Message-ID: <1267696126.5131.2.camel@e102109-lin.cambridge.arm.com>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
	 <20100303005529.GA3879@brick.ozlabs.ibm.com>
	 <1267669426.23829.2.camel@obelisk.thedillows.org>
	 <20100304093259.GA6397@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46110 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755636Ab0CDJs7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2010 04:48:59 -0500
In-Reply-To: <20100304093259.GA6397@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Dillow <dave@thedillows.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Francois Romieu <romieu@fr.zoreil.com>

On Thu, 2010-03-04 at 09:33 +0000, Russell King wrote:
> On Wed, Mar 03, 2010 at 09:23:46PM -0500, David Dillow wrote:
> > On Wed, 2010-03-03 at 11:55 +1100, Paul Mackerras wrote:
> > > Well, if the smp_wmb() is supposed to make the assignment to
> > > tp->intr_mask globally visible before any effects of the RTL_W16(),
> > > then it's buggy.  But from the comments it appears that the smp_wmb()
> > > might be intended to order the store to tp->intr_mask with respect to
> > > following cacheable stores, rather than with respect to the RTL_W16(),
> > > which would be OK.  I can't say without having a much closer look at
> > > what that driver is actually doing.
> >
> > It's buggy. The code was intended to ensure the write to intr_mask was
> > visible to other CPUs before we told the NIC that it could generate
> > another interrupt. Give the definition of the barriers above, this
> > should be wmb() instead of smp_wmb().
> 
> There's a whole bunch of other drivers doing exactly the same thing -
> just grep drivers/net for smp_wmb(). ;(

Yes, but IMHO we shouldn't penalise the SMP systems by requiring a heavy
barrier rather than just fixing the drivers.

-- 
Catalin
