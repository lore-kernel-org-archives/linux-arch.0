Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5386 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261397AbUCVMFr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 07:05:47 -0500
Date: Mon, 22 Mar 2004 12:05:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322120537.A7371@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org> <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322044615.GC2045@holomorphy.com> <1079931403.5345.74.camel@mulgrave> <1079933188.22188.5.camel@gaston> <20040322115807.GO3649@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322115807.GO3649@dualathlon.random>; from andrea@suse.de on Mon, Mar 22, 2004 at 12:58:07PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Bottomley <James.Bottomley@steeleye.com>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 12:58:07PM +0100, Andrea Arcangeli wrote:
> The only reason I believe a paging mechanism would been nicer, is that
> it would avoid latencies in dma_mmap_coherent (not necessairly scheduler
> latencies, but you would pay all the cost of the pagetables immediatly
> during the mmap syscall, so if you've to map gigs of ram that would tend
> to hang the task doing the mmap a little bit, I found it nicer to use
> the paging for this so we also only allocate the memory for the
> pagetables that we need, but OTOH Linus's right that in most cases it
> doesn't worth a single branch in a fast path).

However, if you go on to read what Linus said later, he seems to be saying
that we can guarantee that dma_alloc_coherent() will be backed by memory
which has page structures associated with it.  This means that we _can_
use the ->nopage function for the DMA coherent implementation after all.

However, it isn't useful for the PCI device-side buffer case, which would
need to be handled via remap_page_range().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
