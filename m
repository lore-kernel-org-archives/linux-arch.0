Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39491
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965073AbXABXTI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2007 18:19:08 -0500
Date: Tue, 02 Jan 2007 15:19:06 -0800 (PST)
Message-Id: <20070102.151906.21595863.davem@davemloft.net>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167778403.3687.1.camel@mulgrave.il.steeleye.com>
References: <E1H1VQu-0005oJ-00@dorka.pomaz.szeredi.hu>
	<20070101234559.GE30535@flint.arm.linux.org.uk>
	<1167778403.3687.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: rmk+lkml@arm.linux.org.uk, miklos@szeredi.hu, arjan@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Tue, 02 Jan 2007 16:53:23 -0600

> OK, so lets get down to brass tacks and look at the API characteristics.
> 
> Some of the issues are:
> 
>      1. Should kmap() actually flush all the user spaces? 
>      2. Do we need additional hints in to kmap/kunmap?
> 
> My initial thought on 1. is no, since by and large we use kmap on pages
> that have come to use via an I/O path, so usually they've already had
> the user caches made coherent, unless you want do do this via a hint.

Who did this cache flush?  The idea is to make flush_dcache_page()
do nothing, and have all of the work be done via the kmap()/kunmap()
sequence.

The case you're speaking about isn't a fault path, so it's not
like there will be a flush_cache_page() call somewhere either.

> For 2. like I said, I coded this on parisc without hints (using the page
> table information instead to deduce what type of access the page had
> taken) but we could equally well have used hints.

There are two important attributes 1) most permissive page protection
of the user mappings, essentially does anyone have a writable access
to the page and 2) the access the kernel will make, read or write.

If the kernel is going to read, kmap() would need to flush any
writable user mappings, that's all.

If the kernel is going to write, all user mappings have to be
purged completely so that the writes are visible.

I'm going to coneniently remind you it's possible to avoid all of the
cache flushes by using TLB mappings at kmap() time.  I think PARISC
can even do this, to be honest.  What makes that scheme unusable on
PARISC?
