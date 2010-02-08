From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
	mapping API
Date: Mon, 08 Feb 2010 16:10:21 +0000
Message-ID: <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63818 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752963Ab0BHQK0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2010 11:10:26 -0500
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

I got your point about a kmap-like API which seems to be the case with
many block device drivers. The USB HCD is a different case where kmap
isn't used, only a pointer to a buffer that may span across multiple
pages.

What about something like below (just copying the code, no patch yet). I
used the "pio_" prefix rather than "kmap_" prefix since the last two
functions are used for address ranges rather than page structures for
cases like HCD.

The pio_data_direction could be dropped and use the DMA one. We could
also use pio_kmap_read/pio_kmap_write or similar but we have to triple
the number of functions, so I prefer the additional argument.


#include <linux/highmem.h>

enum pio_data_direction {
	PIO_BIDIRECTIONAL,
	PIO_TO_DEVICE,
	PIO_FROM_DEVICE,
	PIO_NONE
};

#ifdef CONFIG_HAVE_ARCH_PIO
#include <asm/pio-mapping.h>
#else

static inline void *pio_kmap(struct page *page, enum pio_data_direction dir)
{
	return kmap(page);
}

static inline void pio_kunmap(struct page *page, enum pio_data_direction dir)
{
	kunmap(page);
}

static inline void *pio_kmap_atomic(struct page *page, enum km_type idx,
				    enum pio_data_direction dir)
{
	return kmap_atomic(page, idx);
}

static inline void pio_kunmap_atomic(void *addr, enum km_type idx,
				     enum pio_data_direction dir)
{
	kunmap_atomic(page, idx);
}

static inline void *pio_map_range(void *start, size_t size,
				  enum pio_data_direction dir)
{
	return start;
}

static inline void pio_unmap_range(void *start, size_t size,
				   enum pio_data_direction dir)
{
}

#endif	/* CONFIG_HAVE_ARCH_PIO */

-- 
Catalin
