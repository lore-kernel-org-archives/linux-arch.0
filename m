Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62214 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262422AbUCWKEf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 05:04:35 -0500
Date: Tue, 23 Mar 2004 10:04:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323100429.A23349@flint.arm.linux.org.uk>
References: <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323092852.B21352@flint.arm.linux.org.uk> <1080034492.16786.120.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080034492.16786.120.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Tue, Mar 23, 2004 at 09:34:52AM +0000
Sender: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 09:34:52AM +0000, David Woodhouse wrote:
> Populating PTEs on demand through nopage() can be an implementation
> detail. You don't have to make 'struct page' available in the generic
> API to achieve that optimisation.

Indeed - and this is what my implementation of dma_coherent_mmap() does
on ARM.

Once everyone has decided on a solution, we can then move it forward.
Currently it does look like dma_coherent_mmap() is the one of choice,
so... Are there any remaining objections to it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
