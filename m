Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:9451 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263711AbUCVWHs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 17:07:48 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1079969221.1759.25.camel@mulgrave>
References: <405E1859.5030906@pobox.com>
	 <20040321225117.F26708@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	 <20040321234515.G26708@flint.arm.linux.org.uk>
	 <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com>
	 <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave>
	 <20040322093029.A460@flint.arm.linux.org.uk>
	 <1079967870.1759.12.camel@mulgrave>
	 <20040322151533.C11212@flint.arm.linux.org.uk>
	 <1079969221.1759.25.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1079992229.22190.29.camel@gaston>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 08:50:30 +1100
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Russell King <rmk@arm.linux.org.uk>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
List-ID: <linux-arch.vger.kernel.org>


> I could see a point: since we can only keep one address space coherent,
> we cannot allow multiple mmappings of the same region.  Thus, processes
> would be able to hand off the coherent mmap, but wouldn't be allowed
> simultaneously to map.  the unmap API would be telling the arch that the
> mapping was free to be remapped.

You cannot have the mapping coherent in both kernel and user space ? Hrm,
I'm afraid drivers won't like that. The DRI will definitely be unhappy,
and while I don't think sound drivers need to tap the buffers from the
kernel mapping in normal cases, I'm pretty sure things like infiniband
or myrinet will have a problem too.

Ben.
