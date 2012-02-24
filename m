Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33105 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab2BXNYK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 08:24:10 -0500
Date: Fri, 24 Feb 2012 14:24:04 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv6 3/7] ARM: dma-mapping: implement dma sg methods on top of
 any generic dma ops
In-reply-to: <20120214150255.GC18359@phenom.dumpdata.com>
Message-ID: <013401ccf2f7$9413a0e0$bc3ae2a0$%szyprowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: pl
Content-transfer-encoding: 7BIT
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <1328900324-20946-4-git-send-email-m.szyprowski@samsung.com>
 <20120214150255.GC18359@phenom.dumpdata.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, 'Shariq Hasnain' <shariq.hasnain@linaro.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'KyongHo Cho' <pullip.cho@samsung.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>
Message-ID: <20120224132404.wI-oHNTjmDinpUxunBPsaRwydewycU81Idzsu-7t7ac@z>

Hello,

On Tuesday, February 14, 2012 4:03 PM Konrad Rzeszutek Wilk wrote:
 
> On Fri, Feb 10, 2012 at 07:58:40PM +0100, Marek Szyprowski wrote:
> > This patch converts all dma_sg methods to be generic (independent of the
> > current DMA mapping implementation for ARM architecture). All dma sg
> > operations are now implemented on top of respective
> > dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.
> 
> Looks good, except the worry I've that the DMA debug API calls are now
> lost.

Could You point me which DMA debug API calls are lost? The inline functions
from include/asm-generic/dma-mapping-common.h already have all required
dma debug calls, which replaced the previous calls in 
arch/arm/include/dma-mapping.h.

(snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


