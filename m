From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: SMP barriers semantics
Date: Thu, 4 Mar 2010 09:33:00 +0000
Message-ID: <20100304093259.GA6397@flint.arm.linux.org.uk>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com> <20100303005529.GA3879@brick.ozlabs.ibm.com> <1267669426.23829.2.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38713 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab0CDJd3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2010 04:33:29 -0500
Content-Disposition: inline
In-Reply-To: <1267669426.23829.2.camel@obelisk.thedillows.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Dillow <dave@thedillows.org>
Cc: Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>

On Wed, Mar 03, 2010 at 09:23:46PM -0500, David Dillow wrote:
> On Wed, 2010-03-03 at 11:55 +1100, Paul Mackerras wrote:
> > Well, if the smp_wmb() is supposed to make the assignment to
> > tp->intr_mask globally visible before any effects of the RTL_W16(),
> > then it's buggy.  But from the comments it appears that the smp_wmb()
> > might be intended to order the store to tp->intr_mask with respect to
> > following cacheable stores, rather than with respect to the RTL_W16(),
> > which would be OK.  I can't say without having a much closer look at
> > what that driver is actually doing.
> 
> It's buggy. The code was intended to ensure the write to intr_mask was
> visible to other CPUs before we told the NIC that it could generate
> another interrupt. Give the definition of the barriers above, this
> should be wmb() instead of smp_wmb().

There's a whole bunch of other drivers doing exactly the same thing -
just grep drivers/net for smp_wmb(). ;(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
