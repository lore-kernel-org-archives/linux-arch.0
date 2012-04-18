Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65451 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2DRHOu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Apr 2012 03:14:50 -0400
Received: by pbcun15 with SMTP id un15so8592498pbc.19
        for <linux-arch@vger.kernel.org>; Wed, 18 Apr 2012 00:14:50 -0700 (PDT)
Message-ID: <4F8E69DF.9030003@gmail.com>
Date: Wed, 18 Apr 2012 12:44:39 +0530
From: Subash Patel <subashrp@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv8 00/10] ARM: DMA-mapping framework redesign
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>
Message-ID: <20120418071439.KUhLvFwbMBnxuwT6_OenUo_lHnvlIIT7e4hO72w7_Eo@z>

Hello Marek,

I have tested below patch series for vanilla 3.4-rc2 (without videobuf2 
support for dmabuf patches) with and without IOMMU support on origen 
board. These patches are good now. You can add:

Tested-By: Subash Patel <subash.ramaswamy@linaro.org> for whole series.

Regards,
Subash

On 04/10/2012 04:34 PM, Marek Szyprowski wrote:
> Hello,
>
> Linux v3.4-rc2, which include dma-mapping preparation patches, has been
> released two days ago, now it's time for the next spin of ARM
> dma-mapping redesign patches. This version includes various fixes posted
> separately to v7, mainly related to incorrect io address space bitmap
> setup and a major issue with broken mmap for memory which comes from
> dma_declare_coherent(). The patches have been also rebased onto Linux
> v3.4-rc2 which comes with dma_map_ops related changes.
>
> The code has been tested on Samsung Exynos4 'UniversalC210' and NURI
> boards with IOMMU driver posted by KyongHo Cho, I will put separate
> branch which shows how to integrate this driver with this patchset.
>
> The patches are also available on my git repository at:
> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc2-arm-dma-v8
>
>
> History of the development:
>
> v1: (initial version of the DMA-mapping redesign patches):
> http://www.spinics.net/lists/linux-mm/msg21241.html
>
> v2:
> http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000571.html
> http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000577.html
>
> v3:
> http://www.spinics.net/lists/linux-mm/msg25490.html
>
> v4 and v5:
> http://www.spinics.net/lists/arm-kernel/msg151147.html
> http://www.spinics.net/lists/arm-kernel/msg154889.html
>
> v6:
> http://www.spinics.net/lists/linux-mm/msg29903.html
>
> v7:
> http://www.spinics.net/lists/arm-kernel/msg162149.html
>
> Best regards
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> Patch summary:
>
> Marek Szyprowski (10):
>    common: add dma_mmap_from_coherent() function
>    ARM: dma-mapping: use pr_* instread of printk
>    ARM: dma-mapping: introduce ARM_DMA_ERROR constant
>    ARM: dma-mapping: remove offset parameter to prepare for generic
>      dma_ops
>    ARM: dma-mapping: use asm-generic/dma-mapping-common.h
>    ARM: dma-mapping: implement dma sg methods on top of any generic dma
>      ops
>    ARM: dma-mapping: move all dma bounce code to separate dma ops
>      structure
>    ARM: dma-mapping: remove redundant code and cleanup
>    ARM: dma-mapping: use alloc, mmap, free from dma_ops
>    ARM: dma-mapping: add support for IOMMU mapper
>
>   arch/arm/Kconfig                   |    9 +
>   arch/arm/common/dmabounce.c        |   84 +++-
>   arch/arm/include/asm/device.h      |    4 +
>   arch/arm/include/asm/dma-iommu.h   |   34 ++
>   arch/arm/include/asm/dma-mapping.h |  407 ++++-----------
>   arch/arm/mm/dma-mapping.c          | 1019 ++++++++++++++++++++++++++++++------
>   arch/arm/mm/vmregion.h             |    2 +-
>   drivers/base/dma-coherent.c        |   42 ++
>   include/asm-generic/dma-coherent.h |    4 +-
>   9 files changed, 1138 insertions(+), 467 deletions(-)
>   create mode 100644 arch/arm/include/asm/dma-iommu.h
>
