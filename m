From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv6 3/7] ARM: dma-mapping: implement dma sg methods on top of
 any generic dma ops
Date: Fri, 24 Feb 2012 14:24:04 +0100
Message-ID: <013401ccf2f7$9413a0e0$bc3ae2a0$%szyprowski@samsung.com>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <1328900324-20946-4-git-send-email-m.szyprowski@samsung.com>
 <20120214150255.GC18359@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <20120214150255.GC18359@phenom.dumpdata.com>
Content-language: pl
Sender: owner-linux-mm@kvack.org
To: 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, 'Shariq Hasnain' <shariq.hasnain@linaro.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'KyongHo Cho' <pullip.cho@samsung.com>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>
List-Id: linux-arch.vger.kernel.org

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


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
