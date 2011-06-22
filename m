From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [Linaro-mm-sig] [PATCH 7/8] common: dma-mapping: change
 alloc/free_coherent method to more generic alloc/free_attrs
Date: Wed, 22 Jun 2011 09:00:54 +0900
Message-ID: <BANLkTinDN-FF5=8uj9pP58Ny0-LUMtjh=g@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
	<002401cc3005$a941c010$fbc54030$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39912 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407Ab1FVAAy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2011 20:00:54 -0400
Received: by gxk21 with SMTP id 21so123413gxk.19
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2011 17:00:54 -0700 (PDT)
In-Reply-To: <002401cc3005$a941c010$fbc54030$%szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arch@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org

2011/6/21 Marek Szyprowski <m.szyprowski@samsung.com>:
>
> You already got a reply that dropping dma_alloc_writecombine() is no
> go on ARM.
>
Yes.

> That's not a problem. Once we agree on dma_alloc_attrs(), the drivers
> can be changed to use DMA_ATTR_WRITE_COMBINE attribute. If the platform
> doesn't support the attribute, it is just ignored. That's the whole
> point of the attributes extension. Once a driver is converted to
> dma_alloc_attrs(), it can be used without any changes either on platforms
> that supports some specific attributes or the one that doesn't implement
> support for any of them.
>
I just worried that removing an existing construct is not a simple job.
You introduced 3 attributes: DMA_ATTR_WRITE_COMBINE, ***COHERENT and
***NO_KERNEL_VADDR

I replied earlier, I also indicated that write combining option for
dma_alloc_*() is required.
But it does not mean dma_map_ops must support that.
I think dma_alloc_writecombine() can be implemented regardless of dma_map_ops.

> Allocation is a separate operation from mapping to userspace. Mmap
> operation should just map the buffer (represented by a cookie of type
> dma_addr_t) to user address space.
>
> Note that some drivers (like framebuffer drivers for example) also
> needs to have both types of mapping - one for user space and one for
> kernel virtual space.

I meant that I think DMA_ATTR_NOKERNELVADDR is not required because
you also introduced mmap callback.
