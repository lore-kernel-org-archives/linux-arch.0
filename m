From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH] Microblaze: implement dma-coherent API and refactor
	cache flush code.
Date: Tue, 06 May 2008 08:57:17 +1000
Message-ID: <1210028237.5798.121.camel@localhost>
References: <20080505223706.1236C1C8004E@mail131-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:49857 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYEEW6L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 18:58:11 -0400
In-Reply-To: <20080505223706.1236C1C8004E@mail131-sin.bigfish.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2008-05-05 at 15:37 -0700, Stephen Neuendorffer wrote:

> In particular, the dcache in the microblaze is write through, so the
> existing code is more easily thought of as 'invalidation' than
> 'flushing'.  In addition, some of the flush_* methods were old, and
> some shouldn't need to be implemented (since currently no mmu is
> supported).

I agree - this renaming is a long time coming.

[snip]

Does the DMA API insist upon the dma_cache_sync call to guarantee
sensible results?  If so, your implementation looks fine.  If not, then
the results will clearly be bogus as there's nothing magical about the
memory being allocated in dma_alloc.

To that end, can it just call kmalloc(), and similarly kfree() for
dma_free?

I'd still like to see the uncached shadow stuff make a return one day,
it is an effective way of solving the problem, we'll just need to find a
cleaner way to implement it.  A linear walk through the cache to
invalidate is so slow, it destroys any benefit gained from DMA in the
first place.

Cheers,

John
