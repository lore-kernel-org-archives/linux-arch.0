From: Ilya Loginov <isloginov@gmail.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 02:03:09 +0300
Message-ID: <20091210020309.36742c7f.isloginov@gmail.com>
References: <1260398346.14369.45.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:53211 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607AbZLIXDF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 18:03:05 -0500
Received: by ewy1 with SMTP id 1so4975559ewy.28
        for <linux-arch@vger.kernel.org>; Wed, 09 Dec 2009 15:03:11 -0800 (PST)
In-Reply-To: <1260398346.14369.45.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Wed, 09 Dec 2009 16:39:06 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> Then this extra helpers added to block: rq_flush_dcache_pages() loops
> over every segment of the request calling flush_dcache_page() for the
> page.  If you read the mtd code, it acts on a bio at a time so a request
> with N bios flushes every page in the request N times (i'e N^2 flushes).
> I'm assuming there's something somewhere I'm missing that restricts mtd
> to single bio requests, which makes this all OK?

Sorry. But why do you think that do_blktrans_request is dealing with bio?
May be i don't know something...
 
> The pio read case is the problematic one, because you dirty the kernel
> alias by writing the read data to it and have to flush that before it's
> made visible to the user alias view.  The API for doing this is
> flush_kernel_dcache_page() ... it *only* flushes the kernel view, not
> the user view.  The reason for this is that if the arch has to protect
> the user aliases against speculative movein, that's done in the DMA API
> before the request is completed.
> 
> So for this:
> 
> >	case READ:
> >		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
> >			if (tr->readsect(dev, block, buf))
> >				return -EIO;
> >+		rq_flush_dcache_pages(req);
> >		return 0;
> 
> Actually all you need to do is loop over the pages and call
> flush_kernel_dcache_page().

I don't think so. Please reread our discussion. I have this bug on system where
icache don't look for code in dcache. And I need flush dcache exactly in
physical layer.

-- 
Ilya Loginov <isloginov@gmail.com>
