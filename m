From: Michal Simek <monstr@monstr.eu>
Subject: Re: Microblaze caches + tlb handling
Date: Mon, 19 Oct 2009 14:05:14 +0200
Message-ID: <4ADC55FA.6000609@monstr.eu>
References: <4AD87791.5050502@monstr.eu> <20091017133516.GA20090@linux-sh.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:51355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbZJSMFK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2009 08:05:10 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1436702fga.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Oct 2009 05:05:14 -0700 (PDT)
In-Reply-To: <20091017133516.GA20090@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: David Miller <davem@davemloft.net>, lkml <linux-arch@vger.kernel.org>, John Williams <john.williams@petalogix.com>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, chris@zankel.net, Ralf Baechle <ralf@linux-mips.org>

Paul Mundt wrote:
> On Fri, Oct 16, 2009 at 03:39:29PM +0200, Michal Simek wrote:
>> The second thing which I would like to check is number of functions which are empty.
>>
>> flush_dcache_page, flush_dcache_mmap_lock, flush_dcache_mmap_unlock, flush_cache_dup_mm,
>> flush_cache_vmap, flush_cache_vunmap, flush_cache_mm, flush_cache_page, flush_icache_page
>>
> There is no generic answer regarding whether you need these or not, it
> all depends on your cache architecture and you've left those details out.
> If you are on a PIPT non-aliasing cache, then obviously you aren't going
> to care about most of these.
> 
> flush_icache_page() likewise is something that these days is split up and
> handled through flush_dcache_page() and update_mmu_cache(). If you're
> doing a from scratch implementation, you probably want to avoid dealing
> with it at all.

yep it is the first wb implementation - I'll do more test to see if I don't break anything.

> 
> Having said that, all of ARM/MIPS/SH support a wide variety of cache
> configurations, so it's fairly trivial to see which types of strategies
> can be undertaken with different cache types just by reading through
> those.
> 
>> The second part of this email but it is related. It is about tlb_start_vma and tlb_end_vma.
>> arm, avr32, sh, sparc and xtensa implement it and mips implement only tlb_start_vma.
>> Implementation is almost the same. My question is, if is any reason to implement(or not implement) them?
>>
> That would be an optimization to reduce expensive TLB flushing for large
> mappings. With these implemented it's possible to track the range and
> work out whether to do a partial or full MM flush, which can offer
> sizeable performance gains, especially if your platform supports ASID
> tags and your full MM flush is just bumping up the ASID (MIPS and SH both
> do this, for example).
> 
> You can look at c20351846efcb755ba849d9fb701fbd9a1ffb7c2 to see the SH
> change that implemented this, which in turn was derived from an earlier
> ARM one. That has some more background information and links to the
> earlier discussion about it.

Ok. I'll take a look at it.

Thanks for information,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
