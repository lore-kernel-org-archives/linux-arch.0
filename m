From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline
	kernel (specifically arm in our case)
Date: Fri, 21 Nov 2008 17:10:19 +0000
Message-ID: <1227287420.7015.77.camel@pc1117.cambridge.arm.com>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com>
	 <200811191740.23638.nickpiggin@yahoo.com.au>
	 <20081119204315.GB17209@flint.arm.linux.org.uk>
	 <200811201759.01039.nickpiggin@yahoo.com.au>
	 <20081120091923.GA2515@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:58730 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757147AbYKURKd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Nov 2008 12:10:33 -0500
In-Reply-To: <20081120091923.GA2515@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-fsdevel@vger.kernel.org, Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com

On Thu, 2008-11-20 at 09:19 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 20, 2008 at 05:59:00PM +1100, Nick Piggin wrote:
> > - The page is sent to the block layer, which stores into the page. Some
> >   block devices like 'brd' will potentially store via the kernel linear map
> >   here, and they probably don't do enough cache flushing. But a regular
> >   block device should go via DMA, which AFAIK should be OK? (the user address
> >   should remain invalidated because it would be a bug to read from the buffer
> >   before the read has completed)
> 
> This is where things get icky with lots of drivers - DMA is fine, but
> many PIO based drivers don't handle the implications of writing to the
> kernel page cache page when there may be CPU cache side effects.

And for PIO devices, what cache flushing function should be used if the
page isn't available (maybe just a pointer to a buffer) to do a
flush_dcache_page? Should this be done in the filesystem layer?

> If the cache is in read allocate mode, then in this case there shouldn't
> be any dirty cache lines.  (That's not always the case though, esp. via
> conventional IO.)  If the cache is in write allocate mode, PIO data will
> sit in the kernel mapping and won't be visible to userspace.

This problem re-appeared in our tests when someone started using an ext2
filesystem with mtd+slram with write-allocate caches. Basically the D
cache isn't flushed to ensure its coherency with the I cache.

The very dirty workaround was to use flush_icache_range (I know, it's
meant for something completely different) in mtd_blkdevs.c. The slram.c
doesn't have access to any page information either and I noticed that
there are very few block devices that call flush_dcache_page directly.
Should this be done by the filesystem layer?

It looks to me like some filesystems like cramfs call flush_dcache_page
in their "readpage" functions but ext2 doesn't. My other, less dirty,
workaround for the mtd+slram problem is below. It appears to solve the
problem though I'm not sure it is the right solution (ext2 uses
mpage_readpages).

diff --git a/fs/mpage.c b/fs/mpage.c
index 552b80b..979a4a9 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -51,6 +51,7 @@ static void mpage_end_io_read(struct bio *bio, int err)
 			prefetchw(&bvec->bv_page->flags);
 
 		if (uptodate) {
+			flush_dcache_page(page);
 			SetPageUptodate(page);
 		} else {
 			ClearPageUptodate(page);


Thanks.

-- 
Catalin
