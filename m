Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:50325 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262103AbUCWC1J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 21:27:09 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <405F7837.2010800@pobox.com>
References: <20040322002349.GZ2045@holomorphy.com>
	<405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com>
	<1079930497.2045.69.camel@mulgrave>
	<20040322093029.A460@flint.arm.linux.org.uk>
	<1079967870.1759.12.camel@mulgrave>
	<20040322151533.C11212@flint.arm.linux.org.uk>
	<1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
	<405F6636.2090609@pobox.com> <20040322231933.H11212@flint.arm.linux.org.uk>
	 <405F7837.2010800@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 22 Mar 2004 21:26:25 -0500
Message-Id: <1080008788.2165.13.camel@mulgrave>
Mime-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-22 at 18:35, Jeff Garzik wrote:
> Agreed, but due to OSS dain bramage you can read/write as much as you 
> like, up until the mmap point, AFAICS.  It's much easier for the driver 
> to allocate one set of buffers, than to allocate a set at open(2), throw 
> away those allocs at mmap(2) and make new ones.

I didn't say throw the buffers away, merely the mapping.

I think you're looking at this the wrong way.  We only get into this
whole mess of being coherent with respect to a single address space if
we don't obey the virtual address congruence modulus rules

As Russell already pointed out, as long as we can force the virtual
addresses of the mappings (that's all mappings, in both the kernel and
in user space) to obey the congruence modulus rules then were home free.

On PA, we already force any mmapping that will be shared (MAP_SHARED) to
obey the congruence rules (we allocate them all at 0 mod 4MB, which is
our congruence modulus) by hijacking arch_get_unmapped_area.

Thus, as long as the sound card application designates its mappings as
MAP_SHARED, we're half way there.  The other wrinkle is that we'll have
to allocate the coherent memory *also* on a virtual address of 0 mod
4MB.  i.e. if we can be told *before* we hand out the coherent area that
it will be mmapped, we can make it work.  This is going to have to be an
extra flag to dma_alloc_coherent() or something.

The wrong thinking is that this is something we can fix at mapping time,
it's not, it's something we have to set up at buffer allocation time.

James
