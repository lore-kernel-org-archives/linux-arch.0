From: Michal Simek <monstr@monstr.eu>
Subject: Microblaze caches + tlb handling
Date: Fri, 16 Oct 2009 15:39:29 +0200
Message-ID: <4AD87791.5050502@monstr.eu>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48740 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZJPNkm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Oct 2009 09:40:42 -0400
Received: by yxe17 with SMTP id 17so2004656yxe.33
        for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2009 06:39:30 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: lkml <linux-arch@vger.kernel.org>, John Williams <john.williams@petalogix.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, chris@zankel.net, Ralf Baechle <ralf@linux-mips.org>

Hi David and others,

I am working on support write-back caches for Microblaze.
I have working implementation but I would like to be sure that I don't miss anything.

I read David's cachetlb.txt in Documentation folder.

Ok. First of all some information about hw implementation.
Cache is between MMU and main memory and I have to use only physical addresses for
flush/invalidation.
This caused first problem for invalidation icache and flushing dcache for signal trampoline.
I took part of this code from sparc where is flushed whole page I think.
David: Am I right?
I need physical address of trampoline that's why there is adding with page offset.


	pmd_t *pmdp;
	pte_t *ptep;
		address = ((unsigned long)frame->tramp);
		pmdp = pmd_offset(pud_offset(
				pgd_offset(current->mm, address),
						address), address);

		preempt_disable();
		ptep = pte_offset_map(pmdp, address);
		if (pte_present(*ptep)) {
			address = (unsigned long) page_address(pte_page(*ptep));
			/* MS: I need add offset in page */
			address += ((unsigned long)frame->tramp) & ~PAGE_MASK;
			/* MS address is virtual */
			address = virt_to_phys(address);
			invalidate_icache_range(address, address + 8);
			flush_dcache_range(address, address + 8);
		}
		pte_unmap(ptep);
		preempt_enable();


The second thing which I would like to check is number of functions which are empty.

flush_dcache_page, flush_dcache_mmap_lock, flush_dcache_mmap_unlock, flush_cache_dup_mm,
flush_cache_vmap, flush_cache_vunmap, flush_cache_mm, flush_cache_page, flush_icache_page


I am not sure about cache aliasing problem but I think that can't happen for Microblaze.
That's why flush_dcache_page is empty too.

flush_icache_user_range call flush_icache. FRV and PowerPC export it and some archs do nothing.
What is the correct behavior.

The rest of functions call corresponding implementations.



The second part of this email but it is related. It is about tlb_start_vma and tlb_end_vma.
arm, avr32, sh, sparc and xtensa implement it and mips implement only tlb_start_vma.
Implementation is almost the same. My question is, if is any reason to implement(or not implement) them?

Thanks for you comments,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
