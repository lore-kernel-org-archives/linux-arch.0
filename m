From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Thu, 10 Dec 2009 16:00:18 -0600
Message-ID: <1260482418.2457.208.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091210020309.36742c7f.isloginov@gmail.com>
	 <1260400273.14369.52.camel@mulgrave.site>
	 <20091210023609.b8c9bd34.isloginov@gmail.com>
	 <1260402471.14369.60.camel@mulgrave.site>
	 <20091210030638.db4cfd8a.isloginov@gmail.com>
	 <1260404395.14369.68.camel@mulgrave.site>
	 <20091210074020.a7c36c32.isloginov@gmail.com>
	 <1260464851.2457.98.camel@mulgrave.site>
	 <20091210224637.cb9712f7.isloginov@gmail.com>
	 <1260476884.2457.116.camel@mulgrave.site>
	 <20091210234816.5aca535e.isloginov@gmail.com>
	 <1260478776.2457.141.camel@mulgrave.site>
	 <20091211002700.0600d327.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48038 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761248AbZLJWAQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Dec 2009 17:00:16 -0500
In-Reply-To: <20091211002700.0600d327.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Fri, 2009-12-11 at 00:27 +0300, Ilya Loginov wrote:
> On Thu, 10 Dec 2009 14:59:36 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > To fix mips, you just need a
> > flush_kernel_dcache_page() in slram_read so that the alias is updated
> > after the memcpy. 
> 
> I think you right. But! If we choose this way:
> 
> First. We need to realize flush_kernel_dcache_page() for many
> architectures. Am I right?

Actually, I think only sparc and mips need it.  It's only needed for an
aliasing architecture.  Next, it's only used for pio drivers, so if the
platform never uses a pio driver, it can get away without having this
(that's the sparc case, I think).

> Second. What difference will be between flush_kernel_dcache_page and
> flush_dcache_page on MIPS? In common, flush_dcache_page in MIPS set 
> bit dirty on page.

You already replied to this.

> > I would also expect this driver not to work on any
> > highmem system without additional kmap/kunmap(_atomic) pairs in the read
> > and write routines.
> 
> > How many other mtd drivers are affected, I'm not sure ... any that do
> > PIO are wrong ... those that do MMIO should be right (that looks to be
> > just the omap driver).
> 
> Third. We should fix all other PIO drivers with problem and patch
> aoe: switch to the new bio_flush_dcache_pages() interface in -mm tree
> (i can't find this commit in the Linus tree). There is same problem.

Unfortunately, you can't do it at the bio level.  The reason is the
kmap/kunmap.  On a highmem system the mapping disappears after kunmap,
so you have to flush before you lose the mapping ... that means right in
the guts of the driver where it's doing the kmap/copy/kunmap.

Sounds like aio does have the issue, yes.  If you grep the kernel for
flush_kernel_dcache_pages(), you'll see that a lot of PIO drivers are
already using this, so there's not a lot of conversion to be done.

> May be I wrong. And we have much less work.

James
