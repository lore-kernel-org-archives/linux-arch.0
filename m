From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv8 03/10] ARM: dma-mapping: introduce ARM_DMA_ERROR constant
Date: Tue, 10 Apr 2012 14:53:00 +0200
Message-ID: <002c01cd1718$dc852660$958f7320$%szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-4-git-send-email-m.szyprowski@samsung.com>
 <201204101131.56412.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:17504 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab2DJMxH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 08:53:07 -0400
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M29005SNL4NLQ60@mailout4.w1.samsung.com> for
 linux-arch@vger.kernel.org; Tue, 10 Apr 2012 13:53:11 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M2900FN5L4EEK@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Tue, 10 Apr 2012 13:53:02 +0100 (BST)
In-reply-to: <201204101131.56412.arnd@arndb.de>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Subash Patel' <subashrp@gmail.com>

Hi Arnd,

On Tuesday, April 10, 2012 1:32 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > Replace all uses of ~0 with ARM_DMA_ERROR, what should make the code
> > easier to read.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I like the idea, but why not name this DMA_ERROR_CODE like the other
> architectures do? I think in the long run we should put the definition
> into a global header file.

Ok, no problem, I will unify it with other architectures.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
