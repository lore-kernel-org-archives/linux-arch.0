Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44697 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301Ab2CZLEh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Mar 2012 07:04:37 -0400
Message-ID: <4F704D3C.50003@gmail.com>
Date: Mon, 26 Mar 2012 16:34:28 +0530
From: Subash Patel <subashrp@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] ARM: dma-mapping: Fix mmap support for coherent buffers
References: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com> <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>
Message-ID: <20120326110428.fIfwnCNkkysaRbVTxGAminRv8S47z6Dj8fS3td1qNOw@z>

Hi Marek,

I have tested these patch series for origen board, and they mmap the 
buffers to user-space for the coherent pool. You can add:

Tested-By: Subash Patel <subashrp@gmail.com>

Regards,
Subash

On 03/23/2012 05:56 PM, Marek Szyprowski wrote:
> Hello,
>
> This patchset contains patches to fix broken mmap operation for memory
> buffers allocated from 'dma_declare_coherent' pool after applying my dma
> mapping redesign patches [1]. These issues have been reported by Subash
> Patel.
>
> [1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/12819
>
> Patch summary:
>
> Marek Szyprowski (2):
>    common: add dma_mmap_from_coherent() function
>    arm: dma-mapping: use dma_mmap_from_coherent()
>
>   arch/arm/mm/dma-mapping.c          |    3 ++
>   drivers/base/dma-coherent.c        |   42 ++++++++++++++++++++++++++++++++++++
>   include/asm-generic/dma-coherent.h |    4 ++-
>   3 files changed, 48 insertions(+), 1 deletions(-)
>
