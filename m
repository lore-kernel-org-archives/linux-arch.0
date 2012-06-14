From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [Linaro-mm-sig] [PATCHv2 1/6] common: DMA-mapping: add
 DMA_ATTR_NO_KERNEL_MAPPING attribute
Date: Thu, 14 Jun 2012 11:01:11 +0200
Message-ID: <003601cd4a0c$431d7780$c9586680$%szyprowski@samsung.com>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
 <1339588218-24398-2-git-send-email-m.szyprowski@samsung.com>
 <20120613185202.GM4829@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18766 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2FNJBb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jun 2012 05:01:31 -0400
In-reply-to: <20120613185202.GM4829@phenom.ffwll.local>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Daniel Vetter' <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 'Abhinav Kochhar' <abhinav.k@samsung.com>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>

Hello,

On Wednesday, June 13, 2012 8:52 PM Daniel Vetter wrote:

> On Wed, Jun 13, 2012 at 01:50:13PM +0200, Marek Szyprowski wrote:
> > This patch adds DMA_ATTR_NO_KERNEL_MAPPING attribute which lets the
> > platform to avoid creating a kernel virtual mapping for the allocated
> > buffer. On some architectures creating such mapping is non-trivial task
> > and consumes very limited resources (like kernel virtual address space
> > or dma consistent address space). Buffers allocated with this attribute
> > can be only passed to user space by calling dma_mmap_attrs().
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Looks like a nice little extension to support dma-buf for the common case,
> so:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> One question is whether we should go right ahead and add kmap support for
> this, too (with a default implementation that simply returns a pointer to
> the coherent&contigous dma mem), but I guess that can wait until a
> use-case pops up.

I will wait with this until there will be real use cases. Let's get the
patch into mainline first.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
