From: anfei <anfei.zhou@gmail.com>
Subject: Re: [patch 05/16] mm: flush dcache before writing into page to
	avoid alias
Date: Thu, 4 Feb 2010 22:39:19 +0800
Message-ID: <20100204143919.GA11387@desktop>
References: <201002022144.o12Li2wj015711@imap1.linux-foundation.org> <1265221507.2873.369.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:48624 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450Ab0BDOjZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2010 09:39:25 -0500
Content-Disposition: inline
In-Reply-To: <1265221507.2873.369.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, miklos@szeredi.hu, nickpiggin@yahoo.com.au, rmk@arm.linux.org.uk, stable@kernel.org

On Wed, Feb 03, 2010 at 12:25:07PM -0600, James Bottomley wrote:
> On Tue, 2010-02-02 at 13:44 -0800, akpm@linux-foundation.org wrote:
> > From: anfei zhou <anfei.zhou@gmail.com>
> > 
> > The cache alias problem will happen if the changes of user shared mapping
> > is not flushed before copying, then user and kernel mapping may be mapped
> > into two different cache line, it is impossible to guarantee the coherence
> > after iov_iter_copy_from_user_atomic.  So the right steps should be:
> > 
> > 	flush_dcache_page(page);
> 
> This is likely unnecessary if the page has come down a standard path ...
> for fuse, it is possible it didn't go through __get_user_pages().
> 
The problem here is iov_iter_copy_from_user_atomic will write the page,
and that page has been written by (*addr = val) before, but not flushed
yet.  If these two writes are at the same cache line (but aliased), then
we can not guarantee the result by any order.

> > 	kmap_atomic(page);
> > 	write to page;
> > 	kunmap_atomic(page);
> > 	flush_dcache_page(page);
> > 
> > More precisely, we might create two new APIs flush_dcache_user_page and
> > flush_dcache_kern_page to replace the two flush_dcache_page accordingly.
> 
> We already have one of those: flush_kernel_dcache_page().
> 
Yes, but it's only called in a few places, and others usually use
flush_dcache_page, why?

And not every arch with aliasing problem has implement it, such as MIPS.

Regards,
Anfei.

> James
> 
> 
