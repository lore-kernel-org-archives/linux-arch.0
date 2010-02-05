From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
 mapping API
Date: Fri, 05 Feb 2010 11:36:24 -0600
Message-ID: <1265391384.14404.53.camel@mulgrave.site>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36498 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757100Ab0BERg2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 12:36:28 -0500
In-Reply-To: <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org

On Fri, 2010-02-05 at 17:20 +0000, Catalin Marinas wrote:
> On Fri, 2010-02-05 at 16:43 +0000, James Bottomley wrote:
> > On Fri, 2010-02-05 at 16:31 +0000, Catalin Marinas wrote:
> > > This patch introduces support for the PIO mapping API on the ARM
> > > architecture. It is currently only meant as an example for discussions
> > > and it can be further optimised.
> [...]
> > > diff --git a/arch/arm/include/asm/pio-mapping.h b/arch/arm/include/asm/pio-mapping.h
> > > new file mode 100644
> > > index 0000000..d7c866a
> > > --- /dev/null
> > > +++ b/arch/arm/include/asm/pio-mapping.h
> [...]
> > > +static inline void *pio_map_single(void *addr, size_t size,
> > > +                                enum pio_data_direction dir)
> > > +{
> > > +     return addr;
> > 
> > This API is a bit semantically nasty to use, isn't it?  What we usually
> > get in the I/O path is a scatter gather list of pages and offsets (or
> > just a page in the network case).
> > 
> > In a highmem kernel, we'd have to kmap the page before it actually had a
> > kernel virtual address, so now the use case of the API becomes
> > 
> > vaddr = kmap_...(page)
> > pio_map_single(vaddr)
> > 
> > and the reverse on unmap.
> > 
> > Why not just combine the two since we always have to do them anyway and
> > do
> > 
> > kmap_pio ... with the various atomic versions?
> 
> For most cases, what we need looks close enough to the kmap semantics
> but this wouldn't work for the HCD case - the USB mass storage may use
> kmap() but it cannot easily be converted to the kmap_pio API since it's
> only the HCD driver that knows what kind of transfer it would do (and
> this only gets a (void *) pointer).

OK, so I'm not very familiar with the mechanics of useb, but if it gets
a pointer to the kernel virtual address what's wrong with just doing
virt_to_page() on that?  Note that virt_to_page() only really works if
the page is really a proper offset mapped kernel address, but my little
reading in drivers/usb seems to indicate it's a kmalloc buffer.

> We could allow a kmap_pio API to also take (void *) arguments in
> addition to (struct page *) but would this be confusing? It diverges
> slightly from the kmap API. Do you have a better suggestion?
> 
> > enum pio_data_direction dir looks a bit wrong too ... why not just use
> > the exsiting enum dma_data_direction since that's what the dma API uses?
> 
> I just didn't want to confuse things with the DMA_* name but that's a
> valid point.

So this is an interesting question of what will confuse driver writers
least.  Clearly if we can just pass in the dma data direction and have
done, that's easiest for them.

The flip side is that when we pass the flag DMA_FROM_DEVICE, the arch
people have to remember that this means we're writing to the page ... 

> > your pio_map_page is going to have to contain a kmap in the arch
> > implementation anyway ...
> 
> In my approach, the only case for pio_map_page() would be for
> non-highmem pages, otherwise you would need to use pio_map_single() on
> the value returned by kmap() (as you pointed out, it doesn't look nice
> but I don't have a solution to accommodate a kmap API with the HCD
> drivers).

So the distinction between higmemem and non-highmem is really one I'd
like to contain within the API ... otherwise we get drivers peppered
with

if (PageHighMem(page)) {
...
} else {
...
}

which leads to code proliferation and potentially more bugs.

James
