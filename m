Return-Path: <SRS0+37bb1210535c909a0bd1+212+infradead.org+dwmw2@baythorne-093453.srs.infradead.org>
Received: from imladris.demon.co.uk ([193.237.130.41]:16283 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262399AbUCWJfL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 04:35:11 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20040323092852.B21352@flint.arm.linux.org.uk>
References: <1079930497.2045.69.camel@mulgrave>
	 <20040322093029.A460@flint.arm.linux.org.uk>
	 <1079967870.1759.12.camel@mulgrave>
	 <20040322151533.C11212@flint.arm.linux.org.uk>
	 <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
	 <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com>
	 <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com>
	 <20040323092852.B21352@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1080034492.16786.120.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 09:34:52 +0000
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-03-23 at 09:28 +0000, Russell King wrote:
> On Mon, Mar 22, 2004 at 06:07:56PM -0800, William Lee Irwin III wrote:
> > I've already been over every ->nopage() in the kernel once (wrt. what's
> > been merged anyway; a number of times for other reasons), so I really
> > think I can do a bit of useful footwork here.
> 
> Note that currently I have dma_coherent_to_page(), dma_coherent_to_pfn()
> and dma_coherent_mmap() (and maybe dma_coherent_munmap()) implemented
> here.  I'm now taking a back seat in these discussions waiting for one
> of them to take centre stage and be the One True chosen method.

dma_coherent_m{un,}map() makes most sense to me. Given that it's hard
for some arches to make a 'struct page' available, is there any _reason_
to make them jump through that particular hoop expecting them to provide
a dma_coherent_to_page()?

Populating PTEs on demand through nopage() can be an implementation
detail. You don't have to make 'struct page' available in the generic
API to achieve that optimisation.

-- 
dwmw2
