From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH -mm 2/3] unify dma_get_cache_alignment implementations
Date: Thu, 08 Jul 2010 23:14:30 -0700 (PDT)
Message-ID: <20100708.231430.35020644.davem@davemloft.net>
References: <1278572268-26146-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1278572268-26146-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57022
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012Ab0GIGOP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2010 02:14:15 -0400
In-Reply-To: <1278572268-26146-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: fujita.tomonori@lab.ntt.co.jp
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Thu,  8 Jul 2010 15:57:47 +0900

> dma_get_cache_alignment returns the minimum DMA
> alignment. Architectures defines it as ARCH_DMA_MINALIGN (formally
> ARCH_KMALLOC_MINALIGN). So we can unify dma_get_cache_alignment
> implementations.
> 
> Note that some architectures implement dma_get_cache_alignment
> wrongly. dma_get_cache_alignment() should return the minimum DMA
> alignment. So fully-coherent architectures should return 1. This patch
> also fixes this issue.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Acked-by: David S. Miller <davem@davemloft.net>
