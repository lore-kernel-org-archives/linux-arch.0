From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 11:07:31 -0600
Message-ID: <1260464851.2457.98.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091210020309.36742c7f.isloginov@gmail.com>
	 <1260400273.14369.52.camel@mulgrave.site>
	 <20091210023609.b8c9bd34.isloginov@gmail.com>
	 <1260402471.14369.60.camel@mulgrave.site>
	 <20091210030638.db4cfd8a.isloginov@gmail.com>
	 <1260404395.14369.68.camel@mulgrave.site>
	 <20091210074020.a7c36c32.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:32809 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760945AbZLJRH0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 12:07:26 -0500
In-Reply-To: <20091210074020.a7c36c32.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 07:40 +0300, Ilya Loginov wrote:
> On Wed, 09 Dec 2009 18:19:55 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > OK, but the point I'm making is that it's a very heavyweight function on
> > a lot of architectures.  It sounds like mips should just have a
> > flush_kernel_dcache_page() ... has anyone tested fuse on mips; if that
> > fails, then it's a must.
> 
> Yes, it works. There are many embedded systems which are based on MIPS.
> For example, there is MIPS in my router. I use fuse on it(it is required
> by ntfs-3g). OpenWRT.

Yes ... apparently mips implements flush_anon_page(); I'm misremembering
how fuse got fixed.

> > The problem seems to be defined as one of ensuring coherency on PIO
> > block devices in the most efficient manner possible.
> 
> > Like I said previously, I still think some extension to the DMA API to
> > map the areas correctly might be the best way forwards.
> 
> What do you mean under DMA API? Do you mean that we should fix memcpy?

The DMA API prepares user pages to send to physical devices via MMIO.
It's an abstraction to prevent device driver writers having to remember
complex (and architecture specific) rules about page flushing.

For PIO we have this kmap/operate/flush_kernel_dcache_page()/kunmap
complexity (see for example drivers/mmc/mmc_spi.c).  However, it could
all be taken care of in a similar way to the DMA API via an
abstraction ... although I suspect the best abstraction is to pull the
flush into kunmap.

What MTD device is this?  The subsystem is very complex, but I suppose I
could trace the read path in a single device to see what the actual
problem is.

James
