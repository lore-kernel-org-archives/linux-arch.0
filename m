Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:61420 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262504AbUCWLpV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 06:45:21 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040323100429.A23349@flint.arm.linux.org.uk>
References: <1079967870.1759.12.camel@mulgrave>
	 <20040322151533.C11212@flint.arm.linux.org.uk>
	 <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
	 <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com>
	 <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com>
	 <20040323092852.B21352@flint.arm.linux.org.uk>
	 <1080034492.16786.120.camel@imladris.demon.co.uk>
	 <20040323100429.A23349@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1080041343.22212.121.camel@gaston>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 22:29:04 +1100
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, William Lee Irwin III <wli@holomorphy.com>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-03-23 at 21:04, Russell King wrote:
> On Tue, Mar 23, 2004 at 09:34:52AM +0000, David Woodhouse wrote:
> > Populating PTEs on demand through nopage() can be an implementation
> > detail. You don't have to make 'struct page' available in the generic
> > API to achieve that optimisation.
> 
> Indeed - and this is what my implementation of dma_coherent_mmap() does
> on ARM.
> 
> Once everyone has decided on a solution, we can then move it forward.
> Currently it does look like dma_coherent_mmap() is the one of choice,
> so... Are there any remaining objections to it?

Looks fine to me. We may want to refine dma_coherent_alloc() in the
first place though, like introducing a "real" __dma_coherent_alloc()
that takes additional flags and have dma_coherent_alloc() just be
a macro, that way James can pass in flags telling at alloc time that
a given alloc will potentially be mapped to userland (if I understand
James requirements properly).

Ben.
