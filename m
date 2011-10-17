From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [Linaro-mm-sig] [PATCH 1/2] ARM: initial proof-of-concept IOMMU
 mapper for DMA-mapping
Date: Mon, 17 Oct 2011 16:07:27 +0200
Message-ID: <01b801cc8cd6$1a6d4340$4f47c9c0$%szyprowski@samsung.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
 <1314971786-15140-2-git-send-email-m.szyprowski@samsung.com>
 <594816116217195c28de13accaf1f9f2.squirrel@www.codeaurora.org>
 <001f01cc786d$d55222c0$7ff66840$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E37225197F8@HQMAIL04.nvidia.com>
 <00b101cc87ee$8976c410$9c644c30$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519A1F@HQMAIL04.nvidia.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519BF4@HQMAIL04.nvidia.com>
 <00e501cc88a2$b82fc680$288f5380$%szyprowski@samsung.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519C65@HQMAIL04.nvidia.com>
 <401E54CE964CD94BAE1EB4A729C7087E3722519EAE@HQMAIL04.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:9212 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab1JQOHb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2011 10:07:31 -0400
Received: from euspt2 ([210.118.77.13]) by mailout3.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LT700BFSR8HBV60@mailout3.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 17 Oct 2011 15:07:29 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LT700GNMR8G9Y@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 17 Oct 2011 15:07:29 +0100 (BST)
In-reply-to: <401E54CE964CD94BAE1EB4A729C7087E3722519EAE@HQMAIL04.nvidia.com>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Krishna Reddy' <vdumpa@nvidia.com>
Cc: linux-arch@vger.kernel.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, linux-arm-kernel@lists.infradead.org

Hello Krishna,

On Thursday, October 13, 2011 2:18 AM You wrote:

> Here a patch v2 that has updates/fixes to DMA IOMMU code. With these changes, the nvidia
> device is able to boot with all its platform drivers as DMA IOMMU clients.
> 
> Here is the overview of changes.
> 
> 1. Converted the mutex to spinlock to handle atomic context calls and used spinlock in
> necessary places.
> 2. Implemented arm_iommu_map_page and arm_iommu_unmap_page, which are used by MMC host stack.
> 3. Separated creation of dma_iommu_mapping from arm_iommu_attach_device in order to share
> mapping.
> 4. Fixed various bugs identified in DMA IOMMU code during testing.

The code looks much better now. The only problem is the fact that your mailed has changed
all tabs into spaces making the patch really hard to apply. Could you resend it correctly?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
