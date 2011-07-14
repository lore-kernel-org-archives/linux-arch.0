From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 13/13] memblock, x86: Replace memblock_x86_reserve/free_range()
 with generic ones
Date: Thu, 14 Jul 2011 13:10:20 -0700
Message-ID: <4E1F4D2C.3000507@zytor.com>
References: <1310462166-31469-1-git-send-email-tj@kernel.org> <1310462166-31469-14-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52031 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab1GNUKe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jul 2011 16:10:34 -0400
In-Reply-To: <1310462166-31469-14-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, yinghai@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On 07/12/2011 02:16 AM, Tejun Heo wrote:
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -449,6 +449,9 @@ long __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
>  
>  long __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
>  {
> +	memblock_dbg("   memblock_free: [%#016llx-%#016llx] %pF\n",
> +		     base, base + size, (void *)_RET_IP_);
> +
>  	return __memblock_remove(&memblock.reserved, base, size);
>  }
>  
> @@ -456,6 +459,8 @@ long __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
>  {
>  	struct memblock_type *_rgn = &memblock.reserved;
>  
> +	memblock_dbg("memblock_reserve: [%#016llx-%#016llx] %pF\n",
> +		     base, base + size, (void *)_RET_IP_);
>  	BUG_ON(0 == size);
>  
>  	return memblock_add_region(_rgn, base, size);

This assumes phys_addr_t == unsigned long long, which is just plain
wrong.  I will fix it up, but please take more care with that in the
future.  This triggers a warning when building for i386 non-PAE, which
is a good thing because it is a real error.

Also, don't we usually display resources as an *inclusive* range,
meaning that the last one should be base + size - 1?

	-hpa
