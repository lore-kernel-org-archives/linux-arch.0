From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
 mapper for DMA-mapping
Date: Wed, 12 Oct 2011 07:49:34 +0200
Message-ID: <00e501cc88a2$b82fc680$288f5380$%szyprowski@samsung.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
 <1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
 <594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
 <001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E37225197F8@HQMAIL04.nvidia.com>
 <00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519BF4@HQMAIL04.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38035 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1JLFtu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2011 01:49:50 -0400
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LSX00GCLUUXL0@mailout1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Wed, 12 Oct 2011 06:49:45 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LSX002RRUUXTJ@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Wed, 12 Oct 2011 06:49:45 +0100 (BST)
In-reply-to: <401E54CE964CD94BAE1EB4A729C7087E3722519BF4@HQMAIL04.nvidia.com>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Krishna Reddy' <vdumpa@nvidia.com>
Cc: linux-arch@vger.kernel.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, linux-arm-kernel@lists.infradead.org

Hello,

On Wednesday, October 12, 2011 3:35 AM Krishna Reddy wrote:

> >>It looks that You have simplified arm_iommu_map_sg() function too much.
> >>The main advantage of the iommu is to map scattered memory pages into
> >>contiguous dma address space. DMA-mapping is allowed to merge consecutive
> >>entries in the scatter list if hardware supports that.
> >>http://article.gmane.org/gmane.linux.kernel/1128416
> >I would update arm_iommu_map_sg() back to coalesce the sg list.
> >>MMC drivers seem to be aware of coalescing the SG entries together as they are using
> dma_sg_len().
> 
> I have updated the arm_iommu_map_sg() back to coalesce and fixed the issues with it. During
> testing, I found out that mmc host driver doesn't support buffers bigger than 64K. To get the
> device working, I had to break the sg entries coalesce when dma_length is about to go beyond
> 64KB. Looks like Mmc host driver(sdhci.c) need to be fixed to handle buffers bigger than 64KB.
> Should the clients be forced to handle bigger buffers or is there any better way to handle
> these kind of issues?

There is struct device_dma_parameters *dma_parms member of struct device. You can specify
maximum segment size for the dma_map_sg function. This will of course complicate this function
even more...

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
