Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:59365 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262026AbUCVPEj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 10:04:39 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20040322093029.A460@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
	<20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
	<20040321225117.F26708@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	<20040321234515.G26708@flint.arm.linux.org.uk>
	<20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
	<20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
	<20040322093029.A460@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 22 Mar 2004 10:04:23 -0500
Message-Id: <1079967870.1759.12.camel@mulgrave>
Mime-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-22 at 04:30, Russell King wrote:
> On Sun, Mar 21, 2004 at 11:41:35PM -0500, James Bottomley wrote:
> > Let me illustrate what would go wrong on parisc:  we have a VIPT cache
> > and the concept of an address space.
> 
> Is it not the case that VIPT caches are coloured, and mapping a page
> into the appropriate place results in the same virtual index for both?

Not coloured exactly since the caches are associative, but we have a
congruence modulus.  As long as two virtual addresses are equal modulo
this, the cache will detect and unify virtual aliasing (basically it
assigns the addresses the same coherence index).  So, as long as the
proposed API gives the arch control over where in the user vm the
mapping goes, we would be able to accommodate it.

However, my understanding of the API was that you *already* had a vm
range and were trying to place a coherently mapped page into it.

> However, please don't prevent all architectures from being able to
> use these drivers just because a small number can't.

I don't believe I was.  I was merely pointing out the problems as I saw
them with mmap'ing a coherent memory area.

James
