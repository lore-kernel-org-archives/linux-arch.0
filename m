Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59911 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261826AbUCVJah (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 04:30:37 -0500
Date: Mon, 22 Mar 2004 09:30:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322093029.A460@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org> <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com> <20040321225117.F26708@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079930497.2045.69.camel@mulgrave>; from James.Bottomley@steeleye.com on Sun, Mar 21, 2004 at 11:41:35PM -0500
Sender: Russell King <rmk@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 21, 2004 at 11:41:35PM -0500, James Bottomley wrote:
> Let me illustrate what would go wrong on parisc:  we have a VIPT cache
> and the concept of an address space.

Is it not the case that VIPT caches are coloured, and mapping a page
into the appropriate place results in the same virtual index for both?

If this isn't true, this means that SHM is also broken on PARISC since
there is no value of SHMLBA which makes SHM mappings coherent with
each other.

> Therefore, a user trying to make use of a coherent area mmap would have
> to flush/invalidate everything all the time just to try to make sure
> they weren't missing device updates (because we have no mechanism for
> the kernel to know the data has changed and call flush_dcache_page).

Unfortunately, there is a class of drivers where mmaping a large DMA
buffer into user space makes sense.  These are video capture and
sound drivers.

By saying that "we can't support DMA coherent mmap" you're forcing
driver writers to write their own DMA coherent mmap implementations,
which they _have_ done already, and they've screwed up the interfaces
such that it only works on x86 today.

What I want is an interface which allows most of the architectures
which are capable of doing this to indeed do this.  Those which can't
should fail the mmap attempt.  It has to be said that by doing this
we're actually better off - more drivers work across more platforms
and we have a well defined failure mode for platforms where it doesn't
work.

If those platforms want to use those drivers, they aren't actually in
a worse situation - they had to find some way to work around this
before now, and they still have to find some way to work around this
afterwards, or maybe decide that the subset of drivers which need
this are incompatible with the architecture.

However, please don't prevent all architectures from being able to
use these drivers just because a small number can't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
