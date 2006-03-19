Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56985
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750910AbWCSUdT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 15:33:19 -0500
Date: Sun, 19 Mar 2006 12:33:20 -0800 (PST)
Message-Id: <20060319.123320.71795946.davem@davemloft.net>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
References: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 19 Mar 2006 11:15:58 -0600

> The problem, essentially is that get_user_pages() doesn't return a
> coherent view of anonymous pages to the kernel.  The reason is that
> get_user_pages() uses flush_dcache_page() as its engine of coherence,
> and a lot of flush_dcache_page() implementations use the page_mapping()
> macros to get a list of user mappings of the page.  The page_mapping()
> macro (include/linux/mm.h) returns NULL if the PAGE_MAPPING_ANON flag is
> set, this means that flush_dcache_page() has no list of user mappings,
> so nothing gets flushed in user space.
> 
> A lot of arch's don't have an incoherent view of user and kernel
> mappings, so I think this problem perhaps affects only parisc and arm.

flush_dcache_page() implementations intentionally don't operate on
anonymous pages because the kernel should only ever access anonymous
pages via:

1) copy_user_highpage()/clear_user_highpage(), where you can
   handle the D-cache issues there.

2) device DMA, where the L2 cache eviction done by the device DMA
   will pull out the D-cache entries, or if the block I/O is via PIO
   it will do cache flushing in there, as per some asm-*/ide.h
   implementations of __ide_ins*()/__ide_outs*()

3) ptrace poking

You've found a case that doesn't go through any special interfaces,
and thus is not handled properly at the current time.
