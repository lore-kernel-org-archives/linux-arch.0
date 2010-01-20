From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH] asm-generic: dma: Add BUG_ON for uninitialized dma_ops
Date: Wed, 20 Jan 2010 11:56:34 +0100
Message-ID: <20100120105634.GC8665@amd.com>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
 <1263982111-24123-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:56759
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750962Ab0ATK5X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Jan 2010 05:57:23 -0500
Content-Disposition: inline
In-Reply-To: <1263982111-24123-2-git-send-email-monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu

On Wed, Jan 20, 2010 at 11:08:31AM +0100, monstr@monstr.eu wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> Check that dma_ops are initialized correctly. Without this
> checking you get kernel fault and you don't know where the problem is.
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  include/asm-generic/dma-mapping-common.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
> index e694263..ca8bc25 100644
> --- a/include/asm-generic/dma-mapping-common.h
> +++ b/include/asm-generic/dma-mapping-common.h
> @@ -15,6 +15,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>  	dma_addr_t addr;
>  
>  	kmemcheck_mark_initialized(ptr, size);
> +	BUG_ON(!ops);
>  	BUG_ON(!valid_dma_direction(dir));
>  	addr = ops->map_page(dev, virt_to_page(ptr),
>  			     (unsigned long)ptr & ~PAGE_MASK, size,

[...]

> @@ -169,6 +178,7 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>  {
>  	struct dma_map_ops *ops = get_dma_ops(dev);
>  
> +	BUG_ON(!ops);
>  	BUG_ON(!valid_dma_direction(dir));
>  	if (ops->sync_sg_for_device)
>  		ops->sync_sg_for_device(dev, sg, nelems, dir);

The more logical place for all these checks would be in get_dma_ops. But
I also question the value of the check. Every dma_ops implementation
that has survived a boot test shouldn't have this bug. So I see no point
in adding extra cycles to every dma-api call.

	Joerg
