Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:25835 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261664AbUCWAMh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 19:12:37 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040322223509.GO2045@holomorphy.com>
References: <20040322002349.GZ2045@holomorphy.com>
	 <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com>
	 <1079930497.2045.69.camel@mulgrave>
	 <20040322093029.A460@flint.arm.linux.org.uk>
	 <1079967870.1759.12.camel@mulgrave>
	 <20040322151533.C11212@flint.arm.linux.org.uk>
	 <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
	 <405F6636.2090609@pobox.com>  <20040322223509.GO2045@holomorphy.com>
Content-Type: text/plain
Message-Id: <1079999839.23205.40.camel@gaston>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 10:57:19 +1100
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>


> On Mon, Mar 22, 2004 at 05:18:30PM -0500, Jeff Garzik wrote:
> > You need both kernel and userspace...  for audio drivers, mmap(2) is 
> > direct to userspace, but read(2) and write(2) must copy_from_user() into 
> > the allocated DMA area.
> 
> This is burned into silicon, so supporting it's not an option. Frankly
> I think what's best is another device interface for userspace to fall
> back to when this coherent userspace mmap() is unimplementable, e.g.
> read()/write() on some device node.

Exactly. We can implement the simple/nice interface discussed here, and
just not support it on those platforms, they'll have to fall back to
read/write or simply not support those drivers who require that
functionality.

Eventually a nopage variant may be worth for things doing really
large mappings, but I tend to think that when we need to do that mapping
to userland, it is because we need short latencies, which is the opposite
of what a nopage implementation provides, dunno if it's worth the pain
(though it's not _that_ painful).

Ben.
