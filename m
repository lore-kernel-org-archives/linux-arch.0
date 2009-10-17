From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Microblaze caches + tlb handling
Date: Sat, 17 Oct 2009 22:35:16 +0900
Message-ID: <20091017133516.GA20090@linux-sh.org>
References: <4AD87791.5050502@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:37470 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbZJQNgX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 17 Oct 2009 09:36:23 -0400
Content-Disposition: inline
In-Reply-To: <4AD87791.5050502@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: David Miller <davem@davemloft.net>, lkml <linux-arch@vger.kernel.org>, John Williams <john.williams@petalogix.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, chris@zankel.net, Ralf Baechle <ralf@linux-mips.org>

On Fri, Oct 16, 2009 at 03:39:29PM +0200, Michal Simek wrote:
> The second thing which I would like to check is number of functions which are empty.
> 
> flush_dcache_page, flush_dcache_mmap_lock, flush_dcache_mmap_unlock, flush_cache_dup_mm,
> flush_cache_vmap, flush_cache_vunmap, flush_cache_mm, flush_cache_page, flush_icache_page
> 
There is no generic answer regarding whether you need these or not, it
all depends on your cache architecture and you've left those details out.
If you are on a PIPT non-aliasing cache, then obviously you aren't going
to care about most of these.

flush_icache_page() likewise is something that these days is split up and
handled through flush_dcache_page() and update_mmu_cache(). If you're
doing a from scratch implementation, you probably want to avoid dealing
with it at all.

Having said that, all of ARM/MIPS/SH support a wide variety of cache
configurations, so it's fairly trivial to see which types of strategies
can be undertaken with different cache types just by reading through
those.

> The second part of this email but it is related. It is about tlb_start_vma and tlb_end_vma.
> arm, avr32, sh, sparc and xtensa implement it and mips implement only tlb_start_vma.
> Implementation is almost the same. My question is, if is any reason to implement(or not implement) them?
> 
That would be an optimization to reduce expensive TLB flushing for large
mappings. With these implemented it's possible to track the range and
work out whether to do a partial or full MM flush, which can offer
sizeable performance gains, especially if your platform supports ASID
tags and your full MM flush is just bumping up the ASID (MIPS and SH both
do this, for example).

You can look at c20351846efcb755ba849d9fb701fbd9a1ffb7c2 to see the SH
change that implemented this, which in turn was derived from an earlier
ARM one. That has some more background information and links to the
earlier discussion about it.
