From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 07/33] csky: MMU and page table management
Date: Thu, 27 Sep 2018 08:47:33 -0700
Message-ID: <20180927154733.GA15985@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <ed7dcac1e0f3a858fa75735fa881818bc4ab1468.1538058840.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ed7dcac1e0f3a858fa75735fa881818bc4ab1468.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

> +static void *csky_dma_alloc_atomic(
> +	struct device *dev,
> +	size_t size,
> +	dma_addr_t *dma_handle
> +	)

Can you please use normal kernel coding style?  Closing brace on the
same line, either two tab indents for the arguments or align them to the
first argument:

static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
		dma_addr_t *dma_handle)

or:

static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
				   dma_addr_t *dma_handle)

> +	if (DMA_ATTR_NON_CONSISTENT & attrs)
> +		BUG();

Please don't bug on unknown attributs, they can be safely ignored.

> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +			      size_t size, enum dma_data_direction dir)
> +{
> +	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +	unsigned long offset = paddr & ~PAGE_MASK;
> +	unsigned long vaddr;
> +
> +	if (PageHighMem(page))
> +		vaddr = (unsigned long) kmap_atomic(page);

This isn't going to work as the size might be larger than PAGE_SIZE.
