Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31750 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262399AbUCWJ3C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 04:29:02 -0500
Date: Tue, 23 Mar 2004 09:28:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323092852.B21352@flint.arm.linux.org.uk>
References: <1079930497.2045.69.camel@mulgrave> <20040322093029.A460@flint.arm.linux.org.uk> <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323020756.GS2045@holomorphy.com>; from wli@holomorphy.com on Mon, Mar 22, 2004 at 06:07:56PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 06:07:56PM -0800, William Lee Irwin III wrote:
> I've already been over every ->nopage() in the kernel once (wrt. what's
> been merged anyway; a number of times for other reasons), so I really
> think I can do a bit of useful footwork here.

Note that currently I have dma_coherent_to_page(), dma_coherent_to_pfn()
and dma_coherent_mmap() (and maybe dma_coherent_munmap()) implemented
here.  I'm now taking a back seat in these discussions waiting for one
of them to take centre stage and be the One True chosen method.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
