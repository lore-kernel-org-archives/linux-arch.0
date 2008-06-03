From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 3 Jun 2008 01:45:21 -0700
Message-ID: <20080603084521.GD117059@sgi.com>
References: <1211852026.3286.36.camel@pasglop> <200806031433.12460.nickpiggin@yahoo.com.au> <20080603081552.GC117059@sgi.com> <200806031819.06559.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:38402 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750866AbYFCIp1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jun 2008 04:45:27 -0400
Content-Disposition: inline
In-Reply-To: <200806031819.06559.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jes Sorensen <jes@sgi.com>, Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

On Tue, Jun 03, 2008 at 06:19:05PM +1000, Nick Piggin wrote:
> On Tuesday 03 June 2008 18:15, Jeremy Higdon wrote:
> > On Tue, Jun 03, 2008 at 02:33:11PM +1000, Nick Piggin wrote:
> > > On Monday 02 June 2008 19:56, Jes Sorensen wrote:
> > > > Would we be able to use Ben's trick of setting a per cpu flag in
> > > > writel() then and checking that in spin unlock issuing the mmiowb()
> > > > there if needed?
> > >
> > > Yes you could, but your writels would still not be strongly ordered
> > > within (or outside) spinlock regions, which is what Linus wants (and
> > > I kind of agree with).
> >
> > Yes they would be.  Writes from the same CPU are always ordered.  Writes
> > from different CPUs are not, but that's only a concern if you protect
> 
> They are not strongly ordered WRT writes to cacheable memory. If they
> were, then they would not leak out of spinlocks.

No posted writes are.
As I recall, the outX functions are not supposed to be posted, so the sn2
versions issue a mmiowb in the outX.  But writeX has always been posted,
or at least postable.  I thought that was generally accepted.

Normally, the only way for a device to see cacheable memory is via a DMA
read, and you are guaranteed on sn2 that in the following:

	store of of A to location X
	mmio write to device
	device DMA read from location X

that the device will see A.  In the past, on some other archs, you'd have
to flush the Dcache for that to work.

Granted, if the compiler reorders the store and the mmio write, then you
have a problem.

jeremy
