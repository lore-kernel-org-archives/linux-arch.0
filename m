Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbfHFGte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 02:49:34 -0400
Date: Mon, 5 Aug 2019 23:49:33 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory
 ZONEs
Message-ID: <20190806064933.GA2508@infradead.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564488945-20149-3-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190806064933.fvCTKP6cfh3xL8yMfYeK9RDHgG5b1xwF3SrltmsDUIk@z>

On Tue, Jul 30, 2019 at 08:15:44PM +0800, guoren@kernel.org wrote:
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 80783bb..3f1ff9d 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
>  {
>  	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
>  }
> -postcore_initcall(atomic_pool_init);

Please keep the postcore_initcall next to the function it calls.

In this particular case I also plan to remove the function for 5.4 by
moving it to the common dma code, so it is more important than just style.
