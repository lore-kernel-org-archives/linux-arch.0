From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
	to more generic alloc/free_attrs
Date: Mon, 27 Jun 2011 14:23:40 +0200
Message-ID: <000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<201106241751.35655.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <201106241751.35655.arnd@arndb.de>
Content-language: pl
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Joerg Roedel' <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hello,

On Friday, June 24, 2011 5:52 PM Arnd Bergmann wrote:

> On Monday 20 June 2011, Marek Szyprowski wrote:
> > Introduce new alloc/free/mmap methods that take attributes argument.
> > alloc/free_coherent can be implemented on top of the new alloc/free
> > calls with NULL attributes. dma_alloc_non_coherent can be implemented
> > using DMA_ATTR_NONCOHERENT attribute, dma_alloc_writecombine can also
> > use separate DMA_ATTR_WRITECOMBINE attribute. This way the drivers will
> > get more generic, platform independent way of allocating dma memory
> > buffers with specific parameters.
> >
> > One more attribute can be usefull: DMA_ATTR_NOKERNELVADDR. Buffers with
> > such attribute will not have valid kernel virtual address. They might be
> > usefull for drivers that only exports the DMA buffers to userspace (like
> > for example V4L2 or ALSA).
> >
> > mmap method is introduced to let the drivers create a user space mapping
> > for a DMA buffer in generic, architecture independent way.
> >
> > TODO: update all dma_map_ops clients for all architectures
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Yes, I think that is good, but the change needs to be done atomically
> across all architectures.

Yes, I'm aware of this and I will include such changes in the next version
of my patches.

> This should be easy enough as I believe
> all other architectures that use dma_map_ops don't even require
> dma_alloc_noncoherent but just define it to dma_alloc_coherent
> because they have only coherent memory in regular device drivers.

Right, this should be quite simple. I will also add DMA_ATTR_NON_COHERENT
attribute for implementing dma_alloc_noncoherent() call.

> On a related note, do you plan to make the CMA work use this
> transparently, or do you want to have a DMA_ATTR_LARGE or
> DMA_ATTR_CONTIGUOUS for CMA?

IMHO it will be better to hide the CMA from the drivers. Memory allocated
from CMA doesn't really differ from the one allocated by dma_alloc_coherent()
(which internally use alloc_pages()), so I really see no reason for adding
additional attribute for it.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
