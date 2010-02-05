From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
	mapping API
Date: Fri, 05 Feb 2010 18:02:20 +0000
Message-ID: <1265392940.7692.123.camel@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60419 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933516Ab0BESCY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 13:02:24 -0500
In-Reply-To: <1265391384.14404.53.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-arch@vger.kernel.org

On Fri, 2010-02-05 at 17:36 +0000, James Bottomley wrote:
> On Fri, 2010-02-05 at 17:20 +0000, Catalin Marinas wrote:
> > On Fri, 2010-02-05 at 16:43 +0000, James Bottomley wrote:
> > > On Fri, 2010-02-05 at 16:31 +0000, Catalin Marinas wrote:
> > > > This patch introduces support for the PIO mapping API on the ARM
> > > > architecture. It is currently only meant as an example for discussions
> > > > and it can be further optimised.
> > [...]
> > > > diff --git a/arch/arm/include/asm/pio-mapping.h b/arch/arm/include/asm/pio-mapping.h
> > > > new file mode 100644
> > > > index 0000000..d7c866a
> > > > --- /dev/null
> > > > +++ b/arch/arm/include/asm/pio-mapping.h
> > [...]
> > > > +static inline void *pio_map_single(void *addr, size_t size,
> > > > +                                enum pio_data_direction dir)
> > > > +{
> > > > +     return addr;
> > >
> > > This API is a bit semantically nasty to use, isn't it?  What we usually
> > > get in the I/O path is a scatter gather list of pages and offsets (or
> > > just a page in the network case).
> > >
> > > In a highmem kernel, we'd have to kmap the page before it actually had a
> > > kernel virtual address, so now the use case of the API becomes
> > >
> > > vaddr = kmap_...(page)
> > > pio_map_single(vaddr)
> > >
> > > and the reverse on unmap.
> > >
> > > Why not just combine the two since we always have to do them anyway and
> > > do
> > >
> > > kmap_pio ... with the various atomic versions?
> >
> > For most cases, what we need looks close enough to the kmap semantics
> > but this wouldn't work for the HCD case - the USB mass storage may use
> > kmap() but it cannot easily be converted to the kmap_pio API since it's
> > only the HCD driver that knows what kind of transfer it would do (and
> > this only gets a (void *) pointer).
> 
> OK, so I'm not very familiar with the mechanics of useb, but if it gets
> a pointer to the kernel virtual address what's wrong with just doing
> virt_to_page() on that?  Note that virt_to_page() only really works if
> the page is really a proper offset mapped kernel address, but my little
> reading in drivers/usb seems to indicate it's a kmalloc buffer.

According to this commit - 96983d2d8 - the USB mass storage only passes
lowmem pages to the non-DMA HCD drivers, so virt_to_page() is safe.

The only problem is that the transfer buffer passed to HCD may be bigger
than a page (I've seen it going to 64K) and you would need to call
kmap_pio() in the enqueue() function for each page, store the pointers
somewhere and later (once filled) unmap them via kunmap_pio() in the
dequeue() function (my temporary solution is this -
http://lkml.org/lkml/2010/2/2/142).
> 
> > > your pio_map_page is going to have to contain a kmap in the arch
> > > implementation anyway ...
> >
> > In my approach, the only case for pio_map_page() would be for
> > non-highmem pages, otherwise you would need to use pio_map_single() on
> > the value returned by kmap() (as you pointed out, it doesn't look nice
> > but I don't have a solution to accommodate a kmap API with the HCD
> > drivers).
> 
> So the distinction between higmemem and non-highmem is really one I'd
> like to contain within the API ... otherwise we get drivers peppered
> with
> 
> if (PageHighMem(page)) {
> ...
> } else {
> ...
> }
> 
> which leads to code proliferation and potentially more bugs.

I agree. Some more thinking needed over the weekend.

Thanks.

-- 
Catalin
