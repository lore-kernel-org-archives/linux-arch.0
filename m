From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/8] ARM: dma-mapping: remove offset parameter to prepare
 for generic dma_ops
Date: Mon, 20 Jun 2011 12:46:50 +0200
Message-ID: <000001cc2f37$5c5605f0$150211d0$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <1308556213-24970-2-git-send-email-m.szyprowski@samsung.com>
 <op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <op.vxc8tmru3l0zgt@mnazarewicz-glaptop>
Content-language: pl
Sender: owner-linux-mm@kvack.org
To: 'Michal Nazarewicz' <mina86@mina86.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-arch.vger.kernel.org

Hello,

On Monday, June 20, 2011 10:36 AM Michal Nazarewicz wrote:

> On Mon, 20 Jun 2011 09:50:06 +0200, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > +static inline void dma_sync_single_for_cpu(struct device *dev,
> 
> I wouldn't really put inline here or in the function below.
> 
> > +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> > +{
> > +	BUG_ON(!valid_dma_direction(dir));
> > +
> > +	debug_dma_sync_single_for_cpu(dev, handle, size, dir);
> > +
> > +	if (!dmabounce_sync_for_cpu(dev, handle, size, dir))
> > +		return;
> > +
> > +	__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);
> 
> I know it is just copy'n'paste but how about:

This patch is just about moving the code between the files and I wanted just
to show what's being changed and how. There is a final cleanup anyway in the
separate patch. All these patches are meant to start the discussion about
the way the dma mapping can be redesigned for further extensions with generic
iommu support. 

> 
> 	if (dmabounce_sync_for_cpu(dev, handle, size, dir))
> 		__dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir);

The above lines will be removed by the next patches in this series, so I
really see no point in changing this.

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
