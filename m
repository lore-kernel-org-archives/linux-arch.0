From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 02:36:09 +0300
Message-ID: <20091210023609.b8c9bd34.isloginov@gmail.com>
References: <1260398346.14369.45.camel@mulgrave.site>
	<20091210020309.36742c7f.isloginov@gmail.com>
	<1260400273.14369.52.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:39900 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616AbZLIXgG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 18:36:06 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1787044eyd.19
        for <linux-arch@vger.kernel.org>; Wed, 09 Dec 2009 15:36:11 -0800 (PST)
In-Reply-To: <1260400273.14369.52.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Wed, 09 Dec 2009 17:11:13 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

Sorry. But I didn't understand again. You wrote:

> > > If you read the mtd code, it acts on a bio at a time so a request
> > > with N bios flushes every page in the request N times (i'e N^2 flushes).

I think that do_blktrans_request is calling for request and that every page in
request flushes exactly once.

> > > The pio read case is the problematic one, because you dirty the kernel
> > > alias by writing the read data to it and have to flush that before it's
> > > made visible to the user alias view.  The API for doing this is
> > > flush_kernel_dcache_page() ... it *only* flushes the kernel view, not
> > > the user view.  The reason for this is that if the arch has to protect
> > > the user aliases against speculative movein, that's done in the DMA API
> > > before the request is completed.
> > > 
> > > So for this:
> > > 
> > > >	case READ:
> > > >		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
> > > >			if (tr->readsect(dev, block, buf))
> > > >				return -EIO;
> > > >+		rq_flush_dcache_pages(req);
> > > >		return 0;
> > > 
> > > Actually all you need to do is loop over the pages and call
> > > flush_kernel_dcache_page().
> > 
> > I don't think so. Please reread our discussion.
> 
> As I said previously, I seem to have missed the discussion.
> 
> >  I have this bug on system where
> > icache don't look for code in dcache. And I need flush dcache exactly in
> > physical layer.
> 
> icache and dcache are usually separate.  On almost every architecture
> you have to flush the dcache to RAM before the icache can pull it in.
> However, think about where the data is in the pio read case:  it's in
> the cache above the kernel alias.  Once you flush that cache to ram, the
> icache can pick it out ... you don't have to reflush all the untouched
> user aliases, you just use flush_kernel_dcache_page() which places it in
> the ram.

But the flush_kernel_dcache_page() call exists only for sh and parisc. For
other architectures this call is empty. So, we will not fix the bug if we
call flush_kernel_dcache_page().

But. I could do that rq_flush_dcache_pages will call flush_kernel_dcache_page
for architectures where ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE was defined.

-- 
Ilya Loginov <isloginov@gmail.com>
