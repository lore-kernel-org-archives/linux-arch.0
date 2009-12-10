From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: problems in commit 2d4dc890b5c8 (block: add helpers to run
 flush_dcache_page() against a bio and a request's pages)
Date: Wed, 09 Dec 2009 18:19:55 -0600
Message-ID: <1260404395.14369.68.camel@mulgrave.site>
References: <1260398346.14369.45.camel@mulgrave.site>
	 <20091210020309.36742c7f.isloginov@gmail.com>
	 <1260400273.14369.52.camel@mulgrave.site>
	 <20091210023609.b8c9bd34.isloginov@gmail.com>
	 <1260402471.14369.60.camel@mulgrave.site>
	 <20091210030638.db4cfd8a.isloginov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55499 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759117AbZLJATw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2009 19:19:52 -0500
In-Reply-To: <20091210030638.db4cfd8a.isloginov@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Loginov <isloginov@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org

On Thu, 2009-12-10 at 03:06 +0300, Ilya Loginov wrote:
> On Wed, 09 Dec 2009 17:47:51 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > Which architecture is this? ... because if it's missing a necessary
> > definition for flush_kernel_dcache_page() it's very easy to add it ...
> 
> This is a MIPS. Why? The call flush_dcache_page() on MIPS is lazy enought.
> And it do exactly what i need to fix the problem.

OK, but the point I'm making is that it's a very heavyweight function on
a lot of architectures.  It sounds like mips should just have a
flush_kernel_dcache_page() ... has anyone tested fuse on mips; if that
fails, then it's a must.

> > > But. I could do that rq_flush_dcache_pages will call flush_kernel_dcache_page
> > > for architectures where ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE was defined.
> > 
> > The point I'm trying to make is that flush_dcache_page() does a lot of
> > unnecessary flushing.  Where you are in the system with the READ call,
> > you know the user aliases are clean (because users aren't allowed to
> > touch pages submitted for write), so you only (for efficiency) need to
> > flush the dirty kernel alias.
> 
> I understand that in your case(parisc) solution with flushdcache_page()
> is very voracious.

It's not the worst ... VIVT arm is the worst because it loops over every
user mapping of the page.

>  But I don't think that we should change something
> somewhere else except parisc. Or we should write to Ralf Baechle and
> other maintainers and discuss all with them. Don't think?

We actually are ... that's what this linux-arch list is for: contacting
all the architecture maintainers.

The problem seems to be defined as one of ensuring coherency on PIO
block devices in the most efficient manner possible.

Like I said previously, I still think some extension to the DMA API to
map the areas correctly might be the best way forwards.

James
