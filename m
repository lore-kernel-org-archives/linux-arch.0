Return-Path: <andrea@suse.de>
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43183
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261940AbUCVMdu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2004 07:33:50 -0500
Date: Mon, 22 Mar 2004 13:34:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040322123441.GS3649@dualathlon.random>
References: <20040321234515.G26708@flint.arm.linux.org.uk> <20040322002349.GZ2045@holomorphy.com> <405E3387.1050505@pobox.com> <20040322034509.GB2045@holomorphy.com> <1079930497.2045.69.camel@mulgrave> <20040322044615.GC2045@holomorphy.com> <1079931403.5345.74.camel@mulgrave> <1079933188.22188.5.camel@gaston> <20040322115807.GO3649@dualathlon.random> <20040322120537.A7371@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322120537.A7371@flint.arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Bottomley <James.Bottomley@steeleye.com>, William Lee Irwin III <wli@holomorphy.com>, Linux Arch list <linux-arch@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 22, 2004 at 12:05:37PM +0000, Russell King wrote:
> However, it isn't useful for the PCI device-side buffer case, which would
> need to be handled via remap_page_range().

one could allocate page_t for the PCI device-side buffer case too (with
discontigmem to avoid a terrible waste), but it would still be a small
waste. So for non-ram it's better you always map all ptes during ->mmap
and you avoid the page faults like with remap_file_pages than to
allocate a page_t for non-ram ranges with discontigmem.
