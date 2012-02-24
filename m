Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45154 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726Ab2BXPaW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 10:30:22 -0500
Date: Fri, 24 Feb 2012 16:30:16 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv6 7/7] ARM: dma-mapping: add support for IOMMU mapper
In-reply-to: <201202241431.02170.arnd@arndb.de>
Message-ID: <017701ccf309$357d6f90$a0784eb0$%szyprowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: pl
Content-transfer-encoding: 7BIT
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <201202241249.44731.arnd@arndb.de>
 <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
 <201202241431.02170.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Krishna Reddy' <vdumpa@nvidia.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>
Message-ID: <20120224153016.7JMQLTNYlb-hi5b_4e56-WFOtQs6gi0rdvElnG-A6BY@z>

Hello,

On Friday, February 24, 2012 3:31 PM Arnd Bergmann wrote:

> On Friday 24 February 2012, Marek Szyprowski wrote:
> > I want to use some kind of chained arrays, each of at most of PAGE_SIZE. This code
> > doesn't really need to keep these page pointers in contiguous virtual memory area, so
> > it will not be a problem here.
> >
> Sounds like sg_alloc_table(), could you reuse that instead of rolling your own?

I only need to store 'struct page *' there. sg_alloc_table() operates on 'struct statterlist'
entries, which are 4 to 6 times larger than a simple 'struct page *' entry. I don't want to waste
so much memory just for reusing a two function. Implementing the same idea with pure 
'struct page *' pointers will be just a matter of a few lines.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


