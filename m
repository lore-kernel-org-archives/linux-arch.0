From: Subash Patel <subashrp@gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH/RFC 0/8] ARM: DMA-mapping framework redesign
Date: Wed, 22 Jun 2011 10:23:13 +0530
Message-ID: <4E017539.30505@gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48531 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1FVEx2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2011 00:53:28 -0400
Received: by pwj7 with SMTP id 7so371883pwj.19
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2011 21:53:28 -0700 (PDT)
In-Reply-To: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>

Hi Marek,

On 06/20/2011 01:20 PM, Marek Szyprowski wrote:
> Hello,
>
> This patch series is a continuation of my works on implementing generic
> IOMMU support in DMA mapping framework for ARM architecture. Now I
> focused on the DMA mapping framework itself. It turned out that adding
> support for common dma_map_ops structure was not that hard as I initally
> thought. After some modification most of the code fits really well to
> the generic dma_map_ops methods.
>
> The only change required to dma_map_ops is a new alloc function. During
> the discussion on Linaro Memory Management meeting in Budapest we got
> the idea that we can have only one alloc/free/mmap function with
> additional attributes argument. This way all different kinds of
> architecture specific buffer mappings can be hidden behind the
> attributes without the need of creating several versions of dma_alloc_
> function. I also noticed that the dma_alloc_noncoherent() function can
> be also implemented this way with DMA_ATTRIB_NON_COHERENT attribute.
> Systems that just defines dma_alloc_noncoherent as dma_alloc_coherent
> will just ignore such attribute.
>
> Another good use case for alloc methods with attributes is the
> possibility to allocate buffer without a valid kernel mapping. There are
> a number of drivers (mainly V4L2 and ALSA) that only exports the DMA
> buffers to user space. Such drivers don't touch the buffer data at all.
> For such buffers we can avoid the creation of a mapping in kernel
> virtual address space, saving precious vmalloc area. Such buffers might
> be allocated once a new attribute DMA_ATTRIB_NO_KERNEL_MAPPING.

Are you trying to say here, that the buffer would be allocated in the 
user space, and we just use it to map it to the device in DMA+IOMMU 
framework?

>
> All the changes introduced in this patch series are intended to prepare
> a good ground for upcoming generic IOMMU integration to DMA mapping
> framework on ARM architecture.
>
> For more information about proof-of-concept IOMMU implementation in DMA
> mapping framework, please refer to my previous set of patches:
> http://www.spinics.net/lists/linux-mm/msg19856.html
>
> I've tried to split the redesign into a set of single-step changes for
> easier review and understanding. If there is anything that needs further
> clarification, please don't hesitate to ask.
>
> The patches are prepared on top of Linux Kernel v3.0-rc3.
>
> The proposed changes have been tested on Samsung Exynos4 platform. I've
> also tested dmabounce code (by manually registering support for DMA
> bounce for some of the devices available on my board), although my
> hardware have no such strict requirements. Would be great if one could
> test my patches on different ARM architectures to check if I didn't
> break anything.
>
> Best regards

Regards,
Subash
SISO-SLG
