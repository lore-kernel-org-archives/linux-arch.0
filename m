Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62987 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262609AbUCWPup (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 10:50:45 -0500
Date: Tue, 23 Mar 2004 15:50:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323155036.A31185@flint.arm.linux.org.uk>
References: <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random> <20040323124027.D25134@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403230722120.1106@ppc970.osdl.org> <20040323153641.GM22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323153641.GM22639@dualathlon.random>; from andrea@suse.de on Tue, Mar 23, 2004 at 04:36:41PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 04:36:41PM +0100, Andrea Arcangeli wrote:
> On Tue, Mar 23, 2004 at 07:25:31AM -0800, Linus Torvalds wrote:
> > On Tue, 23 Mar 2004, Russell King wrote:
> > > On Tue, Mar 23, 2004 at 01:34:39PM +0100, Andrea Arcangeli wrote:
> > > > anyways Linus vetoed the lazy approch so we probably should give it up
> > > > (the one thing I like most is to avoid the branch in the fast path).
> > > 
> > > I don't think he did - he vetoed adding another special condition to
> > > the fast path, or returning non-RAM pages via ->nopage.
> > 
> > Indeed.
> 
> note that I was talking about non-ram, obviously ram pages can be
> returned via ->nopage and that's what drivers are using already.

Let's not get distracted into the other problem areas.  What we're
talking about here is solving the "how to map memory returned from
dma_alloc_coherent()".

There's the related problem (which Jeff has - via82cxxx_audio.c)
which is effectively a scatter-gather dma_alloc_coherent() +
dma_coherent_mmap() problem.

Then there's the unrelated problem where ALSA wants to map buffers
on PCI devices coherently into user space.

The these are three distinct problems, and we should not confuse
them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
