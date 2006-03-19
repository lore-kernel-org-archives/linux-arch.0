Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:12254 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750978AbWCSUxm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 15:53:42 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060319.123320.71795946.davem@davemloft.net>
References: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
	 <20060319.123320.71795946.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 14:53:08 -0600
Message-Id: <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 12:33 -0800, David S. Miller wrote:
> flush_dcache_page() implementations intentionally don't operate on
> anonymous pages because the kernel should only ever access anonymous
> pages via:

Yes .. I can certainly live with that one.

> 1) copy_user_highpage()/clear_user_highpage(), where you can
>    handle the D-cache issues there.
> 
> 2) device DMA, where the L2 cache eviction done by the device DMA
>    will pull out the D-cache entries, or if the block I/O is via PIO
>    it will do cache flushing in there, as per some asm-*/ide.h
>    implementations of __ide_ins*()/__ide_outs*()

Actually, this is my specific worry.  On parisc, the coherence index
associated with the DMA is that of the kernel mapping, not the user
mappings, so DMA only flushes the kernel cache for the line, not the
user one.  If nothing happens to purge the user line, DMA to anon pages
won't work on parisc either.

> 3) ptrace poking
> 
> You've found a case that doesn't go through any special interfaces,
> and thus is not handled properly at the current time.

I do think we need to begin considering it.  The user space device
managers, like hal, are starting to use SG_IO to interrogate devices,
making it much more prevalent than before.  It's got to be only a matter
of time before this issue bites something like hal.

Is the principle that get_user_pages() should return coherent pages OK?
If so, I think the fix is to have get_user_pages do a specific user page
flush for anonymous pages.

James


