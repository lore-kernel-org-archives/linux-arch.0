From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH 09/56] microblaze_v2: cache support
Date: Mon, 05 May 2008 12:09:03 +1000
Message-ID: <1209953343.5798.54.camel@localhost>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	 <c805caeb1dd7f6d1349c4a463cb88a5342a170d2.1209897266.git.monstr@monstr.eu>
	 <f120ababf2bade9aab7199bffb3014aa606e5a1c.1209897266.git.monstr@monstr.eu>
	 <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
	 <ed3695121faf485d491cecdd96d5d4dcc498411d.1209897266.git.monstr@monstr.eu>
	 <0674b1f7abb9a3d564b68c95bc28adc2c2fe9551.1209897266.git.monstr@monstr.eu>
	 <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
	 <932956128c9c655a218a940eaf02017a5dd0bdf9.1209897266.git.monstr@monstr.eu>
	 <2f801c33caee22e112af51ae927c264ce99ead01.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:49091 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbYEECJn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 22:09:43 -0400
In-Reply-To: <2f801c33caee22e112af51ae927c264ce99ead01.1209897266.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>


> +++ b/arch/microblaze/kernel/cpu/cache.c

> +void __flush_icache_all(void)
> +{
> +	unsigned int i;
> +	unsigned flags;
> +
> +	if (cpuinfo.use_icache) {
> +		local_irq_save(flags);
> +		__disable_icache();
> +
> +		/* Just loop through cache size and invalidate, no need to add
> +			CACHE_BASE address */
> +		for (i = 0; i < cpuinfo.icache_size;
> +			i += cpuinfo.icache_line)
> +				__invalidate_icache(i);
> +
> +		__enable_icache();
> +		local_irq_restore(flags);
> +	}
> +}

This is the slowest and greatest latency-inducing loop in the MicroBlaze
kernel.  The CPU specs says icache must be disabled while you clear it -
if you have a chance it's worth checking to see what happens if you
violate that rule.

This will be less of a problem once we update the kernel_from_bram
patches, but that may be a little while yet.


> +void __flush_icache_range(unsigned long start, unsigned long end)

ditto

> +void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
> +{
> +	__flush_icache_all();
> +}
> +

This could be smarter - if our cache size is less than a page then there
is a win to be had.  But, it's my fault so I won't complain too loudly!

> +void __flush_icache_user_range(struct vm_area_struct *vma,
> +				struct page *page, unsigned long adr,
> +				int len)
> +{
> +	__flush_icache_all();
> +}

and again.

> +
> +void __flush_cache_sigtramp(unsigned long addr)
> +{
> +	__flush_icache_range(addr, addr + 8);
> +}

Perhaps a #define in asm-microblaze/signal.h to tell us the size of the
sigtramp, and also used by microblaze/kernel/signal.c?

> +
> +void __flush_dcache_all(void)
> +{
> +	unsigned int i;
> +	unsigned flags;
> +
> +	if (cpuinfo.use_dcache) {
> +		local_irq_save(flags);
> +		__disable_dcache();
> +
> +		/*
> +		 * Just loop through cache size and invalidate,
> +		 * no need to add CACHE_BASE address
> +		 */
> +		for (i = 0; i < cpuinfo.dcache_size;
> +			i += cpuinfo.dcache_line)
> +				__invalidate_dcache(i);
> +
> +		__enable_dcache();
> +		local_irq_restore(flags);
> +	}
> +}

again might be worth testing if it still works with dcache enabled
during the flush loop.


> --- /dev/null
> +++ b/include/asm-microblaze/cache.h

> +#ifndef L1_CACHE_BYTES
> +/* word-granular cache in microblaze */
> +#define L1_CACHE_BYTES		4
> +#endif

Is this actually used anywhere?  If so, it's wrong because cache line
sizes is configurable now.


> +/* FIXME - I don't think this is right */
> +#ifdef CONFIG_XILINX_UNCACHED_SHADOW
> +#define UNCACHED_SHADOW_MASK (CONFIG_XILINX_ERAM_SIZE)
> +#endif

If you are throwing out the alloc_consist()/free_consist()
implementation then the UNCACHED_SHADOW stuff can go too.


> +#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> +do { memcpy(dst, src, len); \
> +	flush_icache_user_range(vma, page, vaddr, len); \
> +} while (0)

Is the icache flush required?  Is copy_to_user_page() called from the
binfmt_flat loader?
