From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [patch 05/16] mm: flush dcache before writing into page to
 avoid alias
Date: Wed, 03 Feb 2010 12:25:07 -0600
Message-ID: <1265221507.2873.369.camel@mulgrave.site>
References: <201002022144.o12Li2wj015711@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55319 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754272Ab0BCSZO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2010 13:25:14 -0500
In-Reply-To: <201002022144.o12Li2wj015711@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, anfei.zhou@gmail.com, linux-arch@vger.kernel.org, miklos@szeredi.hu, nickpiggin@yahoo.com.au, rmk@arm.linux.org.uk, stable@kernel.org

On Tue, 2010-02-02 at 13:44 -0800, akpm@linux-foundation.org wrote:
> From: anfei zhou <anfei.zhou@gmail.com>
> 
> The cache alias problem will happen if the changes of user shared mapping
> is not flushed before copying, then user and kernel mapping may be mapped
> into two different cache line, it is impossible to guarantee the coherence
> after iov_iter_copy_from_user_atomic.  So the right steps should be:
> 
> 	flush_dcache_page(page);

This is likely unnecessary if the page has come down a standard path ...
for fuse, it is possible it didn't go through __get_user_pages().

> 	kmap_atomic(page);
> 	write to page;
> 	kunmap_atomic(page);
> 	flush_dcache_page(page);
> 
> More precisely, we might create two new APIs flush_dcache_user_page and
> flush_dcache_kern_page to replace the two flush_dcache_page accordingly.

We already have one of those: flush_kernel_dcache_page().

James
