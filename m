Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58740 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767387AbXECFDb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2007 01:03:31 -0400
Date: Wed, 2 May 2007 22:03:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Increase slab redzone to 64bits.
Message-Id: <20070502220325.6cf210be.akpm@linux-foundation.org>
In-Reply-To: <1178026980.2875.68.camel@pmac.infradead.org>
References: <1178026980.2875.68.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 01 May 2007 14:43:00 +0100 David Woodhouse <dwmw2@infradead.org> wrote:

> There are two problems with the existing redzone implementation.
> 
> Firstly, it's causing misalignment of structures which contain a 64-bit
> integer, such as netfilter's 'struct ipt_entry' -- causing netfilter
> modules to fail to load because of the misalignment. (In particular, the
> first check in net/ipv4/netfilter/ip_tables.c::check_entry_size_and_hooks())
> 
> I considered just fixing this by setting ARCH_KMALLOC_MINALIGN to
> __alignof__(uint64_t) in the default case where the architecture hasn't
> already set it -- but that would disable redzone checks on those
> architectures.
> 
> When investigating this, I noticed that on 64-bit platforms we're using
> a 32-bit value of RED_ACTIVE/RED_INACTIVE in the 64-bit memory location
> set aside for the redzone. Which means that the four bytes immediately
> before or after the allocated object at 0x00,0x00,0x00,0x00 for LE and
> BE machines, respectively. Which is probably not the most useful choice
> of poison value.
> 
> One way to fix both of those at once is just to switch to 64-bit
> redzones in all cases. Patch below; better ideas on a postcard to...
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index 3e628f9..e69982e 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -15,8 +15,8 @@
>   * Magic nums for obj red zoning.
>   * Placed in the first word before and the first word after an obj.
>   */
> -#define	RED_INACTIVE	0x5A2CF071UL	/* when obj is inactive */
> -#define	RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
> +#define	RED_INACTIVE	0x5A2CF0715A2CF071ULL	/* when obj is inactive */
> +#define	RED_ACTIVE	0x170FC2A5170FC2A5ULL	/* when obj is active */

I guess it would be slightly useful to use a different pattern for the
other 32 bits.

>  /* ...and for poisoning */
>  #define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
> diff --git a/mm/slab.c b/mm/slab.c
> index 4cbac24..92413cb 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -149,10 +149,11 @@
>   * Usually, the kmalloc caches are cache_line_size() aligned, except when
>   * DEBUG and FORCED_DEBUG are enabled, then they are BYTES_PER_WORD aligned.
>   * Some archs want to perform DMA into kmalloc caches and need a guaranteed
> - * alignment larger than BYTES_PER_WORD. ARCH_KMALLOC_MINALIGN allows that.
> - * Note that this flag disables some debug features.
> + * alignment larger than the alignment of a uint64_t. ARCH_KMALLOC_MINALIGN
> + * allows that.
> + * Note that increasing this value may disable some debug features.
>   */
> -#define ARCH_KMALLOC_MINALIGN 0
> +#define ARCH_KMALLOC_MINALIGN __alignof__(uint64_t)
>  #endif

That would be the only uintNN_t in all of MM.  Stubborn chap.

More seriously, either we should use unsigned long long here, or we should
use u64 everywhere else.

> -	return (unsigned long*) (objp+obj_offset(cachep)-BYTES_PER_WORD);
> +	return (unsigned long long*) (objp+obj_offset(cachep)-8);

And given all the hardwired "8"s, u64 would be more logical.

Doesn't matter a lot - hopefully slab.c will not see the year out.
