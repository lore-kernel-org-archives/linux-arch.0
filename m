From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Wed, 09 Dec 2009 17:11:13 -0600
Message-ID: <1260400273.14369.52.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091210020309.36742c7f.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53875 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758261AbZLIXLK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 18:11:10 -0500
In-Reply-To: <20091210020309.36742c7f.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 02:03 +0300, Ilya Loginov wrote:
> On Wed, 09 Dec 2009 16:39:06 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > Then this extra helpers added to block: rq_flush_dcache_pages() loops
> > over every segment of the request calling flush_dcache_page() for the
> > page.  If you read the mtd code, it acts on a bio at a time so a request
> > with N bios flushes every page in the request N times (i'e N^2 flushes).
> > I'm assuming there's something somewhere I'm missing that restricts mtd
> > to single bio requests, which makes this all OK?
> 
> Sorry. But why do you think that do_blktrans_request is dealing with bio?
> May be i don't know something...

I was basing it on the fact that req->data is bio_data() which is
initialised per bio.  What mtd does can't really work unless it's doing
a bio at a time (or has small limits so that all requests are bios).

> > The pio read case is the problematic one, because you dirty the kernel
> > alias by writing the read data to it and have to flush that before it's
> > made visible to the user alias view.  The API for doing this is
> > flush_kernel_dcache_page() ... it *only* flushes the kernel view, not
> > the user view.  The reason for this is that if the arch has to protect
> > the user aliases against speculative movein, that's done in the DMA API
> > before the request is completed.
> > 
> > So for this:
> > 
> > >	case READ:
> > >		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
> > >			if (tr->readsect(dev, block, buf))
> > >				return -EIO;
> > >+		rq_flush_dcache_pages(req);
> > >		return 0;
> > 
> > Actually all you need to do is loop over the pages and call
> > flush_kernel_dcache_page().
> 
> I don't think so. Please reread our discussion.

As I said previously, I seem to have missed the discussion.

>  I have this bug on system where
> icache don't look for code in dcache. And I need flush dcache exactly in
> physical layer.

icache and dcache are usually separate.  On almost every architecture
you have to flush the dcache to RAM before the icache can pull it in.
However, think about where the data is in the pio read case:  it's in
the cache above the kernel alias.  Once you flush that cache to ram, the
icache can pick it out ... you don't have to reflush all the untouched
user aliases, you just use flush_kernel_dcache_page() which places it in
the ram.

James
