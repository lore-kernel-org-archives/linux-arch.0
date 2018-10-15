Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45629 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeJOIwH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Oct 2018 04:52:07 -0400
Message-ID: <9cfe508c687068853a6e5e030962a78467a8d313.camel@kernel.crashing.org>
Subject: Re: [PATCH 01/33] powerpc: use mm zones more sensibly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Oct 2018 11:47:13 +1100
In-Reply-To: <20181009132500.17643-2-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
         <20181009132500.17643-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181015004713.w_YlQrWZQFFS1sehmRgcIO1CPDK_QLS1TwfrVZQpTJY@z>

On Tue, 2018-10-09 at 15:24 +0200, Christoph Hellwig wrote:
>   * Find the least restrictive zone that is entirely below the
> @@ -324,11 +305,14 @@ void __init paging_init(void)
>         printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>                (long int)((top_of_ram - total_ram) >> 20));
>  
> +#ifdef CONFIG_ZONE_DMA
> +       max_zone_pfns[ZONE_DMA] = min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
> +#endif
> +       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
> -       limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
> +       max_zone_pfns[ZONE_HIGHMEM] = max_pfn
                                               ^
Missing a  ";" here  --------------------------|

Sorry ... works with that fix on an old laptop with highmem.

>  #endif
> -       limit_zone_pfn(TOP_ZONE, top_of_ram >> PAGE_SHIFT);
> -       zone_limits_final = true;
> +
>         free_area_init_nodes(max_zone_pfns);
>  
