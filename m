Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:15086 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262862AbUCWWZr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 17:25:47 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040323153641.GM22639@dualathlon.random>
References: <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com>
	 <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston>
	 <20040323020756.GS2045@holomorphy.com>
	 <20040323113534.GD22639@dualathlon.random>
	 <20040323114452.GE2045@holomorphy.com>
	 <20040323123439.GJ22639@dualathlon.random>
	 <20040323124027.D25134@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403230722120.1106@ppc970.osdl.org>
	 <20040323153641.GM22639@dualathlon.random>
Content-Type: text/plain
Message-Id: <1080079803.23718.131.camel@gaston>
Mime-Version: 1.0
Date: Wed, 24 Mar 2004 09:10:04 +1100
Content-Transfer-Encoding: 7bit
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>, William Lee Irwin III <wli@holomorphy.com>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>


> zones cannot create holes in the middle of mem_map, only discontigmem
> can. I'd expect in most archs to have holes between ram and mmio
> regions (at least in various common ram configuration). That's why I
> guess discontigmem would be needed for that.

Well, just waste some mem_map or use non-trivial page_to_pfn using
some high bit in the address on those archs. No need for DISCONTIGMEM
for that.

For example, on various ppc64's, there is an IO hole of 1 or 2Gb,
so you have 2 or 3Gb of RAM, then the IO hole, then the rest of RAM,
so far I implement that without using DISCONTIGMEM, just giving the
hole size when initializing the zone. That waste some memmap space,
but that's fine for now (the ppc64 discontigmem code would need
some surgery to be split from the numa stuff for beeing able to use
it).

Ben.
