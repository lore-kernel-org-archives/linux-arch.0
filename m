Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:38036 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262536AbUCWMug (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 07:50:36 -0500
Date: Tue, 23 Mar 2004 04:49:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323124958.GF2045@holomorphy.com>
References: <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323123439.GJ22639@dualathlon.random>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 03:44:52AM -0800, William Lee Irwin III wrote:
>> mlock actually loops through the fault path, so in a sense it still
>> requires fault handling on the part of the driver, though AFAICT it can

On Tue, Mar 23, 2004 at 01:34:39PM +0100, Andrea Arcangeli wrote:
> it requires fault handling of course, but that's just the API with the
> driver, on the performance side (and it was the performance/latency side
> of the page faults to be complained) no page faults are generated, so
> it's not going to be a lot different from the map_sg stuff at runtime.
> anyways Linus vetoed the lazy approch so we probably should give it up
> (the one thing I like most is to avoid the branch in the fast path).

dma_mmap_coherent() being implemented via fault handling is unrelated
to ->fault() methods. It just uses the preexisting ->nopage() method
internally and transparently to the driver, and without any hooks
needed in the API either. Basically, however the arch wants to do it
so long as it fits into ->nopage(), doesn't need changes to the core, etc.


-- wli
